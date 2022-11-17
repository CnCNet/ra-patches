%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; 0x0045EE3C
; Overlay placed into structures section crash (RAED map editor failure)


sstring BARB_ovl, "BARB"
sstring SBAG_ovl, "SBAG"
sstring WOOD_ovl, "WOOD"
sstring FENC_ovl, "FENC"
sstring BRIK_ovl, "BRIK"
sstring CYCL_ovl, "CYCL"


hack 0x0045EF35 ; BuildingClass::Read_INI(CCINIClass &)
    pushad
    mov esi, eax
    
    mov edx, BARB_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    mov eax, esi
    mov edx, SBAG_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    mov eax, esi
    mov edx, WOOD_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    mov eax, esi
    mov edx, FENC_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    mov eax, esi
    mov edx, BRIK_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    mov eax, esi
    mov edx, CYCL_ovl
    call strcmp
    cmp eax, 0
    jz .skip
    
    popad
    
    call 0x004537B4
    jmp hackend
    
.skip:
    popad
    jmp 0x0045EED8
