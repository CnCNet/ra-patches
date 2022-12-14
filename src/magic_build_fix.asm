%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"


extern _SessionClass__Session
extern magicbuildfix

; Fixes exploit where the game doesn't refresh whether build location is buildable if you don't move mouse cursor while trying to place a building
; Allowing you to build on a spot that's no longer in proximity as long as you don't move your mouse cursor

@HACK 0x004AFF0D, _DisplayClass_Set_Cursor_Pos_Magic_Build_Fix
    cmp byte [magicbuildfix], 1
    jz .Apply_Fix

    ; if fix isn't applied this check is done
    cmp cx, ax
    jz 0x004AFF9A

.Apply_Fix:
	jmp 0x004AFF16
@ENDHACK
	
@HACK 0x004B31E9, _DisplayClass__TacticalClass__Action_Magic_Build_Fix
    cmp byte [magicbuildfix], 1
    jz .Apply_Fix
    
    ; if fix isn't applied this check is done
    cmp ax, dx
    jz 0x004B31FE

.Apply_Fix:    
	jmp 0x004B31EE
@ENDHACK
