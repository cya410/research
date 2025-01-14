//===-- tsan_rtl_mutex.cc -------------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file is a part of ThreadSanitizer (TSan), a race detector.
//
//===----------------------------------------------------------------------===//

#include <sanitizer_common/sanitizer_deadlock_detector_interface.h>
#include <sanitizer_common/sanitizer_stackdepot.h>

#include "tsan_rtl.h"
#include "tsan_flags.h"
#include "tsan_sync.h"
#include "tsan_report.h"
#include "tsan_symbolize.h"
#include "tsan_platform.h"

namespace __tsan {

void ReportDeadlock(ThreadState *thr, uptr pc, DDReport *r);

struct Callback : DDCallback {
  ThreadState *thr;
  uptr pc;

  Callback(ThreadState *thr, uptr pc)
      : thr(thr)
      , pc(pc) {
    DDCallback::pt = thr->dd_pt;
    DDCallback::lt = thr->dd_lt;
  }

  virtual u32 Unwind() {
    return CurrentStackId(thr, pc);
  }
  virtual int UniqueTid() {
    return thr->unique_id;
  }
};

void DDMutexInit(ThreadState *thr, uptr pc, SyncVar *s) {
  Callback cb(thr, pc);
  ctx->dd->MutexInit(&cb, &s->dd);
  s->dd.ctx = s->GetId();
}

static void ReportMutexMisuse(ThreadState *thr, uptr pc, ReportType typ,
    uptr addr, u64 mid) {
  // In Go, these misuses are either impossible, or detected by std lib,
  // or false positives (e.g. unlock in a different thread).
  if (kGoMode)
    return;
  ThreadRegistryLock l(ctx->thread_registry);
  ScopedReport rep(typ);
  rep.AddMutex(mid);
  VarSizeStackTrace trace;
  ObtainCurrentStack(thr, pc, &trace);
  rep.AddStack(trace, true);
  rep.AddLocation(addr, 1);
  OutputReport(ctx, rep, rep.GetReport()->stacks[0]);
}

void MutexCreate(ThreadState *thr, uptr pc, uptr addr,
                 bool rw, bool recursive, bool linker_init) {
  DPrintf("#%d: MutexCreate %zx\n", thr->tid, addr);
  StatInc(thr, StatMutexCreate);
  if (!linker_init && IsAppMem(addr)) {
    CHECK(!thr->is_freeing);
    thr->is_freeing = true;
    MemoryWrite(thr, pc, addr, kSizeLog1);
    thr->is_freeing = false;
  }
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  s->is_rw = rw;
  s->is_recursive = recursive;
  s->is_linker_init = linker_init;
  s->mtx.Unlock();
}

void MutexDestroy(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: MutexDestroy %zx\n", thr->tid, addr);
  StatInc(thr, StatMutexDestroy);
#ifndef SANITIZER_GO
  // Global mutexes not marked as LINKER_INITIALIZED
  // cause tons of not interesting reports, so just ignore it.
  if (IsGlobalVar(addr))
    return;
#endif
  SyncVar *s = ctx->synctab.GetAndRemove(thr, pc, addr);
  if (s == 0)
    return;
  if (flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ctx->dd->MutexDestroy(&cb, &s->dd);
  }
  if (IsAppMem(addr)) {
    CHECK(!thr->is_freeing);
    thr->is_freeing = true;
    MemoryWrite(thr, pc, addr, kSizeLog1);
    thr->is_freeing = false;
  }
  SyncVar *s = ctx->metamap.GetIfExistsAndLock(addr);
  if (s == 0)
    return;
  if (common_flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ctx->dd->MutexDestroy(&cb, &s->dd);
    ctx->dd->MutexInit(&cb, &s->dd);
  }
  bool unlock_locked = false;
  if (flags()->report_destroy_locked
      && s->owner_tid != SyncVar::kInvalidTid
      && !s->is_broken) {
    s->is_broken = true;
    unlock_locked = true;
  }
  u64 mid = s->GetId();
  u32 last_lock = s->last_lock;
  if (!unlock_locked)
    s->Reset(thr);  // must not reset it before the report is printed
  s->mtx.Unlock();
  if (unlock_locked) {
    ThreadRegistryLock l(ctx->thread_registry);
    ScopedReport rep(ReportTypeMutexDestroyLocked);
    rep.AddMutex(s);
    VarSizeStackTrace trace;
    ObtainCurrentStack(thr, pc, &trace);
    rep.AddStack(trace);
    FastState last(s->last_lock);
    RestoreStack(last.tid(), last.epoch(), &trace, 0);
    rep.AddStack(trace, true);
    rep.AddLocation(addr, 1);
    OutputReport(thr, rep);
  }
  if (unlock_locked) {
    SyncVar *s = ctx->metamap.GetIfExistsAndLock(addr);
    if (s != 0) {
      s->Reset(thr);
      s->mtx.Unlock();
    }
  }
  thr->mset.Remove(mid);
  // s will be destroyed and freed in MetaMap::FreeBlock.
}

void MutexLock(ThreadState *thr, uptr pc, uptr addr, int rec, bool try_lock) {
  DPrintf("#%d: MutexLock %zx rec=%d\n", thr->tid, addr, rec);
  CHECK_GT(rec, 0);
  if (IsAppMem(addr))
    MemoryReadAtomic(thr, pc, addr, kSizeLog1);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  thr->fast_state.IncrementEpoch();
  TraceAddEvent(thr, thr->fast_state, EventTypeLock, s->GetId());
  bool report_double_lock = false;
  if (s->owner_tid == SyncVar::kInvalidTid) {
    CHECK_EQ(s->recursion, 0);
    s->owner_tid = thr->tid;
    s->last_lock = thr->fast_state.raw();
  } else if (s->owner_tid == thr->tid) {
    CHECK_GT(s->recursion, 0);
  } else if (flags()->report_mutex_bugs && !s->is_broken) {
    s->is_broken = true;
    report_double_lock = true;
  }
  if (s->recursion == 0) {
    StatInc(thr, StatMutexLock);
    AcquireImpl(thr, pc, &s->clock);
    AcquireImpl(thr, pc, &s->read_clock);
  } else if (!s->is_recursive) {
    StatInc(thr, StatMutexRecLock);
  }
  s->recursion += rec;
  thr->mset.Add(s->GetId(), true, thr->fast_state.epoch());
  if (common_flags()->detect_deadlocks && (s->recursion - rec) == 0) {
    Callback cb(thr, pc);
    if (!try_lock)
      ctx->dd->MutexBeforeLock(&cb, &s->dd, true);
    ctx->dd->MutexAfterLock(&cb, &s->dd, true, try_lock);
  }
  u64 mid = s->GetId();
  s->mtx.Unlock();
  // Can't touch s after this point.
  if (report_double_lock)
    ReportMutexMisuse(thr, pc, ReportTypeMutexDoubleLock, addr, mid);
  if (common_flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ReportDeadlock(thr, pc, ctx->dd->GetReport(&cb));
  }
}

int MutexUnlock(ThreadState *thr, uptr pc, uptr addr, bool all) {
  DPrintf("#%d: MutexUnlock %zx all=%d\n", thr->tid, addr, all);
  if (IsAppMem(addr))
    MemoryReadAtomic(thr, pc, addr, kSizeLog1);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  thr->fast_state.IncrementEpoch();
  TraceAddEvent(thr, thr->fast_state, EventTypeUnlock, s->GetId());
  int rec = 0;
  bool report_bad_unlock = false;
  if (kCppMode && (s->recursion == 0 || s->owner_tid != thr->tid)) {
    if (flags()->report_mutex_bugs && !s->is_broken) {
      s->is_broken = true;
      report_bad_unlock = true;
    }
  } else {
    rec = all ? s->recursion : 1;
    s->recursion -= rec;
    if (s->recursion == 0) {
      StatInc(thr, StatMutexUnlock);
      s->owner_tid = SyncVar::kInvalidTid;
      ReleaseStoreImpl(thr, pc, &s->clock);
    } else {
      StatInc(thr, StatMutexRecUnlock);
    }
  }
  thr->mset.Del(s->GetId(), true);
  if (common_flags()->detect_deadlocks && s->recursion == 0 &&
      !report_bad_unlock) {
    Callback cb(thr, pc);
    ctx->dd->MutexBeforeUnlock(&cb, &s->dd, true);
  }
  u64 mid = s->GetId();
  s->mtx.Unlock();
  // Can't touch s after this point.
  if (report_bad_unlock)
    ReportMutexMisuse(thr, pc, ReportTypeMutexBadUnlock, addr, mid);
  if (common_flags()->detect_deadlocks && !report_bad_unlock) {
    Callback cb(thr, pc);
    ReportDeadlock(thr, pc, ctx->dd->GetReport(&cb));
  }
  return rec;
}

void MutexReadLock(ThreadState *thr, uptr pc, uptr addr, bool trylock) {
  DPrintf("#%d: MutexReadLock %zx\n", thr->tid, addr);
  StatInc(thr, StatMutexReadLock);
  if (IsAppMem(addr))
    MemoryReadAtomic(thr, pc, addr, kSizeLog1);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, false);
  thr->fast_state.IncrementEpoch();
  TraceAddEvent(thr, thr->fast_state, EventTypeRLock, s->GetId());
  bool report_bad_lock = false;
  if (s->owner_tid != SyncVar::kInvalidTid) {
    if (flags()->report_mutex_bugs && !s->is_broken) {
      s->is_broken = true;
      report_bad_lock = true;
    }
  }
  AcquireImpl(thr, pc, &s->clock);
  s->last_lock = thr->fast_state.raw();
  thr->mset.Add(s->GetId(), false, thr->fast_state.epoch());
  if (common_flags()->detect_deadlocks && s->recursion == 0) {
    Callback cb(thr, pc);
    if (!trylock)
      ctx->dd->MutexBeforeLock(&cb, &s->dd, false);
    ctx->dd->MutexAfterLock(&cb, &s->dd, false, trylock);
  }
  u64 mid = s->GetId();
  s->mtx.ReadUnlock();
  // Can't touch s after this point.
  if (report_bad_lock)
    ReportMutexMisuse(thr, pc, ReportTypeMutexBadReadLock, addr, mid);
  if (common_flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ReportDeadlock(thr, pc, ctx->dd->GetReport(&cb));
  }
}

