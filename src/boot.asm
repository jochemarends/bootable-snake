bits 16

%include "write.inc"

section .boot
    cli

    xor     ax, ax
    mov     ds ,ax
    mov     ss, ax
    mov     es, ax
    mov     sp, 0x7C00

    mov     si, msg
    call    write_str
    jmp     $

msg: db "ik hou van mijn hond", 0x0D, 0x0A, 0

