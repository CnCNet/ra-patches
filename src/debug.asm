%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern CalcFrameRate
cextern PrintFrameRate

%ifdef WWDEBUG
@CLEAR 0x005B61EA, 0x90, 0x005B61F4 ; allow multiple instances (debug)


hack 0x004A7C8B, 0x004A7C91
    call CalcFrameRate

    mov edx, dword[0x00669924]
    jmp hackend
    
    
hack 0x004ACC5B, 0x004ACC61
    pushad
    call PrintFrameRate
    popad

    mov ebx, dword[0x6679C2]
    jmp hackend
%endif
