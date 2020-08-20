start: jmp boot

boot:

greetings:

    mov bx, msg
    mov ah, 0x0e

loop_printf:

    mov al, [bx]
    test al, al
    jz loop_end
    int 0x10
    inc bx
    jmp loop_printf

loop_end:

msg db "Welcome to My Operating System!", 0ah, 0dh, 0h ; 0a - new line 0d - carriage return 0h - null terminator

times 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signiture
