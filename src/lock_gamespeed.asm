%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

extern playerisgamehost
cextern QuickMatch

hack 0x004C4B21
    mov edi, dword[ebp-0x24]
    sub ebx, esi
    
    cmp byte[playerisgamehost], 1
    jnz 0x004C4B72
    
    cmp byte[QuickMatch], 1
    jz 0x004C4B72
    
    jmp 0x004C4B26
