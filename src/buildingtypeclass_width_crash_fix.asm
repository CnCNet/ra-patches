%include "macros/patch.inc"
%include "macros/datatypes.inc"

; 0x00453b6f
; A building a being sold and at the same time a unit tries to attack it (building id is -1)



hack 0x00405570, 0x00405576 ; const AbstractClass::Distance(long)
    mov edx, dword[ecx+0x0CD]
    cmp edx, -1
    jz 0x004055D1
    jmp hackend


hack 0x005626F0, 0x005626F6 ; const TechnoClass::In_Range(long,int)
    mov edx, dword[eax+0x0CD]
    cmp edx, -1
    jz 0x0056278D
    jmp hackend
    

hack 0x005627D3, 0x005627D9 ; const TechnoClass::In_Range(ObjectClass *,int)
    lea eax, [ecx+0x0CD]
    cmp dword[eax], -1
    jz 0x0056286C
    jmp hackend

    
hack 0x004C16C1, 0x004C16C7 ; FootClass::Approach_Target(void)
    mov edx, dword[eax+0x0CD]
    cmp edx, -1
    jz 0x004C171E
    jmp hackend
