%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern _SessionClass__Session
extern allyreveal

@HACK 0x00561385, _TechnoClass__Revealed_Reveal_Other_Player_Buildings
    push ebx
    push eax
    push edx
    mov ebx, [esi+11h]
    mov eax, esi
    xor edx, edx
    call dword [ebx+98h]
    pop edx
    pop eax
    pop ebx
    cmp dword [0x00669914], 1
    jmp 0x00561392
@ENDHACK

@HACK 0x004B07E0, _DisplayClass__Map_Cell_Share_Shroud
    cmp byte [allyreveal], 1
    jz .Shroud_Share
    jmp .No_Shroud_Share
    
.Shroud_Share:
    jmp 0x004B07E9

.No_Shroud_Share:    
    jmp 0x004B0800
@ENDHACK
