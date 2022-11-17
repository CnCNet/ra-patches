%include "macros/patch.inc"
%include "macros/datatypes.inc"

extern spawner_is_active
cextern HideMouse

hack 0x0050E4E2 ;do not hide the cursor -> Net_Reconnect_Dialog
    cmp dword[spawner_is_active], 1
    jz 0x0050E4E7
    call HideMouse
    jmp 0x0050E4E7

    
hack 0x0053A2A5 ;do not hide the cursor -> Start_Scenario
    cmp dword[spawner_is_active], 1
    jz 0x0053A2AA
    call HideMouse
    jmp 0x0053A2AA
