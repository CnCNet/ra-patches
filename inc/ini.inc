extern Loop_Over_RULES_INI_Section_Entries_
extern INIClass__Get_Bool
extern INIClass__Get_Int
extern INIClass__Get_String
extern FileClass__FileClass
extern FileClass__Is_Available
extern _INIClass__INIClass
extern _INIClass__Load

; args: <INI Name>, <FileClass>, <INIClass>
%macro Load_INIClass 3
	MOV EDX, %1
    MOV EAX, %2
    CALL FileClass__FileClass

    ; check ini exists
    MOV EAX, %2
    XOR EDX, EDX
    CALL FileClass__Is_Available

    ; initialize INIClass
    MOV EAX, %3
    CALL _INIClass__INIClass

    ; load FileClass to INIClass
    MOV EDX, %2
    MOV EAX, %3
    CALL _INIClass__Load
%endmacro

; args: <INIClass>, <section>, <key>, <default>, <dst>
%macro INI_Get_Bool_ 4
    MOV ECX, DWORD %4
    MOV EBX, DWORD %3
    MOV EDX, DWORD %2
    MOV EAX, %1
    CALL INIClass__Get_Bool
%endmacro

; args: <INIClass>, <section>, <key>, <default>, <dst>
%macro INI_Get_Int_ 4
    MOV ECX, DWORD %4
    MOV EBX, DWORD %3
    MOV EDX, DWORD %2
    MOV EAX, %1
    CALL INIClass__Get_Int
%endmacro

; args: <INICLASS> <section>, <key>, <default>, <dst>, <dst_len>
%macro INI_Get_String_ 6
    PUSH %6             ; dst len
    PUSH %5             ; dst
    MOV ECX, DWORD %4   ; default
    MOV EBX, DWORD %3   ; key
    MOV EDX, DWORD %2   ; section
    MOV EAX, %1
    CALL INIClass__Get_String
%endmacro

; args: <INIClass>, <Section>, <Key>, <String Value>
%macro INI_Put_String 4
	mov     ebx, %3
	mov     edx, %2
	mov     ecx, %4
	mov		eax, %1
	call    0x004F3760 ; INIClass::Put_String(char *,char *,char *)
%endmacro

; args: <INIClass>, <Section>, <Key>, <Int Value>
%macro INI_Put_Int 4
	push    0
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov     ecx, %4
	call    0x004F35E8; INIClass::Put_Int(char *,char *,int,int)
%endmacro

; args: <INIClass>, <Section>, <Key>, <VQType Value>
%macro INI_Put_VQType 4
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov		cl, %4
	call	0x0463830   ;  int CCINIClass::Put_VQType(char *, char *, VQType)
%endmacro

; args: <INIClass>, <Section>, <Key>, <Bool Value>
%macro INI_Put_Bool 4
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov		ecx, %4
	call	0x004F3AB0    ;  int INIClass::Put_Bool(char *, char *, int)
%endmacro

; args: <INIClass>, <Section>, <Key>, <ThemeType Value>
%macro INI_Put_ThemeType 4
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov		cl, %4
	call	0x00463948    ; int CCINIClass::Put_ThemeType(char *, char *, ThemeType)
%endmacro

; args: <INIClass>, <Section>, <Key>, <Fixed Value>
%macro INI_Put_Fixed 4
	mov     ebx, %3 
	mov     edx, %2
	mov     eax, %1
	mov		ecx, %4
	call	0x004F3D80    ; int INIClass::Put_Fixed(char *, char *, fixed)
%endmacro

; args <RULES.INI Section Name to get entry count for>
%macro	Get_RULES_INI_Section_Entry_Count 1
	push	edx
	mov		edx, %1
	mov     eax, _RulesINI
	call	0x004F31BC    ; int const INIClass::Entry_Count(char *)
	pop		edx
%endmacro
	
; args <RULES.INI Section Name to loop entries over>, <function to call (with entry name in EDX)
%macro	Loop_Over_RULES_INI_Section_Entries 2
	push	edx
	push	eax
	mov		edx, %1
	mov     eax, %2
	call	Loop_Over_RULES_INI_Section_Entries_
	pop		eax
	pop		edx
%endmacro

