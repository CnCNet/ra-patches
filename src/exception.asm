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
%include "macros/datatypes.inc"

struc MINIDUMP_EXCEPTION_INFORMATION
    .ThreadId           RESD 1
    .ExceptionPointers  RESD 1
    .ClientPointers     RESD 1
endstruc

struc EXCEPTION_POINTERS
    .ExceptionRecord    RESD 1
    .ContextRecord      RESD 1
endstruc

extern __imp__LoadLibraryA
extern __imp__FreeLibrary
extern __imp__GetProcAddress
extern __imp__GetCurrentProcess
extern __imp__GetCurrentProcessId
extern __imp__GetCurrentThreadId
extern __imp__CreateFileA 
extern _WinMain 
extern __imp__MessageBoxA 
extern __imp__ExitProcess		
extern __imp__GetExitCodeProcess
extern __exit    
extern generatememorydump
cextern sprintf

%define GENERIC_WRITE           0x40000000 
%define CREATE_ALWAYS           2
%define FILE_ATTRIBUTE_NORMAL   128

StringZ str_exception_title, "Command & Conquer: Red Alert just crashed!"
StringZ str_exception_message2, "A crash dump file with the name 'ra95crash-*.dmp' has been saved. In addition a memory dump with the name 'ra95crash_memory.dmp' has been created."
StringZ str_dbghelp_dll, "dbghelp.dll"
StringZ str_MiniDumpWriteDump, "MiniDumpWriteDump"
StringZ str_memory_dump_name, "ra95crash_memory.dmp"

sstring str_dump_name_format, "ra95crash-0x%08x.dmp"
sstring str_dump_name, "", 64
sstring str_exception_message_format, "Red Alert crashed at address 0x%08x. Ask in the CnCNet forums for more information."
sstring str_exception_message, "", 256

[section .data]
dbghelp_dll                 dd 0
hFile                       dd 0
hProcess                    dd 0
ProcessId                   dd 0
ThreadId                    dd 0
MiniDumpWriteDump           dd 0
ExitCode					dd 0
ExceptionAddress            dd 0

CommandLineArg				dd 0 ; Fuck it just copy it, too many stack corruption issues
LogOnlyOnce                 db 0

exception_info:
    istruc MINIDUMP_EXCEPTION_INFORMATION
        at MINIDUMP_EXCEPTION_INFORMATION.ThreadId,           dd 0
        at MINIDUMP_EXCEPTION_INFORMATION.ExceptionPointers,  dd 0
        at MINIDUMP_EXCEPTION_INFORMATION.ClientPointers,     dd 1
    iend

exception_pointers:
    istruc EXCEPTION_POINTERS
        at EXCEPTION_POINTERS.ExceptionRecord,  dd 0
        at EXCEPTION_POINTERS.ContextRecord,    dd 0
    iend
%ifndef WWDEBUG
@HACK 0x005DE62C, _try_WinMain
;	mov dword [CommandLineArg], [esp+4h]

;	push esi
;	push edi

 ;   INT3
    ; load minidump stuff
    pushad

    push str_dbghelp_dll
    call [__imp__LoadLibraryA]

    test eax,eax
    JZ .nodebug

    mov [dbghelp_dll], eax

    push str_MiniDumpWriteDump
    push eax
    call [__imp__GetProcAddress]

    test eax,eax
    JZ .nodebug

    mov [MiniDumpWriteDump], eax

    call [__imp__GetCurrentProcess]
    mov [hProcess], eax

	call [__imp__GetCurrentThreadId]
    mov [exception_info + MINIDUMP_EXCEPTION_INFORMATION.ThreadId], eax

    call [__imp__GetCurrentProcessId]
    mov [ProcessId], eax

    popad

    ; install exception handler


;	pushad

	mov esi, _exception_handler
	push esi
    push dword [fs:0]
    mov [fs:0], esp

;	popad

    ; continue normal program execution
;	pop edi
;	pop esi

;		pop	ebx
;	mov eax, ebx

	push 0Ah
	push eax
	push edx
	push edx             ; lpModuleName
	call 0x005E58F8 ; GetModuleHandleA(x)
	push eax
;	add esp, 8
    call _WinMain
;	sub esp, 8

    ; clean up our exception handler
    pop dword [fs:0]
    add esp, 12 + 4

    ; free minidump library if loaded
    cmp dword [dbghelp_dll], 0
    je .nodebugdll

    push dword [dbghelp_dll]
    call [__imp__FreeLibrary]

.nodebugdll:
    jmp __exit

.nodebug:
    call _WinMain
    jmp __exit
@ENDHACK
%endif

_exception_handler:
    mov ebx, dword [esp + 0x4]
    mov edx, dword[ebx+0x0C]
    mov dword[ExceptionAddress], edx
    mov edx, dword [esp + 0x0C]
    mov [exception_pointers + EXCEPTION_POINTERS.ExceptionRecord], ebx
	mov [exception_pointers + EXCEPTION_POINTERS.ExceptionRecord], ebx
    mov [exception_pointers + EXCEPTION_POINTERS.ContextRecord], edx

    mov dword [exception_info + MINIDUMP_EXCEPTION_INFORMATION.ExceptionPointers], exception_pointers
	mov dword [exception_info + MINIDUMP_EXCEPTION_INFORMATION.ClientPointers], 1

    push dword[ExceptionAddress]
    push str_dump_name_format
    push str_dump_name
    call sprintf
    add esp, 12
    
    cmp byte[LogOnlyOnce], 1
    jz .out
    mov byte[LogOnlyOnce], 1
    
    push 0
    push FILE_ATTRIBUTE_NORMAL
    push CREATE_ALWAYS
    push 0
    push 0
    push GENERIC_WRITE
    push str_dump_name
    call [__imp__CreateFileA]

    push 0                  ; CallbackParam
    push 0                  ; UserStreamParam
    push exception_info    			; ExceptionParam
    push 0                  ; DumpType, normal dump
;    push 2                  ; DumpType, normal dump with full memory dump
    push eax                ; hFile
    push dword [ProcessId]
    push dword [hProcess]
    call [MiniDumpWriteDump]

	cmp byte [generatememorydump], 1
	jz .Generate_Memory_Dump
    
    push dword[ExceptionAddress]
    push str_exception_message_format
    push str_exception_message
    call sprintf
    add esp, 12
    
    push 0
    push str_exception_title
    push str_exception_message
    push 0
    call [__imp__MessageBoxA]

.out:
    mov esp,[esp + 8]
    pop dword [fs:0]
    add esp, 4

	push ExitCode
    push dword [hProcess]
	call [__imp__GetExitCodeProcess]

	push dword [ExitCode]
    jmp __exit

.Generate_Memory_Dump:
	push 0
    push FILE_ATTRIBUTE_NORMAL
    push CREATE_ALWAYS
    push 0
    push 0
    push GENERIC_WRITE
    push str_memory_dump_name
    call [__imp__CreateFileA]

	push 0                  ; CallbackParam
    push 0                  ; UserStreamParam
    push exception_info    			; ExceptionParam
    push 2                  ; DumpType, normal dump with full memory dump
    push eax                ; hFile
    push dword [ProcessId]
    push dword [hProcess]
	call [MiniDumpWriteDump]

	push 0
    push str_exception_title
    push str_exception_message2 
    push 0
    call [__imp__MessageBoxA]

    mov esp,[esp + 8]
    pop dword [FS:0]
    add esp, 4

	push ExitCode
    push dword [hProcess]
	call [__imp__GetExitCodeProcess]

	push dword [ExitCode]
    jmp __exit
