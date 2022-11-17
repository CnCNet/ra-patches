%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@HACK 0x00534D59, _Load_MessageDelay
	mov ax, 100h ; 200h = 200% -> ~30 secs
;	mov ax, [eax]
	mov [edx], ax
	jmp 0x00534D5F
@ENDHACK