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
	.file	"src/math/rintf.bc"
	.globl	rintf
	.align	2
	.type	rintf,%function
rintf:                                  @ @rintf
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, lr}
	push	{r4, r5, r6, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r4, r0
	mov	r1, #176160768
	b	.LBB0_2
.LBB0_2:                                @ %entry
	and	r0, r4, #2130706432
	orr	r1, r1, #1073741824
	cmp	r0, r1
	bls	.LBB0_4
	b	.LBB0_3
.LBB0_3:
	mov	r5, r4
	b	.LBB0_8
.LBB0_4:                                @ %if.end
	mov	r0, r4
	mov	r1, #-889192448
	bl	__aeabi_fadd
	mov	r1, #1258291200
	b	.LBB0_5
.LBB0_5:                                @ %if.end
	bl	__aeabi_fadd
	mov	r6, r0
	mov	r0, r4
	mov	r1, #1258291200
	b	.LBB0_6
.LBB0_6:                                @ %if.end
	bl	__aeabi_fadd
	mov	r1, #-889192448
	bl	__aeabi_fadd
	mov	r5, r0
	b	.LBB0_7
.LBB0_7:                                @ %if.end
	cmp	r4, #0
	mov	r1, #0
	movlt	r5, r6
	mov	r0, r5
	bl	__aeabi_fcmpeq
	cmp	r0, #0
	andne	r5, r4, #-2147483648
	b	.LBB0_8
.LBB0_8:                                @ %return
	mov	r0, r5
	pop	{r4, r5, r6, lr}
	mov	pc, lr
.Ltmp0:
	.size	rintf, .Ltmp0-rintf
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
