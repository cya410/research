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
	.file	"src/prng/mrand48.bc"
	.globl	jrand48
	.align	2
	.type	jrand48,%function
jrand48:                                @ @jrand48
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	ldr	r1, .LCPI0_0
	add	r1, r1, #6
	bl	__rand48_step
	lsr	r0, r0, #16
	orr	r0, r0, r1, lsl #16
	pop	{r11, lr}
	mov	pc, lr
.LCPI0_0:
	.long	__seed48
.Ltmp0:
	.size	jrand48, .Ltmp0-jrand48
	.cantunwind
	.fnend

	.globl	mrand48
	.align	2
	.type	mrand48,%function
mrand48:                                @ @mrand48
	.fnstart
.Leh_func_begin1:
.LBB1_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB1_1
.LBB1_1:                                @ %entry
	ldr	r0, .LCPI1_0
	add	r1, r0, #6
	bl	__rand48_step
	lsr	r0, r0, #16
	orr	r0, r0, r1, lsl #16
	pop	{r11, lr}
	mov	pc, lr
.LCPI1_0:
	.long	__seed48
.Ltmp1:
	.size	mrand48, .Ltmp1-mrand48
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
