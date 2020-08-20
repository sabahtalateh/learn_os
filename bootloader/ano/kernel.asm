org 500h                ;этот сектор будет загружаться по адресу 0000:0500h
message:
    mov ax, 0002h   ;очищаем экран
    int 10h
         
    mov dx,0h
    ;call SetCursorPos
    mov bp, msg
    mov cx, 20
    mov bl,04h                  
    xor bh,bh
    mov ax,1301h
    int 10h             ;вывод приглашения к вводу команды
        
    add dh,2            ;переводим курсор на один пункт вниз для ввода команды
    ;call SetCursorPos
    mov si,0
  
 
SetCursorPos:        ;установка курсора
    mov ah,2h
    xor bh,bh
    int 10h 
    ret
 
msg db 'Input the command...',0
write db 'write',0
