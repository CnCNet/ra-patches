%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; 0x00463efd
; Crashing when a flamethrower infantry dies
; Only happens with the following mod inside a map:
; [Flamer]
; Warhead=Super


@SET 0x004A35EE, { mov al, 0x0C } ; Combat_Anim(int,WarheadType,LandType)
