%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; 0x0056ABFF
; Too many terrain objects on 1 cell (e.g. trees on top of a rock) are causing a crash with zoomed-in radar enabled
; Adding missing bounds check so we don't end up with a bad pointer


hack 0x0052E9D9, 0x0052E9E1 ; RadarClass::Render_Terrain(short,int,int,int)
    cmp edi, 16
    jge 0x0052E702
    
    cmp edi, edx
    jge 0x0052E702
    jmp hackend
