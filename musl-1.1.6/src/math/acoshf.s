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
	.file	"src/math/acoshf.bc"
	.globl	acoshf
	.align	2
	.type	acoshf,%function
acoshf:                                 @ @acoshf
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, lr}
	push	{r4, r5, r6, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r4, r0
	mov	r1, #0
	bic	r0, r4, #-2147483648
	cmp	r1, r0, lsr #30
	bne	.LBB0_7
	b	.LBB0_2
.LBB0_2:                                @ %if.then
	mov	r1, #1065353216
	mov	r0, r4
	orr	r1, r1, #-2147483648
	bl	__aeabi_fadd
	b	.LBB0_3
.LBB0_3:                                @ %if.then
	mov	r4, r0
	mov	r1, r4
                                        @ kill: R0<def> R4<kill>
	bl	__aeabi_fmul
	b	.LBB0_4
.LBB0_4:                                @ %if.then
	mov	r5, r0
	mov	r0, r4
	mov	r1, r4
	bl	__aeabi_fadd
	b	.LBB0_5
.LBB0_5:                                @ %if.then
	mov	r1, r0
	mov	r0, r5
	bl	__aeabi_fadd
	bl	sqrtf
	b	.LBB0_6
.LBB0_6:                                @ %if.then
	mov	r1, r0
	mov	r0, r4
	bl	__aeabi_fadd
	pop	{r4, r5, r6, lr}
	b	log1pf
.LBB0_7:                                @ %if.end
	lsr	r0, r0, #23
	cmp	r0, #138
	bhi	.LBB0_13
	b	.LBB0_8
.LBB0_8:                                @ %if.then8
	mov	r0, r4
	mov	r1, r4
	bl	__aeabi_fadd
	mov	r5, r0
	b	.LBB0_9
.LBB0_9:                                @ %if.then8
	mov	r0, r4
	mov	r1, r4
	bl	__aeabi_fmul
	mov	r6, #1065353216
	b	.LBB0_10
.LBB0_10:                               @ %if.then8
	orr	r6, r6, #-2147483648
	mov	r1, r6
	bl	__aeabi_fadd
	bl	sqrtf
	b	.LBB0_11
.LBB0_11:                               @ %if.then8
	mov	r1, r4
	bl	__aeabi_fadd
	mov	r1, r0
	mov	r0, r6
	b	.LBB0_12
.LBB0_12:                               @ %if.then8
	bl	__aeabi_fdiv
	mov	r1, r0
	mov	r0, r5
	bl	__aeabi_fadd
	pop	{r4, r5, r6, lr}
	b	logf
.LBB0_13:                               @ %return
	mov	r0, r4
	bl	logf
	ldr	r1, .LCPI0_0
	bl	__aeabi_fadd
	pop	{r4, r5, r6, lr}
	mov	pc, lr
.LCPI0_0:
	.long	1060205080              @ 0x3f317218
.Ltmp0:
	.size	acoshf, .Ltmp0-acoshf
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
