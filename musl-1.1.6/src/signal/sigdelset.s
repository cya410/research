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
	.file	"src/signal/sigdelset.bc"
	.globl	sigdelset
	.align	2
	.type	sigdelset,%function
sigdelset:                              @ @sigdelset
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	sub	r2, r1, #1
	cmp	r2, #63
	bhi	.LBB0_4
	b	.LBB0_1
.LBB0_1:                                @ %entry
	sub	r1, r1, #32
	cmp	r1, #2
	bls	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                @ %if.end
	mvn	r1, #-536870909
	mov	r3, #1
	and	r1, r1, r2, lsr #3
	and	r2, r2, #31
	b	.LBB0_3
.LBB0_3:                                @ %if.end
	ldr	r12, [r0, r1]
	bic	r2, r12, r3, lsl r2
	str	r2, [r0, r1]
	mov	r0, #0
	b	.LBB0_5
.LBB0_4:                                @ %if.then
	bl	__errno_location
	mov	r1, #22
	str	r1, [r0]
	mvn	r0, #0
	b	.LBB0_5
.LBB0_5:                                @ %return
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	sigdelset, .Ltmp0-sigdelset
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
