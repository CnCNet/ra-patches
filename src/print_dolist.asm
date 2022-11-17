%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Print DoList on "data queue overflow" errors

cextern PrintDoList

hack 0x0052926B
    mov ebx, 0x17
    
    pushad
    call PrintDoList
    popad

    jmp hackend
    
    
hack 0x005294B4
    mov ebx, 0x17
    
    pushad
    call PrintDoList
    popad

    jmp hackend
