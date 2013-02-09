	.section	__TEXT,__text,regular,pure_instructions
	.section	__TEXT,__const
	.align	4
LCPI1_0:
	.quad	4613937818241073152
	.quad	4613937818241073152
LCPI1_1:
	.quad	4611686018427387904
	.quad	4611686018427387904
	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI1_2:
	.quad	4613937818241073152
LCPI1_3:
	.quad	4616189618054758400
LCPI1_4:
	.quad	4611686018427387904
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:
Leh_func_begin1:
	pushq	%rbp
Ltmp0:
	movq	%rsp, %rbp
Ltmp1:
	subq	$64, %rsp
Ltmp2:
	movabsq	$4607182418800017408, %rax
	movq	%rax, -32(%rbp)
	movabsq	$4611686018427387904, %rax
	movq	%rax, -24(%rbp)
	movabsq	$4613937818241073152, %rax
	movq	%rax, -16(%rbp)
	movabsq	$4616189618054758400, %rax
	movq	%rax, -8(%rbp)
	xorpd	%xmm0, %xmm0
	movapd	-32(%rbp), %xmm1
	movapd	-16(%rbp), %xmm2
	movapd	%xmm1, %xmm3
	mulpd	%xmm0, %xmm3
	movapd	%xmm2, %xmm4
	mulpd	%xmm0, %xmm4
	movapd	LCPI1_0(%rip), %xmm5
	mulpd	%xmm1, %xmm5
	addpd	%xmm0, %xmm5
	addpd	%xmm4, %xmm5
	movapd	%xmm5, -48(%rbp)
	movd	%xmm5, %rax
	movd	%rax, %xmm4
	addpd	%xmm0, %xmm3
	movapd	LCPI1_1(%rip), %xmm0
	mulpd	%xmm2, %xmm0
	addpd	%xmm3, %xmm0
	movapd	%xmm0, -64(%rbp)
	movd	%xmm0, %rax
	movd	%rax, %xmm5
	movd	%xmm1, %rax
	movd	%rax, %xmm0
	movd	%xmm2, %rax
	movd	%rax, %xmm1
	leaq	L_.str(%rip), %rdi
	movsd	LCPI1_2(%rip), %xmm2
	pxor	%xmm3, %xmm3
	movb	$6, %al
	callq	_printf
	movdqa	-48(%rbp), %xmm5
	punpckhqdq	%xmm5, %xmm5
	movd	%xmm5, %rax
	movd	%rax, %xmm4
	movdqa	-64(%rbp), %xmm0
	punpckhqdq	%xmm0, %xmm0
	movd	%xmm0, %rax
	movd	%rax, %xmm5
	leaq	L_.str1(%rip), %rdi
	movsd	LCPI1_3(%rip), %xmm1
	movsd	LCPI1_4(%rip), %xmm0
	pxor	%xmm2, %xmm2
	movapd	%xmm0, %xmm3
	movb	$6, %al
	callq	_printf
	xorl	%eax, %eax
	addq	$64, %rsp
	popq	%rbp
	ret
Leh_func_end1:

	.section	__TEXT,__cstring,cstring_literals
L_.str:
	.asciz	 "|%g %g| * |%g %g| = |%g %g|\n"

L_.str1:
	.asciz	 "|%g %g|   |%g %g|   |%g %g|\n"

	.section	__TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame0:
Lsection_eh_frame:
Leh_frame_common:
Lset0 = Leh_frame_common_end-Leh_frame_common_begin
	.long	Lset0
Leh_frame_common_begin:
	.long	0
	.byte	1
	.asciz	 "zR"
	.byte	1
	.byte	120
	.byte	16
	.byte	1
	.byte	16
	.byte	12
	.byte	7
	.byte	8
	.byte	144
	.byte	1
	.align	3
Leh_frame_common_end:
	.globl	_main.eh
_main.eh:
Lset1 = Leh_frame_end1-Leh_frame_begin1
	.long	Lset1
Leh_frame_begin1:
Lset2 = Leh_frame_begin1-Leh_frame_common
	.long	Lset2
Ltmp3:
	.quad	Leh_func_begin1-Ltmp3
Lset3 = Leh_func_end1-Leh_func_begin1
	.quad	Lset3
	.byte	0
	.byte	4
Lset4 = Ltmp0-Leh_func_begin1
	.long	Lset4
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset5 = Ltmp1-Ltmp0
	.long	Lset5
	.byte	13
	.byte	6
	.align	3
Leh_frame_end1:


.subsections_via_symbols
