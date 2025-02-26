.section pclose_text
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
	.file	"src/stdio/pclose.bc"
	.globl	pclose
	.align	2
	.type	pclose,%function
.section bb0_0
pclose:                                 @ @pclose
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r7, r11, lr}
	push	{r4, r7, r11, lr}
	b	.LBB0_1
.section bb0_1
.LBB0_1:                                @ %entry
	.pad	#8
	sub	sp, sp, #8
	b	.LBB0_2
.section bb0_2
.LBB0_2:                                @ %entry
	ldr	r4, [r0, #64]
	bl	fclose
	add	r1, sp, #4
	mov	r7, #114
	mov	r2, #0
	mov	r3, #0
	b	.LBB0_3
.section bb0_3
.LBB0_3:                                @ %while.cond
                                        @ =>This Inner Loop Header: Depth=1
	mov	r0, r4
	@APP
	svc	#0
	@NO_APP
	cmn	r0, #4
	beq	.LBB0_3
	b	.LBB0_4
.section bb0_4
.LBB0_4:                                @ %while.end
	cmp	r0, #0
	blt	.LBB0_6
	b	.LBB0_5
.section bb0_5
.LBB0_5:                                @ %if.end
	ldr	r0, [sp, #4]
	b	.LBB0_7
.section bb0_6
.LBB0_6:                                @ %if.then
	bl	__syscall_ret
	b	.LBB0_7
.section bb0_7
.LBB0_7:                                @ %return
	add	sp, sp, #8
	pop	{r4, r7, r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	pclose, .Ltmp0-pclose
	.cantunwind
	.fnend

	.hidden	__syscall_ret

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
