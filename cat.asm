;
; CAT PROGRAM IN ASM x64
;

%define EXIT_SUCCESS	0
%define EXIT_FAILURE	1

%define SYSCALL_READ		0
%define SYSCALL_WRITE		1
%define SYSCALL_OPEN		2
%define SYSCALL_SENDFILE64	40
%define SYSCALL_EXIT		60

%define FD_STDOUT 0
%define FD_STDERR 1

%define O_RDONLY	0
%define O_WRONLY	1
%define O_RDWR		2


segment .text


global _start


_start:
	; OPEN FIRST ARGUMENT
	mov  rax, SYSCALL_OPEN 
	mov  rdi, [rsp + 16]
	mov  rsi, 0
	mov  rdx, O_RDONLY
	syscall

	; CALL SENDFILE FROM OPENED FD TO STDOUT
	mov rsi, rax
	mov rax, SYSCALL_SENDFILE64
	mov rdi, FD_STDOUT
	mov rdx, 0
	mov r10, 256
	syscall

	mov  rax, SYSCALL_EXIT
	mov  rdi, EXIT_SUCCESS
	syscall

; vim: set filetype=asm :
