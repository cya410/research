// RUN: %clangxx_asan -O0 %s -Fe%t
// FIXME: 'cat' is needed due to PR19744.
// RUN: not %run %t 2>&1 | cat | FileCheck %s

#include <stdio.h>
#include <string.h>
#include <malloc.h>

int main() {
  char *ptr = _strdup("Hello");
  int subscript = 1;
  ptr[subscript] = '3';
  printf("%s\n", ptr);
  fflush(0);
// CHECK: H3llo

  subscript = -1;
  ptr[subscript] = 42;
// CHECK: AddressSanitizer: heap-buffer-overflow on address [[ADDR:0x[0-9a-f]+]]
// CHECK: WRITE of size 1 at [[ADDR]] thread T0
// CHECK:   {{#0 .* main .*}}intercept_strdup.cc:[[@LINE-3]]
// CHECK: [[ADDR]] is located 1 bytes to the left of 6-byte region
// CHECK: allocated by thread T0 here:
// CHECK:   {{#0 .* malloc }}
// CHECK:   {{#1 .*strdup}}
// CHECK:   {{#2 .* main .*}}intercept_strdup.cc:[[@LINE-16]]
  free(ptr);
}
