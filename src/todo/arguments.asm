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

; Original -LAN code was in CCHyper's 3.04, love you <3

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%define AntsEnabled 		0x00665DDC
%define recording_mode		0x00680151

[section .data]
arg_attract: db "-ATTRACT",0
arg_lan: db "-LAN",0
arg_internet: db "-INTERNET",0
arg_skirmish: db "-SKIRMISH",0
arg_newmissions: db "-NEWMISSIONS",0
arg_antmissions: db "-ANTMISSIONS",0
arg_record: db "-RECORD",0
arg_playback: db "-PLAYBACK",0

[section .data]
antmissionsenabled db 0
newmissionsenabled db 0

@HACK 0x005025CC _Select_Game_AntMissions_Check
	
	cmp  byte [antmissionsenabled], 1
	jne .Jump_Back

	mov byte [antmissionsenabled], 0
	mov byte [AntsEnabled], 1
	mov dword [ebp-30h], 2
	xor edi, edi

.Jump_Back:
	test edi, edi
	jnz 0x0050210E
	jmp 0x005025D4
@ENDHACK

@HACK 0x004F5B38 _arguments
.lan:
    mov EDX, arg_lan
    mov eax,esi
    call stristr_
    test eax,eax
    je .skirmish
    mov byte [0x0067F2B4], 3
    jmp .ret
	
.skirmish:
    mov EDX, arg_skirmish
    mov eax,esi
    call stristr_
    test eax,eax
    je .antmissions
    mov byte [0x0067F2B4], 5
    jmp .ret
	
.antmissions:
    mov EDX, arg_antmissions
    mov eax,esi
    call stristr_
    test eax,eax
    je .newmissions
    mov byte [antmissionsenabled], 1
    jmp .ret 
	
.newmissions:
    mov EDX, arg_newmissions
    mov eax,esi
    call stristr_
    test eax,eax
    je .internet
    mov byte [newmissionsenabled], 1
    jmp .ret 

.internet:
    mov EDX, arg_internet
    mov eax,esi
    call stristr_
    test eax,eax
    je .record
    mov byte [0x0067F2B4], 4
	
.record:
    mov EDX, arg_record
    mov eax,esi
    call stristr_
    test eax,eax
    je .playback
	or byte [recording_mode], 5
	
.playback:
    mov EDX, arg_playback
    mov eax,esi
    call stristr_
    test eax,eax
    je .ret
	or byte [recording_mode], 6

.ret:
	mov EDX, arg_attract
    jmp 0x004F5B3D
@ENDHACK