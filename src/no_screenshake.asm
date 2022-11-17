%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern noscreenshake

@HACK 0x004AB678, _Shake_The_Screen_Return_At_Prologue
    cmp byte [noscreenshake], 1
    jz .Early_Return
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    jmp 0x004AB67F
    
.Early_Return:
    jmp 0x004ABF4A ; jump to RETN instruction at the end of the function
@ENDHACK
