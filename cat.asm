;
; CAT PROGRAM IN ASM x64
;

%define EXIT_SUCCESS		0
%define EXIT_FAILURE		1

%define SYSCALL_READ		0
%define SYSCALL_WRITE		1
%define SYSCALL_OPEN		2
%define SYSCALL_CLOSE		3
%define SYSCALL_STAT		4
%define SYSCALL_SENDFILE64	40
%define SYSCALL_EXIT		60

%define FD_STDOUT		0
%define FD_STDERR 		1

%define O_RDONLY		0
%define O_WRONLY		1
%define O_RDWR			2

%define STRUCT_STAT_SIZE	144

%define ARGC_OFFSET		0
%define ARGV_EXEC_OFFSET	8
%define ARGV_FILE_OFFSET	16


	segment .text
	global _start
_start:
	; GETTING STAT ABOUT FILE
	mov	rax, SYSCALL_STAT
	mov	rdi, [rsp + ARGV_FILE_OFFSET]
	mov	rsi, structstat
	syscall

	mov	r10, [rax + 48]

	; OPEN FIRST ARGUMENT
	mov	rax, SYSCALL_OPEN 
	mov	rdi, [rsp + ARGV_FILE_OFFSET]
	mov	rsi, 0
	mov	rdx, O_RDONLY
	syscall

	; CALL SENDFILE FROM OPENED FD TO STDOUT
	mov	rsi, rax
	mov	rax, SYSCALL_SENDFILE64
	mov	rdi, FD_STDOUT
	mov	rdx, 0
	; mov	r10, 256
	syscall

	mov	rax, SYSCALL_EXIT
	mov	rdi, EXIT_SUCCESS
	syscall

	segment .bss
structstat:
	resb	STRUCT_STAT_SIZE

; vim: set filetype=asm :
