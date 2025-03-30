bits 16

global to_hex

section .text

;----------------------------------------------------------
to_hex:
; receives: ax = value to convert
;           di = address to buffer
; returns:  nothing
;----------------------------------------------------------
    pusha
    mov     cx, 4
.loop:
    rol     ax, 4
    mov     si, ax
    and     si, 0x0f
    add     si, .digits
    movsb
    loop    .loop
    popa
    ret

.digits: db "0123456789abcdef"
    
