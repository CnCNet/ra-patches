%include "macros/patch.inc"
%include "macros/datatypes.inc"

extern spawner_is_active
cextern DrawConnectionLiveStats
cextern PlayerConnected
cextern CheckHouseFrames
cextern DrawReconNames

sbool Connected, false

hack 0x00529C8D, 0x00529C95 ; Wait_For_Players() - set connected bool to avoid showing the stats during the game
    cmp eax, edi ; eax = connections to be made, edi = established
    jle .connected 
    jmp hackend
  
.connected:
    mov byte[Connected], 1
    jmp 0x00529D1E ; all connections established, time to leave function


hack 0x00529C10, 0x00529C16 ; Wait_For_Players() - process receive - save sender house
    mov ecx, dword[ebp-0x4C]
    mov ebx, dword[ebp-0x48]
    cmp byte[Connected], 1
    jz hackend
    cmp ebx, 19
    ja hackend
    
    push ebx
    and ebx, 0x000000FF
    sub ebx, 12
    mov byte[ebx+PlayerConnected], 1
    pop ebx
    jmp hackend


hack 0x0050E84F ; draw connection live stats to see who of the players connected
    cmp dword[spawner_is_active], 1
    jnz .out
    cmp byte[Connected], 1
    jz .out
    
    pushad
    call DrawConnectionLiveStats
    popad

.out:
    call 0x004AE8C0
    jmp hackend

    
hack 0x0052972C, 0x00529734 ; draw names of lagging players
    pushad
    push eax
    call CheckHouseFrames
    add esp, 4
    popad
    test eax, eax
    jne 0x0052989C
    jmp hackend

    
hack 0x004ACC56
    call 0x004AE8C0
    pushad
    call DrawReconNames
    popad
    jmp hackend
