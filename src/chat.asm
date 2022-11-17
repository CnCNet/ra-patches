%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "patch.inc"

hack 0x004A72AD ; outgoing global chat
    pushad
    call OutgoingMessageAllowed
    cmp al, 1
    popad
    jnz 0x004A731C
    
    call 0x004FAAAC
    jmp hackend

    
hack 0x004A72F4 ; outgoing private chat
    pushad
    call OutgoingMessageAllowed
    cmp al, 1
    popad
    jnz 0x004A731C

    push 0x0067FF53
    jmp hackend

    
hack 0x004A7935, 0x004A7962 ; incoming chat
    pushad
    call IncomingMessageAllowed
    cmp al, 1
    popad
    jnz 0x004A79CE

    jmp hackend
