%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern skipscorescreen

; skipscorescreen

@HACK 0x00540670, _Campaign_Do_Win_Score_Screen
	cmp byte [skipscorescreen], 1
	jnz .No_Early_Ret
	retn
	
.No_Early_Ret:
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	push esi
	push edi 
	jmp 0x00540678
@ENDHACK
	
@HACK 0x00546678, _Multiplayer_Score_Presentation_Start
	cmp byte [skipscorescreen], 1
	jnz .No_Early_Ret
	retn

.No_Early_Ret:
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	push esi
	push edi
	jmp 0x00546680
@ENDHACK