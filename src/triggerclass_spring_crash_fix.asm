%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; 0x0056cc6f
; Index can become a negative value if the triggerclass destructer is getting called twice in a row
; Making sure we leave if LogicTriggerID has a negative value


hack 0x004FDDC3, 0x004FDDC9 ; LogicClass::AI(void)
    mov ecx, dword[0x0067F288]
    
    test ecx, ecx
    js 0x004FDE86
    
    jmp hackend
