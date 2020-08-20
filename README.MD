# Загрузчик
## Чтобы загрузиться и загрузить едро

`bootloader/working`

http://learnitonweb.com/2019/10/26/2-writing-an-operating-system-episode-2-bios-uefi-assembler-boot-loader-and-hello-world/

https://metanit.com/assembler/articles/MiniOS.php

- Создаём пустую дискетку `1 474 560 байт (512 * 2880)`
`dd if=/dev/zero of=disk.img bs=512 count=2880`
- Компилируем загрузчик
`nasm -f bin bootloder.asm -o bootloder`
- Записываем скомпилированый загрузчик на дискетку в нулевой сектор
`dd conv=notrunc if=bootloder of=disk.img bs=512 count=1 seek=0`


nasm -f bin bootloder.asm -o bootloder && nasm -f bin kernel.asm -o kernel && dd conv=notrunc if=bootloder of=disk.img bs=512 count=1 seek=0 && dd conv=notrunc if=kernel of=disk.img bs=512 count=1 seek=1 && /usr/local/Cellar/qemu/5.1.0/bin/qemu-system-i386 -fda disk.img