.model tiny 
.code 
org 100h

start:
    mov si,offset _end ;в SI смещение метки _end, ее адрес
    lodsw ;в AX слово по адресу DS:SI, SI=SI+2
    xchg ax,cx ;помещаем в CX значение AX (cx - счетчик)
    push si ;сохраняем в стек значение SI
decrypt: 
    xor byte ptr[si],55h ;сложение по модулю 2 ; через квадратные скобки можно получить доступ к памяти
    inc si ;увеличиваем SI на 1
    loop decrypt ;цикл с метки decrypt CX раз
    jmp si ;прыгаем по адресу SI, в lab23
_end: 
    filesize dw 0 ;размер шифруемого файла
end start