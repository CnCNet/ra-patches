%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"

extern shortgame
cextern InCoopMode
cextern QuickMatch


@HACK 0x004D4C79, _HouseClass__AI_Is_House_Multiplayer_Defeated_Check
    cmp dword[InCoopMode], 1
    jz .coop
    
    cmp byte [shortgame], 1
    jz .Short_Game
    
.coop:
    cmp dword [eax+13Bh], 0 ; Does player still have buildings left?
    jmp 0x004D4C80
	
.Short_Game:
    cmp dword [eax+13Bh], 0 ; Does player still have buildings left?
    jnz 0x004D4CB4
    cmp dword [eax+0x482], 0 ; Does player still have an MCV left?
    jnz 0x004D4CB4
    call 0x004D8814 ; HouseClass::Blowup_All(void)
    mov eax, [ebp-0x58] ; move HouseClass this pointer into eax again
    call 0x004D8270 ; HouseClass::MPlayer_Defeated(void)
    jmp 0x004D4CB4
@ENDHACK


; QuickMatch version of ShortGame - Automatically lose when you only have naval units left
hack 0x004D4C9D, 0x004D4CA6
    cmp byte[QuickMatch], 1
    jz hackend

    cmp dword[eax+0x16B], 0 ; Does player still have naval units left?
    jne 0x004D4CB4
    jmp hackend
    
hack 0x004D4C82, 0x004D4C8B
    cmp byte[QuickMatch], 1
    jz hackend

    cmp dword[eax+0x15F], 0 ; Does player still have aircrafts left?
    jne 0x004D4CB4
    jmp hackend