void MutexReadUnlock(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: MutexReadUnlock %zx\n", thr->tid, addr);
  StatInc(thr, StatMutexReadUnlock);
  if (IsAppMem(addr))
    MemoryReadAtomic(thr, pc, addr, kSizeLog1);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  thr->fast_state.IncrementEpoch();
  TraceAddEvent(thr, thr->fast_state, EventTypeRUnlock, s->GetId());
  bool report_bad_unlock = false;
  if (s->owner_tid != SyncVar::kInvalidTid) {
    if (flags()->report_mutex_bugs && !s->is_broken) {
      s->is_broken = true;
      report_bad_unlock = true;
    }
  }
  ReleaseImpl(thr, pc, &s->read_clock);
  if (common_flags()->detect_deadlocks && s->recursion == 0) {
    Callback cb(thr, pc);
    ctx->dd->MutexBeforeUnlock(&cb, &s->dd, false);
  }
  u64 mid = s->GetId();
  s->mtx.Unlock();
  // Can't touch s after this point.
  thr->mset.Del(mid, false);
  if (report_bad_unlock)
    ReportMutexMisuse(thr, pc, ReportTypeMutexBadReadUnlock, addr, mid);
  if (common_flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ReportDeadlock(thr, pc, ctx->dd->GetReport(&cb));
  }
}

