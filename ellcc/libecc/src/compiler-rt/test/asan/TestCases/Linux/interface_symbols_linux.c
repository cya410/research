// Check the presence of interface symbols in compiled file.

// RUN: %clang_asan -O2 %s -o %t.exe
// RUN: nm -D %t.exe | grep " T " | sed "s/.* T //" \
// RUN:    | grep "__asan_" | sed "s/___asan_/__asan_/" \
// RUN:    | sed -E "s/__asan_init_v[0-9]+/__asan_init/" \
// RUN:    | grep -v "__asan_default_options" \
// RUN:    | grep -v "__asan_stack_" \
// RUN:    | grep -v "__asan_on_error" > %t.symbols
// RUN: cat %p/../../../../lib/asan/asan_interface_internal.h \
// RUN:    | sed "s/\/\/.*//" | sed "s/typedef.*//" \
// RUN:    | grep -v "OPTIONAL" \
// RUN:    | grep "__asan_.*(" | sed "s/.* __asan_/__asan_/;s/(.*//" \
// RUN:    > %t.interface
// RUN: echo __asan_report_load1 >> %t.interface
// RUN: echo __asan_report_load2 >> %t.interface
// RUN: echo __asan_report_load4 >> %t.interface
// RUN: echo __asan_report_load8 >> %t.interface
// RUN: echo __asan_report_load16 >> %t.interface
// RUN: echo __asan_report_store1 >> %t.interface
// RUN: echo __asan_report_store2 >> %t.interface
// RUN: echo __asan_report_store4 >> %t.interface
// RUN: echo __asan_report_store8 >> %t.interface
// RUN: echo __asan_report_store16 >> %t.interface
// RUN: echo __asan_report_load_n >> %t.interface
// RUN: echo __asan_report_store_n >> %t.interface
// RUN: echo __asan_report_exp_load1 >> %t.interface
// RUN: echo __asan_report_exp_load2 >> %t.interface
// RUN: echo __asan_report_exp_load4 >> %t.interface
// RUN: echo __asan_report_exp_load8 >> %t.interface
// RUN: echo __asan_report_exp_load16 >> %t.interface
// RUN: echo __asan_report_exp_store1 >> %t.interface
// RUN: echo __asan_report_exp_store2 >> %t.interface
// RUN: echo __asan_report_exp_store4 >> %t.interface
// RUN: echo __asan_report_exp_store8 >> %t.interface
// RUN: echo __asan_report_exp_store16 >> %t.interface
// RUN: echo __asan_report_exp_load_n >> %t.interface
// RUN: echo __asan_report_exp_store_n >> %t.interface
// RUN: echo __asan_get_current_fake_stack >> %t.interface
// RUN: echo __asan_addr_is_in_fake_stack >> %t.interface
// RUN: cat %t.interface | sort -u | diff %t.symbols -

// FIXME: nm -D on powerpc somewhy shows ASan interface symbols residing
// in "initialized data section".
// REQUIRES: x86_64-supported-target,i386-supported-target

int main() { return 0; }
