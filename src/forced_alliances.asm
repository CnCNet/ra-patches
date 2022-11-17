%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern forcedalliances

@HACK 0x004BD167, EventClass__Execute_Ally_Forced_Alliances
     mov eax, 0x0065D994
     
     cmp byte [forcedalliances], 1
     jz 0x004BDFED ; jump to EVENT_EXECUTE_NULL
     
     jmp 0x004BD16C
@ENDHACK