void MutexReadOrWriteUnlock(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: MutexReadOrWriteUnlock %zx\n", thr->tid, addr);
  if (IsAppMem(addr))
    MemoryReadAtomic(thr, pc, addr, kSizeLog1);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  bool write = true;
  bool report_bad_unlock = false;
  if (s->owner_tid == SyncVar::kInvalidTid) {
    // Seems to be read unlock.
    write = false;
    StatInc(thr, StatMutexReadUnlock);
    thr->fast_state.IncrementEpoch();
    TraceAddEvent(thr, thr->fast_state, EventTypeRUnlock, s->GetId());
    ReleaseImpl(thr, pc, &s->read_clock);
  } else if (s->owner_tid == thr->tid) {
    // Seems to be write unlock.
    thr->fast_state.IncrementEpoch();
    TraceAddEvent(thr, thr->fast_state, EventTypeUnlock, s->GetId());
    CHECK_GT(s->recursion, 0);
    s->recursion--;
    if (s->recursion == 0) {
      StatInc(thr, StatMutexUnlock);
      s->owner_tid = SyncVar::kInvalidTid;
      ReleaseImpl(thr, pc, &s->clock);
    } else {
      StatInc(thr, StatMutexRecUnlock);
    }
  } else if (!s->is_broken) {
    s->is_broken = true;
    report_bad_unlock = true;
  }
  thr->mset.Del(s->GetId(), write);
  if (common_flags()->detect_deadlocks && s->recursion == 0) {
    Callback cb(thr, pc);
    ctx->dd->MutexBeforeUnlock(&cb, &s->dd, write);
  }
  u64 mid = s->GetId();
  s->mtx.Unlock();
  // Can't touch s after this point.
  if (report_bad_unlock)
    ReportMutexMisuse(thr, pc, ReportTypeMutexBadUnlock, addr, mid);
  if (common_flags()->detect_deadlocks) {
    Callback cb(thr, pc);
    ReportDeadlock(thr, pc, ctx->dd->GetReport(&cb));
  }
}

