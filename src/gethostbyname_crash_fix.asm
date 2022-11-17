%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "patch.inc"
%include "ra95.inc"


hack 0x005A877E, 0x005A878A ; handle cases where gethostbyname returns NULL
    cmp ebx, 0
    je 0x005A8805

    mov esi, dword[ebx+0x0C]
    cmp dword[esi], 0
    je 0x005A8805
    jmp hackend
