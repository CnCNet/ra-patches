%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x004C32C3, _FootClass__Detach_Botched_Loop_Increment_Fix
	call 0x005C38B3 ; memmove_()
	inc ecx
	jmp 0x004C32C8
@ENDHACK