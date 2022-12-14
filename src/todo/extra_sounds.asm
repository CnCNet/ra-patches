%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x0058FF40 _Change_Weapon_Sounds
	call 0x00463428
	
	cmp byte [esi], 12
	jz .Modify_Grenade_Sound
	
	cmp byte [esi], 9
	jz .Modify_Rifle_Sound
		
.No_Change:
	jmp 0x0058FF45
	
.Modify_Grenade_Sound:
	cmp byte [usegrenadethrowingsound], 1
	jnz .No_Change
	
	mov word [esi+23h], 41
	jmp 0x0058FF49
	
.Modify_Rifle_Sound:
	cmp byte [alternativeriflesound], 1
	jnz .No_Change

	mov word [esi+23h], 56
	jmp 0x0058FF49
@ENDHACK