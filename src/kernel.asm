bits 16

global kernel

%include "write.inc"

section .text

kernel:
    mov     si, msg
    call    write_str
    jmp     $

msg: db "Jag tycker om min hund", 0x0d, 0x0a, 0

