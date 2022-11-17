%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; if modified, also re-adjust patch "include ToAllies string in message" - Also adjust chat-func.c
sstring ToAllies, "To Allies:(Allies): ", 32


hack 0x00505C07, 0x00505C0D ; include ToAllies string in message
    cmp byte[ToAllies], 0
    jz .out
    
    mov dword[eax+0x158], 10 ; start length of ToAllies string that should not be sent to the other players
    jmp hackend

.out:
    mov dword[eax+0x158], ecx
    jmp hackend


hack 0x004A6BF8, 0x004A6C02 ; jump over VK_RETURN check and let VK_BACK get through
    push edx
    mov edx, dword[HouseClass__PlayerPtr]
    test byte[edx+0x43], 1 ; IsDead bit field
    pop edx
    jnz .dead

    cmp word[eax], 0x08 ; VK_BACK
    jz hackend
    
.dead:
    cmp word[eax], 0x0D
    jne 0x004A6F79
    jmp hackend

    
hack 0x004A6CEF, 0x004A6CF5 ; Check which key was pressed and enable allies chat if needed
    add eax, 0x6F
    mov dx, word[ebx]
    
    mov byte[ToAllies], 0 ; disable allies chat
    
    cmp edx, 0x0D ; VK_RETURN can now be used to send global messages too (just like F8)
    jz 0x004A6CF9
    
    cmp edx, 0x08 ; VK_BACK is used for allies chat
    jz .vk_back
    
    jmp hackend
    
.vk_back:
    mov byte[ToAllies], 'T' ; enable allies chat
    jmp 0x004A6CF9


hack 0x004A6D1C ; use our new allies chat string
    cmp byte[ToAllies], 0
    jz .out
    
    mov eax, ToAllies
    jmp hackend
    
.out:
    call ExtractString
    jmp hackend
    
    
hack 0x004A72BF ; Send to allies and skip others
    call IPXManagerClass__Connection_ID ; returns HousesType
    
    cmp byte[ToAllies], 0 ; Checking if allies chat enabled (could use a bool here too...)
    jz hackend
    
    push eax
    mov edx, eax
    mov eax, dword[HouseClass__PlayerPtr]
    call HouseClass__Is_Ally
    cmp eax, 1
    pop eax
    jnz .notAlly
    
    jmp hackend
    
.notAlly:
    inc esi
    jmp 0x004A72E7
