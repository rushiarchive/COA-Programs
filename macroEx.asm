%macro WRITE 02
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro READ 02
mov rax,00
mov rdi,00
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro EXIT 0	
mov rax, 60        
xor rdi, rdi       
syscall
%endmacro

section .bss
    a resb 02          
    b resb 02
    c resb 02
    
section .data
    msg db "Enter A : ",0xA
    msg_len equ $ - msg
    msg2 db "Enter B : ", 10
    msg2_len equ $ - msg2
    
    msg3 db "Addition = "
    msg3_len equ $ - msg3

section .text
    global _start

_start:
   WRITE msg,msg_len
   READ a, 02
   WRITE msg2,msg2_len
   READ b, 02
  
    
    sub byte[a],48
    sub byte[b],48
    mov al, byte[a]
    add al,byte[b]
    mov byte[c],al
    add byte[c],48
    
    WRITE msg3, msg3_len
    WRITE c, 02
    EXIT
