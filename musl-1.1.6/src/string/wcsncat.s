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
	.file	"src/string/wcsncat.bc"
	.globl	wcsncat
	.align	2
	.type	wcsncat,%function
wcsncat:                                @ @wcsncat
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, lr}
	push	{r4, r5, r6, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r4, r0
	mov	r5, r2
	b	.LBB0_2
.LBB0_2:                                @ %entry
	mov	r6, r1
                                        @ kill: R0<def> R4<kill>
	bl	wcslen
	add	r0, r4, r0, lsl #2
	cmp	r5, #0
	beq	.LBB0_4
	b	.LBB0_3
.LBB0_3:                                @ %land.rhs
                                        @ =>This Inner Loop Header: Depth=1
	ldr	r1, [r6]
	cmp	r1, #0
	strne	r1, [r0], #4
	addne	r6, r6, #4
	subsne	r5, r5, #1
	bne	.LBB0_3
	b	.LBB0_4
.LBB0_4:                                @ %while.end
	mov	r1, #0
	str	r1, [r0]
	mov	r0, r4
	pop	{r4, r5, r6, lr}
	mov	pc, lr
.Ltmp0:
	.size	wcsncat, .Ltmp0-wcsncat
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
