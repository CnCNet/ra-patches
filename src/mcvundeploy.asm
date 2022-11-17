%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern mcvundeploy

@HACK 0x0045A71A, BuildingClass__What_Action_MCV_Undeploy
    cmp byte [mcvundeploy], 1
    jz 0x0045A725
    test byte [0x00666831], 80h
    jnz 0x0045A725     
    jmp 0x0045A723
@ENDHACK
	
@HACK 0x0045C1CE, BuildingClass__Mission_Deconstruction_MCV_Undeploy
    cmp byte [mcvundeploy], 1
    jz .Ret
    test byte [0x00666831], 80h
    jz 0x0045C204
  
.Ret:  
    mov ebx, [edx]
    jmp 0x0045C1D9
@ENDHACK
