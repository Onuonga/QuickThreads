/*
// QuickThreads -- Threads-building toolkit.
// Copyright (c) 2013 by Frankie Onuonga
//
// Permission to use, copy, modify and distribute this software and
// its documentation for any purpose and without fee is hereby
// granted, provided that the above copyright notice and this notice
// appear in all copies.  This software is provided as a
// proof-of-concept and for demonstration purposes; there is no
// representation about the suitability of this software for any
// purpose.  */

	.globl b_null
b_null:
	ret


	.globl _b_call_reg
	.globl b_call_reg
_b_call_reg:
b_call_reg:
	mov $b_null, %ebx
b_call_reg_inner:
	call *%ebx
	call *%ebx
	call *%ebx
	call *%ebx
	call *%ebx

	call *%ebx
	call *%ebx
	call *%ebx
	call *%ebx
	call *%ebx

	addl $-10, 4(%esp)
	jg b_call_reg_inner
	ret


	.globl _b_call_imm
	.globl b_call_imm
_b_call_imm:
b_call_imm:
	mov $b_null, %ebx
b_call_imm_inner:
	call b_null
	call b_null
	call b_null
	call b_null
	call b_null

	call b_null
	call b_null
	call b_null
	call b_null
	call b_null

	addl $-10, 4(%esp)
	jg b_call_imm_inner
	ret

	
	
	.globl _b_add
	.globl b_add
_b_add:
b_add:
	clr %eax
	clr %ebx
	clr %ecx
	clr %edx
	clr %esi

b_add_inner:
	addl $5, %eax
	addl $5, %ebx
	addl $5, %ecx
	addl $5, %edx
	addl $5, %esi

	addl $5, %eax
	addl $5, %ebx
	addl $5, %ecx
	addl $5, %edx
	addl $5, %esi

	addl $-10, 4(%esp)
	jg b_add_inner
	ret

	.globl _b_load
	.globl b_load

b_load_inner:
	movl 4(%esp), %ebx
	movl 8(%esp), %ebx
	movl 12(%esp), %ebx
	movl 16(%esp), %ebx
	movl 20(%esp), %ebx

	movl 4(%esp), %ebx
	movl 8(%esp), %ebx
	movl 12(%esp), %ebx
	movl 16(%esp), %ebx
	movl 20(%esp), %ebx

	addl $-10, 4(%esp)
	jg b_load_inner
	ret
_b_load:
b_load:
