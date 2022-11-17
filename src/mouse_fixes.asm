%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern _ScreenWidth
extern _ScreenHeight

@HACK 0x005D8F79, _ASM_Set_Mouse_Cursor_Mouse_Coords_Check
	cmp dword eax, [_ScreenWidth]
	jg .Exit
	cmp dword ebx, [_ScreenHeight]
	jg .Exit
	mov [ebp-4h], eax ; y
	mov [ebp-8h], ebx ; x
	jmp 0x005D8F7F
	
.Exit:
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	leave
	retn
@ENDHACK
