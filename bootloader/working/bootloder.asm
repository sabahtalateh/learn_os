org 7c00h

start: 
    mov bx, wellcome
    mov ah, 0x0e
    call print_text

    mov bx, load_kernel_msg
    mov ah, 0x0e
    call print_text

kernel:
    ;; настройка буферов
    mov ax, 0x50            ; по этому адресу будем читать ядро (то есть копировать сюда)
    mov es, ax              ; не знаю зачем это надо (зачем то видимо надо сюда положить то же что и в ax)
    xor bx, bx              ; ax:bx = 0x50:0
    

    ;; настраиваем как читать с дискеты
    mov al, 2               ; читать 2 сектора (пока кернел занимает только один)
    mov ch, 0               ; номер цилиндра/дорожки - 0
    mov cl, 2               ; начальный сектор - 2 (тут начинается с единицы нумерация)
    mov dh, 0               ; номер головки - 0
    mov dl, 0               ; дискета - 0
    mov ah, 2               ; читать секторы
    int 13h
    jmp 0x500               ; переход на 500h, куда загружен второй сектор (yadro)

    jmp end

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

wellcome db 'Wellcome to Jopa OS!!', 0ah, 0dh, 0h ; 0a - new line 0d - carriage return 0h - null terminator
load_kernel_msg db 'loading kernel..', 0ah, 0dh, 0h

end:

times 510 - ($-$$) db 0
dw 0xAA55
