%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

;In offline games speed gets multiplied with game/AI difficulty on top of the normal game speed (which you get set in the options menu). Patch this logic out so it always uses the normal speed.

@HACK 0x004A7DE3, _Main_Loop_Modify_Game_Speed_Based_On_Difficulty
    mov byte bh, 1
    test bh, bh
    jmp 0x004A7DE8
@ENDHACK