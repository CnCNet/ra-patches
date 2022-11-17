%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern CheckHotkeys

hack 0x005261A8
    call 0x004F3660
    mov bl, byte[esi+0x1B]
    mov word[esi+0x7A], ax
    
    pushad
    push esi
    call CheckHotkeys
    add esp, 4
    popad
    
    jmp hackend
