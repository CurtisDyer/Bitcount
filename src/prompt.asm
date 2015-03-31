;---------------------------------------------------------------
; prompt.asm - get user input
;
; I'll be building on my previous bitcount program.
;
; :vim:ts=4:sw=4
; :asmsyntax=nasm
;---------------------------------------------------------------
; Author: Curtis Dyer
; Class: CS-3
; Format: amd64 ELF64
;---------------------------------------------------------------
; Linux AMD64 GCC calling conventions:
;	1st arg: RDI	2nd arg: RSI
;	3rd arg: RDX	4th arg: RCX
;	5th arg: R8		6th arg: R9
;---------------------------------------------------------------
; NB: stack should be aligned on 16-byte boundary by caller
;---------------------------------------------------------------

; Symbolic constants; these will expand to immediate values, as
; they're processed by NASM's preprocessor
%define BUFFER_SIZE	128
%define STDIN 0
%define STDOUT 1

	extern puts
	extern atoi

	global getnum

	section .text

; C signature: uint64_t getnum(void)
getnum:
	mov rdi, prompt
	call puts

	; we're going to use the Linux read() system call
	; read(unsigned fd, char *buf, size_t count)
	xor rax, rax
	mov rdi, STDIN
	mov rsi, number
	mov rdx, BUFFER_SIZE - 1	; leave space for NUL terminator
	syscall

	; make sure data is NUL-terminated
	; RAX holds bytes read
	mov [number+rax], byte 0
	mov rdi, number
	call atoi

	ret							; atoi result already in RAX


	section .bss
number:		resb BUFFER_SIZE	; initialize storage for our line

	section .data
prompt:		db "Input number: ", 0

