// RUN: %clangxx_asan -O0 %s -Fe%t
// FIXME: 'cat' is needed due to PR19744.
// RUN: not %run %t 2>&1 | cat | FileCheck %s

#include <windows.h>

int main() {
  char *buffer = new char;
  buffer[-1] = 42;
// CHECK: AddressSanitizer: heap-buffer-overflow on address [[ADDR:0x[0-9a-f]+]]
// CHECK: WRITE of size 1 at [[ADDR]] thread T0
// CHECK:   {{#0 .* main .*operator_new_left_oob.cc}}:[[@LINE-3]]
// CHECK: [[ADDR]] is located 1 bytes to the left of 1-byte region
// CHECK: allocated by thread T0 here:
// CHECK:   {{#0 .* operator new }}
// CHECK:   {{#1 .* main .*operator_new_left_oob.cc}}:[[@LINE-8]]
  delete buffer;
}
