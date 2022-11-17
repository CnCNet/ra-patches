%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

StringZ str_redalert, "Red Alert"

; this function shows a message box with the title "Command & Conquer"
; fix it to show "Red Alert" instead
@HACK 0x005BE913 _Print_Sound_Error_Fix_Window_Title
    push str_redalert
    jmp 0x005BE918
@ENDHACK