%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"
%include "patch.inc"

cextern Frame
cextern NetKey
cextern ExtOutOfSyncLog
cextern ScenarioClass__ScenOrRandom
cextern RandomClassLog
cextern EventLog
cextern OutOfSync

%assign RandomClassLogLength 1024
%assign EventLogLength 256

sint RandomClassLogIndex, 0
sint EventLogIndex, 0
sint LastOOSFrame, 0
sstring SyncLoss, "Loss of sync detected, trying to continue without the offending players"
sstring ComputerPlayer, "Computer"
sint MCVobject, 0


; TimeQuake is not working by default (flawed code), however, 
; it is working when the options menu is shown.
; The game is going out of sync if 1 player got the options menu open while 
; another player is using the chronosphere or someone picks up a TimeQuake crate.
; This code disables the TimeQuake completely


@CLEAR 0x004A0BD8, 0x90, 0x004A0BE2 ; CellClass::Goodie_Check(FootClass *)
@CLEAR 0x004D7553, 0x90, 0x004D7558 ; HouseClass::Place_Special_Blast(SpecialWeaponType,short)
;@CLEAR 0x0057E1A2, 0x90, 0x0057E1A7 ; UnitClass::Mission_Unload(void) - edit: this is actually used for the M.A.D. tank...

@CLEAR 0x004A5427, 0x90, 0x004A5438 ; remove code before main_loop call and insert inside main_loop with code below

hack 0x004A7C9E ; this code normally runs before the main_loop call, but westwood forgot to add it to the options menu and other places
    mov eax, dword[0x00665DF0] ; int PendingTimeQuake
    mov dword[0x00665DEC], eax ; int TimeQuake
    xor eax, eax
    mov dword[0x00665DF0], eax ; int PendingTimeQuake

    call 0x005B4808
    jmp hackend
    


; The game checks if the mcv can be deployed and changes the cursor if it can't,
; it removes mcv temporary, then calls Legal_Placement and then adds the mcv back on the map.
; If a tank is driving partial over the cell with the mcv it will drive a slightly different path
; at the time the mcv is removed. (Result: bad coords and/or bad facing values)
;@LJMP 0x0057F4B9, 0x0057F766

@CLEAR 0x0057F4C0, 0x90, 0x0057F4C6 ; do not remove mcv from map
@CLEAR 0x0057F52A, 0x90, 0x0057F530 ; do not add mcv back to map

hack 0x0057F513 ; save mcv object so we can compare and ignore it in CellClass::Cell_Object
    mov dword[MCVobject], ecx
    call 0x00569E30 ; const TechnoTypeClass::Legal_Placement(short)
    mov dword[MCVobject], 0
    jmp hackend


hack 0x0049F219 ; compare object pointer with mcv
    call 0x0049F0D8 ; const CellClass::Cell_Object(int,int)
    cmp eax, dword[MCVobject]
    jne hackend
    xor eax, eax
    jmp hackend
    


; Disconnect the players with bad crc instead of stopping the game with an Out Of Sync error

hack 0x0052BB9F ; Execute_DoList
    mov ecx, dword[edx*4+0x687860] ; get crc from the current frame
    mov byte[OutOfSync], 1
    
    cmp dword[LastOOSFrame], 0
    jz .printCRCs ; Only write it on the first oos
    
    push eax
    mov eax, dword[Frame]
    sub eax, dword[LastOOSFrame]
    cmp eax, 30 ; the oos code will trigger multiple times and all players would disconnect without this check
    pop eax
    jbe 0x0052BC63 ; jump over oos stuff and continue
    jmp .updateKey
    
.printCRCs:
    pushad ; Write the log anyways, might be useful to keep track of oos bugs later. 
    call 0x0052C2B8 ; Print_CRCs(EventClass *)
    popad
    
.updateKey:
    pushad 
    call ShowSyncLossMessage
    call ProcessPendingPackets
    popad
    mov dword[NetKey], ecx ; ecx = crc
    mov ecx, dword[Frame]
    mov dword[LastOOSFrame], ecx
    jmp 0x0052BC63 ; jump over oos stuff and continue

    
sfunction ShowSyncLossMessage
    xor edx, edx
    mov dx, word[0x006667C7] ; RulesClass.MessageDelay
    lea eax, [edx*8]
    sub eax, edx
    shl eax, 5
    add eax, edx
    shl eax, 2
    add eax, 0x80
    shr eax, 8
    push eax
    push 0x4046
    mov ecx, SyncLoss
    xor ebx, ebx
    push 3 ; PlayerColorType
    xor edx, edx
    mov eax, 0x0067F5A8 ; MessageListClass_67F5A8
    call 0x0050542C ; MessageListClass::Add_Message
    retn


