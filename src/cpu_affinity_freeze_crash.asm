%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

; Fixes lagging audio and movies
@HACK 0x005C5D71, _VQA_Play_SetPriorityClass_NOP_Out2
	add esp, 8
	jmp 0x005C5D78
@ENDHACK

@HACK 0x005C5AFE, _VQA_Play_SetPriorityClass_NOP_Out
	add esp, 8
	jmp 0x005C5B05
@ENDHACK
	