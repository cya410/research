// RUN: %clangxx_asan -O0 %s -Fe%t
// FIXME: 'cat' is needed due to PR19744.
// RUN: not %run %t 2>&1 | cat | FileCheck %s

#include <windows.h>

DWORD WINAPI thread_proc(void *) {
  int subscript = 42;
  volatile char stack_buffer[42];
  stack_buffer[subscript] = 42;
// CHECK: AddressSanitizer: stack-buffer-overflow on address [[ADDR:0x[0-9a-f]+]]
// CHECK: WRITE of size 1 at [[ADDR]] thread T1
// CHECK:   {{#0 .* thread_proc .*thread_stack_array_right_oob.cc}}:[[@LINE-3]]
// CHECK: Address [[ADDR]] is located in stack of thread T1 at offset {{.*}} in frame
// CHECK:   thread_proc
  return 0;
}

int main(void) {
  HANDLE thr = CreateThread(NULL, 0, thread_proc, NULL, 0, NULL);
// CHECK: Thread T1 created by T0 here:
// CHECK:   {{#[01] .* main .*thread_stack_array_right_oob.cc}}:[[@LINE-2]]

  // A failure to create a thread should fail the test!
  if (thr == 0) return 0;

  WaitForSingleObject(thr, INFINITE);
}