sfunction ProcessPendingPackets
%define FirstTick ebp-4

    push ebp
    mov ebp, esp
    sub esp, 4
    
    call [_imp__timeGetTime]
    mov dword[FirstTick], eax
    
.start:
    call 0x004A765C ; Call_Back(void)
    
    push 20
    call [_imp__Sleep]
    
    call [_imp__timeGetTime]
    sub eax, dword[FirstTick]
    cmp eax, 4000 ; 4 seconds should be enough (works with pings up to 500 - for 600 pings I needed to set it to 6000)
    jb .start
    
    mov esp, ebp
    pop ebp
    retn

    
; improve oos logs
    
hack 0x005BC963 ; RandomClass::operator()(int,int)
    cmp eax, ScenarioClass__ScenOrRandom ; only log critical random numbers
    jnz .out

    push eax
    mov eax, dword[RandomClassLogIndex]
    
    cmp eax, RandomClassLogLength
    jb .inc
    
    xor eax, eax
    mov dword[RandomClassLogIndex], eax
    jmp .noInc
    
.inc:
    inc dword[RandomClassLogIndex]

.noInc:    
    push ecx
    mov ecx, dword[ebp+4]
    mov dword[eax*4+RandomClassLog], ecx
    pop ecx
    pop eax
    
.out:
    push ecx
    push esi
    push edi
    mov esi, eax
    jmp hackend
    
    
    
hack 0x005BC93F, 0x005BC946 ; RandomClass::operator()(void)
    cmp eax, ScenarioClass__ScenOrRandom ; only log critical random numbers
    jnz .out

    cmp dword[ebp+4], 0x005BC9AF ; skip if we are getting called from RandomClass::operator()(int,int)
    jz .out
    cmp dword[ebp+4], 0x0052C272 ; skip if we are getting called from Compute_Game_CRC(void)
    jz .out
    
    push eax
    mov eax, dword[RandomClassLogIndex]
    
    cmp eax, RandomClassLogLength
    jb .inc
    
    xor eax, eax
    mov dword[RandomClassLogIndex], eax
    jmp .noInc
    
.inc:
    inc dword[RandomClassLogIndex]

.noInc:    
    push ecx
    mov ecx, dword[ebp+4]
    mov dword[eax*4+RandomClassLog], ecx
    pop ecx
    pop eax
    
.out:
    push edx
    imul edx, dword[eax], 0x41C64E6D
    jmp hackend



hack 0x004BD0DA, 0x004BD0E0 ;EventClass::Execute(void)
;    cmp byte[esi], 22 ; Framesync
;    jz .out
;    cmp byte[esi], 24 ; Response time
;    jz .out
;    cmp byte[esi], 25 ; Frameinfo
;    jz .out
    cmp byte[esi], 29 ; Timing
    jz .out
    cmp byte[esi], 30 ; Process time
    jz .out

    pushad
    mov eax, dword[EventLogIndex]
    
    cmp eax, EventLogLength
    jb .inc
    
    xor eax, eax
    mov dword[EventLogIndex], eax
    jmp .noInc
    
.inc:
    inc dword[EventLogIndex]

.noInc:    
    imul eax, EventInfo_size

    mov ecx, dword[Frame]
    mov dword[eax + EventLog + EventInfo.Frame], ecx
    
    mov ecx, dword[esi+1]
    and ecx, 0x03FFFFFF
    mov dword[eax + EventLog + EventInfo.EventFrame], ecx

    mov ecx, dword[esi+1]
    add ecx, ecx
    shr ecx, 0x1B
    mov dword[eax + EventLog + EventInfo.HouseId], ecx

    push esi
    lea edi, [eax + EventLog + EventInfo.RawEvent]
    cld
    mov ecx, 20
    rep movsb
    pop esi

    popad
    
.out:
    mov ebx, dword[0x0065D814]
    jmp hackend
    
    
    
hack 0x0052C2E7, 0x0052C2ED ; append new data to log
    je 0x0052D2F7
    
    pushad
    push ebx
    call ExtOutOfSyncLog
    add esp, 4
    popad

    jmp hackend


hack 0x0052C381, 0x0052C387 ; Use english strings for AI player names (crc32 would not match otherwise)
    cmp eax, 1
    jz .isHuman

    mov eax, ComputerPlayer
    jmp hackend
    

.isHuman:
    lea eax, [ecx+HC_PLAYER_NAME]
    jmp hackend


