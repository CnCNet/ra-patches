%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

cextern Queue_Exit
cextern SessionClass__Session
extern spawner_is_active
extern HouseClass__Blowup_All
cextern HouseClass__MPlayer_Defeated
cextern InCoopMode
cextern HouseDisconnectFrames
cextern HouseAbortFrames
cextern Frame
cextern SetDestructFrame
cextern TimedDestruct

sint DestroyConnReason, 0

; Aircrafts are not exploding when a player hit the resign button because
; AircraftClass::Take_Damage will reduce the damage by 50% if the aircraft is not in layer 0
; So we double the value up and AircraftClass::Take_Damage will reduce it by 50% again
; TL;DR we are going to take 100% damage
hack 0x004D891D, 0x004D8925 ; HouseClass::Blowup_All(void)
    mov ecx, 1
    sar eax, 0x10
    
    cmp dword[esi+9], 0 ; check layer
    jz hackend
    
    imul eax, 2
    
    jmp hackend


hack 0x00506631, 0x00506638 ; save d/c reason in global var for debug log
    mov dword[DestroyConnReason], edx
    
    cmp dword[0x0065D814], 0
    jmp hackend
    
    
%if 1
hack 0x0050676A ;Auto resign on abort/connection lost - Destroy_Connection(int,int)
%define housePtr ebp-0x14
    call 0x004FAA1C

    mov eax, dword[ebp-0x18] ; save disconnectFrame for debugging
    mov edx, dword[Frame]
    
    cmp dword[DestroyConnReason], 1
    jne .noDisconnect
    
    mov dword[eax*4+HouseDisconnectFrames], edx
    jmp .end
    
.noDisconnect:
    mov dword[eax*4+HouseAbortFrames], edx
    
.end:
    cmp dword[spawner_is_active], 0
    jz hackend
    cmp dword[InCoopMode], 1
    jz hackend
    
    cmp dword[HumanPlayersLeft], 1
    jne .noWin
    
    mov dword[0x006680C8], 1 ; PlayerWins
    
.noWin:
    pushad
    push dword[ebp-0x18]
    call SetDestructFrame
    add esp, 4
    popad
    jmp 0x00506837 ; Jump to the end of the function, DO NOT turn the player into an AI player
    
    
hack 0x004A7EFE 
    mov dword[0x00665DEC], eax
    pushad
    call TimedDestruct
    popad
    jmp hackend
    
    
hack 0x004BD128 ; Drop all events that execute after the abort frame (to prevent OOS)
    and eax, 0x000000FF
    
    cmp dword[InCoopMode], 1
    jz hackend
    
    push ecx
    mov ecx, dword[esi+1]
    add ecx, ecx
    shr ecx, 0x1B
    mov ecx, dword[ecx*4+HouseAbortFrames]
    cmp ecx, 0
    jnz .abort
    
    pop ecx
    jmp hackend
    
.abort:
    cmp dword[Frame], ecx
    pop ecx
    jg 0x004BDFED ; Event_Execute_NULL
    
    jmp hackend
    
    
hack 0x0052A988 ; exit game loop on time out if 2 player game
    cmp dword[spawner_is_active], 0
    jz .out
    cmp dword[InCoopMode], 1
    jz .out

    mov dword[0x006680C8], 1 ; PlayerWins
    
.out:
    mov ecx, 1
    jmp hackend
%endif
