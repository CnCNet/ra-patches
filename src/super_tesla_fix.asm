%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

gbool SuperTeslaFix, true


hack 0x004A343F, 0x004A344C ; Fix for infantry on top of buildings glitch, take full damage instead of lower splash damage
    cmp byte[SuperTeslaFix], 1
    jnz .out
    
    cmp byte[edi], RTTI_BUILDING
    jnz .NoTesla
    
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__TESLA_COIL
    jnz .NoTesla
    
    add edx, 4 ; call ObjectClass::Target_Coord instead of Center_Coord for tesla coil since the tesla shp goes over 2 cells in height while it actually only sits on 1
    
.NoTesla:
    call dword[edx+0x0C] ; ObjectClass::Center_Coord
    mov edx, eax
    mov eax, dword[ebp-0x24]
    call 0x004AC41C ; Distance(ulong,ulong)
    
    cmp eax, 110 
    jge hackend ; distance is bigger than 110, building is not on the same cell as bullet target cell -> do not apply full damage
    cmp byte[edi], RTTI_BUILDING
    jnz hackend ; no building -> no fix
    
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__TESLA_COIL
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__PILLBOX
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__CAMO_PILLBOX
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__TURRET
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__AA_GUN
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__FLAME_TURRET
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__SILO
    jz .ApplyFix
    cmp dword[edi+BUILDING_CLASS__BUILDING_TYPE], BUILDING_TYPE__KENNEL
    jz .ApplyFix
    
    jmp hackend

.ApplyFix:
    mov eax, 0 ; fix distance by setting it to 0 to get full damage
    jmp hackend

.out:
    call dword[edx+0x0C] ; ObjectClass::Center_Coord
    mov edx, eax
    mov eax, dword[ebp-0x24]
    call 0x004AC41C ; Distance(ulong,ulong)
    jmp hackend
