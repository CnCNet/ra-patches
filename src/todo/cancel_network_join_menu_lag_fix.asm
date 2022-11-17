%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x00508AB7 _Net_Join_Dialog_Cancel_Lag_Fix
	jmp 0x00508ACD
@ENDHACK