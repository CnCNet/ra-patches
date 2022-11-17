%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

[section .data]
str_derppp db "derpppp", 0

@HACK 0x004BB74A Slide_Show_Credits_CnCDDraw_Crash_Fix
	jmp 0x004BB74F
@ENDHACK

@HACK 0x004BC2E5 _Slide_Show_No_Background
	mov edi, str_derppp
	jmp 0x004BC2EA
@ENDHACK