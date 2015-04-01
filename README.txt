                         EXPLANATION OF CODE
                         -------------------

Bit Counting Algorithm
----------------------

The excerpt below shows the code. Our main loop shifts the unsigned
representation of the user's number right 1 place each time. This is
nice because it both lets us count bits that were set by examining the
carry flag and allows us to test for when to terminate the loop. Once
the last bit is shifted, we're done, and left with the sum of all ON
bits in RCX.

We MOV the value in RCX in RAX, because C calling conventions dictate
that function return values should be stored there.


Excerpt from `src/bitcount.asm':

 1  bitcount:
 2      mov rax, rdi
 3      xor rcx, rcx
 4  
 5  .shift:
 6      shr rax, 1
 7      jnc .test
 8      inc rcx
 9  
10  .test:
11      test rax, rax
12      jnz .shift
13
14      mov rax, rcx
15      ret


Prompting for User Input
------------------------

This algorithm focuses on making a system call to the Linux kernel's
`read(2)' function and then converting the user's input into an
integer.  See the excerpt below for relevant code.

The only noteworthy aspects of the prompt module is that we use the
return value from the call to `read(2)' in order to NUL-terminate our
line buffer so that it's a valid C string.

As mentioned above, after the `read(2)' call, the user's input was
stored as a string, which is not what we want. We therefore use the C
`atoi(3)' function to convert the user input to an integer.

Since C functions' return values are placed in RAX, we simply leave
the register as-is after the call to `atoi(3)' to pass the value back
to the callee.

Excerpt from `src/prompt.asm':

 1      extern puts
 2      extern atoi
 3
 4      global getnum
 5
 6      section .text
 7 
 8  getnum:
 9      mov rdi, prompt
10      call puts
11   
12      xor rax, rax
13      mov rdi, STDIN
14      mov rsi, number
15      mov rdx, BUFFER_SIZE - 1
16      syscall
17   
18      mov [number+rax], byte 0
19      mov rdi, number
20      call atoi
21   
22      ret
23   
24   
25      section .bss
26  number:     resb BUFFER_SIZE
27 
28      section .data
29  prompt:     db "Input number: ", 0
