model small ; собирается как exe
.stack 100h
.data

QuestionOsenOrZima db 13,10,'Seychas '
OsenText   db 'Osen'
           db ' Ili '
ZimaText   db 'Zima'
           db '? (O/Z)',13,10,'$'
QuestionZharkoIliHolodno db 13,10,'Seychas '
ZharkoText   db 'Zharko'
           db ' Ili '
HolodnoText   db 'Holodno'
           db '? (Z/H)',13,10,'$'
QuestionFeelengGood db 13,10,'Vi horosho sebya chustuvuete? '
DaText   db 'Da'
           db ' Ili '
NetText   db 'Net'
           db '? (D/N)',13,10,'$'

; Текст для вывода в случае неверного ввода
AnywayOsenOrZima db 13,10,'Vvedite simvol "O" ili "Z"!',13,10,'$'
AnywayZharkoIliHolodno db 13,10,'Vvedite simvol "Z" ili "H"!',13,10,'$'
AnywayFeelengGood db 13,10,'Vvedite simvol "D" ili "N"!',13,10,'$'

; Текст для вывода конечной информации
OtvetOsen db 13,10,'Seychas Osen!',13,10,'$'
OtvetZima db 13,10,'Seychas Zima!',13,10,'$'
OtvetZharko db 13,10,'Seychas Zharko!',13,10,'$'
OtvetHolodno db 13,10,'Seychas Holodno!',13,10,'$'
OtvetDa db 13,10,'Vi horosho sebya chustuvuete!',13,10,'$'
OtvetNet db 13,10,'Vi ne horosho sebya chustuvuete!',13,10,'$'

.code
start:
  mov ax,@data ;установка в ds адреса сегмента данных
  mov ds,ax

RepeatQuestionOsenOrZima:
  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx, offset QuestionOsenOrZima
  int 21h
  
  xor ah,ah 
  mov ah,1 ;функция DOS ввода символа с клавиатуры
  int 21h

  cmp al, [OsenText]  
  jz FnOtvetOsen

  cmp al, [ZimaText]   
  jz FnOtvetZima

  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx,offset AnywayOsenOrZima
  int 21h

  jmp RepeatQuestionOsenOrZima

FnOtvetOsen:
  mov ah, 09h
  mov dx, offset OtvetOsen
  int 21h
  jmp RepeatQuestionZharkoIliHolodno

FnOtvetZima:
  mov ah, 09h
  mov dx, offset OtvetZima
  int 21h

RepeatQuestionZharkoIliHolodno:
  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx,offset QuestionZharkoIliHolodno
  int 21h

  xor ah,ah 
  mov ah,1 ;функция DOS ввода символа с клавиатуры
  int 21h

  cmp al, [ZharkoText]  
  jz FnOtvetZharko

  cmp al, [HolodnoText]   
  jz FnOtvetHolodno

  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx,offset AnywayZharkoIliHolodno
  int 21h
  jmp RepeatQuestionZharkoIliHolodno

FnOtvetZharko:
  mov ah, 09h
  mov dx, offset OtvetZharko
  int 21h
  jmp RepeatQuestionFeelengGood

FnOtvetHolodno:
  mov ah, 09h
  mov dx, offset OtvetHolodno
  int 21h

RepeatQuestionFeelengGood:
  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx,offset QuestionFeelengGood
  int 21h
  xor ah,ah 
  mov ah,1 ;функция DOS ввода символа с клавиатуры
  int 21h

  cmp al, [DaText]   
  jz FnOtvetDa

  cmp al, [NetText]
  jz FnOtvetNet

  mov ah,09h ;функция DOS вывода сообщения на экран
  mov dx,offset AnywayFeelengGood
  int 21h
  jmp RepeatQuestionFeelengGood

FnOtvetDa:
  mov ah, 09h
  mov dx, offset OtvetDa
  int 21h
  jmp Exit

FnOtvetNet:
  mov ah, 09h
  mov dx, offset OtvetNet
  int 21h

Exit:
  mov ax, 4C00h
  int 21h

  end start