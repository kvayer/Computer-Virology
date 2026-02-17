.model tiny 
.code 
org 100h 

start: 
    ; Вывод запроса имени файла
    mov ah,40h 
    mov bx,1
    mov cx, textFilenameLen
    lea dx, textFilename
    int 21h

    ; Ввод имени файла
    mov ah,3Fh
    xor bx,bx
    mov cx,15
    lea dx, filename
    int 21h

    mov si,ax ; в ax теперь лежит длина введенного имени файла
    sub si,2 ; но нужно убрать символы перевода строки
    mov filename[si],0 ; ставим 0 в конец строки обозначающий конец строки

    ; Вывод запроса ключа
    mov ah, 40h
    mov bx, 1
    mov cx, textKeyLen
    mov dx, offset textKey
    int 21h

    mov ah, 3Fh
    xor bx, bx
    mov cx, 8
    mov dx, offset password
    int 21h

    mov cx, ax
    dec cx
    dec cx
    lea si, password
    xor al, al
    next:
    add al, [si]
    inc si
    loop next
    mov key, al

    ; Поиск файла
    mov ah,4Eh 
    lea dx, filename 
    int 21h
    jnc file_ok ; если файл найден, переходим на метку file_ok

    ; Если файл не найден выводим сообщение об ошибке
    mov ah,9 
    lea dx,textErr 
    int 21h 
    ret

file_ok: 
    ; Открытие файла для чтения и записи
    mov ax,3D02h 
    lea dx,filename 
    int 21h 

    xchg bx,ax ;Помещаем в BX дескриптор файла

    ; Чтение файла в буфер
    mov ah,3Fh 
    mov cx,ds:[9Ah] ; размер файла из DTA
    lea dx,buffer 
    int 21h

    ; Шифрование данных
    mov cx,ds:[9Ah] ;В CX помещаем размер файла
    mov si,offset buffer
    mov al,key 
    call crypt ;Вызываем процедуру crypt

    ; Перемещение указателя в начало файла
    mov ah,42h 
    mov al,0 
    xor cx,cx 
    xor dx,dx 
    int 21h 

    ; Запись измененных данных обратно
    mov ah,40h
    mov cx,ds:[9Ah] 
    lea dx,buffer 
    int 21h 

    ; Закрытие файла
    mov ah,3Eh 
    int 21h 
    ret 

; Процедура шифрования: умножение на ключ (mod 256)
; Расшифровка — умножение на обратный к ключу (в decrpt)
crypt proc
nextIterByte:
    add [si], al            ; Шифрование сложением (отличие от lab11)
    inc si
    loop nextIterByte
    ret
crypt endp 

    ; Данные
    textFilename db 0Dh,0Ah,'filename:' 
    textFilenameLen = $-textFilename 
    textKey db 0Dh,0Ah, 'key:' 
    textKeyLen = $-textKey 
    textErr db 'file not found',0Dh,0Ah,'$'

    filename db 15 dup(0) 
    password db 8 dup(0) ;Буфер для вводимого пароля
    key db 0 
buffer: ;Буфер для содержимого файла

end start