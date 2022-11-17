%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "ini.inc"

cextern time
cextern gmtime
cextern asctime_
cextern sprintf

global Create_Map_Snapshot

sstring str_MapSnap_MPR, "MapSnap.MPR"
sstring MapSnapshotSF, "Map Snapshot %s"
sstring MapSnapshot, "", 256
sint unixTime, 0

%define Basic_Section 0x005EFFA5

[section .data]
; sizes not actually verified
MapSnapshot_CCINIClass TIMES 256 db 0
MapSnapshot_FileClass TIMES 256 db 0



[section .text]
Create_Map_Snapshot:
	pushad
	
	; Initialize output file
	mov edx, str_MapSnap_MPR
 mov eax, MapSnapshot_FileClass
 call 0x004627D4 ; CCFileClass::CCFileClass(char *)
	
 ; initialize INIClass	
 mov eax, MapSnapshot_CCINIClass
 call 0x004C7C60 ; CCINIClass::CCINIClass(void)
	
;===========================
	; Write [Basic]
	
	; Map name
	;mov eax, 0x00667BD8 ;original name
    mov eax, unixTime
    call time
    mov eax, unixTime
    call gmtime
    push eax
    call asctime_
    add esp, 4
    push eax
    push MapSnapshotSF
    push MapSnapshot
    call sprintf
    add esp, 12
    
    mov eax, MapSnapshot
	INI_Put_String MapSnapshot_CCINIClass, Basic_Section, 0x005EFFB2, eax
		
	; NewINIFormat
	INI_Put_Int MapSnapshot_CCINIClass, Basic_Section, 0x005F000E, dword [0x00665DE8]
		
	; Intro
	INI_Put_VQType MapSnapshot_CCINIClass, Basic_Section, 0x005EFFB7, byte [0x00667C04]

	; Brief
	INI_Put_VQType MapSnapshot_CCINIClass, Basic_Section, 0x005EFFBD, byte [0x00667C05]
	
	; Win
	INI_Put_VQType MapSnapshot_CCINIClass, Basic_Section, 0x005EFFC3, byte [0x00667C06]
	
	; Lose
	INI_Put_VQType MapSnapshot_CCINIClass, Basic_Section, 0x005EFFC7, byte [0x00667C07]
	
	; Action
	INI_Put_VQType MapSnapshot_CCINIClass, Basic_Section, 0x005EFFCC, byte [0x00667C08]
	
	; ToCarryOver
	xor ecx, ecx
	test byte [0x006680A1], 8 ; ptr ds:Scenario_bool_bitfield_6680A1
	setne cl
	INI_Put_Bool MapSnapshot_CCINIClass, Basic_Section, 0x005EFFD3, ecx
	
	; Theme
	INI_Put_ThemeType MapSnapshot_CCINIClass, Basic_Section, 0x005F0008, byte [0x00668009]
	
	; CarryOverMoney
	INI_Put_Fixed MapSnapshot_CCINIClass, Basic_Section, 0x0005F001B, 0x0066800B
	
	; CarryOverCap
	INI_Put_Int	MapSnapshot_CCINIClass, Basic_Section, 0x005F002A, dword [0x00668011]
	
;=========================	
	; Write other stuff
	mov edx, MapSnapshot_CCINIClass
	mov eax, 0x00668250 ; offset MouseClass Map
	call 0x004B545C   ;  void DisplayClass::Write_INI(CCINIClass &)
	
	mov edx, MapSnapshot_CCINIClass
	mov eax, 0x0067F28C ; offset BaseClass Base
	call 0x00426944 ; void BaseClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass
	call 0x005501E4 ; void SmudgeClass::Write_INI(CCINIClass &)

	mov eax, MapSnapshot_CCINIClass
	call 0x0052736C ; void OverlayClass::Write_INI(CCINIClass &)

	mov eax, MapSnapshot_CCINIClass	
	call 0x0056076C ; void TeamTypeClass::Write_INI(CCINIClass &)

	mov eax, MapSnapshot_CCINIClass	
	call 0x0056AD6C ; void TerrainClass::Write_INI(CCINIClass &)

	mov eax, MapSnapshot_CCINIClass	
	call 0x0056D640 ; void TriggerTypeClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass	
	call 0x004DDEB0 ; void HouseClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass	
	call 0x004F0A84 ; void InfantryClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass	
	call 0x00581298 ; void UnitClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass	
	call 0x0058CC18 ; void VesselClass::Write_INI(CCINIClass &)
	
	mov eax, MapSnapshot_CCINIClass	
	call 0x0045F07C ; void BuildingClass::Write_INI(CCINIClass &)
	
.Save_File:
	xor ebx, ebx
	mov edx, MapSnapshot_FileClass
	mov eax, MapSnapshot_CCINIClass
	call 0x004F2F08 ; int const INIClass::Save(FileClass &)
	
.Ret:
	popad
	retn