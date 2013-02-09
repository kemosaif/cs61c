	.section	__TEXT,__text,regular,pure_instructions
	.globl	_sum_naive
	.align	4, 0x90
_sum_naive:
Leh_func_begin1:
	pushq	%rbp
Ltmp0:
	movq	%rsp, %rbp
Ltmp1:
	testl	%edi, %edi
	jg	LBB1_2
	xorl	%eax, %eax
	popq	%rbp
	ret
LBB1_2:
	movl	%edi, %ecx
	xorl	%eax, %eax
	.align	4, 0x90
LBB1_3:
	addl	(%rsi), %eax
	addq	$4, %rsi
	decq	%rcx
	jne	LBB1_3
	popq	%rbp
	ret
Leh_func_end1:

	.globl	_sum_unrolled
	.align	4, 0x90
_sum_unrolled:
Leh_func_begin2:
	pushq	%rbp
Ltmp2:
	movq	%rsp, %rbp
Ltmp3:
	movl	%edi, %ecx
	sarl	$31, %ecx
	shrl	$30, %ecx
	addl	%edi, %ecx
	movl	%ecx, %edx
	sarl	$2, %edx
	andl	$-4, %ecx
	testl	%ecx, %ecx
	jg	LBB2_2
	xorl	%eax, %eax
	jmp	LBB2_4
LBB2_2:
	leal	-1(%rcx), %eax
	shrl	$2, %eax
	incq	%rax
	cmpl	$4, %ecx
	movl	$1, %r8d
	cmovgq	%rax, %r8
	leaq	12(%rsi), %r9
	xorl	%eax, %eax
	.align	4, 0x90
LBB2_3:
	addl	-12(%r9), %eax
	addl	-8(%r9), %eax
	addl	-4(%r9), %eax
	addl	(%r9), %eax
	addq	$16, %r9
	decq	%r8
	jne	LBB2_3
LBB2_4:
	cmpl	%edi, %ecx
	jge	LBB2_7
	shll	$2, %edx
	movslq	%edx, %rcx
	leaq	(%rsi,%rcx,4), %rdx
	decl	%edi
	subl	%ecx, %edi
	incq	%rdi
	.align	4, 0x90
LBB2_6:
	addl	(%rdx), %eax
	addq	$4, %rdx
	decq	%rdi
	jne	LBB2_6
LBB2_7:
	popq	%rbp
	ret
Leh_func_end2:

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI3_0:
	.quad	4985484787500187648
LCPI3_1:
	.quad	4747323572421132288
LCPI3_2:
	.quad	4696837146684686336
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_benchmark
	.align	4, 0x90
_benchmark:
Leh_func_begin3:
	pushq	%rbp
Ltmp4:
	movq	%rsp, %rbp
