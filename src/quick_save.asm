%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SessionClass__Session
extern Save_Game
extern Load_Game
extern Speak

%assign QUICK_SAVE_ID 999 

sstring QuickSaveName, "Quick Save"

gfunction QuickSave
    cmp byte[SessionClass__Session], 0 ; Single player
    jz .save
    cmp byte[SessionClass__Session], 5 ; Skirmish
    jz .save
    
    jmp .out

.save:
    pushad
    xor ebx, ebx ; unknown
    mov edx, QuickSaveName
    mov eax, QUICK_SAVE_ID
    call Save_Game
    
    mov eax, 0x72 ; Mission Saved
    call 0x00426158 ; void Speak(VoxType)
    popad
    
.out:
    retn

    
gfunction QuickLoad
    cmp byte[SessionClass__Session], 0 ; Single player
    jz .load
    cmp byte[SessionClass__Session], 5 ; Skirmish
    jz .load
    
    jmp .out

.load:
    pushad
    mov eax, QUICK_SAVE_ID
    call Load_Game
    
    mov eax, 0x73 ; Mission Loaded
    call 0x00426158 ; void Speak(VoxType)
    popad
    
.out:
    retn
