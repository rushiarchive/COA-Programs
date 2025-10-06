section .bss
    a resb 2          

section .data
    msg db "Enter a number:"
    msg_len equ $ - msg
    msg2 db "Your Entered Number : "
    msg2_len equ $ - msg2

section .text
    global _start

_start:
    ; write(1, msg, msg_len)
    mov rax, 1       
    mov rdi, 1        
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; read(0, a, 2)
    mov rax, 0         
    mov rdi, 0         
    mov rsi, a
    mov rdx, 2       
    syscall


    mov rax, 1     
    mov rdi, 1        
    mov rsi, msg2
    mov rdx, msg2_len        
    syscall
    
    ; write(1, a, 2)
    mov rax, 1     
    mov rdi, 1        
    mov rsi, a
    mov rdx, 2        
    syscall
    

    ; exit(0)
    mov rax, 60        
    xor rdi, rdi       
    syscall

