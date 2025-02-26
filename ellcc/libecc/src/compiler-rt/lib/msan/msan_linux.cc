//===-- msan_linux.cc -----------------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file is a part of MemorySanitizer.
//
// Linux- and FreeBSD-specific code.
//===----------------------------------------------------------------------===//

#include "sanitizer_common/sanitizer_platform.h"
#if SANITIZER_FREEBSD || SANITIZER_LINUX

#include "msan.h"

#include <elf.h>
#include <link.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <unwind.h>
#include <execinfo.h>
#include <sys/time.h>
#include <sys/resource.h>

#include "sanitizer_common/sanitizer_common.h"
#include "sanitizer_common/sanitizer_procmaps.h"

namespace __msan {

void ReportMapRange(const char *descr, uptr beg, uptr size) {
  if (size > 0) {
    uptr end = beg + size - 1;
    VPrintf(1, "%s : %p - %p\n", descr, beg, end);
  }
}

static bool CheckMemoryRangeAvailability(uptr beg, uptr size) {
  if (size > 0) {
    uptr end = beg + size - 1;
    if (!MemoryRangeIsAvailable(beg, end)) {
      Printf("FATAL: Memory range %p - %p is not available.\n", beg, end);
      return false;
    }
  }
  return true;
}

static bool ProtectMemoryRange(uptr beg, uptr size) {
  if (size > 0) {
    uptr end = beg + size - 1;
    if (!Mprotect(beg, size)) {
      Printf("FATAL: Cannot protect memory range %p - %p.\n", beg, end);
      return false;
    }
  }
  return true;
}

static void CheckMemoryLayoutSanity() {
  uptr prev_end = 0;
  for (unsigned i = 0; i < kMemoryLayoutSize; ++i) {
    uptr start = kMemoryLayout[i].start;
    uptr end = kMemoryLayout[i].end;
    MappingDesc::Type type = kMemoryLayout[i].type;
    CHECK_LT(start, end);
    CHECK_EQ(prev_end, start);
    CHECK(addr_is_type(start, type));
    CHECK(addr_is_type((start + end) / 2, type));
    CHECK(addr_is_type(end - 1, type));
    if (type == MappingDesc::APP) {
      uptr addr = start;
      CHECK(MEM_IS_SHADOW(MEM_TO_SHADOW(addr)));
      CHECK(MEM_IS_ORIGIN(MEM_TO_ORIGIN(addr)));
      CHECK_EQ(MEM_TO_ORIGIN(addr), SHADOW_TO_ORIGIN(MEM_TO_SHADOW(addr)));

      addr = (start + end) / 2;
      CHECK(MEM_IS_SHADOW(MEM_TO_SHADOW(addr)));
      CHECK(MEM_IS_ORIGIN(MEM_TO_ORIGIN(addr)));
      CHECK_EQ(MEM_TO_ORIGIN(addr), SHADOW_TO_ORIGIN(MEM_TO_SHADOW(addr)));

      addr = end - 1;
      CHECK(MEM_IS_SHADOW(MEM_TO_SHADOW(addr)));
      CHECK(MEM_IS_ORIGIN(MEM_TO_ORIGIN(addr)));
      CHECK_EQ(MEM_TO_ORIGIN(addr), SHADOW_TO_ORIGIN(MEM_TO_SHADOW(addr)));
    }
    prev_end = end;
  }
}

bool InitShadow(bool map_shadow, bool init_origins) {
  // Let user know mapping parameters first.
  VPrintf(1, "__msan_init %p\n", &__msan_init);
  for (unsigned i = 0; i < kMemoryLayoutSize; ++i)
    VPrintf(1, "%s: %zx - %zx\n", kMemoryLayout[i].name, kMemoryLayout[i].start,
            kMemoryLayout[i].end - 1);

  CheckMemoryLayoutSanity();

  if (!MEM_IS_APP(&__msan_init)) {
    Printf("FATAL: Code %p is out of application range. Non-PIE build?\n",
           (uptr)&__msan_init);
    return false;
  }

  for (unsigned i = 0; i < kMemoryLayoutSize; ++i) {
    uptr start = kMemoryLayout[i].start;
    uptr end = kMemoryLayout[i].end;
    uptr size= end - start;
    MappingDesc::Type type = kMemoryLayout[i].type;
    if ((map_shadow && type == MappingDesc::SHADOW) ||
        (init_origins && type == MappingDesc::ORIGIN)) {
      if (!CheckMemoryRangeAvailability(start, size)) return false;
      if ((uptr)MmapFixedNoReserve(start, size) != start) return false;
      if (common_flags()->use_madv_dontdump)
        DontDumpShadowMemory(start, size);
    } else if (type == MappingDesc::INVALID) {
      if (!CheckMemoryRangeAvailability(start, size)) return false;
      if (!ProtectMemoryRange(start, size)) return false;
    }
  }

  return true;
}

void MsanDie() {
  if (common_flags()->coverage)
    __sanitizer_cov_dump();
  if (death_callback)
    death_callback();
  internal__exit(flags()->exit_code);
}

static void MsanAtExit(void) {
  if (flags()->print_stats && (flags()->atexit || msan_report_count > 0))
    ReportStats();
  if (msan_report_count > 0) {
    ReportAtExitStatistics();
    if (flags()->exit_code) _exit(flags()->exit_code);
  }
}

void InstallAtExitHandler() {
  atexit(MsanAtExit);
}

// ---------------------- TSD ---------------- {{{1

static pthread_key_t tsd_key;
static bool tsd_key_inited = false;

void MsanTSDInit(void (*destructor)(void *tsd)) {
  CHECK(!tsd_key_inited);
  tsd_key_inited = true;
  CHECK_EQ(0, pthread_key_create(&tsd_key, destructor));
}

static THREADLOCAL MsanThread* msan_current_thread;

MsanThread *GetCurrentThread() {
  return msan_current_thread;
}

void SetCurrentThread(MsanThread *t) {
  // Make sure we do not reset the current MsanThread.
  CHECK_EQ(0, msan_current_thread);
  msan_current_thread = t;
  // Make sure that MsanTSDDtor gets called at the end.
  CHECK(tsd_key_inited);
  pthread_setspecific(tsd_key, (void *)t);
}

void MsanTSDDtor(void *tsd) {
  MsanThread *t = (MsanThread*)tsd;
  if (t->destructor_iterations_ > 1) {
    t->destructor_iterations_--;
    CHECK_EQ(0, pthread_setspecific(tsd_key, tsd));
    return;
  }
  msan_current_thread = nullptr;
  // Make sure that signal handler can not see a stale current thread pointer.
  atomic_signal_fence(memory_order_seq_cst);
  MsanThread::TSDDtor(tsd);
}

}  // namespace __msan

#endif  // SANITIZER_FREEBSD || SANITIZER_LINUX
