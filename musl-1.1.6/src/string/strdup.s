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
	.file	"src/string/strdup.bc"
	.globl	__strdup
	.align	2
	.type	__strdup,%function
__strdup:                               @ @__strdup
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r4, r0
                                        @ kill: R0<def> R4<kill>
	b	.LBB0_2
.LBB0_2:                                @ %entry
	bl	strlen
	add	r5, r0, #1
	mov	r0, r5
	bl	malloc
	b	.LBB0_3
.LBB0_3:                                @ %entry
	cmp	r0, #0
	moveq	r0, #0
	popeq	{r4, r5, r11, lr}
	moveq	pc, lr
	mov	r1, r4
	mov	r2, r5
	pop	{r4, r5, r11, lr}
	b	memcpy
.Ltmp0:
	.size	__strdup, .Ltmp0-__strdup
	.cantunwind
	.fnend


	.weak	strdup
strdup = __strdup
	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
