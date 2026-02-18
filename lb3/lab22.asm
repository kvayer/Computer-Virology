.model tiny 
.code 
org 100h 

start:
    mov ah,9
    mov dx,offset text
    int 21h
    ret
    text db 'Hello',0dh,0ah,'$'
_end: 
    end start