%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"


cextern Read_Scenario_INI_ex

hack 0x0053D7BE ; Read_Scenario_INI
	call    0x004F3ACC ; const INIClass::Get_Bool(char *,char *,int)
    
	pushad
	
    lea eax, [ebp-0x8C] ; Scenario INI file
    push eax
    call Read_Scenario_INI_ex
    add esp, 4

	popad
    
	jmp hackend
