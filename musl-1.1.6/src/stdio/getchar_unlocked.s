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
	.file	"src/stdio/getchar_unlocked.bc"
	.globl	getchar_unlocked
	.align	2
	.type	getchar_unlocked,%function
getchar_unlocked:                       @ @getchar_unlocked
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	ldr	r0, .LCPI0_0
	ldr	r0, [r0]
	ldmib	r0, {r1, r2}
	cmp	r1, r2
	b	.LBB0_1
.LCPI0_0:
	.long	stdin
.LBB0_1:                                @ %entry
	addlo	r2, r1, #1
	strlo	r2, [r0, #4]
	ldrblo	r0, [r1]
	movlo	pc, lr
	b	__uflow
.Ltmp0:
	.size	getchar_unlocked, .Ltmp0-getchar_unlocked
	.cantunwind
	.fnend

	.protected	__uflow

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
