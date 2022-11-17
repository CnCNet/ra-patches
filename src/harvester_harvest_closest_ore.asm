%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"

cextern harvestergemmapfix

@HACK 0x0057E3E6, _UnitClass__Mission_Harvest_Set_Target_Ore_Patch_To_NULL
	cmp dword [harvestergemmapfix], 0
	jz .out

	pushad
	mov eax, ecx
	xor edx, edx
	call 0x00580B94 ; UnitClass::Assign_Destination(long)
	popad
	
.out:
	mov edx, eax
	mov eax, ecx
	mov [ecx+141h], bh
	jmp 0x0057E3F0
@ENDHACK
	
@HACK 0x0057E5DD, _UnitClass__Mission_Harvest_Set_Target_Ore_Patch_To_NULL2
	cmp dword [harvestergemmapfix], 0
	jz .out
	
	pushad
	mov eax, ecx
	xor edx, edx
	call 0x00580B94 ; UnitClass::Assign_Destination(long)
	popad
	
.out:
	sar eax, 8
	mov edx, eax
	mov eax, ecx
	jmp 0x0057E5E4
@ENDHACK
