%include "macros/patch.inc"
%include "macros/datatypes.inc"

; 0x004b065b - Text_Overlap_List is too long (60), Refresh_Cells only supports lists with a size up to 36
; Last item in the list must be 0x7FFF, otherwise Refresh_Cells ends up in a loop
; This patch cuts the size of the list down to 36 to prevent crashes. 
; side effect: rather than crashing, some cells may not redraw now if the list is too long (HelpText wont disappear until you scroll)

hack 0x004B064D
    call 0x004ABF4C
    
    mov word[ebp-0x12], 0x7FFF
    jmp hackend
