bits 16

%include "write.inc"
%include "disk.inc"

extern kernel

section .boot

    cli

    xor     ax, ax
    mov     ds ,ax
    mov     ss, ax
    mov     es, ax
    mov     sp, 0x7c00

    mov     [boot_drive], dl
    disk_reset [boot_drive]
    disk_read 4, 0, 2, 0, [boot_drive], 0x7e00

    sti

    mov     si, msg
    call    write_str
    jmp     kernel

msg: db "ik hou van mijn hond", 0x0d, 0x0a, 0
boot_drive: db 0

