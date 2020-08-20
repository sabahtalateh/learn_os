org 0x500

start: 
    mov bx, krnl
    mov ah, 0x0e
    call print_text

;; string address in bx
print_text:
    mov al, [bx]            ; в al кладём значние которое лежит по адресу bx
    test al, al             ; сравнить al с нулем (в конце строк у нас нулевые байты) https://ru.stackoverflow.com/questions/135230/%D0%AF%D0%B2%D0%BD%D1%8B%D0%B5-%D0%BE%D1%82%D0%BB%D0%B8%D1%87%D0%B8%D1%8F-cmp-%D0%BE%D1%82-test/135243ы
    jz print_text_end       ; если в al - нуль то конец
    int 0x10                ; прерывание для печатания того что в al
    inc bx                  ; инкремент адреса
    jmp print_text          ; давай поновой миша
    print_text_end:
    ret

krnl db 'Kernell loaded!!!', 0ah, 0dh, 0h

end: