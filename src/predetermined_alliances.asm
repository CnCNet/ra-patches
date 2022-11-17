%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

; args <HouseType that will ally>, <HouseType to ally>
%macro Ally_House 2
	mov		eax, %1 ; House that will ally another house
	call	0x004D2CB0 ; HouseClass::As_Pointer()
	mov		edx, %2	; House to be allied
	call	0x004D6060 ; HouseClass::Make_Ally(HousesType)
%endmacro

; Loads alliances from map for a HouseType
; args <HouseType>, <INI section string>, <INIClass>
%macro Load_Alliances 3
	INI_Get_Int_ %3, %2, str_HouseAllyOne, 0
	cmp eax, 0
	jz .Dont_Ally_1_%1	
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_1_%1:
	INI_Get_Int_ %3, %2, str_HouseAllyTwo, 0
	cmp eax, 0
	jz .Dont_Ally_2_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_2_%1:

	INI_Get_Int_ %3, %2, str_HouseAllyThree, 0
	cmp eax, 0
	jz .Dont_Ally_3_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_3_%1:

	INI_Get_Int_ %3, %2, str_HouseAllyFour, 0
	cmp eax, 0
	jz .Dont_Ally_4_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_4_%1:

	INI_Get_Int_ %3, %2, str_HouseAllyFive, 0
	cmp eax, 0
	jz .Dont_Ally_5_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_5_%1:

	INI_Get_Int_ %3, %2, str_HouseAllySix, 0
	cmp eax, 0
	jz .Dont_Ally_6_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_6_%1:

	INI_Get_Int_ %3, %2, str_HouseAllySeven, 0
	cmp eax, 0
	jz .Dont_Ally_7_%1
	mov edx, eax
	Ally_House %1, edx
	
.Dont_Ally_7_%1:
	
%endmacro

extern INIClass_SPAWN

%define HOUSE_MULTI1 0x0c
%define HOUSE_MULTI2 0x0d
%define HOUSE_MULTI3 0x0e
%define HOUSE_MULTI4 0x0f
%define HOUSE_MULTI5 0x10
%define HOUSE_MULTI6 0x11
%define HOUSE_MULTI7 0x12
%define HOUSE_MULTI8 0x13

StringZ str_HouseAllyOne, "HouseAllyOne"
StringZ str_HouseAllyTwo, "HouseAllyTwo"
StringZ str_HouseAllyThree, "HouseAllyThree"
StringZ str_HouseAllyFour, "HouseAllyFour"
StringZ str_HouseAllyFive, "HouseAllyFive"
StringZ str_HouseAllySix, "HouseAllySix"
StringZ str_HouseAllySeven, "HouseAllySeven"
StringZ str_Multi1_Alliances, "Multi1_Alliances"
StringZ str_Multi2_Alliances, "Multi2_Alliances"
StringZ str_Multi3_Alliances, "Multi3_Alliances"
StringZ str_Multi4_Alliances, "Multi4_Alliances"
StringZ str_Multi5_Alliances, "Multi5_Alliances"
StringZ str_Multi6_Alliances, "Multi6_Alliances"
StringZ str_Multi7_Alliances, "Multi7_Alliances"
StringZ str_Multi8_Alliances, "Multi8_Alliances"

@HACK 0x0053DC0B, _Read_Scenario_INI_Ally_Test
	call 0x0053DED4 ; Assign_Houses(void)
	
	pushad
	
	mov esi, INIClass_SPAWN ; SPAWN.INI
	; args <HouseType>, <INI section string>, <INIClass>
	Load_Alliances HOUSE_MULTI1, str_Multi1_Alliances, esi
	Load_Alliances HOUSE_MULTI2, str_Multi2_Alliances, esi
	Load_Alliances HOUSE_MULTI3, str_Multi3_Alliances, esi
	Load_Alliances HOUSE_MULTI4, str_Multi4_Alliances, esi
	Load_Alliances HOUSE_MULTI5, str_Multi5_Alliances, esi
	Load_Alliances HOUSE_MULTI6, str_Multi6_Alliances, esi
	Load_Alliances HOUSE_MULTI7, str_Multi7_Alliances, esi
	Load_Alliances HOUSE_MULTI8, str_Multi8_Alliances, esi
	
	; Have Multi1 ally Multi2
;	Ally_House HOUSE_MULTI1, HOUSE_MULTI2
	; Have Multi2 ally Multi1
;	Ally_House HOUSE_MULTI2, HOUSE_MULTI1
	
	popad
	
	jmp 0x0053DC10
@ENDHACK
	
	