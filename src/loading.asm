%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"
%include "ini.inc"
%include "macro.inc"

%macro Initialize_Remap_Table 1
	xor		eax, eax

.Loop_Initialize_Remap_Table_%1:
	mov		BYTE [extraremaptable+2+%1+eax], al
	inc		eax
	cmp		BYTE AL, 0                          ;loop 256 times
	jnz		.Loop_Initialize_Remap_Table_%1

	mov		eax, 258

.Loop_Initialize_Black_Part_%1:
	mov		BYTE [extraremaptable+%1+eax], 00
	inc		eax
	cmp		eax, 268
	jnz		.Loop_Initialize_Black_Part_%1	
%endmacro

extern INIClass__Get_String
extern INIClass__Get_Int
extern _ScenarioNumber
extern _INIClass__Load
extern _INIClass__INIClass
extern FileClass__Is_Available
extern FileClass__FileClass
extern _SessionClass__Session
extern Clear_Extended_Savegame_Values
extern _strdup_
extern _sprintf_
cextern LimitCpuUsage
cextern ScrollFix
cextern KeyQuickSave
cextern KeyQuickLoad
cextern KeyDebug
cextern LagWarningTime
cextern LagWarningDuration
cextern LowCpuUsageScroll
cextern MaxFPS

; Load our settings from here

@LJMP	0x004F446C,		_Init_Game_Hook_Load ; For rules.ini stuff
@LJMP 	0x00525A9F,		_OptionsClass__Load_Settings ; For redalert.ini and some spawn.ini stuff
@LJMP	0x00551A87,		_Startup_Function_Hook_Early_Load ; For redalert.ini and some spawn.ini stuff
@LJMP   0x0053D081,      _Map_Load_Before_Hook ; For map loading stuff
@LJMP   0x0053A568,      _Map_Load_Late_Hook  ; For map loading stuff
@LJMP   0x00537E08,     _Load_Game_Before_Hook ; For savegame loading stuff
@LJMP   0x00538F07,      _Load_Game_Late_Hook  ; For savegame loading stuff
@LJMP   0x0055B84B,     _Ore_Mine_Foundation_Voodoo
@LJMP   0x00408005,      _FRAG1_Data_Voodoo
@LJMP	0x00536AB5, 		_RulesClass__AI_Load
@LJMP	0x0053D6AA, 		_Custom_Missions_Load_Map_Specific_Tutorial_Text
@LJMP	0x00538CE1,		_Custom_Missions_Load_Game_Map_Specific_Tutorial_Text

%define colorwhiteoffset	0
%define colorblackoffset	282
%define colourflamingblueoffset 564

cglobal harvestergemmapfix
global str_aftermathfastbuildspeed
global nocdmode
global generatememorydump
global skipscorescreen
global EasyAIGemValue
global EasyAIOreValue
global NormalAIGemValue
global NormalAIOreValue
global HardAIGemValue
global HardAIOreValue
global ReenableAITechUpCheck
global removeaitechupcheck
global computerparanoidforcedisabledskirmish
global fixaisendingtankstopleft
global fixaially
cglobal fixaially
global fixaiparanoid
global usesmallinfantry
global usebetateslatank
global usebetadestroyer
global usebetasubmarine
global usebetagunboat
global usebetacruiser
global usedosinterfacemod
global str_redalertini5
global FileClass_redalertini5
global str_options5
global str_gamelanguage
global INIClass_redalertini5
global gamelanguage
global spawner_aftermath
global aftermathenabled
cglobal aftermathenabled
global counterstrikeenabled
global keysidebartoggle 
global keymapsnapshot
global aftermathfastbuildspeed
cglobal aftermathfastbuildspeed
global fastambuildspeed
global fixformationspeed
cglobal fixformationspeed
global forcedalliances
cglobal forcedalliances
global mcvundeploy
cglobal mcvundeploy
global noscreenshake
global parabombsinmultiplayer
cglobal parabombsinmultiplayer
global allyreveal
cglobal allyreveal
global shortgame
cglobal shortgame
global spawner_is_active
cglobal spawner_is_active
global buildoffally
cglobal buildoffally
global infantryrangeexploitfix
cglobal infantryrangeexploitfix
global noteslazapeffectdelay
global mousewheelscrolling
global magicbuildfix
cglobal magicbuildfix
global str_aftermath
global str_fixformationspeed
global str_fixrangeexploit
global str_fixmagicbuild
global str_parabombsinmultiplayer
global str_fixaially
global str_mcvundeploy
global str_allyreveal
global str_forcedalliances
global str_techcenterbugfix
global techcenterbugfix
global str_buildoffally
global str_southadvantagefix
global southadvantagefix
global str_noscreenshake
global str_noteslazapeffectdelay
global str_shortgame
global str_deadplayersradar
global str_playerisgamehost
global playerisgamehost
global evacinmp
global fixnavalexploits
global FRAG1AnimData
global OreMineFoundation
global buildingcrewstuckfix
global deadplayersradar
global randomstartingsong
cglobal extraremaptable
global autoharvesting
global str_AutoHarvesting

sstring LimitCpuUsageKey, "LimitCpuUsage"
sstring QuickSaveIniKey, "KeyQuickSave"
sstring QuickLoadIniKey, "KeyQuickLoad"
sstring DebugIniKey, "KeyDebug"
sstring LagWarningTimeKey, "LagWarningTime"
sstring LagWarningDurationKey, "LagWarningDuration"
sstring MaxFPSKey, "MaxFPS"

