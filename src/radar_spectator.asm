%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

extern deadplayersradar

sbyte RadarActivated, 0

hack 0x004D5193, 0x004D519C ; don't remove gps 
    cmp esi, dword[HouseClass__PlayerPtr]
    jnz .out
    cmp byte[deadplayersradar], 0
    jz .out
    test byte [esi+0x43], 1 ; is dead
    jz .out
    
    jmp 0x004D51B3

.out:
    test byte[esi+0x13B], 0x01
    jne 0x004D51B3
    jmp hackend


hack 0x004D4145, 0x004D414B ; radar init
    cmp eax, dword[HouseClass__PlayerPtr]
    jnz .out
    cmp byte[deadplayersradar], 0
    jz .out
    cmp byte[RadarActivated], 1
    jz .out
    test byte [eax+0x43], 1 ; is dead
    jz .out

    mov byte[RadarActivated], 1
    
    pushad
    mov eax, 0x00668250 ; MouseClass Map
    call 0x00532974 ;RadarClass::Is_Radar_Active(void)
    cmp al, 1
    jz .active
    
    mov edx, 1
    mov eax, 0x00668250 ; MouseClass Map
    call 0x0052D790 ; RadarClass::Radar_Activate(int)
    
.active:
    mov eax, dword[HouseClass__PlayerPtr]
    or byte [eax+0x44], 0x08
    popad
    
.out:
    test byte[eax+0x42], 0x20
    jne 0x004D4156
    jmp hackend
