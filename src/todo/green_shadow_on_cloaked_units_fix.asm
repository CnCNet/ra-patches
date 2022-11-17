%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x005672D9 _Green_Shadow_On_Cloaked_Units_Fix
	push 0x00657EE4
	mov esi, dword [EBP-24h]
	push esi
	mov eax,dword [EBP+9h]
	push 1130h
	jmp 0x005672EA
@ENDHACK