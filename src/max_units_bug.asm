;
; Copyright (c) 2012 Toni Spets <toni.spets@iki.fi>
;
; Permission to use, copy, modify, and distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"
%include "patch.inc"

@CLEAR 0x0054F2E8, 0x90, 0x0054F2F2 ; do not play "Building" sound (yet)

; the game does glitch/crash/oos when the unit limit was reached, we will now disallow building units before the real limit was reached
hack 0x0054F31A 
    pushad
    push ebx ; rttitype
    call ProductionLimitReached
    add esp, 4
    cmp al, 1
    jz .limitReached
    
    mov eax, 0x0D ; "Building" sound
    call Speak
    popad
    
    call 0x004BCEF8 ; EventClass::EventClass(EventClass::EventType,RTTIType,int)
    jmp hackend
    
.limitReached:
    mov eax, 0x11 ; "Unable to build more" sound
    call Speak
    popad
    jmp 0x0054F363


%if 0 ; the fix above solves the same crash, not sure if this one here is good to use (didn't test for OOS)
@HACK 0x004BEFED, _max_units_bug

    je 0x004BF21B
    cmp dword [ECX+0x2A], 0
	je .Abandon_Production
    jmp 0x004BEFF3

.Abandon_Production:
;	mov eax, ecx
;	call 0x004BF228
    mov eax, 17
    call 0x00426158 ; void Speak(VoxType)
    jmp 0x004BF21B
@ENDHACK
%endif
