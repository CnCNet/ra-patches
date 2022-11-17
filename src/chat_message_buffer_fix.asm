%include "macros/patch.inc"
%include "macros/datatypes.inc"


hack 0x004FA482 ; prevent buffer overflow when faulty text message packets don't contain the terminating null byte
    mov eax, 1
    mov byte[0x00680188], 0 ; nickname
    mov byte[0x00680200], 0 ; text message
    jmp hackend
