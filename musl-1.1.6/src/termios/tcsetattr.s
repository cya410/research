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
	.file	"src/termios/tcsetattr.bc"
	.globl	tcsetattr
	.align	2
	.type	tcsetattr,%function
tcsetattr:                              @ @tcsetattr
	.fnstart
.Leh_func_begin0:
.LBB0_0:                                @ %entry
	.save	{r11, lr}
	push	{r11, lr}
	cmp	r1, #2
	bls	.LBB0_2
	b	.LBB0_1
.LBB0_1:                                @ %return
	bl	__errno_location
	mov	r1, #22
	str	r1, [r0]
	mvn	r0, #0
	pop	{r11, lr}
	mov	pc, lr
.LBB0_2:                                @ %if.end
	add	r1, r1, #2
	add	r1, r1, #21504
	bl	ioctl
	pop	{r11, lr}
	mov	pc, lr
.Ltmp0:
	.size	tcsetattr, .Ltmp0-tcsetattr
	.cantunwind
	.fnend


	.ident	"clang version 3.7.0 (trunk 229146)"
	.section	".note.GNU-stack","",%progbits
