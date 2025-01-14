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
	.file	"src/time/gettimeofday.bc"
	.globl	gettimeofday
	.align	2
	.type	gettimeofday,%function
gettimeofday:                           @ @gettimeofday
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, lr}
	push	{r4, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#8
	sub	sp, sp, #8
	mov	r4, r0
	cmp	r4, #0
	beq	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                @ %if.end
	mov	r1, sp
	mov	r0, #0
	bl	clock_gettime
	ldr	r0, [sp]
	b	.LBB0_3
.LBB0_3:                                @ %if.end
	str	r0, [r4]
	ldr	r0, .LCPI0_0
	ldr	r1, [sp, #4]
	smull	r2, r3, r1, r0
	asr	r0, r3, #6
	add	r0, r0, r3, lsr #31
	str	r0, [r4, #4]
	b	.LBB0_4
.LCPI0_0:
	.long	274877907               @ 0x10624dd3
.LBB0_4:                                @ %return
	mov	r0, #0
	add	sp, sp, #8
	pop	{r4, lr}
	mov	pc, lr
.Ltmp0:
	.size	gettimeofday, .Ltmp0-gettimeofday
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