Ltmp5:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
Ltmp6:
	movq	%rcx, -56(%rbp)
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movl	%edi, %r15d
	movl	%r15d, %edi
	movq	%r14, %rsi
	callq	*%rbx
	movl	%eax, -60(%rbp)
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, -64(%rbp)
	movl	%edx, %r12d
	movl	%r15d, %edi
	movq	%r14, %rsi
	callq	*%rbx
	movl	%eax, -44(%rbp)
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, %ebx
	movl	%edx, %r13d
	leaq	L_.str(%rip), %rdi
	xorb	%al, %al
	movq	-56(%rbp), %rsi
	callq	_printf
	movl	-44(%rbp), %eax
	addl	-60(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	-64(%rbp), %eax
	shlq	$32, %r12
	addq	%r12, %rax
	movl	%ebx, %ecx
	shlq	$32, %r13
	addq	%r13, %rcx
	testl	%r15d, %r15d
	jg	LBB3_2
	xorl	%r15d, %r15d
	jmp	LBB3_5
LBB3_2:
	movl	%r15d, %edx
	xorl	%r15d, %r15d
	.align	4, 0x90
LBB3_3:
	addl	(%r14), %r15d
	addq	$4, %r14
	decq	%rdx
	jne	LBB3_3
	addl	%r15d, %r15d
LBB3_5:
	cmpl	-44(%rbp), %r15d
	jne	LBB3_7
	subq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	movabsq	$4985484787499139072, %rdx
	addq	%rax, %rdx
	movd	%rdx, %xmm1
	subsd	LCPI3_0(%rip), %xmm1
	movl	%ecx, %eax
	movabsq	$4841369599423283200, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm0
	addsd	%xmm1, %xmm0
	divsd	LCPI3_1(%rip), %xmm0
	mulsd	LCPI3_2(%rip), %xmm0
	leaq	L_.str1(%rip), %rdi
	movb	$1, %al
	callq	_printf
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
LBB3_7:
	leaq	L_.str2(%rip), %rdi
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_puts  # TAILCALL
Leh_func_end3:

	.section	__TEXT,__literal8,8byte_literals
	.align	3
LCPI4_0:
	.quad	4985484787500187648
LCPI4_1:
	.quad	4747323572421132288
LCPI4_2:
	.quad	4696837146684686336
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main
	.align	4, 0x90
_main:
Leh_func_begin4:
	pushq	%rbp
Ltmp7:
	movq	%rsp, %rbp
Ltmp8:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$31112, %rsp
Ltmp9:
	xorl	%ebx, %ebx
	.align	4, 0x90
LBB4_1:
	callq	_rand
	movl	%eax, -31148(%rbp,%rbx,4)
	incq	%rbx
	cmpq	$7777, %rbx
	jne	LBB4_1
	leaq	-31148(%rbp), %rbx
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_naive
	movl	%eax, %r14d
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, -31152(%rbp)
	movl	%edx, %r15d
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_naive
	movl	%eax, %ebx
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, %r12d
	movl	%edx, %r13d
	leaq	L_.str(%rip), %rdi
	leaq	L_.str3(%rip), %rsi
	xorb	%al, %al
	callq	_printf
	shlq	$32, %r15
	shlq	$32, %r13
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.align	4, 0x90
LBB4_3:
	addl	-31148(%rbp,%rcx,4), %eax
	incq	%rcx
	cmpq	$7777, %rcx
	jne	LBB4_3
	addl	%r14d, %ebx
	addl	%eax, %eax
	cmpl	%ebx, %eax
	jne	LBB4_6
	movl	-31152(%rbp), %eax
	orq	%rax, %r15
	movl	%r12d, %eax
	orq	%rax, %r13
	subq	%r15, %r13
	movq	%r13, %rax
	shrq	$32, %rax
	movabsq	$4985484787499139072, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm1
	subsd	LCPI4_0(%rip), %xmm1
	movl	%r13d, %eax
	movabsq	$4841369599423283200, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm0
	addsd	%xmm1, %xmm0
	divsd	LCPI4_1(%rip), %xmm0
	mulsd	LCPI4_2(%rip), %xmm0
	leaq	L_.str1(%rip), %rdi
	movb	$1, %al
	callq	_printf
	jmp	LBB4_7
LBB4_6:
	leaq	L_.str2(%rip), %rdi
	callq	_puts
LBB4_7:
	leaq	-31148(%rbp), %rbx
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_unrolled
	movl	%eax, %r14d
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, -31152(%rbp)
	movl	%edx, %r15d
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_unrolled
	movl	%eax, %ebx
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, %r12d
	movl	%edx, %r13d
	leaq	L_.str(%rip), %rdi
	leaq	L_.str4(%rip), %rsi
	xorb	%al, %al
	callq	_printf
	shlq	$32, %r15
	shlq	$32, %r13
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.align	4, 0x90
LBB4_8:
	addl	-31148(%rbp,%rcx,4), %eax
	incq	%rcx
	cmpq	$7777, %rcx
	jne	LBB4_8
	addl	%r14d, %ebx
	addl	%eax, %eax
	cmpl	%ebx, %eax
	jne	LBB4_11
	movl	-31152(%rbp), %eax
	orq	%rax, %r15
	movl	%r12d, %eax
	orq	%rax, %r13
	subq	%r15, %r13
	movq	%r13, %rax
	shrq	$32, %rax
	movabsq	$4985484787499139072, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm1
	subsd	LCPI4_0(%rip), %xmm1
	movl	%r13d, %eax
	movabsq	$4841369599423283200, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm0
	addsd	%xmm1, %xmm0
	divsd	LCPI4_1(%rip), %xmm0
	mulsd	LCPI4_2(%rip), %xmm0
	leaq	L_.str1(%rip), %rdi
	movb	$1, %al
	callq	_printf
	jmp	LBB4_12
LBB4_11:
	leaq	L_.str2(%rip), %rdi
	callq	_puts
LBB4_12:
	leaq	-31148(%rbp), %rbx
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_vectorized
	movl	%eax, %r14d
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, -31152(%rbp)
	movl	%edx, %r15d
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_vectorized
	movl	%eax, %ebx
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, %r12d
	movl	%edx, %r13d
	leaq	L_.str(%rip), %rdi
	leaq	L_.str5(%rip), %rsi
	xorb	%al, %al
	callq	_printf
	shlq	$32, %r15
	shlq	$32, %r13
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.align	4, 0x90
LBB4_13:
	addl	-31148(%rbp,%rcx,4), %eax
	incq	%rcx
	cmpq	$7777, %rcx
	jne	LBB4_13
	addl	%r14d, %ebx
	addl	%eax, %eax
	cmpl	%ebx, %eax
	jne	LBB4_16
	movl	-31152(%rbp), %eax
	orq	%rax, %r15
	movl	%r12d, %eax
	orq	%rax, %r13
	subq	%r15, %r13
	movq	%r13, %rax
	shrq	$32, %rax
	movabsq	$4985484787499139072, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm1
	subsd	LCPI4_0(%rip), %xmm1
	movl	%r13d, %eax
	movabsq	$4841369599423283200, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm0
	addsd	%xmm1, %xmm0
	divsd	LCPI4_1(%rip), %xmm0
	mulsd	LCPI4_2(%rip), %xmm0
	leaq	L_.str1(%rip), %rdi
	movb	$1, %al
	callq	_printf
	jmp	LBB4_17
LBB4_16:
	leaq	L_.str2(%rip), %rdi
	callq	_puts
LBB4_17:
	leaq	-31148(%rbp), %rbx
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_vectorized_unrolled
	movl	%eax, %r14d
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, -31152(%rbp)
	movl	%edx, %r15d
	movl	$7777, %edi
	movq	%rbx, %rsi
	callq	_sum_vectorized_unrolled
	movl	%eax, %ebx
	## InlineAsm Start
	rdtsc
	## InlineAsm End
	movl	%eax, %r12d
	movl	%edx, %r13d
	leaq	L_.str(%rip), %rdi
	leaq	L_.str6(%rip), %rsi
	xorb	%al, %al
	callq	_printf
	shlq	$32, %r15
	shlq	$32, %r13
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.align	4, 0x90
LBB4_18:
	addl	-31148(%rbp,%rcx,4), %eax
	incq	%rcx
	cmpq	$7777, %rcx
	jne	LBB4_18
	addl	%r14d, %ebx
	addl	%eax, %eax
	cmpl	%ebx, %eax
	jne	LBB4_21
	movl	-31152(%rbp), %eax
	orq	%rax, %r15
	movl	%r12d, %eax
	orq	%rax, %r13
	subq	%r15, %r13
	movq	%r13, %rax
	shrq	$32, %rax
	movabsq	$4985484787499139072, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm1
	subsd	LCPI4_0(%rip), %xmm1
	movl	%r13d, %eax
	movabsq	$4841369599423283200, %rcx
	addq	%rax, %rcx
	movd	%rcx, %xmm0
	addsd	%xmm1, %xmm0
	divsd	LCPI4_1(%rip), %xmm0
	mulsd	LCPI4_2(%rip), %xmm0
	leaq	L_.str1(%rip), %rdi
	movb	$1, %al
	callq	_printf
	jmp	LBB4_22
LBB4_21:
	leaq	L_.str2(%rip), %rdi
	callq	_puts
LBB4_22:
	xorl	%eax, %eax
	addq	$31112, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	ret
Leh_func_end4:

	.globl	_sum_vectorized
	.align	4, 0x90
_sum_vectorized:
Leh_func_begin5:
	pushq	%rbp
Ltmp10:
	movq	%rsp, %rbp
Ltmp11:
	movl	%edi, %eax
	sarl	$31, %eax
	shrl	$30, %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	sarl	$2, %ecx
	andl	$-4, %eax
	testl	%eax, %eax
	jg	LBB5_2
	xorl	%edx, %edx
	movl	%edx, %r8d
	movl	%edx, %r9d
	movl	%edx, %r10d
	jmp	LBB5_5
LBB5_2:
	leal	-1(%rax), %edx
	shrl	$2, %edx
	incq	%rdx
	cmpl	$4, %eax
	movl	$1, %r8d
	cmovgq	%rdx, %r8
	pxor	%xmm0, %xmm0
	movq	%rsi, %rdx
	.align	4, 0x90
LBB5_3:
	movdqu	(%rdx), %xmm1
	paddd	%xmm1, %xmm0
	addq	$16, %rdx
	decq	%r8
	jne	LBB5_3
	movd	%xmm0, %rdx
	punpckhqdq	%xmm0, %xmm0
	movd	%xmm0, %r9
	movq	%rdx, %r8
	shrq	$32, %r8
	movq	%r9, %r10
	shrq	$32, %r10
LBB5_5:
	addl	%edx, %r10d
	addl	%r9d, %r10d
	addl	%r8d, %r10d
	cmpl	%edi, %eax
	jge	LBB5_8
	shll	$2, %ecx
	movslq	%ecx, %rax
	leaq	(%rsi,%rax,4), %rcx
	decl	%edi
	subl	%eax, %edi
	incq	%rdi
	.align	4, 0x90
LBB5_7:
	addl	(%rcx), %r10d
	addq	$4, %rcx
	decq	%rdi
	jne	LBB5_7
LBB5_8:
	movl	%r10d, %eax
	popq	%rbp
	ret
Leh_func_end5:

	.globl	_sum_vectorized_unrolled
	.align	4, 0x90
_sum_vectorized_unrolled:
Leh_func_begin6:
	pushq	%rbp
Ltmp12:
	movq	%rsp, %rbp
Ltmp13:
	movl	%edi, %eax
	sarl	$31, %eax
	shrl	$28, %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	sarl	$4, %ecx
	andl	$-16, %eax
	testl	%eax, %eax
	jg	LBB6_2
	xorl	%edx, %edx
	movl	%edx, %r8d
	movl	%edx, %r9d
	movl	%edx, %r10d
	jmp	LBB6_6
LBB6_2:
	leal	-1(%rax), %edx
	shrl	$4, %edx
	incq	%rdx
	cmpl	$16, %eax
	movl	$1, %r8d
	cmovgq	%rdx, %r8
	leaq	48(%rsi), %rdx
	pxor	%xmm0, %xmm0
	jmp	LBB6_3
	.align	4, 0x90
LBB6_4:
	movaps	%xmm1, %xmm0
LBB6_3:
	movdqu	-48(%rdx), %xmm1
	movdqu	-32(%rdx), %xmm2
	movdqu	-16(%rdx), %xmm3
	movdqu	(%rdx), %xmm4
	paddd	%xmm0, %xmm1
	paddd	%xmm2, %xmm1
	paddd	%xmm3, %xmm1
	paddd	%xmm4, %xmm1
	addq	$64, %rdx
	decq	%r8
	jne	LBB6_4
	movd	%xmm1, %rdx
	punpckhqdq	%xmm1, %xmm1
	movd	%xmm1, %r9
	movq	%rdx, %r8
	shrq	$32, %r8
	movq	%r9, %r10
	shrq	$32, %r10
LBB6_6:
	addl	%edx, %r10d
	addl	%r9d, %r10d
	addl	%r8d, %r10d
	cmpl	%edi, %eax
	jge	LBB6_9
	shll	$4, %ecx
	movslq	%ecx, %rax
	leaq	(%rsi,%rax,4), %rcx
	decl	%edi
	subl	%eax, %edi
	incq	%rdi
	.align	4, 0x90
LBB6_8:
	addl	(%rcx), %r10d
	addq	$4, %rcx
	decq	%rdi
	jne	LBB6_8
LBB6_9:
	movl	%r10d, %eax
	popq	%rbp
	ret
Leh_func_end6:

	.section	__TEXT,__cstring,cstring_literals
L_.str:
	.asciz	 "%20s: "

L_.str1:
	.asciz	 "%.2f microseconds\n"

L_.str2:
	.asciz	 "ERROR!"

L_.str3:
	.asciz	 "naive"

L_.str4:
	.asciz	 "unrolled"

L_.str5:
	.asciz	 "vectorized"

L_.str6:
	.asciz	 "vectorized unrolled"

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
	.globl	_sum_naive.eh
_sum_naive.eh:
Lset1 = Leh_frame_end1-Leh_frame_begin1
	.long	Lset1
Leh_frame_begin1:
Lset2 = Leh_frame_begin1-Leh_frame_common
	.long	Lset2
Ltmp14:
	.quad	Leh_func_begin1-Ltmp14
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

	.globl	_sum_unrolled.eh
_sum_unrolled.eh:
Lset6 = Leh_frame_end2-Leh_frame_begin2
	.long	Lset6
Leh_frame_begin2:
Lset7 = Leh_frame_begin2-Leh_frame_common
	.long	Lset7
Ltmp15:
	.quad	Leh_func_begin2-Ltmp15
Lset8 = Leh_func_end2-Leh_func_begin2
	.quad	Lset8
	.byte	0
	.byte	4
Lset9 = Ltmp2-Leh_func_begin2
	.long	Lset9
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset10 = Ltmp3-Ltmp2
	.long	Lset10
	.byte	13
	.byte	6
	.align	3
Leh_frame_end2:

	.globl	_benchmark.eh
_benchmark.eh:
Lset11 = Leh_frame_end3-Leh_frame_begin3
	.long	Lset11
Leh_frame_begin3:
Lset12 = Leh_frame_begin3-Leh_frame_common
	.long	Lset12
Ltmp16:
	.quad	Leh_func_begin3-Ltmp16
Lset13 = Leh_func_end3-Leh_func_begin3
	.quad	Lset13
	.byte	0
	.byte	4
Lset14 = Ltmp4-Leh_func_begin3
	.long	Lset14
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset15 = Ltmp5-Ltmp4
	.long	Lset15
	.byte	13
	.byte	6
	.byte	4
Lset16 = Ltmp6-Ltmp5
	.long	Lset16
	.byte	131
	.byte	7
	.byte	140
	.byte	6
	.byte	141
	.byte	5
	.byte	142
	.byte	4
	.byte	143
	.byte	3
	.align	3
Leh_frame_end3:

	.globl	_main.eh
_main.eh:
Lset17 = Leh_frame_end4-Leh_frame_begin4
	.long	Lset17
Leh_frame_begin4:
Lset18 = Leh_frame_begin4-Leh_frame_common
	.long	Lset18
Ltmp17:
	.quad	Leh_func_begin4-Ltmp17
Lset19 = Leh_func_end4-Leh_func_begin4
	.quad	Lset19
	.byte	0
	.byte	4
Lset20 = Ltmp7-Leh_func_begin4
	.long	Lset20
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset21 = Ltmp8-Ltmp7
	.long	Lset21
	.byte	13
	.byte	6
	.byte	4
Lset22 = Ltmp9-Ltmp8
	.long	Lset22
	.byte	131
	.byte	7
	.byte	140
	.byte	6
	.byte	141
	.byte	5
	.byte	142
	.byte	4
	.byte	143
	.byte	3
	.align	3
Leh_frame_end4:

	.globl	_sum_vectorized.eh
_sum_vectorized.eh:
Lset23 = Leh_frame_end5-Leh_frame_begin5
	.long	Lset23
Leh_frame_begin5:
Lset24 = Leh_frame_begin5-Leh_frame_common
	.long	Lset24
Ltmp18:
	.quad	Leh_func_begin5-Ltmp18
Lset25 = Leh_func_end5-Leh_func_begin5
	.quad	Lset25
	.byte	0
	.byte	4
Lset26 = Ltmp10-Leh_func_begin5
	.long	Lset26
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset27 = Ltmp11-Ltmp10
	.long	Lset27
	.byte	13
	.byte	6
	.align	3
Leh_frame_end5:

	.globl	_sum_vectorized_unrolled.eh
_sum_vectorized_unrolled.eh:
Lset28 = Leh_frame_end6-Leh_frame_begin6
	.long	Lset28
Leh_frame_begin6:
Lset29 = Leh_frame_begin6-Leh_frame_common
	.long	Lset29
Ltmp19:
	.quad	Leh_func_begin6-Ltmp19
Lset30 = Leh_func_end6-Leh_func_begin6
	.quad	Lset30
	.byte	0
	.byte	4
Lset31 = Ltmp12-Leh_func_begin6
	.long	Lset31
	.byte	14
	.byte	16
	.byte	134
	.byte	2
	.byte	4
Lset32 = Ltmp13-Ltmp12
	.long	Lset32
	.byte	13
	.byte	6
	.align	3
Leh_frame_end6:


.subsections_via_symbols
