%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

; Fixes the "music changes when alt+tabbing out" bug for some reason
@HACK 0x005B3491 _Focus_Loss
	jmp 0x005B349B
@ENDHACK

;@HACK 0x005B3624 _Check_For_Focus_Loss
;	mov ebp, 800000
;	mov eax, 0
;	retn
;@ENDHACK

;@HACK 0x005BF220 _Attempt_Audio_Restore
;	retn
;@ENDHACK