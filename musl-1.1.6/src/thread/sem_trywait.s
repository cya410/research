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
	.file	"src/thread/sem_trywait.bc"
	.globl	sem_trywait
	.align	2
	.type	sem_trywait,%function
sem_trywait:                            @ @sem_trywait
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r6, lr}
	push	{r4, r5, r6, lr}
	b	.LBB0_1
.LBB0_1:                                @ %entry
	mov	r4, r0
	ldr	r0, [r4]
	b	.LBB0_8
.LBB0_2:                                @ %while.body
                                        @   in Loop: Header=BB0_8 Depth=1
	sub	r6, r5, #1
	mov	r0, #0
	bne	.LBB0_4
	b	.LBB0_3
.LBB0_3:                                @ %land.rhs
                                        @   in Loop: Header=BB0_8 Depth=1
	ldr	r0, [r4, #4]
	cmp	r0, #0
	movne	r0, #1
	b	.LBB0_4
.LBB0_4:                                @ %land.end
                                        @   in Loop: Header=BB0_8 Depth=1
	cmp	r0, #0
	subne	r6, r6, #1
	b	.LBB0_5
.LBB0_5:                                @ %for.cond.i
                                        @   Parent Loop BB0_8 Depth=1
                                        @ =>  This Inner Loop Header: Depth=2
	mov	r0, r5
	mov	r1, r6
	mov	r2, r4
	bl	__a_cas
	b	.LBB0_6
.LBB0_6:                                @ %for.cond.i
                                        @   in Loop: Header=BB0_5 Depth=2
	mov	r1, r0
	mov	r0, #0
	cmp	r1, #0
	beq	.LBB0_10
	b	.LBB0_7
.LBB0_7:                                @ %if.end.i
                                        @   in Loop: Header=BB0_5 Depth=2
	ldr	r0, [r4]
	cmp	r0, r5
	beq	.LBB0_5
	b	.LBB0_8
.LBB0_8:                                @ %while.cond
                                        @ =>This Loop Header: Depth=1
                                        @     Child Loop BB0_5 Depth 2
	mov	r5, r0
	cmp	r5, #1
	bge	.LBB0_2
	b	.LBB0_9
.LBB0_9:                                @ %while.end
	bl	__errno_location
	mov	r1, #11
	str	r1, [r0]
	mvn	r0, #0
	b	.LBB0_10
.LBB0_10:                               @ %return
	pop	{r4, r5, r6, lr}
	mov	pc, lr
.Ltmp0:
	.size	sem_trywait, .Ltmp0-sem_trywait
	.cantunwind
	.fnend

	.hidden	__a_cas

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
