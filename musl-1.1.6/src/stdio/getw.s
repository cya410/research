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
	.file	"src/stdio/getw.bc"
	.globl	getw
	.align	2
	.type	getw,%function
getw:                                   @ @getw
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#8
	sub	sp, sp, #8
	mov	r3, r0
	add	r0, sp, #4
	b	.LBB0_2
.LBB0_2:                                @ %entry
	mov	r1, #4
	mov	r2, #1
	bl	fread
	ldr	r1, [sp, #4]
	b	.LBB0_3
.LBB0_3:                                @ %entry
	cmp	r0, #0
	mvneq	r1, #0
	mov	r0, r1
	add	sp, sp, #8
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	getw, .Ltmp0-getw
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
