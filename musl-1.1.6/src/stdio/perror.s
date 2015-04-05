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
	.file	"src/stdio/perror.bc"
	.globl	perror
	.align	2
	.type	perror,%function
perror:                                 @ @perror
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, r7, r11, lr}
	push	{r4, r5, r6, r7, r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	b	.LBB0_2
.LBB0_2:                                @ %entry
	mov	r7, r0
	bl	__errno_location
	ldr	r1, .LCPI0_0
	ldr	r0, [r0]
	b	.LBB0_3
.LCPI0_0:
	.long	stderr
.LBB0_3:                                @ %entry
	ldr	r4, [r1]
	bl	strerror
	mov	r6, r0
	ldr	r0, [r4, #76]
	mov	r5, #0
	cmp	r0, #0
	blt	.LBB0_5
	b	.LBB0_4
.LBB0_4:                                @ %cond.true
	mov	r0, r4
	bl	__lockfile
	mov	r5, r0
	b	.LBB0_5
.LBB0_5:                                @ %cond.end
	cmp	r7, #0
	ldrbne	r0, [r7]
	cmpne	r0, #0
	beq	.LBB0_9
	b	.LBB0_6
.LBB0_6:                                @ %if.then
	mov	r0, r7
	bl	strlen
	mov	r1, r0
	mov	r0, r7
	b	.LBB0_7
.LBB0_7:                                @ %if.then
	mov	r2, #1
	mov	r3, r4
	bl	fwrite
	mov	r0, #58
	b	.LBB0_8
.LBB0_8:                                @ %if.then
	mov	r1, r4
	bl	fputc
	mov	r0, #32
	mov	r1, r4
	bl	fputc
	b	.LBB0_9
.LBB0_9:                                @ %if.end
	mov	r0, r6
	bl	strlen
	mov	r1, r0
	mov	r0, r6
	b	.LBB0_10
.LBB0_10:                               @ %if.end
	mov	r2, #1
	mov	r3, r4
	bl	fwrite
	mov	r0, #10
	b	.LBB0_11
.LBB0_11:                               @ %if.end
	mov	r1, r4
	bl	fputc
	cmp	r5, #0
	popeq	{r4, r5, r6, r7, r11, lr}
	moveq	pc, lr
	mov	r0, r4
	pop	{r4, r5, r6, r7, r11, lr}
	b	__unlockfile
.Ltmp0:
	.size	perror, .Ltmp0-perror
	.cantunwind
	.fnend

	.hidden	__lockfile
	.hidden	__unlockfile

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits