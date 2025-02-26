// RUN: %clangxx_asan -O0 %p/dll_host.cc -Fe%t
// RUN: %clangxx_asan -LD -O0 %s -Fe%t.dll
// FIXME: 'cat' is needed due to PR19744.
// RUN: not %run %t %t.dll 2>&1 | cat | FileCheck %s

#include <windows.h>
#include <malloc.h>

DWORD WINAPI thread_proc(void *context) {
  int subscript = -1;
  char stack_buffer[42];
  stack_buffer[subscript] = 42;
// CHECK: AddressSanitizer: stack-buffer-underflow on address [[ADDR:0x[0-9a-f]+]]
// CHECK: WRITE of size 1 at [[ADDR]] thread T1
// CHECK-NEXT:  thread_proc {{.*}}dll_thread_stack_array_left_oob.cc:[[@LINE-3]]
//
// CHECK: Address [[ADDR]] is located in stack of thread T1 at offset [[OFFSET:.*]] in frame
// CHECK-NEXT:  thread_proc {{.*}}dll_thread_stack_array_left_oob.cc
//
// CHECK: 'stack_buffer' <== Memory access at offset [[OFFSET]] underflows this variable

  return 0;
}

extern "C" __declspec(dllexport)
int test_function() {
  HANDLE thr = CreateThread(NULL, 0, thread_proc, NULL, 0, NULL);
// CHECK-LABEL: Thread T1 created by T0 here:
// CHECK:         test_function {{.*}}dll_thread_stack_array_left_oob.cc:[[@LINE-2]]
// CHECK-NEXT:    main {{.*}}dll_host.cc
// CHECK-LABEL: SUMMARY
  if (thr == 0)
    return 1;
  if (WAIT_OBJECT_0 != WaitForSingleObject(thr, INFINITE))
    return 2;
  return 0;
}
