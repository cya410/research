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
	.file	"src/thread/pthread_mutex_consistent.bc"
	.globl	pthread_mutex_consistent
	.align	2
	.type	pthread_mutex_consistent,%function
pthread_mutex_consistent:               @ @pthread_mutex_consistent
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r1, r0
	mov	r0, #22
	ldr	r2, [r1]
	tst	r2, #8
	beq	.LBB0_4
	b	.LBB0_2
.LBB0_2:                                @ %if.end
	@APP
	bl	__a_gettp
	mov	r3, r0
	@NO_APP
	ldr	r0, [r1, #4]
	ldr	r12, [r3, #-160]
	bic	r3, r0, #-2147483648
	b	.LBB0_3
.LBB0_3:                                @ %if.end
	mov	r0, #1
	cmp	r3, r12
	biceq	r0, r2, #8
	streq	r0, [r1]
	moveq	r0, #0
	b	.LBB0_4
.LBB0_4:                                @ %return
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	pthread_mutex_consistent, .Ltmp0-pthread_mutex_consistent
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
