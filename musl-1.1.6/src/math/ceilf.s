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
	.file	"src/math/ceilf.bc"
	.globl	ceilf
	.align	2
	.type	ceilf,%function
ceilf:                                  @ @ceilf
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#8
	sub	sp, sp, #8
	b	.LBB0_2
.LBB0_2:                                @ %entry
	mov	r4, r0
	mov	r0, #255
	and	r0, r0, r4, lsr #23
	sub	r0, r0, #127
	cmp	r0, #22
	bgt	.LBB0_10
	b	.LBB0_3
.LBB0_3:                                @ %if.end
	cmp	r0, #0
	blt	.LBB0_7
	b	.LBB0_4
.LBB0_4:                                @ %if.then2
	ldr	r1, .LCPI0_0
	tst	r4, r1, lsr r0
	beq	.LBB0_10
	b	.LBB0_5
.LCPI0_0:
	.long	8388607                 @ 0x7fffff
.LBB0_5:                                @ %do.body
	lsr	r5, r1, r0
	mov	r1, #998244352
	mov	r0, r4
	orr	r1, r1, #1073741824
	b	.LBB0_6
.LBB0_6:                                @ %do.body
	bl	__aeabi_fadd
	cmp	r4, #0
	str	r0, [sp, #4]
	addge	r4, r4, r5
	bic	r0, r4, r5
	b	.LBB0_11
.LBB0_7:                                @ %do.body18
	mov	r1, #998244352
	mov	r0, r4
	orr	r1, r1, #1073741824
	bl	__aeabi_fadd
	b	.LBB0_8
.LBB0_8:                                @ %do.body18
	str	r0, [sp]
	mov	r0, #-2147483648
	cmp	r4, #0
	blt	.LBB0_11
	b	.LBB0_9
.LBB0_9:                                @ %if.else26
	mvn	r0, #-2147483648
	tst	r4, r0
	movne	r4, #1065353216
	b	.LBB0_10
.LBB0_10:                               @ %return
	mov	r0, r4
	b	.LBB0_11
.LBB0_11:                               @ %return
	add	sp, sp, #8
	pop	{r4, r5, r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	ceilf, .Ltmp0-ceilf
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
