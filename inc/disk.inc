%ifndef DISK_INC
%define DISK_INC

;----------------------------------------------------------
%macro disk_reset 1
; receives: drive
; returns:  cf = set on error
;           ah = return code
;----------------------------------------------------------
    push    dx
    mov     dl, %1
    xor     ah, ah
    int     0x13
    pop    dx
%endmacro

;----------------------------------------------------------
%macro disk_read 6
; receives: sector count, cylinder, sector, head, drive, 
;           buffer address
; returns:  cf = set on error
;           ah = return code
;           al = sectors read
;----------------------------------------------------------
    push    bx
    push    cx
    mov     ah, 0x02
    mov     al, %1
    mov     ch, %2
    mov     cl, %3
    mov     dh, %4
    mov     dl, %5
    mov     bx, %6
    int     0x13
    pop     cx
    pop     bx
%endmacro

%endif
