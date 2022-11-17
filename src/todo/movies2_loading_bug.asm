%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x004F80D4 _Init_Secondary_Mixfiles_Movies1_Check_NOP
	mov eax, 24h
	jmp 0x004F80DD
@ENDHACK
	
@HACK 0x004F80F5 _Init_Secondary_Mixfiles_Movies1_Jump_NOP
	 mov eax, 24h
	 jmp 0x004F80FC
@ENDHACK