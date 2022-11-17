;
; Copyright (c) 2013 Toni Spets <toni.spets@iki.fi>
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

; Internet button in the main menu goes to cncnet.org instead of WOL

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%define SessionClass_Session    0x0067F2B4
%define ShellExecuteA           0x005E653C
%define ShowWindow              0x005E6884
%define pHWnd                   0x006B1498
%define SW_MINIMIZE             6

StringZ str_cncnet_org, "http://cncnet.org/"
StringZ str_dot, "."

@HACK 0x004F4D7E _Internet_Action
    cmp byte [enablewol], 1
    jz .Normal_Code

    push SW_MINIMIZE
    mov eax, [pHWnd]
    push eax
    call dword [ShowWindow]

    push 5
    push str_dot
    push 0
    push str_cncnet_org
    push 0
    push 0
    call dword [ShellExecuteA]

    mov byte [SessionClass_Session], 0
    jmp 0x004F467B

.Normal_Code:
    mov eax, [0x0069172C]
    jmp 0x004F4D83
@ENDHACK  
