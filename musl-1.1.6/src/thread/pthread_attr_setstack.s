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
	.file	"src/thread/pthread_attr_setstack.bc"
	.globl	pthread_attr_setstack
	.align	2
	.type	pthread_attr_setstack,%function
pthread_attr_setstack:                  @ @pthread_attr_setstack
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	lr, #22
	sub	r12, r2, #2048
	mov	r3, #0
	cmp	r3, r12, lsr #30
	bne	.LBB0_3
	b	.LBB0_2
.LBB0_2:                                @ %if.end
	add	r1, r1, r2
	mov	lr, #0
	str	r1, [r0, #8]
	sub	r1, r2, #81920
	str	r1, [r0]
	b	.LBB0_3
.LBB0_3:                                @ %return
	mov	r0, lr
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	pthread_attr_setstack, .Ltmp0-pthread_attr_setstack
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits