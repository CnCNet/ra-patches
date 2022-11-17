%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

%define	EXT_Resigned				0x17BC

cextern Queue_Exit

gbool ForceExit, 0

sbool ForceExitExecuted, 0


hack 0x004A7CA3
    cmp byte[ForceExit], 1
    jnz .out
    
    cmp byte[ForceExitExecuted], 1
    jz .out
    
    mov byte[ForceExitExecuted], 1
    
    pushad
    mov eax, dword[HouseClass__PlayerPtr]
    mov dword[eax+EXT_Resigned], 1
    
    call Queue_Exit
    popad
    
.out:
    mov eax, dword[0x006680C4]
    jmp hackend