[section .rdata]
str_sprintf_format3 db "cmu%02dea",0
str_s_format  db "%s",0
str_general db "General",0
str_custommissions db "Custom Missions",0
str_expansionissions db "Expansions Missions",0
str_UseCustomTutorialText db "UseCustomTutorialText",0
str_NextMissionInCampaign db "NextMissionInCampaign",0
str_ScenarioNumber db "ScenarioNumber",0
str_MapSelectionAnimation db "MapSelectionAnimation",0
str_MapSelectA db "MapSelectA",0
str_MapSelectB db "MapSelectB",0
str_MapSelectC db "MapSelectC",0
str_ChronoReinforceTanks db"ChronoReinforceTanks",0
str_UseAtomWhiteScreenEffectInMP db"UseAtomWhiteScreenEffectInMP",0
str_UseSinglePlayerAtomDamage db"UseSinglePlayerAtomDamage",0

str_EasyAIGoldValue db "EasyAIGoldValue",0
str_EasyAIGemValue db "EasyAIGemValue",0
str_NormalAIGoldValue db "NormalAIGoldValue",0
str_NormalAIGemValue db "NormalAIGemValue",0
str_HardAIGoldValue db "HardAIGoldValue",0
str_HardAIGemValue db "HardAIGemValue",0

str_ReenableAITechUpCheck db "ReenableAITechUpCheck",0
str_kernel32dll db "Kernel32.dll",0
str_SetProcessAffinityMask db "SetProcessAffinityMask",0
str_forcesinglecpu db"ForceSingleCPU",0
str_fastambuildspeed db"FastAMBuildSpeed",0
str_enablewol db"EnableWOL",0
str_deadplayersradar db"DeadPlayersRadar",0
str_settings2 db"Settings",0
str_aftermath   db "Aftermath", 0
str_shortgame db"ShortGame",0
str_noteslazapeffectdelay db"NoTeslaZapEffectDelay",0
str_southadvantagefix db"SouthAdvantageFix",0
str_noscreenshake db"NoScreenShake",0
str_buildoffally db"BuildOffAlly",0
str_techcenterbugfix db"TechCenterBugFix",0
str_forcedalliances db"ForcedAlliances",0
str_fixmagicbuild db"FixMagicBuild",0
str_fixrangeexploit db"FixRangeExploit",0
str_allyreveal db"AllyReveal",0
str_mcvundeploy db"MCVUndeploy",0
str_redalertini5 db "REDALERT.INI",0
str_options5 db "Options",0
str_videointerlacemode db "VideoInterlaceMode",0
str_skipscorescreen db "SkipScoreScreen",0
str_randomstartingsong db "RandomStartingSong",0
str_ai db "AI",0
str_removeaitechupcheck db "RemoveAITechupCheck",0
str_fixaiparanoid db "FixAIParanoid",0
str_fixaially db "FixAIAlly",0
str_fixformationspeed db "FixFormationSpeed",0
str_gamelanguage db "GameLanguage",0
str_debuglogging db "DebugLogging",0
str_aftermathenabled db "AftermathEnabled",0
str_counterstrikeenabled db "CounterstrikeEnabled",0
str_usesmallinfantry db "UseSmallInfantry",0
str_nocd db "NoCD", 0
str_displayoriginalmultiplayermaps db "DisplayOriginalMultiplayerMaps",0
str_displayaftermathmultiplayermaps db "DisplayAftermathMultiplayerMaps",0
str_displaycounterstrikemultiplayermaps db "DisplayCounterstrikeMultiplayerMaps",0
str_parabombsinmultiplayer db "ParabombsInMultiplayer",0
str_mousewheelscrolling db "MouseWheelScrolling",0
str_evacinmp db "EvacInMP",0
str_alternativeriflesound db "AlternativeRifleSound",0
str_usegrenadethrowingsound db "UseGrenadeThrowingSound",0
str_usebetateslatank db "UseBetaTeslaTank",0
str_winhotkeys db "WinHotkeys",0
str_keysidebartoggle db "KeySidebarToggle",0
str_keymapsnapshot db "KeyMapSnapshot",0
str_fixaisendingtankstopleft db "FixAISendingTanksTopLeft",0
str_generatememorydump db "GenerateMemoryDump",0
str_forceamunitsinmissions db "ForceAMUnitsInMissions",0
str_usebetadestroyer db "UseBetaDestroyer",0
str_usebetacruiser db "UseBetaCruiser",0
str_usebetasubmarine db "UseBetaSubmarine",0
str_usebetagunboat db "UseBetaGunboat",0
str_colorremapsidebarcameoicons db "ColorRemapSidebarIcons",0
str_usedosinterfacemod db "UseDOSInterfaceMod",0
str_computerparanoidforcedisabledskirmish db "ComputerParanoidForceDisabledSkirmish",0
str_playerisgamehost db "Host",0
str_spawnini2 db"SPAWN.INI",0
str_aftermathfastbuildspeed db"AftermathFastBuildSpeed",0
str_LowCpuUsageScroll db"LowCpuUsageScroll",0
str_ScrollFix db"ScrollFix",0
str_AllocConsole db"AllocConsole",0
str_conout db"CONOUT$",0
str_w db"w",0
str_Debug db"Debug",0
str_AutoHarvesting db"AutoHarvesting",0

[section .data]
sprintf_buffer3 TIMES 512 db 0
sprintf_key_buffer TIMES 512 db 0
strdup_text_buffer TIMES 512 db 0
MissionCounter	dd	0
TutorialINIPointer dd 0
tutorial_text_buffer  TIMES 512 db 0
FileClass_TutorialText  TIMES 128 db 0
INIClass_TutorialText TIMES 128 db 0
NextCampaignMissionBuf TIMES 128 db 0
MapSelectionAnimationBuf TIMES 128 db 0
MapSelectABuf TIMES 128 db 0
MapSelectBBuf TIMES 128 db 0
MapSelectCBuf TIMES 128 db 0
ChronoReinforceTanks dd 0
UseAtomWhiteScreenEffectInMP dd 0
UseSinglePlayerAtomDamage dd 0

