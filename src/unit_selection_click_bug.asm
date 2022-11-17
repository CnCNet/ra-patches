%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

; sometimes when you select units and release the left mouse button it will trigger the Mouse_Left_Release function twice, it causes a bug where the units start moving after the selection

[section .data]
LMouseDown db 1

@HACK 0x005B83B6, LMouseDownEvent
    mov byte[LMouseDown], 1
    mov edx, 1
    jmp 0x005B83BB
@ENDHACK

@HACK 0x004B3D6A, LMouseReleaseUnitSelection
    mov byte[LMouseDown], 0
    mov edx, ebx
    shl edx, 8
    jmp 0x004B3D6F
@ENDHACK

@REPLACE 0x004B3E1C, 0x004B3E26, LMouseReleaseNoUnitSelection
    cmp byte[LMouseDown], 1
    jnz 0x004B45FD
    cmp byte[ebp+0x0C], 8
    jne 0x004B3E93
    jmp 0x004B3E26
@ENDREPLACE
