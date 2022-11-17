%include "macros/patch.inc"
%include "macros/datatypes.inc"

; 0x0049ef34
; A building a being sold/destroyed and at the same time the radar is redrawing (building id is -1)



hack 0x0049EF15 ; const CellClass::Cell_Color(int)
    add eax, 0x0CD
    
    cmp ecx, -1
    jz 0x0049EF78 ; draw normal terrain color
    jmp hackend