INIClass_redalertini5 TIMES 64 db 0
FileClass_redalertini5	TIMES 128 db 0

INIClass_spawnini2 TIMES 64 db 0
FileClass_spawnini2	TIMES 128 db 0

extraremaptable TIMES 2400 db 0

SetProcessAffinityMask dd 0

EasyAIOreValue dd -1
EasyAIGemValue dd -1
NormalAIOreValue dd -1
NormalAIGemValue dd -1
HardAIOreValue dd -1
HardAIGemValue dd -1

fixnavalexploits db 0
ReenableAITechUpCheck db 0
forcesinglecpu db 0
fastambuildspeed db 0
enablewol db 0
deadplayersradar db 0
spawner_aftermath db 0
shortgame db 0
noteslazapeffectdelay db 0
southadvantagefix db 0
noscreenshake db 0
buildoffally db 0
techcenterbugfix db 0
forcedalliances db 0
allyreveal db 0
mcvundeploy db 0
buildingcrewstuckfix dd 0
magicbuildfix db 0
infantryrangeexploitfix db 0
OreMineFoundation dd 0
FRAG1AnimData dd 0
computerparanoidforcedisabledskirmish db 1
colorremapsidebarcameoicons db 0
usebetadestroyer db 0
usebetacruiser db 0
usebetasubmarine db 0
usebetagunboat db 0
forceamunitsinmissions db 0
aftermathfastbuildspeed	db 0
videointerlacemode	dd 2
skipscorescreen db 0
randomstartingsong db 0
removeaitechupcheck db 0
fixaiparanoid db 0
fixaially db 0
fixformationspeed db 0
gamelanguage dd 1
debuglogging db 1
counterstrikeenabled db 1
aftermathenabled db 1
nocdmode db 1
usesmallinfantry db 0
displayoriginalmultiplayermaps db 1
displaycounterstrikemultiplayermaps db 1
displayaftermathmultiplayermaps db 1
parabombsinmultiplayer	db 0
mousewheelscrolling db 0
evacinmp db 1
alternativeriflesound db 0
usegrenadethrowingsound db 0
usebetateslatank db 0
keysidebartoggle dw 0
keymapsnapshot dw 0
fixaisendingtankstopleft db 0
generatememorydump	db 0
usedosinterfacemod db 0
spawner_is_active  dd 0
playerisgamehost db 1
harvestergemmapfix dd 0
autoharvesting dd 0

[section .text]
_Custom_Missions_Load_Game_Map_Specific_Tutorial_Text:
	pushad
	
	lea     eax, [ebp-16Ch] ; ScenarioFileClass
	call	Read_Map_Specific_Tutorial_Text
	
	popad
	lea     edx, [ebp-16Ch]	
	jmp		0x00538CE7

_Custom_Missions_Load_Map_Specific_Tutorial_Text:
	pushad

	lea     eax, [ebp-8Ch] ; ScenarioFileClass
	call	Read_Map_Specific_Tutorial_Text
	
	popad
	lea     edx, [ebp-8Ch]
	jmp		0x0053D6B0
	
Read_Map_Specific_Tutorial_Text:
;	PUSH 512             ; dst len
;    PUSH tutorial_text_buffer             ; dst
;    MOV ECX, 0x005EC00F   ; default, "TUTORIAL.INI"
;    MOV EBX, str_customtutorialFile   ; key, "CustomTutorialFile"
;    MOV EDX, 0x005EFFA5  ; section, "Basic"
;;	lea     eax, [ebp-8Ch] ; ScenarioFileClass
;    CALL INIClass__Get_String

	mov DWORD [TutorialINIPointer], eax ; Set INI file to scenario
	
	; Load map name buffer for next mission in campaign for custom campaigns
	PUSH 128 ; dst len
	LEA EBX, [NextCampaignMissionBuf]
	PUSH EBX ; dst
	MOV ECX, 0x005EC01F ; offset empty_string
	MOV EBX, str_NextMissionInCampaign   ; key
	MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
	CALL INIClass__Get_String
	
	; Load map select A buffer for next mission in campaign for custom campaigns
	PUSH 128 ; dst len
	LEA EBX, [MapSelectABuf]
	PUSH EBX ; dst
	MOV ECX, 0x005EC01F ; offset empty_string
	MOV EBX, str_MapSelectA   ; key
	MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
	CALL INIClass__Get_String
	
	; Load  map select B buffer for next mission in campaign for custom campaigns
	PUSH 128 ; dst len
	LEA EBX, [MapSelectBBuf]
	PUSH EBX ; dst
	MOV ECX, 0x005EC01F ; offset empty_string
	MOV EBX, str_MapSelectB   ; key
	MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
	CALL INIClass__Get_String
	
	; Load  map select C buffer for next mission in campaign for custom campaigns
	PUSH 128 ; dst len
	LEA EBX, [MapSelectCBuf]
	PUSH EBX ; dst
	MOV ECX, 0x005EC01F ; offset empty_string
	MOV EBX, str_MapSelectC   ; key
	MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
	CALL INIClass__Get_String

	
	; Load map selection animation buffer for the current mission
	PUSH 128 ; dst len
	LEA EBX, [MapSelectionAnimationBuf]
	PUSH EBX ; dst
	MOV ECX, 0x005EC01F ; offset empty_string
	MOV EBX, str_MapSelectionAnimation   ; key
	MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
	CALL INIClass__Get_String
	
	; Read ScenarioNumber from map file
	
	; args: <INIClass>, <section>, <key>, <default>, <dst>
    MOV ECX, -1
    MOV EBX, str_ScenarioNumber
    MOV EDX, 0x005EFFA5  ; section, "Basic"
	mov		DWORD eax, [TutorialINIPointer]
    CALL INIClass__Get_Int
	
	cmp		eax, -1
	jz		.Dont_Set_Scenario_Number
	
	mov		[_ScenarioNumber], eax
	
