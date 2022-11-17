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
; rewritten to check for a file instead of a registry key
%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern __imp__GetCommandLineA
extern str_spawn_arg
extern _stristr_
extern spawner_aftermath
extern aftermathenabled
extern counterstrikeenabled

StringZ str_am_file, "SCG43EA.INI"
StringZ str_cs_file, "SCU38EA.INI"

@HACK 0x004AC024, _Is_Aftermath_Installed
_Init_Game_Should_Load_AFTRMATH_INI:
    pushad
  
    call [__imp__GetCommandLineA]
    mov edx, str_spawn_arg
    call _stristr_
    test eax,eax
    popad
    jz .Non_Spawner_Check
    
    xor eax, eax
    mov byte al, [spawner_aftermath]
    retn
    
.Non_Spawner_Check:
	cmp byte [aftermathenabled], 1
	jz .Ret_True

.Ret_False:	
	mov		eax, 0
    retn
.Ret_True:
	mov		eax, 1
	retn
@ENDHACK	

@HACK 0x004ABF88, _Is_Counterstrike_Installed
	cmp byte [counterstrikeenabled], 1
	jz .Ret_True
	mov eax, 0
    retn
.Ret_True:
	mov eax, 1
	retn
@ENDHACK