.section semget_text
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
	.file	"src/ipc/semget.bc"
	.globl	semget
	.align	2
	.type	semget,%function
.section bb0_0
semget:                                 @ @semget
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r7, lr}
	push	{r7, lr}
	cmp	r1, #65536
	blt	.LBB0_2
	b	.LBB0_1
.section bb0_1
.LBB0_1:                                @ %if.then
	mvn	r0, #21
	pop	{r7, lr}
	b	__syscall_ret
.section bb0_2
.LBB0_2:                                @ %if.end
	mov	r7, #43
	orr	r7, r7, #256
	@APP
	svc	#0
	@NO_APP
	pop	{r7, lr}
	b	__syscall_ret
.Ltmp0:
	.size	semget, .Ltmp0-semget
	.cantunwind
	.fnend

	.hidden	__syscall_ret

	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