.Dont_Set_Scenario_Number:

	mov		DWORD eax, [TutorialINIPointer]
	INI_Get_Bool_ eax, 0x005EFFA5, str_ChronoReinforceTanks, 0
	mov		DWORD [ChronoReinforceTanks], eax
	
	mov		DWORD eax, [TutorialINIPointer]
	INI_Get_Bool_ eax, 0x005EFFA5, str_UseAtomWhiteScreenEffectInMP, 0
	mov		DWORD [UseAtomWhiteScreenEffectInMP], eax
	
	mov		DWORD eax, [TutorialINIPointer]
	INI_Get_Bool_ eax, 0x005EFFA5, str_UseSinglePlayerAtomDamage, 0
	mov		DWORD [UseSinglePlayerAtomDamage], eax

	
	mov		DWORD eax, [TutorialINIPointer]
	INI_Get_Bool_ eax, 0x005EFFA5, str_UseCustomTutorialText, 0
		
	
	cmp		BYTE AL, 1 ; if using custom tutorial text in map/mission file
	jz		.Dont_Load_TUTORIAL_INI_Text 
	
	
	mov eax, [FileClass_TutorialText]
	test eax, eax
	
	MOV EDX, 0x005EC00F ; "TUTORIAL.INI"
    MOV EAX, FileClass_TutorialText
    CALL FileClass__FileClass

    ; check ini exists
    MOV EAX, FileClass_TutorialText
    XOR EDX, EDX
;	JE File_Not_Available ; on file not available

    ; initialize INIClass
    MOV EAX, INIClass_TutorialText
    CALL _INIClass__INIClass

    ; load FileClass to INIClass
    MOV EDX, FileClass_TutorialText
    MOV EAX, INIClass_TutorialText
    CALL _INIClass__Load
	
	mov DWORD [TutorialINIPointer], INIClass_TutorialText
	
.Dont_Load_TUTORIAL_INI_Text:
	
	xor		edi, edi
	xor		esi, esi
	jmp		.LoopStart
	
.Loop:
	inc     edi
	add     esi, 4
	cmp     edi, 0E1h
	jge     .Out
	
.LoopStart:
	push    edi             ; Format
	push    0x005EC01C    ; "%d"
	mov    eax, sprintf_key_buffer
	xor     ecx, ecx
	push    eax             ; Dest
	MOV 	DWORD [ESI+0x666304], ECX
	call    _sprintf_

	add     esp, 0Ch
	mov    ebx, sprintf_key_buffer
	push    80h
	mov    eax, strdup_text_buffer
	mov     edx, 0x005EC020 ; "Tutorial"
	push    eax
	mov     ecx, 0x005EC01F ; offset empty_string
	mov     eax, DWORD [TutorialINIPointer]
	CALL INIClass__Get_String
	test    eax, eax
	jz      .Loop
	mov     eax, strdup_text_buffer
	call    _strdup_
	MOV 	DWORD [ESI+0x666304],EAX
	jmp     .Loop

.Out:
	retn

_Load_Game_Late_Hook:
    pushad
    
    ; Enable AM units for skirmish savegames
    cmp		BYTE [_SessionClass__Session], 5
    jne     .No_Enable_New_Units
    call    0x004AC024 ; Is_Aftermath_Installed(void)
    cmp     DWORD eax, 1
    jne     .No_Enable_New_Units
    
    mov     DWORD [0X00665DE0], 1 ; NewUnitsEnabled true
    
.No_Enable_New_Units:

    ; Enable AM units in single player if option is turned on
    cmp		BYTE [_SessionClass__Session], 0
    jne     .Dont_Force_AM_Units_In_Missions
    cmp     BYTE [forceamunitsinmissions], 1
    jne     .Dont_Force_AM_Units_In_Missions
    call    0x004AC024 ; Is_Aftermath_Installed(void)
    cmp     DWORD eax, 1
    jne     .Dont_Force_AM_Units_In_Missions
        
    mov     DWORD [0X00665DE0], 1 ; NewUnitsEnabled
    
.Dont_Force_AM_Units_In_Missions:
    
    popad
    call    0x004F25D0 ; INIClass::~INIClass(void)
    jmp     0x00538F0C

_Load_Game_Before_Hook:
    pushad
    
    ;Remove any active Chrono Vortex
    mov     eax, 0x006904B4 ; ChronoVortex instance
    call    0x0058E304 ; ChronalVortexClass::Stop(void)

    ; Ore Mine foundation fix code
    mov     eax, DWORD [OreMineFoundation]
    mov     DWORD [eax], 0x1000080 ; Set to normal, bugged Ore Mine foundation
    
    cmp		BYTE [_SessionClass__Session], 5
    jne     .No_Skirmish_Mine_Fix
   
    mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
    
.No_Skirmish_Mine_Fix:

    cmp		BYTE [_SessionClass__Session], 0
    jne     .No_Skirmish_Mine_Fix2
  
    mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
   
.No_Skirmish_Mine_Fix2:

    cmp		DWORD [spawner_is_active], 0
    jz     .No_Skirmish_Mine_Fix3
  
    mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
   
.No_Skirmish_Mine_Fix3: 

    ; FRAG1 explosion anim fix code
    mov     eax, DWORD [FRAG1AnimData]
    mov     BYTE [eax], 0xC3 ; Set to normal, bugged FRAG1 anim data
    
    cmp		BYTE [_SessionClass__Session], 5
    je      .Fix_FRAG1
    cmp		BYTE [_SessionClass__Session], 0
    je      .Fix_FRAG1
    cmp		DWORD [spawner_is_active], 1
    je      .Fix_FRAG1
    
    jmp     .Dont_Fix_FRAG1
    