void MutexRepair(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: MutexRepair %zx\n", thr->tid, addr);
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  s->owner_tid = SyncVar::kInvalidTid;
  s->recursion = 0;
  s->mtx.Unlock();
}

void Acquire(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: Acquire %zx\n", thr->tid, addr);
  if (thr->ignore_sync)
    return;
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, false);
  AcquireImpl(thr, pc, &s->clock);
  s->mtx.ReadUnlock();
}

static void UpdateClockCallback(ThreadContextBase *tctx_base, void *arg) {
  ThreadState *thr = reinterpret_cast<ThreadState*>(arg);
  ThreadContext *tctx = static_cast<ThreadContext*>(tctx_base);
  if (tctx->status == ThreadStatusRunning)
    thr->clock.set(tctx->tid, tctx->thr->fast_state.epoch());
  else
    thr->clock.set(tctx->tid, tctx->epoch1);
}

void AcquireGlobal(ThreadState *thr, uptr pc) {
  DPrintf("#%d: AcquireGlobal\n", thr->tid);
  if (thr->ignore_sync)
    return;
  ThreadRegistryLock l(ctx->thread_registry);
  ctx->thread_registry->RunCallbackForEachThreadLocked(
      UpdateClockCallback, thr);
}

void Release(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: Release %zx\n", thr->tid, addr);
  if (thr->ignore_sync)
    return;
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  thr->fast_state.IncrementEpoch();
  // Can't increment epoch w/o writing to the trace as well.
  TraceAddEvent(thr, thr->fast_state, EventTypeMop, 0);
  ReleaseImpl(thr, pc, &s->clock);
  s->mtx.Unlock();
}

void ReleaseStore(ThreadState *thr, uptr pc, uptr addr) {
  DPrintf("#%d: ReleaseStore %zx\n", thr->tid, addr);
  if (thr->ignore_sync)
    return;
  SyncVar *s = ctx->synctab.GetOrCreateAndLock(thr, pc, addr, true);
  thr->fast_state.IncrementEpoch();
  // Can't increment epoch w/o writing to the trace as well.
  TraceAddEvent(thr, thr->fast_state, EventTypeMop, 0);
  ReleaseStoreImpl(thr, pc, &s->clock);
  s->mtx.Unlock();
}

