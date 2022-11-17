%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

; Fixes a rare issue where the game sometimes thinks you have don't have much disk space left if you actually have a lot left
; This fix changes the "get disk space" function to always return enough disk space to pass the game's checks

@HACK 0x004AB108, _Get_Disk_Space ; Not the function's real name
	mov eax, 800001h
	retn
@ENDHACK
