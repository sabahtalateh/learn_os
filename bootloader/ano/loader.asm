org 7c00h
start:
        cli             ;запрещаем прерывания
        xor ax,ax       ;обнуляем регистр ах
        mov ds,ax       ;настраиваем сегмент данных на нулевой адрес
        mov es,ax       ;настраиваем сегмент es на нулевой адрес
        mov ss,ax       ;настраиваем сегмент стека на нулевой адрес
        mov sp,07C00h   ;сегмент sp указывает на текущую вершину стека
        sti             ;разрешаем прерывания
            
        mov ax, 0002h   ;очищаем экран - функция 00h прерывания 10h 
        int 10h
         
        mov dx,0h
        call SetCursorPos
         
        mov bp, msg             
        mov cx, 13
        call PrintMes   ;Вывод на экран строки msg
         
        add dh,1        ;переходим на одну строку ниже
        call SetCursorPos
        mov bp, Con             ;Вывод на экран строки Con
        mov cx, 23
        call PrintMes
                 
         mov ah,10h
         int 16h
                 
Continue:
        cmp al, 0Dh     ;Если нажимаем на Enter, то переходим к загрузке ядра
        jz Kernel
        jmp Continue    ;Если нет, снова ожидаем нажатия клавиши
                 
Kernel:
        mov ax,0000h
        mov es,ax
        mov bx,500h
        mov ch,0            ;номер цилиндра - 0
        mov cl,02h          ;начальный сектор - 2
        mov dh,0            ;номер головки - 0
        mov dl,0h           ;жесткий диск - 80h
        mov al,01h          ;кол-во читаемых секторов -1
        mov ah,02h
        int 13h
        jmp 0000:0500h      ;переход на 0000:0500h, куда загружен второй сектор
 
;===================== Подпрограммы ===================================
PrintMes:                   ;в регистре  bp - строка, в регистре cx - длина этой строки
        mov bl,04h          ;в регистре  bl- атрибут
        mov ax,1301h        ;функция 13h прерывания 10h
        int 10h
        ret
        ;----------------------------------
SetCursorPos:        ;установка курсора : функция 02h прерывания 10h
        mov ah,2h
        xor bh,bh
        int 10h 
        ret
            
;===================== выводимые сообщения===================== 
        msg db 'OS Loading...',0     
        Con db 'Press Enter to Continue',0
  
times (510-($-$$)) db 0
dw 0xAA55