bits 16

%include "string.inc"

global write_hex
global write_str

section .boot

%macro write_ch 1
    push    ax
    push    bx
    mov     ah, 0x0e
    mov     al, %1
    xor     bx, bx
    int     0x10
    pop     bx
    pop     ax
%endmacro

;----------------------------------------------------------
write_hex:
; receives: ax = value to write
; returns:  nothing
;----------------------------------------------------------
    pusha
    mov     di, .buffer
    call    to_hex
    mov     si, .prefix
    call    write_str
    popa
    ret

.digits: db "0123456789abcdef", 0
.prefix: db "0x",
.buffer: times 4 db 0, 
.postfix: db 0x0d, 0x0a, 0

;----------------------------------------------------------
write_str:
; receives: si = address to null-terminated string
; returns:  nothing
;----------------------------------------------------------
    push    ax
    push    bx
    push    si
    cld
.loop:
    lodsb
    or      al, al
    jz      .done
    mov     ah, 0x0e
    xor     bh, bh
    int     0x10
    jmp     .loop
.done:
    pop     si
    pop     bx
    pop     ax
    ret

