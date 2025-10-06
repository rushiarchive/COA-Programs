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
   ; print prompt "Enter A : "
    mov rax, 1       
    mov rdi, 1        
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; read 2 bytes from stdin (digit + newline) into 'a'
    mov rax, 0         
    mov rdi, 0         
    mov rsi, a
    mov rdx, 2       
    syscall

    ; print prompt "Enter B : "
    mov rax, 1     
    mov rdi, 1        
    mov rsi, msg2
    mov rdx, msg2_len        
    syscall
    
    ; read 2 bytes (digit + newline) into 'b'
    mov rax,0
    mov rdi,0
    mov rsi,b
    mov rdx, 2
    syscall
    
    sub byte[a],48
    sub byte[b],48
    mov al, byte[a]
    add al,byte[b]
    mov byte[c],al
    add byte[c],48
    
    ; write(1, a, 2)
    mov rax,1
    mov rdi,1
    mov rsi,msg3
    mov rdx,msg3_len
    syscall 
    
    mov rax, 1     
    mov rdi, 1        
    mov rsi, c
    mov rdx, 2        
    syscall
    

    ; exit(0)
    mov rax, 60        
    xor rdi, rdi       
    syscall

