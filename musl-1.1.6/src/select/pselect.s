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
	.file	"src/select/pselect.bc"
	.globl	pselect
	.align	2
	.type	pselect,%function
pselect:                                @ @pselect
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, lr}
	push	{r4, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#32
	sub	sp, sp, #32
	mov	lr, r1
	mov	r1, r0
	b	.LBB0_2
.LBB0_2:                                @ %entry
	ldr	r0, [sp, #44]
	mov	r12, r2
	str	r0, [sp, #24]
	mov	r0, #8
	b	.LBB0_3
.LBB0_3:                                @ %entry
	str	r0, [sp, #28]
	ldr	r0, [sp, #40]
	cmp	r0, #0
	ldmne	r0, {r2, r4}
	b	.LBB0_4
.LBB0_4:                                @ %entry
	strne	r4, [sp, #20]
	strne	r2, [sp, #16]
	add	r4, sp, #16
	cmp	r0, #0
	b	.LBB0_5
.LBB0_5:                                @ %entry
	add	r2, sp, #24
	moveq	r4, r0
	mov	r0, #79
	stm	sp, {r3, r4}
	b	.LBB0_6
.LBB0_6:                                @ %entry
	str	r2, [sp, #8]
	orr	r0, r0, #256
	mov	r2, lr
	mov	r3, r12
	b	.LBB0_7
.LBB0_7:                                @ %entry
	bl	__syscall_cp
	bl	__syscall_ret
	add	sp, sp, #32
	pop	{r4, lr}
	mov	pc, lr
.Ltmp0:
	.size	pselect, .Ltmp0-pselect
	.cantunwind
	.fnend

	.hidden	__syscall_ret
	.hidden	__syscall_cp

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
