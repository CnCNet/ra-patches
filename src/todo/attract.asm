%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x0052BECB _Queue_Playback_Remove_Single_Player_Only_Playback_Check
	jmp 0x0052BED8
@ENDHACK

@HACK 0x004AB321 _Do_Record_Playback_Dont_Playback_Objects_Selected_And_Other_Stuff
	jmp 0x004AB4D5
@ENDHACK

@HACK 0x004AB16C _Do_Record_Playback_Dont_Record_Objects_Selected_And_Other_Stuff
	jmp 0x004AB2E6
@ENDHACK