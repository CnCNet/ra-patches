%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

; args <HouseType for house>, <Colour to set>
%macro Set_House_Colour 2
	mov eax, %1
	call 0x004D2CB0 ; HouseClass::As_Pointer()
    xor edx, edx
	mov dl, %2	; Colour
    cmp dl, 0xFF
    je .Set_House_Colour_Ret_%1
    mov [eax+178Fh], dl
.Set_House_Colour_Ret_%1:
%endmacro

; args <HouseType for house>, <Country to set>
%macro Set_House_Country 2
	mov eax, %1
	call 0x004D2CB0 ; HouseClass::As_Pointer()
    xor edx, edx
	mov dl, %2	; Country
    cmp dl, 0xFF
    je .Set_House_Country_Ret_%1
    mov [eax+41h], dl
.Set_House_Country_Ret_%1:
%endmacro

; args <HouseType for house>, <Handicap to set>
%macro Set_House_Handicap 2
	mov eax, %1
	call 0x004D2CB0 ; HouseClass::As_Pointer()
    xor edx, edx
	mov dl, %2	; Handicap
    cmp dl, 0xFF
    je .Set_House_Handicap_Ret_%1
    call 0x004D2D48
.Set_House_Handicap_Ret_%1:
%endmacro

extern str_housecolours
extern str_housecountries
extern str_househandicaps

extern Multi1_Colour
extern Multi2_Colour
extern Multi3_Colour
extern Multi4_Colour
extern Multi5_Colour
extern Multi6_Colour
extern Multi7_Colour
extern Multi8_Colour

extern Multi1_Country
extern Multi2_Country
extern Multi3_Country
extern Multi4_Country
extern Multi5_Country
extern Multi6_Country
extern Multi7_Country
extern Multi8_Country

extern Multi1_Handicap
extern Multi2_Handicap
extern Multi3_Handicap
extern Multi4_Handicap
extern Multi5_Handicap
extern Multi6_Handicap
extern Multi7_Handicap
extern Multi8_Handicap

%define HOUSE_MULTI1 0x0c
%define HOUSE_MULTI2 0x0d
%define HOUSE_MULTI3 0x0e
%define HOUSE_MULTI4 0x0f
%define HOUSE_MULTI5 0x10
%define HOUSE_MULTI6 0x11
%define HOUSE_MULTI7 0x12
%define HOUSE_MULTI8 0x13


[section .text]
Set_Colour_For_Houses:
    Set_House_Colour HOUSE_MULTI1, [Multi1_Colour]
    Set_House_Colour HOUSE_MULTI2, [Multi2_Colour]
    Set_House_Colour HOUSE_MULTI3, [Multi3_Colour]
    Set_House_Colour HOUSE_MULTI4, [Multi4_Colour]
    Set_House_Colour HOUSE_MULTI5, [Multi5_Colour]
    Set_House_Colour HOUSE_MULTI6, [Multi6_Colour]
    Set_House_Colour HOUSE_MULTI7, [Multi7_Colour]
    Set_House_Colour HOUSE_MULTI8, [Multi8_Colour]
    retn
    
Set_Country_For_Houses:
    Set_House_Country HOUSE_MULTI1, [Multi1_Country]
    Set_House_Country HOUSE_MULTI2, [Multi2_Country]
    Set_House_Country HOUSE_MULTI3, [Multi3_Country]
    Set_House_Country HOUSE_MULTI4, [Multi4_Country]
    Set_House_Country HOUSE_MULTI5, [Multi5_Country]
    Set_House_Country HOUSE_MULTI6, [Multi6_Country]
    Set_House_Country HOUSE_MULTI7, [Multi7_Country]
    Set_House_Country HOUSE_MULTI8, [Multi8_Country]
    retn
    
Set_Handicap_For_Houses:
    Set_House_Handicap HOUSE_MULTI1, [Multi1_Handicap]
    Set_House_Handicap HOUSE_MULTI2, [Multi2_Handicap]
    Set_House_Handicap HOUSE_MULTI3, [Multi3_Handicap]
    Set_House_Handicap HOUSE_MULTI4, [Multi4_Handicap]
    Set_House_Handicap HOUSE_MULTI5, [Multi5_Handicap]
    Set_House_Handicap HOUSE_MULTI6, [Multi6_Handicap]
    Set_House_Handicap HOUSE_MULTI7, [Multi7_Handicap]
    Set_House_Handicap HOUSE_MULTI8, [Multi8_Handicap]
    retn
    

@HACK 0x0053E1BC, _Assign_Houses_Epilogue
    jge .Epilogue
    jmp 0x0053E1C2
    
.Epilogue:
    pushad
    
    call Set_Colour_For_Houses
    call Set_Country_For_Houses
    call Set_Handicap_For_Houses
    
    popad
    jmp 0x0053B81A
@ENDHACK

@HACK 0x0053E18F, _Assign_Houses_Epilogue2
    jge .Epilogue
    jmp 0x0053E195
    
.Epilogue:
    pushad
    
    call Set_Colour_For_Houses
    call Set_Country_For_Houses
    call Set_Handicap_For_Houses
    
    popad
    jmp 0x0053B81A
@ENDHACK
