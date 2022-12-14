%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%define __processor 0x00607D78

;keep a global flag telling telling the cnc-ddraw version patched by me (iran) to video stretch or not
;use the unused 'Processor' byte at 0x00607D78, this is supposed to be used to store CPU procressor info
;but isn't actually used

@HACK 0x0053AF3B, _Campaign_Do_Win_ScoreClass__Presentation
	mov byte [__processor], 1
	
	call 0x00540670	; ScoreClass::Presentation()
	mov byte [__processor], 0
	jmp 0x0053AF40
@ENDHACK

@HACK 0x0053B037, _Campaign_Do_Win_Map_Selection
	mov byte [__processor], 1
	
	call 0x00500A68	; Map_Selection()
	mov byte [__processor], 0
	jmp 0x0053B03C
@ENDHACK
	
@HACK 0x0053ADF6, _Campaign_Do_Win_Multiplayer_Score_Presentation
	mov byte [__processor], 1
	
	call 0x00546678	; Multiplayer_Score_Presentation()
	mov byte [__processor], 0
	jmp 0x0053ADFB
@ENDHACK
	
@HACK 0x0053B3E6, _Do_Win_Multiplayer_Score_Presentation
	mov byte [__processor], 1
	
	call 0x00546678	; Multiplayer_Score_Presentation()
	mov byte [__processor], 0
	jmp 0x0053B3EB
@ENDHACK
	
@HACK 0x0053B6CF, _Do_Lose_Multiplayer_Score_Presentation
	mov byte [__processor], 1
	
	call 0x00546678	; Multiplayer_Score_Presentation()
	mov byte [__processor], 0
	jmp 0x0053B6D4
@ENDHACK