%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

; was 3 originally
%define THEATERS_COUNT 8

;Theaters array
sstring Temperate, "TEMPERATE", 16
sstring Temperat, "TEMPERAT", 10
sstring Tem, "TEM", 4
sstring Snow, "SNOW", 16
sstring Snow_2, "SNOW", 10
sstring Sno, "SNO", 4
sstring Interior, "INTERIOR", 16
sstring Interior_2, "INTERIOR", 10
sstring Int_, "INT", 4
sstring Winter, "WINTER", 16
sstring Winter2, "WINTER", 10
sstring Win_, "WIN", 4
sstring Desert, "DESERT", 16
sstring Desert2, "DESERT", 10
sstring Des, "DES", 4
sstring Jungle, "JUNGLE", 16
sstring Jungle2, "JUNGLE", 10
sstring Jun, "JUN", 4
sstring Barren, "BARREN", 16
sstring Barren2, "BARREN", 10
sstring Bar, "BAR", 4
sstring Cave, "CAVE", 16
sstring Cave2, "CAVE", 10
sstring Cav, "CAV", 4


@HACK 0x0056AAE9,	_TerrainClass__Unlimbo_Theater_Check_NOP
	jmp 0x0056AAF1 
@ENDHACK

;@HACK 0x0041C6A1, _AnimTypeClass__Init_Theater_Check_NOP
;	jmp 0x0041C6A6
;@ENDHACK

;@HACK 0x00524B68, _OverlayTypeClass__Init_Theater_Check_NOP
;	jmp 0x00524B8B
;@ENDHACK

@HACK 0x004F7805,	_Init_Heaps_Larger_Theater_Buffer
	mov edx, 5500000
	jmp 0x004F780A
@ENDHACK

@HACK 0x0049EAF3,	_TemplateTypeClass__Init_Theater_Check_NOP
	shl eax, cl
	jmp 0x0049EAF9
@ENDHACK

@HACK 0x0055B8FA,  _TerrainTypeClass__Init_Theater_Check_NOP
	shl eax, cl
	jmp 0x0055B900
@ENDHACK

@HACK 0x0055B909,  _TerrainTypeClass__Init_Theater
	add eax, Temperate
	jmp 0x0055B90E
@ENDHACK

@HACK 0x00549E0A,  _SmudgeTypeClass__Init_Theater
	add eax, Temperate
	jmp 0x00549E0F
@ENDHACK

@HACK 0x00524B76,  _OverlayTypeClass__Init_Theater
	add eax, Temperate
	jmp 0x00524B7B
@ENDHACK

@HACK 0x004AF0D4,  _DisplayClass__Init_Theater2
	add eax, Temperate
	jmp 0x004AF0D9
@ENDHACK

@HACK 0x004AF057,  _DisplayClass__Init_Theater
	add eax, Temperate
	jmp 0x004AF05C
@ENDHACK

@HACK 0x004A9450, _Fading_Table_Name_Theater
	add eax, Temperate
	jmp 0x004A9455
@ENDHACK

@HACK 0x0049EB02,  _TemplateTypeClass__Init_Theater
	add eax, Temperate
	jmp 0x0049EB07
@ENDHACK

@HACK 0x004638A4,  _CCINIClass__Put_TheaterType_Theater
	mov ecx, Temperate
	jmp 0x004638A9
@ENDHACK

@HACK 0x004A7AEB,	_Theater_From_Name_New_Theaters_Array
	add edx, Temperate
	jmp 0x004A7AF1
@ENDHACK
	
@HACK 0x004A7AD4, 	_Theater_From_Name_New_Theaters_Counter_Check
	cmp dl, THEATERS_COUNT
	jl 0x004A7AE0
	jmp 0x004A7AFF
@ENDHACK
	
@HACK 0x0041C6AF, 	_AnimTypeClass__Init_Theater
	add eax, Temperate
	jmp 0x0041C6B4
@ENDHACK
	
@HACK 0x00453943,  _BuildingTypeClass__Init_Theater
	add edx, Temperate
	jmp 0x00453949
@ENDHACK

@HACK 0x00453988,  _BuildingTypeClass__Init_Theater2
	add eax, Temperate
	jmp 0x0045398D
@ENDHACK