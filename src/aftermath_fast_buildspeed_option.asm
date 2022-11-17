%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern str_aftermathfastbuildspeed
extern aftermathfastbuildspeed
extern fastambuildspeed
extern _SessionClass__Session

global str_orespreads
global str_general3
global str_rules_ini
global FileClass_rulesini
global INIClass_rulesini

StringZ str_orespreads, "OreSpreads"
StringZ str_general3, "General"
StringZ str_rules_ini, "RULES.INI"
;StringZ str_aftermath, "Aftermath"

[section .data]
FileClass_rulesini TIMES 128 db 0
INIClass_rulesini TIMES 128 db 0

;reads the keyword boolean AftermathFastBuildSpeed from the section [Aftermath] in rules.ini to enable quick build spede with the Aftermath expansion enabled (it's normally disabled if the expansion is enabled)
@HACK 0x005611F3, Time_To_Build_NewUnitsEnabled_Check
    cmp byte[aftermathfastbuildspeed], 1
    jz 0x00561206
    cmp byte[fastambuildspeed], 1
    jz .Fast_AM_For_Skirmish_And_Singleplayer
	
.Normal_Code:
    cmp dword[0x00665DE0], 0 ; NewUnitsEnabled
    jz 0x00561206
    jmp 0x005611FC
	
.Fast_AM_For_Skirmish_And_Singleplayer:
    cmp byte[_SessionClass__Session], 0
    jz .Fast_Speed
    cmp byte[_SessionClass__Session], 5
    jz .Fast_Speed
    jmp .Normal_Code
	
.Fast_Speed: 
    jmp 0x00561206
@ENDHACK