.Fix_FRAG1:

  mov     BYTE [eax], 0xC1 ; Set to fixed FRAG1 anim data   
    
.Dont_Fix_FRAG1:
    
    popad
    call    0x004A765C ; Call_Back(void)
    jmp     0x00537E0D
    
 _FRAG1_Data_Voodoo:
    mov     edx, [0x00625B48]
    push    edx
    lea     ecx, [eax+0x138]
    mov     DWORD [FRAG1AnimData], ecx
    mov     [eax+138h], cl
    
    pop     edx
    jmp     0x00408011 

_Ore_Mine_Foundation_Voodoo:
    push    ecx
    lea     ecx, [eax+0x139]
    mov     DWORD [OreMineFoundation], ecx
    mov     [eax+139h], edx
    
    pop     ecx
    jmp     0x0055B851

 _Map_Load_Before_Hook:
    call    0x0053AA94 ; Clear_Scenario(void)
    pushad

	cmp		DWORD [spawner_is_active], 1
	jz		.Dont_Clear_Savegame_Values
	
	; disable some spawn.INI and rules.ini stuff that could be loaded
	; e.g. from savegame
	
	 call	Clear_Extended_Savegame_Values
	
.Dont_Clear_Savegame_Values:

	mov		DWORD [EasyAIOreValue], -1
	mov		DWORD [EasyAIGemValue], -1
	mov		DWORD [NormalAIOreValue], -1
	mov		DWORD [NormalAIGemValue], -1
	mov		DWORD [HardAIOreValue], -1
	mov		DWORD [HardAIGemValue], -1
	mov		DWORD [ReenableAITechUpCheck], 0
    
    ; Set current credit count to be displayed on the credits tab to 0
    mov     DWORD [0x0066984E], 0
    
    ;Remove any active Chrono Vortex
    mov     eax, 0x006904B4 ; ChronoVortex instance
    call    0x0058E304 ; ChronalVortexClass::Stop(void)
    
    ; Ore Mine foundation fix code,
   mov     eax, DWORD [OreMineFoundation]
   mov     DWORD [eax], 0x1000080 ; Set to normal, bugged Ore Mine foundation
    
   cmp		BYTE [_SessionClass__Session], 5
   jne     .No_Skirmish_Mine_Fix
   
   mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
    
.No_Skirmish_Mine_Fix:

   cmp		BYTE [_SessionClass__Session], 0
   jne     .No_Skirmish_Mine_Fix2
   
    mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
    
.No_Skirmish_Mine_Fix2:

   cmp		DWORD [spawner_is_active], 0
   je     .No_Skirmish_Mine_Fix3
   
    mov     DWORD [eax], 0x800080 ; Set to fixed Ore Mine foundation
   
.No_Skirmish_Mine_Fix3:

    popad
    jmp     0x0053D086
    
_Map_Load_Late_Hook:
    pushad
    
    ; Enable AM units in single player if option is turned on
    cmp		BYTE [_SessionClass__Session], 0
    jne     .Dont_Force_AM_Units_In_Missions
    cmp     BYTE [forceamunitsinmissions], 1
    jne     .Dont_Force_AM_Units_In_Missions
    call    0x004AC024 ; Is_Aftermath_Installed(void)
    cmp     DWORD eax, 1
    jne     .Dont_Force_AM_Units_In_Missions
        
    mov     DWORD [0X00665DE0], 1 ; NewUnitsEnabled
    
.Dont_Force_AM_Units_In_Missions:

    ; FRAG1 explosion anim fix code
    mov     eax, DWORD [FRAG1AnimData]
    mov     BYTE [eax], 0xC3 ; Set to normal, bugged FRAG1 anim data
    
    cmp		BYTE [_SessionClass__Session], 5
    je      .Fix_FRAG1
    cmp		BYTE [_SessionClass__Session], 0
    je      .Fix_FRAG1
    cmp		DWORD [spawner_is_active], 1
    jz      .Fix_FRAG1
    
    jmp     .Dont_Fix_FRAG1
    
.Fix_FRAG1:

  mov     BYTE [eax], 0xC1 ; Set to fixed FRAG1 anim data   
    
.Dont_Fix_FRAG1:
    
    popad
    call    0x0053A5C8 ; Fill_In_Data(void)
    jmp     0x0053A56D

%define		EBP_RedAlertINI		[ebp-0x74]
	
_OptionsClass__Load_Settings:
	call	0x004F3660
	pushad

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_forcesinglecpu, 1
	mov		[forcesinglecpu], al
	
	cmp		al, 0
	jz		.Dont_Set_Single_CPU
	
	call	Set_Single_CPU_Affinity
	
.Dont_Set_Single_CPU:	
	
	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_Debug, 0
    cmp al, 0
    jz .noDebug
    
    call DoAllocConsole
    
