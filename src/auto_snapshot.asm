%include "macros/patch.inc"
%include "macros/datatypes.inc"

extern spawner_is_active
extern Create_Map_Snapshot

hack 0x0052BBB0 ;out of sync
    cmp dword[spawner_is_active], 0
    jz .out
    pushad
    call Create_Map_Snapshot
    popad
    
.out:
    mov edx, 0x10B
    jmp 0x0052BBB5

    
hack 0x0050668C ; connection to player X lost
    cmp dword[spawner_is_active], 0
    jz .out
    pushad
    call Create_Map_Snapshot
    popad
    
.out:
    mov edx, 0x0E5
    jmp 0x00506691
