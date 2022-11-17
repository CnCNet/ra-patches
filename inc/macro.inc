%define _printf     0x005CD97B
%define _sprintf    0x005B8BAA

%macro printf 1-*
    %rep %0
        %rotate -1
        PUSH %1
    %endrep
    CALL _printf
    ADD ESP,(%0 * 4)
%endmacro

%macro sprintf 1-*
    %rep %0
        %rotate -1
        PUSH %1
    %endrep
    CALL _sprintf
    ADD ESP,(%0 * 4)
%endmacro


%macro Extract_Conquer_Eng_String 1
	mov     edx, %1
	mov     eax, [0x0066991C] ; ds:char *SystemStrings
	call    0x005C5070  ; Extract_String(void *,int)
%endmacro

; args <What to turn bit on, <what bit to turn on>
%macro Turn_On_Bit	2
	mov		al,	1
	shl		al, BYTE %2-1
	or		BYTE %1, al
%endmacro Set_Bit 3

; args <What to check bit on>, <what bit to check>
%macro Get_Bit 2
	mov		al, 1
	shl		al, BYTE %2-1
	test    BYTE %1, al
	setnz	al
%endmacro

;number &= ~(1 << x);
; args <What to clear bit on>, <what bit to clear>
%macro Clear_Bit 2
	mov		al, 1
	shl		al, BYTE %2-1
	add 	al, 1
	neg		al
	and 	BYTE %1, al
%endmacro

; args <What to clear bit on>, <what bit>, <turn on or off>, <identifier for branch>
%macro Set_Bit_Byte	4
	cmp		BYTE %3, 0
	jz		.Set_Bit_Turn_Off_%4
	
	Turn_On_Bit	%1, %2
	
	jmp		.Set_Bit_Done_%4
	
.Set_Bit_Turn_Off_%4:
	Clear_Bit %1, %2

.Set_Bit_Done_%4:
%endmacro