#ifndef SANITIZER_GO
static void UpdateSleepClockCallback(ThreadContextBase *tctx_base, void *arg) {
  ThreadState *thr = reinterpret_cast<ThreadState*>(arg);
  ThreadContext *tctx = static_cast<ThreadContext*>(tctx_base);
  if (tctx->status == ThreadStatusRunning)
    thr->last_sleep_clock.set(tctx->tid, tctx->thr->fast_state.epoch());
  else
    thr->last_sleep_clock.set(tctx->tid, tctx->epoch1);
}

void AfterSleep(ThreadState *thr, uptr pc) {
  DPrintf("#%d: AfterSleep %zx\n", thr->tid);
  if (thr->ignore_sync)
    return;
  thr->last_sleep_stack_id = CurrentStackId(thr, pc);
  ThreadRegistryLock l(ctx->thread_registry);
  ctx->thread_registry->RunCallbackForEachThreadLocked(
      UpdateSleepClockCallback, thr);
}
#endif

void AcquireImpl(ThreadState *thr, uptr pc, SyncClock *c) {
  if (thr->ignore_sync)
    return;
  thr->clock.set(thr->tid, thr->fast_state.epoch());
  thr->clock.acquire(&thr->clock_cache, c);
  StatInc(thr, StatSyncAcquire);
}

void ReleaseImpl(ThreadState *thr, uptr pc, SyncClock *c) {
  if (thr->ignore_sync)
    return;
  thr->clock.set(thr->tid, thr->fast_state.epoch());
  thr->fast_synch_epoch = thr->fast_state.epoch();
  thr->clock.release(&thr->clock_cache, c);
  StatInc(thr, StatSyncRelease);
}

void ReleaseStoreImpl(ThreadState *thr, uptr pc, SyncClock *c) {
  if (thr->ignore_sync)
    return;
  thr->clock.set(thr->tid, thr->fast_state.epoch());
  thr->fast_synch_epoch = thr->fast_state.epoch();
  thr->clock.ReleaseStore(&thr->clock_cache, c);
  StatInc(thr, StatSyncRelease);
}

void AcquireReleaseImpl(ThreadState *thr, uptr pc, SyncClock *c) {
  if (thr->ignore_sync)
    return;
  thr->clock.set(thr->tid, thr->fast_state.epoch());
  thr->fast_synch_epoch = thr->fast_state.epoch();
  thr->clock.acq_rel(&thr->clock_cache, c);
  StatInc(thr, StatSyncAcquire);
  StatInc(thr, StatSyncRelease);
}

void ReportDeadlock(ThreadState *thr, uptr pc, DDReport *r) {
  if (r == 0)
    return;
  ThreadRegistryLock l(ctx->thread_registry);
  ScopedReport rep(ReportTypeDeadlock);
  for (int i = 0; i < r->n; i++) {
    rep.AddMutex(r->loop[i].mtx_ctx0);
    rep.AddUniqueTid((int)r->loop[i].thr_ctx);
    rep.AddThread((int)r->loop[i].thr_ctx);
  }
  uptr dummy_pc = 0x42;
  for (int i = 0; i < r->n; i++) {
    for (int j = 0; j < (flags()->second_deadlock_stack ? 2 : 1); j++) {
      u32 stk = r->loop[i].stk[j];
      if (stk) {
        rep.AddStack(StackDepotGet(stk), true);
      } else {
        // Sometimes we fail to extract the stack trace (FIXME: investigate),
        // but we should still produce some stack trace in the report.
        rep.AddStack(StackTrace(&dummy_pc, 1), true);
      }
    }
  }
  // FIXME: use all stacks for suppressions, not just the second stack of the
  // first edge.
  OutputReport(ctx, rep, rep.GetReport()->stacks[0]);
}

}  // namespace __tsan
