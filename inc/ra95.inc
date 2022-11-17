%include "macros/extern.inc"

; This header works with sym.asm which defines the Vanilla symbols
; This header will be split up as it becomes larger

; ### definitions of common structures ###

struc ListAddress
    .port:      RESD 1
    .ip:        RESD 1
endstruc


; ### Constants ###

%assign SESSION_CAMPAIGN  0x0
%assign SESSION_1 0x1
%assign SESSION_2 0x2
%assign SESSION_NETWORK   0x3
%assign SESSION_ONLINE    0x4
%assign SESSION_SKIRMISH  0x5
%assign SESSION_6 0x6
%assign SESSION_MODEM 0x7

%assign HC_PLAYER_NAME 0x1790

%assign 	RTTI_NONE			0
%assign 	RTTI_AIRCRAFT		1
%assign 	RTTI_AIRCRAFTTYPE	2
%assign 	RTTI_ANIM 			3
%assign 	RTTI_ANIMTYPE		4
%assign 	RTTI_BUILDING 		5
%assign 	RTTI_BUILDINGTYPE	6
%assign 	RTTI_BULLET 		7
%assign 	RTTI_BULLETTYPE		8
%assign 	RTTI_CELL			9
%assign 	RTTI_FACTORY		10
%assign 	RTTI_HOUSE 			11
%assign 	RTTI_HOUSETYPE 		12
%assign 	RTTI_INFANTRY 		13
%assign 	RTTI_INFANTRYTYPE 	14
%assign 	RTTI_OVERLAY 		15
%assign 	RTTI_OVERLAYTYPE 	16
%assign 	RTTI_SMUDGE 		17
%assign 	RTTI_SMDUGETYPE 	18
%assign 	RTTI_SPECIAL 		19
%assign 	RTTI_TEAM 			20
%assign 	RTTI_TEAMTYPE 		21
%assign 	RTTI_TEMPLATE 		22
%assign 	RTTI_TEMPLATETYPE 	23
%assign 	RTTI_TERRAIN 		24
%assign 	RTTI_TERRAINTYPE 	25
%assign 	RTTI_TRIGGER 		26
%assign 	RTTI_TRIGGERTYPE 	27
%assign 	RTTI_UNIT 			28
%assign 	RTTI_UNITTYPE 		29
%assign 	RTTI_VESSEL 		30
%assign 	RTTI_VESSELTYPE 	31

%assign BUILDING_CLASS__BUILDING_TYPE 0x0cd

%assign BUILDING_TYPE__ALLIES_TECH_CENTER 0
%assign BUILDING_TYPE__IRON_COURTAIN 1
%assign BUILDING_TYPE__WAR_FACTORY 2
%assign BUILDING_TYPE__CHRONOSPHERE 3
%assign BUILDING_TYPE__PILLBOX 4
%assign BUILDING_TYPE__CAMO_PILLBOX 5
%assign BUILDING_TYPE__RADAR 6
%assign BUILDING_TYPE__GAP_GENERATOR 7
%assign BUILDING_TYPE__TURRET 8
%assign BUILDING_TYPE__AA_GUN 9
%assign BUILDING_TYPE__FLAME_TURRET 10
%assign BUILDING_TYPE__CONSTRUCTION_YARD 11
%assign BUILDING_TYPE__REFINERY 12
%assign BUILDING_TYPE__SILO 13
%assign BUILDING_TYPE__HELIPAD 14
%assign BUILDING_TYPE__SAM_SITE 15
%assign BUILDING_TYPE__AIRFIELD 16
%assign BUILDING_TYPE__POWER_PLANT 17
%assign BUILDING_TYPE__ADVANCED_POWER_PLANT 18
%assign BUILDING_TYPE__SOVIET_TECH_CENTER 19
%assign BUILDING_TYPE__HOSPITAL 20
%assign BUILDING_TYPE__SOVIET_BARRACKS 21
%assign BUILDING_TYPE__ALLIES_BARRACKS 22
%assign BUILDING_TYPE__KENNEL 23
%assign BUILDING_TYPE__SERVICE_DEPOT 24
%assign BUILDING_TYPE__BIO_LABOR 25
%assign BUILDING_TYPE__TESLA_COIL 31

; ### Variables ###
cextern HouseClass__PlayerPtr
cextern PKey__FastKey
cextern ConnectionLost
cextern HumanPlayersLeft


; ### Functions ###
cextern HouseClass__Is_Ally
extern IPXManagerClass__Connection_ID
cextern ExtractString
cextern MixFileClass_CCFileClass_Retrieve
cextern MixFileClass_CCFileClass_Cache

cextern _imp__Sleep
cextern _imp__timeGetTime
cextern _imp__GetCurrentThread
cextern _imp__GetProcAddress
cextern _imp__LoadLibraryA
cextern _imp__GetModuleHandleA
cextern _imp__EnterCriticalSection
cextern _imp__DeleteCriticalSection
cextern _imp__InitializeCriticalSection
cextern _imp__LeaveCriticalSection

cextern memcpy
cextern stristr_

; watcall
extern OperatorNew
extern FieldClass__FieldClass_String
extern PacketClass__Add_Field
extern strcmp

