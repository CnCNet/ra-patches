%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern mousewheelscrolling
extern _HouseClass_PlayerPtr
extern _MouseClass_Map

[section .data]
Scrolling db 0
ProcessingSidebar dd 0

;@LJMP 0x0054E3BB,    _SidebarClass_StripClass__AI_Scroll_Check
@HACK 0x005B38DD, _Mouse_Wheel_Sidebar_Scrolling
	cmp byte [mousewheelscrolling], 1
	jnz .out
	mov esi, [ebp+0Ch]
	cmp esi, 20Ah               ;WM_MOUSEHWHEEL
	jnz .out
	mov ecx, [_HouseClass_PlayerPtr]
	test ecx, ecx
	jz .out
	mov cl, byte [Scrolling]
	test cl, cl
	jnz .out
	
	
;	mov ebx, 2
;	mov eax, [0x00665EB0]
;	call 0x005BBF30 ;   WinTimerClass::Get_System_Tick_Count(void)
;	cdq
;	idiv ebx
;	cmp dword edx, 0
;	jnz .out
	
	mov byte [Scrolling], 1
	mov edx, [ebp+10h]
	shr edx, 10h
	test dx, dx
	jl .scroll
	mov ebx, 0FFFFFFFFh
	mov edx, 1
	mov eax, _MouseClass_Map
	call 0x0054D684      ;//SidebarClass::Scroll
	jmp .done
 
;-----------------------------------------------
.scroll:
	mov ebx, 0FFFFFFFFh
	xor edx, edx
	mov eax, _MouseClass_Map
	call 0x0054D684      ;//SidebarClass::Scroll

.done:
	mov byte [Scrolling], 0
 
.out:
	cmp esi, 1Ch
	jb 0x5B38EE
	jmp 0x5B38E2
@ENDHACK