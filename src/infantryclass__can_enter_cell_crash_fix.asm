%include "macros/patch.inc"
%include "macros/datatypes.inc"

; 0x004eda41
; A building a being sold/destroyed and at the same time a infantry checks if it can enter the same cell (building id is -1)

; doesn't work too well yet
%if 0
hack 0x004EDA22, 0x004EDA28 ; const InfantryClass::Can_Enter_Cell(short,FacingType)
    lea edx, [ebx+0x0CD]
    
    cmp dword[edx], -1
    jz 0x004EDAD6
    jmp hackend
%endif
