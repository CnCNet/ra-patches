%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x00462FF7, _CCINIClass__Load__No_Digest
    mov eax, 1
    jmp 0x00462FFC
@ENDHACK