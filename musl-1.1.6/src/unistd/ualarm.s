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
	.file	"src/unistd/ualarm.bc"
	.globl	ualarm
	.align	2
	.type	ualarm,%function
ualarm:                                 @ @ualarm
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#16
	sub	sp, sp, #16
	mov	r2, #0
	str	r2, [sp]
	b	.LBB0_2
.LBB0_2:                                @ %entry
	str	r1, [sp, #4]
	mov	r1, sp
	str	r2, [sp, #8]
	str	r0, [sp, #12]
	b	.LBB0_3
.LBB0_3:                                @ %entry
	mov	r0, #0
	mov	r2, r1
	bl	setitimer
	ldr	r2, [sp, #8]
	b	.LBB0_4
.LBB0_4:                                @ %entry
	ldr	r3, [sp, #12]
	mov	r1, #576
	orr	r1, r1, #999424
	mla	r0, r2, r1, r3
	add	sp, sp, #16
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	ualarm, .Ltmp0-ualarm
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
