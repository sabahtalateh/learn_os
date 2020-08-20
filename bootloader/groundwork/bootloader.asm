org 0x7c00
bits 16

start: jmp boot

boot:

load_kernel:

    cli ; no interrupts
    cld ; all that we need to init

    ;; read os into 0x5000
    mov ax, 0x50

    ;; buffer to read into
    mov es, ax
    xor bx, bx

    mov al, 2 ; read 2 sector
    mov ch, 0 ; track 0
    mov cl, 2 ; sector to read (The second sector)
    mov dh, 0 ; head number
    mov dl, 0 ; drive number

    mov ah, 0x02    ; read sectors from disk
    int 0x13        ; call the BIOS routine
    jmp 0x50:0x0    ; jump and execute the sector!
    hlt ; halt the system

times 510 - ($-$$) db 0
dw 0xAA55 ; Boot Signiture
