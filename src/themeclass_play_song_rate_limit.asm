%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; ThemeClass::Play_Song(ThemeType) causing high cpu load when no music was found

sint LastTick, 0

hack 0x0056C099, 0x0056C0A2
    cmp dword[0x006680C0], 0
    je 0x0056C105

    pushad
    call [_imp__timeGetTime]
    
    cmp dword[LastTick], 0
    jz .ok
    mov edx, eax
    sub edx, dword[LastTick]
    cmp edx, 5000 ; 5seconds
    jbe .skip
   
.ok:
    mov dword[LastTick], eax
    popad
    jmp hackend

.skip:
    popad
    jmp 0x0056C105
