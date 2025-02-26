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
	.file	"src/multibyte/c16rtomb.bc"
	.globl	c16rtomb
	.align	2
	.type	c16rtomb,%function
c16rtomb:                               @ @c16rtomb
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	ldr	r3, .LCPI0_0
	cmp	r2, #0
	movne	r3, r2
	cmp	r0, #0
	ldr	lr, [r3]
	beq	.LBB0_5
	b	.LBB0_2
.LCPI0_0:
	.long	c16rtomb.internal_state
.LBB0_2:                                @ %if.end6
	and	r12, r1, #64512
	cmp	lr, #0
	beq	.LBB0_7
	b	.LBB0_3
.LBB0_3:                                @ %if.then14
	cmp	r12, #56320
	bne	.LBB0_6
	b	.LBB0_4
.LBB0_4:                                @ %if.else
	add	r1, r1, lr
	mov	r2, #0
	sub	r1, r1, #56320
	str	r2, [r3]
	b	.LBB0_10
.LBB0_5:                                @ %if.then2
	mov	r0, #1
	cmp	lr, #0
	beq	.LBB0_9
	b	.LBB0_6
.LBB0_6:                                @ %ilseq
	mov	r0, #0
	str	r0, [r3]
	bl	__errno_location
	mov	r1, #84
	str	r1, [r0]
	mvn	r0, #0
	b	.LBB0_9
.LBB0_7:                                @ %land.lhs.true
	cmp	r12, #55296
	bne	.LBB0_10
	b	.LBB0_8
.LBB0_8:                                @ %if.then9
	mov	r0, #10551296
	orr	r0, r0, #-67108864
	add	r0, r0, r1, lsl #10
	str	r0, [r3]
	mov	r0, #0
	b	.LBB0_9
.LBB0_9:                                @ %return
	pop	{r11, lr}
	mov	pc, lr
.LBB0_10:                               @ %if.end25
	mov	r2, #0
	pop	{r11, lr}
	b	wcrtomb
.Ltmp0:
	.size	c16rtomb, .Ltmp0-c16rtomb
	.cantunwind
	.fnend

	.type	c16rtomb.internal_state,%object @ @c16rtomb.internal_state
	.local	c16rtomb.internal_state
	.comm	c16rtomb.internal_state,4,4

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
