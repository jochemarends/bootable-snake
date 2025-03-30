bits 16

global kernel

%include "write.inc"

section .text

kernel:
    mov     si, msg
    call    write_str

    mov     ah, 0x0f
    int     0x10
    xor     ah, ah
    call    write_hex
    jmp     $

msg: db "video mode: ", 0

