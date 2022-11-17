%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "patch.inc"

; 0x004b06f6 - const DisplayClass::Cell_Shadow(short)

; The crash only happens in maps with Y offset 1
; This function seems to smoothen the edges of unreaveled cells. 
; When a cell is not revealed it tries to substract 7482 (58 * 129) from the cell_array pointer
; to get the cell above the current one. This can fail cause there is no more row of cells above
; the current row in maps with Y offset 1. 

hack 0x004B06F6, 0x004B06FC
    push eax
    lea eax, [eax-0x1D38]
    cmp dword[esi], eax ; esi = cell_array pointer
    pop eax
    jg 0x004B077E

    mov bh, byte[eax-0x1D38]
    jmp hackend
