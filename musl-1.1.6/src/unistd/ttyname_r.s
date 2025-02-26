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
	.file	"src/unistd/ttyname_r.bc"
	.globl	ttyname_r
	.align	2
	.type	ttyname_r,%function
ttyname_r:                              @ @ttyname_r
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, r7, r11, lr}
	push	{r4, r5, r6, r7, r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	b	.LBB0_2
.LBB0_2:                                @ %entry
	.pad	#32
	sub	sp, sp, #32
	mov	r6, r0
	mov	r5, r2
	b	.LBB0_3
.LBB0_3:                                @ %entry
	mov	r4, r1
                                        @ kill: R0<def> R6<kill>
	bl	isatty
	mov	r1, r0
	mov	r0, #25
	cmp	r1, #0
	beq	.LBB0_8
	b	.LBB0_4
.LBB0_4:                                @ %if.end
	add	r7, sp, #3
	mov	r1, r6
	mov	r0, r7
	bl	__procfdname
	b	.LBB0_5
.LBB0_5:                                @ %if.end
	mov	r0, r7
	mov	r1, r4
	mov	r2, r5
	bl	readlink
	mov	r1, r0
	cmp	r1, #0
	blt	.LBB0_7
	b	.LBB0_6
.LBB0_6:                                @ %if.else
	mov	r0, #34
	cmp	r1, r5
	movne	r0, #0
	strbne	r0, [r4, r1]
	b	.LBB0_8
.LBB0_7:                                @ %if.then3
	bl	__errno_location
	ldr	r0, [r0]
	b	.LBB0_8
.LBB0_8:                                @ %return
	add	sp, sp, #32
	pop	{r4, r5, r6, r7, r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	ttyname_r, .Ltmp0-ttyname_r
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
