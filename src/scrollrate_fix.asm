%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern _imp__timeGetTime
cextern ScrollRate

gbool LowCpuUsageScroll, false
gbool ScrollFix, false

sint LastScrollTick, 0

hack 0x0054709C ; don't call the scroll function too often
    xor edx, edx
    mov dword[ebp-0x1C], edx
    cmp byte[ScrollFix], 1
    jnz hackend
    
    pushad
    call [_imp__timeGetTime]
    cmp dword[LastScrollTick], 0
    jz .scroll
    mov edx, eax
    sub edx, dword[LastScrollTick]
    
    cmp byte[LowCpuUsageScroll], 1
    jz .lowCpuScroll
    
    cmp edx, 5
    jbe .noScroll
    jmp .scroll
    
.lowCpuScroll:
    cmp edx, 50
    jbe .noScroll
   
.scroll:
    mov dword[LastScrollTick], eax
    popad
    jmp hackend

.noScroll:
    popad
    jmp 0x00547449

    
 
hack 0x005472BB, 0x005472C2 ; increase scroll distance
    mov eax, dword[esi*4+0x00604CA0]

    cmp byte[ScrollFix], 1
    jnz hackend
    cmp byte[LowCpuUsageScroll], 1
    jnz hackend
    
    add eax, 8
    imul eax, 3
    cmp eax, 500
    jbe hackend
    mov eax, 500
    
    jmp hackend

    