%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

; cache all .mix that are needed during gameplay (no more I/O)

sstring dotAud, ".AUD"

%macro CacheMixFile 1
    mov eax, %1
    xor edx, edx
    call MixFileClass_CCFileClass_Cache
%endmacro


hack 0x004F8559 ; Init_Bulk_Data(void)
    call MixFileClass_CCFileClass_Cache

    CacheMixFile 0x005EBF4E ; "SPEECH.MIX"
    
    CacheMixFile 0x005EBF43 ; "SCORES.MIX"

    jmp hackend
    
    
    
hack 0x00462AF2 ; Don't check for loose .aud files in the folder (Need to fix this, there are better ways to solve the problem)
    pushad
    call 0x00426390 ; const RawFileClass::File_Name(void)
    mov edx, dotAud
    call stristr_
    test eax, eax
    popad
    jnz 0x00462B0A

    call 0x005BD734 ; BufferIOFileClass::Is_Available(int)
    jmp hackend
