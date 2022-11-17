%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern parabombsinmultiplayer
extern _SessionClass__Session

%define SessionClass__Session 0x0067F2B4

@HACK 0x004D5B13, _Paraboms_Single_Player_Check

	cmp byte [parabombsinmultiplayer], 1
	jz 0x004D5B1C

	cmp byte [SessionClass__Session], 0
	jmp 0x004D5B1A
@ENDHACK