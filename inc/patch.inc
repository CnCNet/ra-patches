%include "macros/extern.inc"

; This header is used for patches
; This header will be split up as it becomes larger

struc EventInfo
    .HouseId: RESD 1
    .Frame: RESD 1
    .EventFrame: RESD 1
    .RawEvent: RESB 20
endstruc


; ### Functions ###
cextern DrawLiveStats
cextern ProductionLimitReached
cextern Speak
cextern OutgoingMessageAllowed
cextern IncomingMessageAllowed
cextern IgnoredColors
