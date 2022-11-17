%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%define SessionClass__Session 0x0067F2B4

@HACK 0x0041CB90	_Count_as_Civ_Evac_Check
	cmp byte [SessionClass__Session], 0
	jnz .Check_EvacInMP_Keyword
	jmp .Normal_Function

.Check_EvacInMP_Keyword:
	cmp byte [evacinmp], 1
	jz .Normal_Function
	
	mov eax, 0
	retn
	
.Normal_Function:
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	push edi
	jmp 0x0041CB97
@ENDHACK