.noDebug:

	lea		eax, EBP_RedAlertINI
	INI_Get_Int_ eax, str_options5, LagWarningDurationKey, [LagWarningDuration]
	mov		[LagWarningDuration], eax

	lea		eax, EBP_RedAlertINI
	INI_Get_Int_ eax, str_options5, LagWarningTimeKey, [LagWarningTime]
	mov		[LagWarningTime], eax
    
	lea		eax, EBP_RedAlertINI
	INI_Get_Int_ eax, str_options5, MaxFPSKey, [MaxFPS]
	mov		[MaxFPS], eax
    
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, LimitCpuUsageKey, 0
	mov		byte[LimitCpuUsage], al
    
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_ScrollFix, 0
	mov		[ScrollFix], al
    
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_LowCpuUsageScroll, 0
	mov		[LowCpuUsageScroll], al
    
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_mousewheelscrolling, 0
	mov		[mousewheelscrolling], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_displaycounterstrikemultiplayermaps, 1
	mov		[displaycounterstrikemultiplayermaps], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_displayaftermathmultiplayermaps, 1
	mov		[displayaftermathmultiplayermaps], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_displayoriginalmultiplayermaps, 1
	mov		[displayoriginalmultiplayermaps], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_usesmallinfantry, 0
	mov		[usesmallinfantry], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_aftermathenabled, 1
	mov		[aftermathenabled], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_counterstrikeenabled, 1
	mov		[counterstrikeenabled], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_nocd, 1
	mov		[nocdmode], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_debuglogging, 1
	mov		[debuglogging], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Int_ eax, str_options5, str_videointerlacemode, 2 ; 2 = deinterlace videos
	mov		[videointerlacemode], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_skipscorescreen, 0
	mov		[skipscorescreen], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_randomstartingsong, 0
	mov		[randomstartingsong], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Bool_ eax, str_options5, str_alternativeriflesound, 0
	mov		[alternativeriflesound], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_usegrenadethrowingsound, 0
	mov		[usegrenadethrowingsound], al

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_usebetateslatank, 0
	mov		[usebetateslatank], al
 
	lea		eax, EBP_RedAlertINI 
    INI_Get_Bool_ eax, str_options5, str_usebetadestroyer, 0
	mov		[usebetadestroyer], al
   
	lea		eax, EBP_RedAlertINI   
    INI_Get_Bool_ eax, str_options5, str_usebetacruiser, 0
	mov		[usebetacruiser], al
 
	lea		eax, EBP_RedAlertINI 
    INI_Get_Bool_ eax, str_options5, str_usebetasubmarine, 0
	mov		[usebetasubmarine], al
    
	lea		eax, EBP_RedAlertINI
    INI_Get_Bool_ eax, str_options5, str_usebetagunboat, 0
	mov		[usebetagunboat], al
	
	lea		eax, EBP_RedAlertINI
	INI_Get_Int_ eax, str_winhotkeys, str_keysidebartoggle, 9
	mov		[keysidebartoggle], ax

	lea		eax, EBP_RedAlertINI	
	INI_Get_Int_ eax, str_winhotkeys, str_keymapsnapshot, 0
	mov		[keymapsnapshot], ax
    
	lea		eax, EBP_RedAlertINI	
	INI_Get_Int_ eax, str_winhotkeys, QuickSaveIniKey, 0x50 ; P
	mov		[KeyQuickSave], ax
    
	lea		eax, EBP_RedAlertINI	
	INI_Get_Int_ eax, str_winhotkeys, QuickLoadIniKey, 0x4C ; L
	mov		[KeyQuickLoad], ax
    
	lea		eax, EBP_RedAlertINI	
	INI_Get_Int_ eax, str_winhotkeys, DebugIniKey, 0x49 ; I
	mov		[KeyDebug], ax

	lea		eax, EBP_RedAlertINI	
	INI_Get_Bool_ eax, str_options5, str_generatememorydump, 0
	mov		[generatememorydump], al
    
	lea		eax, EBP_RedAlertINI
    INI_Get_Bool_ eax, str_options5, str_forceamunitsinmissions, 0
	mov		[forceamunitsinmissions], al
  
	lea		eax, EBP_RedAlertINI  
    INI_Get_Bool_ eax, str_options5, str_colorremapsidebarcameoicons, 0
	mov		[colorremapsidebarcameoicons], al
    
	lea		eax, EBP_RedAlertINI
    INI_Get_Bool_ eax, str_options5, str_usedosinterfacemod, 0
	mov		[usedosinterfacemod], al

	lea		eax, EBP_RedAlertINI    
    INI_Get_Bool_ eax, str_options5, str_enablewol, 0
	mov		[enablewol], al
  
	lea		eax, EBP_RedAlertINI  
    INI_Get_Bool_ eax, str_options5, str_fastambuildspeed, 0
	mov		[fastambuildspeed], al

	
	popad
	jmp		0x00525AA4

_Startup_Function_Hook_Early_Load:
	xor                edx, edx
	mov                [0x006ABBC8], edx
	pushad

    Load_INIClass str_spawnini2, FileClass_spawnini2, INIClass_spawnini2
	
	INI_Get_Bool_ INIClass_spawnini2, str_settings2, str_aftermath, 0
	mov		[spawner_aftermath], al
	
	popad
	mov     ebx, [0x006ABC10]
	jmp                0x00551A8D
	retn

_Init_Game_Hook_Load:
	push 	ecx
	push 	ebx
	push 	edx
	push 	eax
	
	
	INI_Get_Bool_ 0x00666688, str_aftermath, str_aftermathfastbuildspeed, 0
	mov		[aftermathfastbuildspeed], al
	
	INI_Get_Bool_ 0x00666688, str_ai, str_removeaitechupcheck, 0
	mov		[removeaitechupcheck], al
	
	INI_Get_Bool_ 0x00666688, str_ai, str_fixaiparanoid, 0
	mov		[fixaiparanoid], al
	
	INI_Get_Bool_ 0x00666688, str_ai, str_fixaially, 0
	mov		[fixaially], al
	
	INI_Get_Bool_ 0x00666688, str_general, str_fixformationspeed, 0
	mov		[fixformationspeed], al
	
	INI_Get_Bool_ 0x00666688, str_general, str_parabombsinmultiplayer, 0
	mov		[parabombsinmultiplayer], al
	
	INI_Get_Bool_ 0x00666688, str_general, str_evacinmp, 1
	mov		[evacinmp], al
	
	INI_Get_Bool_ 0x00666688, str_ai, str_fixaisendingtankstopleft, 0
	mov		[fixaisendingtankstopleft], al
    
    INI_Get_Bool_ 0x00666688, str_ai, str_computerparanoidforcedisabledskirmish, 1
	mov [computerparanoidforcedisabledskirmish], al
    
	
