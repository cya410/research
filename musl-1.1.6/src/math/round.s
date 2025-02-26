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
	.file	"src/math/round.bc"
	.globl	round
	.align	2
	.type	round,%function
round:                                  @ @round
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	push	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	b	.LBB0_2
.LBB0_2:                                @ %entry
	.pad	#12
	sub	sp, sp, #12
	b	.LBB0_3
.LBB0_3:                                @ %entry
	mov	r5, r0
	mov	r0, #255
	mov	r11, r1
	b	.LBB0_4
.LBB0_4:                                @ %entry
	orr	r0, r0, #1792
	mov	r7, r5
	and	r4, r0, r11, lsr #20
	mov	r0, #50
	orr	r0, r0, #1024
	cmp	r4, r0
	bls	.LBB0_6
	b	.LBB0_5
.LBB0_5:
	mov	r1, r11
	b	.LBB0_28
.LBB0_6:                                @ %if.end
	mov	r0, #0
	mov	r1, #-2147483648
	mov	r2, r7
	mov	r3, r11
	b	.LBB0_7
.LBB0_7:                                @ %if.end
	bl	__aeabi_dsub
	cmp	r11, #0
	mov	r6, r1
	mov	r3, #53477376
	b	.LBB0_8
.LBB0_8:                                @ %if.end
	mov	r2, #0
	movlt	r5, r0
	movge	r6, r11
	orr	r3, r3, #1073741824
	b	.LBB0_9
.LBB0_9:                                @ %if.end
	mov	r0, r5
	mov	r1, r6
	bl	__aeabi_dadd
	mov	r2, #253
	orr	r2, r2, #768
	cmp	r4, r2
	bhi	.LBB0_12
	b	.LBB0_10
.LBB0_10:                               @ %do.body
	str	r0, [sp]
	str	r1, [sp, #4]
	mov	r0, r7
	mov	r1, r11
	b	.LBB0_11
.LBB0_11:                               @ %do.body
	mov	r2, #0
	mov	r3, #0
	bl	__aeabi_dmul
	mov	r7, r0
	b	.LBB0_28
.LBB0_12:                               @ %if.end10
	mov	r3, #53477376
	mov	r2, #0
	orr	r3, r3, #-1073741824
	bl	__aeabi_dadd
	b	.LBB0_13
.LBB0_13:                               @ %if.end10
	mov	r2, r5
	mov	r3, r6
	bl	__aeabi_dsub
	mov	r9, #266338304
	b	.LBB0_14
.LBB0_14:                               @ %if.end10
	mov	r7, r0
	mov	r8, r1
	mov	r2, #0
	orr	r9, r9, #805306368
	b	.LBB0_15
.LBB0_15:                               @ %if.end10
                                        @ kill: R0<def> R7<kill>
                                        @ kill: R1<def> R8<kill>
	mov	r3, r9
	bl	__aeabi_dcmple
	b	.LBB0_16
.LBB0_16:                               @ %if.end10
	mov	r10, r0
	mov	r0, r7
	mov	r1, r8
	mov	r2, #0
	b	.LBB0_17
.LBB0_17:                               @ %if.end10
	mov	r3, r9
	bl	__aeabi_dcmpun
	orrs	r0, r0, r10
	bne	.LBB0_19
	b	.LBB0_18
.LBB0_18:                               @ %if.then16
	mov	r0, r5
	mov	r1, r6
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_dadd
	mov	r3, #267386880
	orr	r3, r3, #-1342177280
	b	.LBB0_25
.LBB0_19:                               @ %if.else
	mov	r9, #266338304
	mov	r0, r7
	mov	r1, r8
	mov	r2, #0
	b	.LBB0_20
.LBB0_20:                               @ %if.else
	orr	r9, r9, #-1342177280
	mov	r3, r9
	bl	__aeabi_dcmpgt
	mov	r10, r0
	b	.LBB0_21
.LBB0_21:                               @ %if.else
	mov	r0, r7
	mov	r1, r8
	mov	r2, #0
	mov	r3, r9
	b	.LBB0_22
.LBB0_22:                               @ %if.else
	bl	__aeabi_dcmpun
	orr	r4, r0, r10
	mov	r0, r5
	mov	r1, r6
	b	.LBB0_23
.LBB0_23:                               @ %if.else
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_dadd
	mov	r5, r0
	mov	r6, r1
	cmp	r4, #0
	bne	.LBB0_26
	b	.LBB0_24
.LBB0_24:                               @ %if.then21
	mov	r3, #267386880
	mov	r0, r5
	mov	r1, r6
	orr	r3, r3, #805306368
	b	.LBB0_25
.LBB0_25:                               @ %if.end27
	mov	r2, #0
	bl	__aeabi_dadd
	mov	r5, r0
	mov	r6, r1
	b	.LBB0_26
.LBB0_26:                               @ %if.end27
	mov	r0, #0
	mov	r1, #-2147483648
	mov	r2, r5
	mov	r3, r6
	b	.LBB0_27
.LBB0_27:                               @ %if.end27
	bl	__aeabi_dsub
	cmp	r11, #0
	mov	r7, r0
	movge	r1, r6
	movge	r7, r5
	b	.LBB0_28
.LBB0_28:                               @ %return
	mov	r0, r7
	add	sp, sp, #12
	pop	{r4, r5, r6, r7, r8, r9, r10, r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	round, .Ltmp0-round
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
