%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern buildoffally

; Allows you to build building close to allied buildings

; args <HouseType to check whose alliances will be checked>, <HouseType to check for>
%macro Is_Ally 2
	mov eax, %1
	call 0x004D2CB0 ; HouseClass::As_Pointer()
	mov edx, %2
	call 0x004D5FC8 ; HouseClass::Is_Ally(HousesType)
%endmacro

@HACK 0x004AF821, _Build_Off_Ally_Buildings
    cmp byte [buildoffally], 0
    jz .Normal_Code
    
	pushad
	xor ecx, ecx
	mov byte cl, [eax+25h]
	xor ebx, ebx
	mov byte bl, [ebp-14h]
	Is_Ally ecx, ebx
	cmp eax, 1
	jnz .Not_Ally
	
	popad
	jmp 0x004AF826
	
.Not_Ally:
	popad
	jmp 0x004AF82E
    
.Normal_Code:
    cmp dl, [eax+25h]
    jnz 0x004AF82E
    jmp 0x004AF826
@ENDHACK

@HACK 0x004AF9D3, _Build_Off_Ally_Buildings2
    cmp byte [buildoffally], 0
    jz .Normal_Code

	pushad
	xor ecx, ecx
	mov byte cl, [eax+25h]
	xor ebx, ebx
	mov byte bl, [ebp-14h]
	Is_Ally  ecx, ebx
	cmp eax, 1
	jnz .Not_Ally
	
	popad
	jmp 0x004AF9D8
	
.Not_Ally:
	popad
	jmp 0x004AFA12
    
.Normal_Code:
    cmp bh, [eax+25h]
    jnz 0x004AFA12
    jmp 0x004AF9D8
@ENDHACK

@HACK 0x004AFAF5, _Build_Off_Ally_Buildings3
    cmp byte [buildoffally], 0
    jz .Normal_Code
    
	pushad
	xor ecx, ecx
	mov byte cl, [eax+25h]
	xor ebx, ebx
	mov byte bl, [ebp-14h]
	Is_Ally  ecx, ebx
	cmp eax, 1
	jnz .Not_Ally
	
	popad
	jmp 0x004AFAFD
	
.Not_Ally:
	popad
	jmp 0x004AFAAD
    
.Normal_Code:
    mov al, [eax+25h]
    cmp byte al, [ebp-0x14]
    jnz 0x004AFAAD
    jmp 0x004AFAFD
@ENDHACK	

@HACK 0x004AFB82, _Build_Off_Ally_Buildings4
    cmp byte [buildoffally], 0
    jz .Normal_Code_
    
	pushad
	xor ecx, ecx
	mov byte cl, [eax+25h]
	xor ebx, ebx
	mov byte bl, [ebp-14h]
	Is_Ally ecx, ebx
	cmp eax, 1
	jnz .Not_Ally
	
	popad
	jmp 0x004AFB87
	
.Not_Ally:
	popad
	jmp 0x004AFB98
    
.Normal_Code_:
    nop
    nop
    nop
    nop
    cmp dl, [eax+25h]
    jnz 0x004AFB98
    jmp 0x004AFB87
@ENDHACK	

@HACK 0x004AFC3E, _Build_Off_Ally_Buildings5
    cmp BYTE [buildoffally], 0
    jz .Normal_Code
    
	pushad
	xor ecx, ecx
	mov BYTE cl, [eax+25h]
	xor ebx, ebx
	mov BYTE bl, [ebp-14h]
	Is_Ally ecx, ebx
	cmp eax, 1
	jnz .Not_Ally
	
	popad
	jmp 0x004AFC43
	
.Not_Ally:
	popad
	jmp 0x004AFBCF

.Normal_Code:
    cmp ch, [eax+25h]
    jnz 0x004AFBCF
    jmp 0x004AFC43
@ENDHACK