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
	.file	"src/ipc/ftok.bc"
	.globl	ftok
	.align	2
	.type	ftok,%function
ftok:                                   @ @ftok
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, lr}
	push	{r4, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	.pad	#104
	sub	sp, sp, #104
	mov	r4, r1
	mov	r1, sp
	b	.LBB0_2
.LBB0_2:                                @ %entry
	bl	stat
	mov	r1, r0
	mvn	r0, #0
	cmp	r1, #0
	blt	.LBB0_4
	b	.LBB0_3
.LBB0_3:                                @ %if.end
	ldr	r0, [sp]
	mov	r1, #16711680
	and	r0, r1, r0, lsl #16
	ldrh	r1, [sp, #96]
	orr	r1, r1, r4, lsl #24
	orr	r0, r1, r0
	b	.LBB0_4
.LBB0_4:                                @ %cleanup
	add	sp, sp, #104
	pop	{r4, lr}
	mov	pc, lr
.Ltmp0:
	.size	ftok, .Ltmp0-ftok
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