;  EXTRA COLOUR REMAP WHITE
	Initialize_Remap_Table colorwhiteoffset
		
	mov		BYTE [extraremaptable+0x0], 0x0F 
	mov		BYTE [extraremaptable+0x1], 0x0F ; Name in radar logo color bits, this is for a yellow name
	
	; Remap colours for name in the name list on the radar
	mov		BYTE [extraremaptable+268], 0x0F
	mov		BYTE [extraremaptable+269], 0x0E
	mov		BYTE [extraremaptable+270], 0x0F
	mov		BYTE [extraremaptable+271], 0x0E
	mov		BYTE [extraremaptable+272], 0x0F
	mov		BYTE [extraremaptable+273], 0x0E
	mov		BYTE [extraremaptable+274], 0x0F
	mov		BYTE [extraremaptable+275], 0x0E
	mov		BYTE [extraremaptable+276], 0x0F
	mov		BYTE [extraremaptable+277], 0x0E
	mov		BYTE [extraremaptable+278], 0x0F
	mov		BYTE [extraremaptable+279], 0x0E
	
	; Remap colour on radar map
	mov		BYTE [extraremaptable+280], 0x4F
	mov		BYTE [extraremaptable+281], 0x4F
		
	; Remap colours on units, from lighest shade to darkest
	MOV     BYTE [extraremaptable+82], 0x0F ; 15
	MOV     BYTE [extraremaptable+83], 0x0F ; 15
	MOV     BYTE [extraremaptable+84], 0x80 ; 128
	MOV     BYTE [extraremaptable+85], 0x80 ; 128
	MOV     BYTE [extraremaptable+86], 0x80 ; 128
	MOV     BYTE [extraremaptable+87], 0x84 ; 132
	MOV     BYTE [extraremaptable+88], 0x84 ; 132
	MOV     BYTE [extraremaptable+89], 0x85 ; 133
	MOV     BYTE [extraremaptable+90], 0x88 ; 136
	MOV     BYTE [extraremaptable+91], 0x89 ; 137
	MOV     BYTE [extraremaptable+92], 0x8A ; 138
	MOV     BYTE [extraremaptable+93], 0x8A ; 138
	MOV     BYTE [extraremaptable+94], 0x8B ; 139
	MOV     BYTE [extraremaptable+95], 0x8B ; 139
	MOV     BYTE [extraremaptable+96], 0x8D ; 141
	MOV     BYTE [extraremaptable+97], 0x8F ; 143
	
;  EXTRA COLOUR REMAP BLACK
	Initialize_Remap_Table colorblackoffset
	
	mov		BYTE [extraremaptable+colorblackoffset+0x0], 0x0F 
	mov		BYTE [extraremaptable+colorblackoffset+0x1], 0x0F ; Name in radar logo color bits, this is for a yellow name
	
	; Remap colours for name in the name list on the radar
	mov		BYTE [extraremaptable+colorblackoffset+268], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+269], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+270], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+271], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+272], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+273], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+274], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+275], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+276], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+277], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+278], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+279], 0x12
	
	; Remap colour on radar map
	mov		BYTE [extraremaptable+colorblackoffset+280], 0x12
	mov		BYTE [extraremaptable+colorblackoffset+281], 0x12
		
	; Remap colours on units, from lighest shade to darkest
	MOV     BYTE [extraremaptable+colorblackoffset+82], 0x8A ; 138
	MOV     BYTE [extraremaptable+colorblackoffset+83], 0x8B ; 139
	MOV     BYTE [extraremaptable+colorblackoffset+84], 0x8C ; 140
	MOV     BYTE [extraremaptable+colorblackoffset+85], 0x8C ; 140
	MOV     BYTE [extraremaptable+colorblackoffset+86], 0x8D ; 141
	MOV     BYTE [extraremaptable+colorblackoffset+87], 0x8D ; 141
	MOV     BYTE [extraremaptable+colorblackoffset+88], 0x8E ; 142
	MOV     BYTE [extraremaptable+colorblackoffset+89], 0x8E ; 142
	MOV     BYTE [extraremaptable+colorblackoffset+90], 0x8F ; 143
	MOV     BYTE [extraremaptable+colorblackoffset+91], 0x8F ; 143
	MOV     BYTE [extraremaptable+colorblackoffset+92], 0x13 ; 19
	MOV     BYTE [extraremaptable+colorblackoffset+93], 0x12 ; 18
	MOV     BYTE [extraremaptable+colorblackoffset+94], 0x11 ; 17
	MOV     BYTE [extraremaptable+colorblackoffset+95], 0x11 ; 17
	MOV     BYTE [extraremaptable+colorblackoffset+96], 0x0C ; 12
	MOV     BYTE [extraremaptable+colorblackoffset+97], 0x0C ; 12
	
	;  EXTRA COLOUR REMAP FLAMING BLUE
	Initialize_Remap_Table colourflamingblueoffset
	
	; Remap colours for name in the name list on the radar
