%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "patch.inc"
%include "ra95.inc"

; remove cursor position check to ensure cursor thread will draw cursor every time
;@CLEAR 0x005C1A0C, 0x90, 0x005C1A12
; change mouse thread delay from 16 to 1
;@SET 0x005C17A9, { push 1 }

[section .bss]
align 8, resb 0
sbyte SurfaceCS, 0, 24
sbool Initialized, false


hack 0x005C1028, 0x005C1032 ; GraphicBufferClass::Lock(void) - start
    mov dword[ebp-4], eax
    mov dword[ebp-8], 0
    
    pushad
    
    cmp byte[Initialized], 1
    jz .doneinit
    
    mov byte[Initialized], 1
    
    push SurfaceCS
    call [_imp__InitializeCriticalSection]
    
.doneinit:
    push SurfaceCS
    call [_imp__EnterCriticalSection]

    popad
    jmp hackend


hack 0x005C1185 ; GraphicBufferClass::Lock(void) - end
    mov eax, dword[ebp-0x10]
    
    pushad
    push SurfaceCS
    call [_imp__LeaveCriticalSection]
    popad

    mov esp, ebp
    jmp hackend


hack 0x005C119F, 0x005C11A5 ; GraphicBufferClass::Unlock(void) - start
    mov dword[ebp-4], eax
    mov eax, dword[ebp-4]
    
    pushad
    
    cmp byte[Initialized], 1
    jz .doneinit
    
    mov byte[Initialized], 1
    
    push SurfaceCS
    call [_imp__InitializeCriticalSection]
    
.doneinit:
    push SurfaceCS
    call [_imp__EnterCriticalSection]

    popad
    jmp hackend


hack 0x005C1237 ; GraphicBufferClass::Unlock(void) - end
    mov eax, dword[ebp-8]

    pushad
    push SurfaceCS
    call [_imp__LeaveCriticalSection]
    popad

    mov esp, ebp
    jmp hackend

    
hack 0x005B3836 ; game exit
    call 0x005D6800
    
    cmp byte[Initialized], 1
    jnz hackend

    push SurfaceCS
    call [_imp__DeleteCriticalSection]

    jmp hackend

    
@SET 0x005C23D7, { xchg dword[eax], esi }
@SET 0x005C0A2F, { xchg dword[eax], ebx }

; _Mouse_Shadow_Buffer
hack 0x005D9048
    add eax, dword[ebp-4]
    
    xor ebx, ebx
    lock xadd dword [edi], ebx
    mov edi, ebx
    
    test edi, edi
    jz 0x005D9099
    
    jmp hackend

    
; _Draw_Mouse
hack 0x005D918B
    add eax, dword[ebp-4]
    
    xor ebx, ebx
    lock xadd dword [edi], ebx
    mov edi, ebx
    
    test edi, edi
    jz 0x005D91C7
    
    jmp hackend


; 005ab7a8, 005ab7b2, ....
; Getting called from TechnoClass::Electric_Zap(long,int,ulong,char *)
hack 0x005AB632
    add eax, dword[esi+4]
    mov edi, dword[esi]

    cmp edi, 0x00002800
    jz 0x005AB69D
    
    cmp edi, 0
    jz 0x005AB69D

    jmp hackend
