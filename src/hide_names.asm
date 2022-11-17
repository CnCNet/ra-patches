%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

cextern QuickMatch

sstring PlayerName, "Player"

hack 0x00532788, 0x0053278E ; don't draw names in QuickMatch games
    cmp byte[QuickMatch], 1
    jnz .out

    mov eax, PlayerName
    jmp hackend
    
.out:
    lea eax, [ebx+0x1790]
    jmp hackend

    
hack 0x004A6BE4 ; disable F1 chat hotkey in QuickMatch games
    cmp byte[QuickMatch], 1
    jnz .out
    
    cmp word[eax], 0x70 ; F1
    jz 0x004A6F79
    
.out:
    mov eax, dword[0x0067F31D]
    jmp hackend

    
hack 0x0050E2F1 ; remove player name on recon dialog in QuickMatch games
    call 0x004FAAD8 ; IPXManagerClass::Connection_Name(int)
    
    cmp byte[QuickMatch], 1
    jnz hackend
    
    mov eax, PlayerName
    
    jmp hackend
