.section raise_text
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
	.file	"src/signal/raise.bc"
	.globl	raise
	.align	2
	.type	raise,%function
.section bb0_0
raise:                                  @ @raise
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r4, r5, r7, lr}
	push	{r4, r5, r7, lr}
	b	.LBB0_1
.section bb0_1
.LBB0_1:                                @ %entry
	.pad	#128
	sub	sp, sp, #128
	b	.LBB0_2
.section bb0_2
.LBB0_2:                                @ %entry
	mov	r5, sp
	mov	r4, r0
	mov	r0, r5
	bl	__block_app_sigs
	b	.LBB0_3
.section bb0_3
.LBB0_3:                                @ %entry
	mov	r7, #224
	mov	r1, r4
	@APP
	svc	#0
	@NO_APP
	mov	r7, #238
	b	.LBB0_4
.section bb0_4
.LBB0_4:                                @ %entry
	@APP
	svc	#0
	@NO_APP
	bl	__syscall_ret
	mov	r4, r0
	mov	r0, r5
	b	.LBB0_5
.section bb0_5
.LBB0_5:                                @ %entry
	bl	__restore_sigs
	mov	r0, r4
	add	sp, sp, #128
	pop	{r4, r5, r7, lr}
	mov	pc, lr
.Ltmp0:
	.size	raise, .Ltmp0-raise
	.cantunwind
	.fnend

	.hidden	__syscall_ret

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
