.section asinf_text
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
	.file	"src/math/asinf.bc"
	.globl	asinf
	.align	2
	.type	asinf,%function
.section bb0_0
asinf:                                  @ @asinf
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, r7, r11, lr}
	push	{r4, r5, r6, r7, r11, lr}
	b	.LBB0_1
.section bb0_1
.LBB0_1:                                @ %entry
	b	.LBB0_2
.section bb0_2
.LBB0_2:                                @ %entry
	mov	r4, r0
	bic	r0, r4, #-2147483648
	cmp	r0, #1065353216
	blo	.LBB0_6
	b	.LBB0_3
.section bb0_3
.LBB0_3:                                @ %if.then
	bne	.LBB0_10
	b	.LBB0_4
.section bb0_4
.LBB0_4:                                @ %if.then2
	mov	r0, r4
	bl	__aeabi_f2d
	ldr	r2, .LCPI0_2
	ldr	r3, .LCPI0_4
	b	.LBB0_5
.LCPI0_2:
	.long	1413754136              @ 0x54442d18
.LCPI0_4:
	.long	1073291771              @ 0x3ff921fb
.section bb0_5
.LBB0_5:                                @ %if.then2
	bl	__aeabi_dmul
	mov	r3, #141557760
	mov	r2, #0
	orr	r3, r3, #805306368
	bl	__aeabi_dadd
	bl	__aeabi_d2f
	b	.LBB0_11
.section bb0_6
.LBB0_6:                                @ %if.end4
	lsr	r1, r0, #24
	cmp	r1, #62
	bhi	.LBB0_13
	b	.LBB0_7
.section bb0_7
.LBB0_7:                                @ %if.then7
	sub	r0, r0, #8388608
	cmp	r0, #956301312
	blo	.LBB0_12
	b	.LBB0_8
.section bb0_8
.LBB0_8:                                @ %if.end13
	mov	r0, r4
	mov	r1, r4
	bl	__aeabi_fmul
	bl	R
	b	.LBB0_9
.section bb0_9
.LBB0_9:                                @ %if.end13
	mov	r1, r4
	bl	__aeabi_fmul
	mov	r1, r4
	bl	__aeabi_fadd
	b	.LBB0_11
.section bb0_10
.LBB0_10:                               @ %if.end
	mov	r0, r4
	mov	r1, r4
	bl	__aeabi_fsub
	mov	r1, r0
	mov	r0, #0
	bl	__aeabi_fdiv
	b	.LBB0_11
.section bb0_11
.LBB0_11:                               @ %return
	mov	r4, r0
	b	.LBB0_12
.section bb0_12
.LBB0_12:                               @ %return
	mov	r0, r4
	pop	{r4, r5, r6, r7, r11, lr}
	mov	pc, lr
.section bb0_13
.LBB0_13:                               @ %if.end17
	mov	r0, r4
	bl	fabsf
	mov	r1, r0
	mov	r0, #1065353216
	b	.LBB0_14
.section bb0_14
.LBB0_14:                               @ %if.end17
	bl	__aeabi_fsub
	mov	r1, #1056964608
	bl	__aeabi_fmul
	mov	r5, r0
	b	.LBB0_15
.section bb0_15
.LBB0_15:                               @ %if.end17
                                        @ kill: R0<def> R5<kill>
	bl	__aeabi_f2d
	bl	sqrt
	mov	r6, r0
	b	.LBB0_16
.section bb0_16
.LBB0_16:                               @ %if.end17
	mov	r0, r5
	mov	r7, r1
	bl	R
	bl	__aeabi_f2d
	b	.LBB0_17
.section bb0_17
.LBB0_17:                               @ %if.end17
	mov	r2, r0
	mov	r3, r1
	mov	r0, r6
	mov	r1, r7
	b	.LBB0_18
.section bb0_18
.LBB0_18:                               @ %if.end17
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r6
	b	.LBB0_19
.section bb0_19
.LBB0_19:                               @ %if.end17
	mov	r1, r7
	bl	__aeabi_dadd
	mov	r2, #0
	mov	r3, #-1073741824
	b	.LBB0_20
.section bb0_20
.LBB0_20:                               @ %if.end17
	bl	__aeabi_dmul
	ldr	r2, .LCPI0_3
	ldr	r3, .LCPI0_5
	bl	__aeabi_dadd
	b	.LBB0_21
.LCPI0_3:
	.long	1413754136              @ 0x54442d18
.LCPI0_5:
	.long	1073291771              @ 0x3ff921fb
.section bb0_21
.LBB0_21:                               @ %if.end17
	bl	__aeabi_d2f
	mov	r5, r0
	mov	r0, #-2147483648
	mov	r1, r5
	b	.LBB0_22
.section bb0_22
.LBB0_22:                               @ %if.end17
	bl	__aeabi_fsub
	cmp	r4, #0
	movge	r0, r5
	pop	{r4, r5, r6, r7, r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	asinf, .Ltmp0-asinf
	.cantunwind
	.fnend

	.align	2
	.type	R,%function
.section bb1_0
R:                                      @ @R
	.fnstart
.Leh_func_begin1:
.LBB1_0:                                @ %entry
	.save	{r4, r5, r11, lr}
	push	{r4, r5, r11, lr}
	b	.LBB1_1
.section bb1_1
.LBB1_1:                                @ %entry
	ldr	r1, .LCPI1_0
	mov	r4, r0
	b	.LBB1_2
.LCPI1_0:
	.long	3155022699              @ 0xbc0dd36b
.section bb1_2
.LBB1_2:                                @ %entry
                                        @ kill: R0<def> R4<kill>
	bl	__aeabi_fmul
	ldr	r1, .LCPI1_4
	bl	__aeabi_fadd
	b	.LBB1_3
.LCPI1_4:
	.long	3173979066              @ 0xbd2f13ba
.section bb1_3
.LBB1_3:                                @ %entry
	mov	r1, r4
	bl	__aeabi_fmul
	ldr	r1, .LCPI1_5
	bl	__aeabi_fadd
	b	.LBB1_4
.LCPI1_5:
	.long	1042983541              @ 0x3e2aaa75
.section bb1_4
.LBB1_4:                                @ %entry
	mov	r1, r4
	bl	__aeabi_fmul
	ldr	r1, .LCPI1_6
	mov	r5, r0
	b	.LBB1_5
.LCPI1_6:
	.long	3207914926              @ 0xbf34e5ae
.section bb1_5
.LBB1_5:                                @ %entry
	mov	r0, r4
	bl	__aeabi_fmul
	mov	r1, #1065353216
	bl	__aeabi_fadd
	b	.LBB1_6
.section bb1_6
.LBB1_6:                                @ %entry
	mov	r1, r0
	mov	r0, r5
	bl	__aeabi_fdiv
	pop	{r4, r5, r11, lr}
	mov	pc, lr
.Ltmp1:
	.size	R, .Ltmp1-R
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
