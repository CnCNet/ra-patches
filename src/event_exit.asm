%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; the game will exit too quick, the sound doesn't fully play. 
; Sometimes the game goes out of sync when one player leaves, 
; could be that one player didn't receive the game exit event packet and all others did?
; TL;DR It might not wait long enough for the ack and just quits without sending it again on packet loss.

sint FirstTick, 0

hack 0x004BDAB5, 0x004BDACA
    call 0x005B7974 ; Register_Game_End_Time(void)

    call [_imp__timeGetTime]
    mov dword[FirstTick], eax
    
.start:
    call 0x004A765C ; Call_Back(void)
    
    push 20
    call [_imp__Sleep]
    
    call [_imp__timeGetTime]
    sub eax, dword[FirstTick]
    cmp eax, 4000 ; 4 seconds should be enough
    jb .start
    
.stillSpeaking:
    call 0x00426344 ; Is_Speaking(void)
    test eax, eax
    jz .out
    call 0x004A765C ; Call_Back(void)
    jmp .stillSpeaking
    
.out:
    mov dword[0x00669924], 0 ;int GameActive
    jmp hackend
