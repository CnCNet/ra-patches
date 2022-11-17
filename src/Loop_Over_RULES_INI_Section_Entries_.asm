%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern INIClass__Get_String
extern _RulesINI

%macro INI_Get_String_ 6
    push %6             ; dst len
    push %5             ; dst
    mov ecx, dword %4   ; default
    mov ebx, dword %3   ; key
    mov edx, dword %2   ; section
    mov eax, %1
    call INIClass__Get_String
%endmacro

; args <RULES.INI Section Name to get entry count for>
%macro	Get_RULES_INI_Section_Entry_Count 1
	push	edx
	mov		edx, %1
	mov     eax, _RulesINI
	call	0x004F31BC    ; int const INIClass::Entry_Count(char *)
	pop		edx
%endmacro

global Loop_Over_RULES_INI_Section_Entries_

[section .data]
Loop_Entry_Buffer: TIMES 256 DB 0

[section .text]
Loop_Over_RULES_INI_Section_Entries_:
	pushad
;	==== loop setup
	push	edx		; section name
	push	eax	; function to call
	Get_RULES_INI_Section_Entry_Count edx
	mov		esi, eax ; loop max
	mov		edi, 0 ; Loop variable
;	==== start looping
.Loop:
	cmp		edi, esi
	jge		.Out
	
	mov		ebx, edi
	mov		edx, [esp+4] ; Section name
	mov		eax, _RulesINI
	call	0x004F31EC     ;  char * const INIClass::Get_Entry(char *, int)

	mov		edx, [esp+4] ; Section name
	INI_Get_String_ _RulesINI, edx , eax, 0xFF, Loop_Entry_Buffer, 256
	
	; call function pointer with the value of the entry
	mov		edx, Loop_Entry_Buffer
	mov		ebx, edi
	mov		eax, esp ; function pointer
	call	[eax]
	
	inc		edi
	jmp		.Loop
	
.Out:
	pop		eax
	pop		edx
	popad
	retn
	