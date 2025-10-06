%macro WRITE 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro READ 2
    mov rax, 0
    mov rdi, 0
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

section .data
    msg1 db "Enter first number: ", 10
    len1 equ $-msg1

    msg2 db "Enter second number: ", 10
    len2 equ $-msg2

    msg3 db "The sum is: ", 10
    len3 equ $-msg3

section .bss
    a resq 1
    b resq 1
    c resq 1

    char_buff resb 17
    actl resq 1

section .text
    global _start

_start:
    WRITE msg1, len1
    READ char_buff, 17
    call accept
    mov [a], rbx

    WRITE msg2, len2
    READ char_buff, 17
    call accept
    mov [b], rbx

    mov rbx, [a]
    add rbx, [b]
    mov [c], rbx

    WRITE msg3, len3
    mov rbx, [c]
    call display

    mov rax, 60
    xor rdi, rdi
    syscall

accept:
    dec rax
    mov [actl], rax
    mov rsi, char_buff
    mov rbx, 0

up:
    shl rbx, 4
    mov rdx, 0
    mov dl, [rsi]
    cmp dl, 0Ah
    je done_accept

    cmp dl, '9'
    jbe sub30
    sub dl, 7

sub30:
    sub dl, '0'
    add rbx, rdx
    inc rsi
    jmp up

done_accept:
    ret

display:
    mov rsi, char_buff
    mov rcx, 16

above:
    rol rbx, 4
    mov dl, bl
    and dl, 0Fh
    cmp dl, 9
    jbe add30
    add dl, 7

add30:
    add dl, '0'
    mov [rsi], dl
    inc rsi
    dec rcx
    jnz above

    WRITE char_buff, 16
    ret
