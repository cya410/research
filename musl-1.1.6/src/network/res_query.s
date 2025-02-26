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
	.file	"src/network/res_query.bc"
	.globl	__res_query
	.align	2
	.type	__res_query,%function
__res_query:                            @ @__res_query
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, r7, r8, lr}
	push	{r4, r5, r6, r7, r8, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	b	.LBB0_2
.LBB0_2:                                @ %entry
	.pad	#304
	sub	sp, sp, #304
	mov	r6, r3
	mov	r3, r2
	b	.LBB0_3
.LBB0_3:                                @ %entry
	mov	r2, r1
	mov	r1, r0
	mov	r5, #0
	mov	r0, #280
	b	.LBB0_4
.LBB0_4:                                @ %entry
	add	r4, sp, #24
	str	r5, [sp]
	str	r5, [sp, #4]
	str	r5, [sp, #8]
	b	.LBB0_5
.LBB0_5:                                @ %entry
	str	r4, [sp, #12]
	str	r0, [sp, #16]
	mov	r0, #0
	bl	__res_mkquery
	mov	r1, r0
	cmp	r1, #0
	blt	.LBB0_7
	b	.LBB0_6
.LBB0_6:                                @ %if.end
	ldr	r3, [sp, #328]
	add	r0, sp, #24
	mov	r2, r6
	bl	__res_send
	mov	r1, r0
	b	.LBB0_7
.LBB0_7:                                @ %cleanup
	mov	r0, r1
	add	sp, sp, #304
	pop	{r4, r5, r6, r7, r8, lr}
	mov	pc, lr
.Ltmp0:
	.size	__res_query, .Ltmp0-__res_query
	.cantunwind
	.fnend


	.weak	res_query
res_query = __res_query
	.weak	res_search
res_search = __res_query
	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
