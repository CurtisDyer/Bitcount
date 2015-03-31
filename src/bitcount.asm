;---------------------------------------------------------------
; bitcount.asm - count bits in an (unsigned) integer value
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

	global bitcount		; allow libc to see our function

	section .text
bitcount:				; uint64_t bitcount(uint64_t n);
	mov rax, rdi		; 1st parameter
	xor rcx, rcx		; our counter

.shift:
	shr rax, 1			; perform arithmetic shift (unsigned)
	jnc .test			; bit not set, see if work still needs to be done
	inc rcx				; increment counter for bit

.test:
	test rax, rax		; check if more bits need shifting
	jnz .shift

	mov rax, rcx		; place count in rax for `ret'
	ret

