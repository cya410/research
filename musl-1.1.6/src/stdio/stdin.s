	.text
	.syntax unified
	.eabi_attribute	67, "2.09"	@ Tag_conformance
	.eabi_attribute	6, 1	@ Tag_CPU_arch
	.eabi_attribute	8, 1	@ Tag_ARM_ISA_use
	.eabi_attribute	17, 1	@ Tag_ABI_PCS_GOT_use
	.eabi_attribute	20, 1	@ Tag_ABI_FP_denormal
	.eabi_attribute	21, 1	@ Tag_ABI_FP_exceptions
	.eabi_attribute	23, 3	@ Tag_ABI_FP_number_model
	.eabi_attribute	34, 0	@ Tag_CPU_unaligned_access
	.eabi_attribute	24, 1	@ Tag_ABI_align_needed
	.eabi_attribute	25, 1	@ Tag_ABI_align_preserved
	.eabi_attribute	38, 1	@ Tag_ABI_FP_16bit_format
	.eabi_attribute	18, 4	@ Tag_ABI_PCS_wchar_t
	.eabi_attribute	26, 2	@ Tag_ABI_enum_size
	.eabi_attribute	14, 0	@ Tag_ABI_PCS_R9_use
	.file	"src/stdio/stdin.bc"
	.type	f,%object               @ @f
	.section	.data.rel,"aw",%progbits
	.align	3
f:
	.long	9                       @ 0x9
	.long	0
	.long	0
	.long	__stdio_close
	.long	0
	.long	0
	.long	0
	.long	0
	.long	__stdio_read
	.long	0
	.long	__stdio_seek
	.long	buf+8
	.long	1024                    @ 0x400
	.long	0
	.long	0
	.long	0                       @ 0x0
	.long	0                       @ 0x0
	.long	0                       @ 0x0
	.short	0                       @ 0x0
	.byte	0                       @ 0x0
	.byte	0                       @ 0x0
	.long	4294967295              @ 0xffffffff
	.long	0                       @ 0x0
	.long	0
	.long	0                       @ 0x0
	.long	0
	.long	0
	.long	0
	.long	0
	.zero	4
	.long	0                       @ 0x0
	.long	0
	.long	0                       @ 0x0
	.long	0
	.long	0
	.long	0
	.size	f, 136

	.type	stdin,%object           @ @stdin
	.section	.data.rel.ro.local,"aw",%progbits
	.globl	stdin
	.align	2
stdin:
	.long	f
	.size	stdin, 4

	.type	__stdin_used,%object    @ @__stdin_used
	.section	.data.rel.local,"aw",%progbits
	.globl	__stdin_used
	.align	2
__stdin_used:
	.long	f
	.size	__stdin_used, 4

	.type	buf,%object             @ @buf
	.local	buf
	.comm	buf,1032,1

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
