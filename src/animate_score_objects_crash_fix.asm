%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x005464EE, _Animate_Score_Objs_PseudoSeenBuff_NULL_Check
	cmp dword esi, 0
	je .Ret
	
	mov eax, [esi+20h]
	xor edi, edi
	jmp 0x005464F3

.Ret:
	jmp 0x005464B8
@ENDHACK