;00667518  C0 C1 C2 C3 C4 C5 C7 C6  ????
;00667520  C5 C2 C2 A0            ???

	mov		BYTE [extraremaptable+colourflamingblueoffset+268], 0xC0
	mov		BYTE [extraremaptable+colourflamingblueoffset+269], 0xC1
	mov		BYTE [extraremaptable+colourflamingblueoffset+270], 0xC2
	mov		BYTE [extraremaptable+colourflamingblueoffset+271], 0xC3
	mov		BYTE [extraremaptable+colourflamingblueoffset+272], 0xC4
	mov		BYTE [extraremaptable+colourflamingblueoffset+273], 0xC5
	mov		BYTE [extraremaptable+colourflamingblueoffset+274], 0xC7
	mov		BYTE [extraremaptable+colourflamingblueoffset+275], 0xC6
	mov		BYTE [extraremaptable+colourflamingblueoffset+276], 0xC5
	mov		BYTE [extraremaptable+colourflamingblueoffset+277], 0xC2
	mov		BYTE [extraremaptable+colourflamingblueoffset+278], 0xC2
	mov		BYTE [extraremaptable+colourflamingblueoffset+279], 0xA0
	
	; Remap colour on radar map
; 00667524  A0 C4                    ?

	mov		BYTE [extraremaptable+colourflamingblueoffset+280], 0xA0
	mov		BYTE [extraremaptable+colourflamingblueoffset+281], 0xC4
		
	; Remap colours on units, from lighest shade to darkest
;0066745E  A0 A1 C0 C1 C2 C3 C4 C5  ????
;00667466  C6 C6 C7 C7 AD AE AF AF       ???

	MOV     BYTE [extraremaptable+colourflamingblueoffset+82], 0xA0
	MOV     BYTE [extraremaptable+colourflamingblueoffset+83], 0xA1
	MOV     BYTE [extraremaptable+colourflamingblueoffset+84], 0xC0
	MOV     BYTE [extraremaptable+colourflamingblueoffset+85], 0xC1
	MOV     BYTE [extraremaptable+colourflamingblueoffset+86], 0xC2
	MOV     BYTE [extraremaptable+colourflamingblueoffset+87], 0xC3
	MOV     BYTE [extraremaptable+colourflamingblueoffset+88], 0xC4
	MOV     BYTE [extraremaptable+colourflamingblueoffset+89], 0xC5
	MOV     BYTE [extraremaptable+colourflamingblueoffset+90], 0xC6
	MOV     BYTE [extraremaptable+colourflamingblueoffset+91], 0xC6
	MOV     BYTE [extraremaptable+colourflamingblueoffset+92], 0xC7
	MOV     BYTE [extraremaptable+colourflamingblueoffset+93], 0xC7
	MOV     BYTE [extraremaptable+colourflamingblueoffset+94], 0xAD
	MOV     BYTE [extraremaptable+colourflamingblueoffset+95], 0xAE
	MOV     BYTE [extraremaptable+colourflamingblueoffset+96], 0xAF
	MOV     BYTE [extraremaptable+colourflamingblueoffset+97], 0xAF
	
;	mov		BYTE [extraremaptable+colourbrightyellowoffset+0x0], 0x0F 
;	mov		BYTE [extraremaptable+colourbrightyellowoffset+0x1], 0x12 ; Name in radar logo color bits, this is for a yellow name
		
;	_INIClass__Get_Int_
	
	pop		eax
	pop		edx
	pop		ebx
	pop		ecx
	
	mov     eax, 1
	jmp		0x004F4471
	
	
Set_Single_CPU_Affinity:
	PUSH str_kernel32dll
    CALL 0x005E5892 ; LoadLibraryA

    TEST EAX,EAX
    JZ .Crash


    PUSH str_SetProcessAffinityMask
    PUSH EAX
    CALL 0x005E575A ; GetProcAddress

    TEST EAX,EAX
    JZ .Crash

    MOV [SetProcessAffinityMask], EAX

	PUSH	1
    CALL [0x005E65D0] ; [GetCurrentProcess]
	PUSH	EAX
	
	call [SetProcessAffinityMask]
	
.Ret:
	retn
	
.Crash:
	int 	3
    
    
DoAllocConsole:
	PUSH str_kernel32dll
    CALL 0x005E5892 ; LoadLibraryA

    TEST EAX,EAX
    JZ .Ret

    PUSH str_AllocConsole
    PUSH EAX
    CALL 0x005E575A ; GetProcAddress

    TEST EAX,EAX
    JZ .Ret

    call EAX
	
    mov ebx, 0x0060D63A ; stdout
    mov edx, str_w ; w
    mov eax, str_conout ; "CONOUT$"
    call 0x005D413D ; freopen_
    
.Ret:
	retn

    
_RulesClass__AI_Load:
	pushad
	
	INI_Get_Int_ esi, 0x005EFC29, str_EasyAIGoldValue, [EasyAIOreValue]
	mov		[EasyAIOreValue], eax
	
	INI_Get_Int_ esi, 0x005EFC29, str_EasyAIGemValue, [EasyAIGemValue]
	mov		[EasyAIGemValue], eax
	
	INI_Get_Int_ esi, 0x005EFC29, str_NormalAIGoldValue, [NormalAIOreValue]
	mov		[NormalAIOreValue], eax
	
	INI_Get_Int_ esi, 0x005EFC29, str_NormalAIGemValue, [NormalAIGemValue]
	mov		[NormalAIGemValue], eax
	
	INI_Get_Int_ esi, 0x005EFC29, str_HardAIGoldValue, [HardAIOreValue]
	mov		[HardAIOreValue], eax
	
	INI_Get_Int_ esi, 0x005EFC29, str_HardAIGemValue, [HardAIGemValue]
	mov		[HardAIGemValue], eax
	
	INI_Get_Bool_ esi, 0x005EFC29, str_ReenableAITechUpCheck, [ReenableAITechUpCheck]
	mov		[ReenableAITechUpCheck], eax
	
.Ret:
	popad
	mov     ebx, 0x005EFD21; offset aDefenselimit
	jmp		0x00536ABA
