// We use fast_unwind_on_malloc=0 to have full unwinding even w/o frame
// pointers. This setting is not on by default because it's too expensive.
//
// We use fast_unwind_on_malloc=0 to have full unwinding even w/o frame
// pointers. This setting is not on by default because it's too expensive.
//
// Different size: detect a bug if detect_odr_violation>=1
// RUN: %clangxx_asan -DBUILD_SO=1 -fPIC -shared %s -o %t-ODR-SO.so
// RUN: %clangxx_asan %s %t-ODR-SO.so -Wl,-R. -o %t-ODR-EXE
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=1 not %run %t-ODR-EXE 2>&1 | FileCheck %s
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=2 not %run %t-ODR-EXE 2>&1 | FileCheck %s
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=0     %run %t-ODR-EXE 2>&1 | FileCheck %s --check-prefix=DISABLED
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0                        not %run %t-ODR-EXE 2>&1 | FileCheck %s
//
// Same size: report a bug only if detect_odr_violation>=2.
// RUN: %clangxx_asan -DBUILD_SO=1 -fPIC -shared %s -o %t-ODR-SO.so -DSZ=100
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=1     %run %t-ODR-EXE 2>&1 | FileCheck %s --check-prefix=DISABLED
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=2 not %run %t-ODR-EXE 2>&1 | FileCheck %s
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0                        not %run %t-ODR-EXE 2>&1 | FileCheck %s
// RUN: echo "odr_violation:foo::ZZZ" > %t.supp
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=2:suppressions=%t.supp  not %run %t-ODR-EXE 2>&1 | FileCheck %s
// RUN: echo "odr_violation:foo::G" > %t.supp
// RUN: ASAN_OPTIONS=fast_unwind_on_malloc=0:detect_odr_violation=2:suppressions=%t.supp      %run %t-ODR-EXE 2>&1 | FileCheck %s --check-prefix=DISABLED
// RUN: rm -f %t.supp

// GNU driver doesn't handle .so files properly.
// REQUIRES: Clang

#ifndef SZ
# define SZ 4
#endif

#if BUILD_SO
namespace foo { char G[SZ]; }
#else
#include <stdio.h>
namespace foo { char G[100]; }
// CHECK: ERROR: AddressSanitizer: odr-violation
// CHECK: size=100 'foo::G' {{.*}}odr-violation.cc:[[@LINE-2]]:22
// CHECK: size={{4|100}} 'foo::G'
int main(int argc, char **argv) {
  printf("PASS: %p\n", &foo::G);
}
#endif

// CHECK: These globals were registered at these points:
// CHECK: ODR-EXE
// CHECK: ODR-SO
// CHECK: SUMMARY: AddressSanitizer: odr-violation: global 'foo::G' at {{.*}}odr-violation.cc
// DISABLED: PASS
