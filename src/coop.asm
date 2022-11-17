%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

extern _SessionClass__Session
cextern AutoAlly_MakeAlly

; Remove game single player game mode check when checking for win/lose flags set in HouseClass::AI()
@SJMP 0x004D415D, 0x004D416A
@SJMP 0x004D41D4, 0x004D41DD

cglobal InCoopMode

[section .data]
InCoopMode	dd 0

; Crates stuff?

;004A0B5B   EB 13    JMP SHORT ra95-spa.004A0B70
;004FEEA8   E9 7E000000  JMP ra95-spa.004FEF2B
;004FF2B5   90   NOP
;004A04C8   90   NOP
;004A071F   E9 BF010000  JMP ra95-spa.004A08E3

;005272EF 90     NOP
;0052714E 90     NOP

@HACK 0x00533180, _Do_Reinforcements_Fix_Crash_When_Reinforcing_Nonexistent_Houses
	push	eax
	
	cmp dword [InCoopMode], 0
	jz .Normal_Code
	
	cmp eax, 0
	jz .Out
    
	mov eax, [eax+0x2D]
	sar eax, 18h
	call	0x004D2CB0 ; HouseClass * HouseClass::As_Pointer(HousesType) proc near
	
	cmp eax, 0 ; Check for NULL
	jz .Out
	
	test    byte [eax+0x43], 1 ; test if house is dead or spectator
    jnz .Out
	

.Normal_Code:
	pop eax
	sub esp, 34h
	mov [ebp-0x30], eax
	jmp 0x00533186
	
.Out:
	pop eax
	jmp 0x00533514
@ENDHACK

@HACK 0x004AB659, _Owner_From_Name_No_Multi_Houses_Check_In_Coop_Mode
	cmp dword [InCoopMode], 1
	jz 0x004AB661

	cmp al, 0x0c
	jl  0x004AB661
	jmp 0x004AB65D	
@ENDHACK

@HACK 0x004D4F2E,  _HouseClass__AI_No_Expert_AI_In_Coop_Mode
	cmp dword [InCoopMode], 1
	jz 0x004D4F5E

	test    eax, eax    ; Hooked by patch
	jnz 0x004D4F5E
	mov eax, [ebp-0x58]
	jmp 0x004D4F35


;004DA2AC   90   NOP
@ENDHACK

@HACK 0x004DA2A5,  _HouseClass__AI_Building_Single_Player_AI_In_Coop
	cmp dword [InCoopMode], 1
	jz 0x004DA2AE

	cmp byte [_SessionClass__Session], 0
	jnz 0x004DA2F1
	jmp 0x004DA2AE

;004DB87A   90   NOP
@ENDHACK

@HACK 0x004DB873,  _HouseClass__AI_Unit_Single_Player_AI_In_Coop
	cmp dword [InCoopMode], 1
	jz 0x004DB880

	cmp byte [_SessionClass__Session], 0
	jnz 0x004DBBEE; AI_Skirmish
	jmp 0x004DB880

;004DBD3D   EB 06    JMP SHORT ra95-spa.004DBD45
@ENDHACK

@HACK 0x004DBD35,  _HouseClass__AI_Vessel_Single_Player_AI_In_Coop
	cmp dword [InCoopMode], 1
	jz 0x004DBD45

	mov dh, byte [_SessionClass__Session]
	jmp 0x004DBD3B


;004DC18F   90   NOP
@ENDHACK

@HACK 0x004DC188,  _HouseClass__AI_Infantry_Single_Player_AI_In_Coop
	cmp dword [InCoopMode], 1
	jz 0x004DC195

	cmp byte [_SessionClass__Session], 0
	jnz 0x004DC53E ; Skirmish_AI
	jmp 0x004DC195



;0053E08A 90 NOP
@ENDHACK

@HACK 0x0053E085,  _Assign_Houses_House_Auto_Production_Bit
	mov edx, 126h
	
	cmp dword [InCoopMode], 1
	jz .Ret
	
	or  ch, 8 ; Auto production bit for house

.Ret:
	jmp 0x0053E08D

;004D4159 90     NOP

;004DBB6A B8 01000000    MOV EAX,1

;004DBA01  |. 90     NOP
;004DBA06  |. 90     NOP

;005601F8 EB 0B  JMP SHORT ra95-spa.00560205

;0055C425    ^E9 56FFFFFF    JMP ra95-spa.0055C380
@ENDHACK

@HACK 0x0055C41E, _TeamClass__AI_Single_Player_Logic1
	cmp dword [InCoopMode], 1
	jz 0x0055C380

	cmp byte [_SessionClass__Session], 0
	jmp 0x0055C425

;0055C7B6 90     NOP
@ENDHACK

@HACK 0x0055C7AF, _TeamClass__AI_Single_Player_Logic2
	cmp dword [InCoopMode], 1
	jz 0x0055C7BC

	cmp byte [_SessionClass__Session], 0
	jmp 0x0055C7B6

;004FE1CC C645 E4 00 MOV byte PTR SS:[EBP-1C],0
@ENDHACK

@HACK 0x004FE1C1,  _LogicClass__AI_Call_HouseClass_AI_For_All_Houses_In_Coop
	mov al, byte [_SessionClass__Session]
	
	cmp dword [InCoopMode], 1
	jz .Set_House_Types_Loop_Variable
	
	test    al, al
	jnz 0x004FE1CC ;
	jmp 0x004FE1CA

.Set_House_Types_Loop_Variable:
	mov byte [ebp-1Ch], 0
	jmp 0x004FE1D0

	
;004D4CAF 90     NOP
@ENDHACK

@HACK 0x004D4CAF, _HouseClass__AI_No_MPlayer_Defeated_Call_In_Coop
	cmp dword [InCoopMode], 1
	jz 0x004D4CB4

	call    0x004D8270 ; HouseClass::MPlayer_Defeated(void)
	jmp 0x004D4CB4

;005810A4 EB 28  JMP SHORT ra95-spa.005810CE
@ENDHACK

@HACK 0x0058109D,  _UnitClass__Read_INI_Use_Single_Player_Logic
	CMP dword [InCoopMode], 1
	jz  0x005810CE
	
	cmp byte [_SessionClass__Session], 0
	jz  0x005810CE
	
	jmp 0x005810A6
@ENDHACK	

@HACK 0x004D406A, _HouseClass__Use_Single_Player_Logic
	CMP dword [InCoopMode], 1
	jz  .Ret

	cmp byte [_SessionClass__Session], 0
	jnz 0x004D407D
	
.Ret:
	jmp 0x004D4073 

;0056826E 90     NOP
@ENDHACK

@HACK 0x00568267,  _TechnoClass__Is_Allowed_To_Retaliate_Single_Player_Logic
	CMP dword [InCoopMode], 1
	jz  .Ret

	cmp byte [_SessionClass__Session], 0
	jnz 0x005682B6

.Ret:
	jmp 0x00568270

;00562F4C 90     NOP
;0056316E 90     NOP
;005631AF EB 1A  JMP SHORT ra95-spa.005631CB

;0053DDEB 90     NOP
@ENDHACK

@HACK 0x0053DDEB,  _Read_Scenario_INI_Dont_Create_MP_Spawning_Units_In_Coop
	CMP dword [InCoopMode], 1
	jz  .Ret

	call    0x0053E204 ; Create_Units(int)
    
    call    AutoAlly_MakeAlly
	
.Ret:
	jmp 0x0053DDF0

;004D8CAE NOP CREDITS
@ENDHACK

@HACK 0x004D8CAE, _HouseClass__Init_Data_Dont_Set_Credits_In_Coop_Mode
	CMP dword [InCoopMode], 1
	jz  .Ret
	
	mov [eax+197h], ecx ; Credits

.Ret:
	jmp 0x004D8CB4

;0053DFEC NOP BUILDLEVEL
@ENDHACK

@HACK 0x0053DFDD, _Assign_Houses__Dont_Set_Tech_Level_In_Coop_Mode
	mov eax, dword [0x006016C8] ; ds:int BuildLevel
	
	CMP dword [InCoopMode], 1
	jz  0x0053DFEF
	
	jmp 0x0053DFE2

;0053E0D0   90   NOP IQLEEL
@ENDHACK

@HACK 0x0053E0CB, _Assign_Houses__Dont_Set_IQ_Level_In_Coop_Mode
	mov eax, dword [0x00666780] ; ds:nRulesClass_IQ_MaxIQLevels
	
	CMP dword [InCoopMode], 1
	jz  0x0053E0D3
	
	jmp 0x0053E0D0

;0053E0FB NOP BUILDLEVEL AGAIN
@ENDHACK

@HACK 0x0053E0EC, _Assign_Houses__Dont_Set_Tech_Level_In_Coop_Mode2
	mov eax, dword [0x006016C8] ; ds:int BuildLevel

	CMP dword [InCoopMode], 1	
	jz 0x0053E0FE
	
	jmp 0x0053E0F1
@ENDHACK

@HACK 0x0045FF34, _BuildingClass__Repair_AI_Use_Single_Player_Logic1
	CMP dword [InCoopMode], 1	
	jz  0x00460176
	
	cmp byte [_SessionClass__Session], 0
	jz  0x00460176
	
	jmp 0x0045FF41
@ENDHACK	

@HACK 0x00460073, _BuildingClass__Repair_AI_Use_Single_Player_Logic2
	CMP dword [InCoopMode], 1	
	jz  .Ret

	cmp byte [_SessionClass__Session], 0
	jnz 0x00460089

.Ret:
	jmp 0x0046007C

@ENDHACK	

@HACK 0x0056787B, _TechnoClass__Base_Is_Attacked_Single_Player_Logic1
	CMP dword [InCoopMode], 1	
	jz  .Ret

	cmp byte [_SessionClass__Session], 0
	jnz 0x0056789D

.Ret:
	jmp 0x00567884
@ENDHACK

@HACK 0x00567BC6,  _TechnoClass__Base_Is_Attacked_Single_Player_Logic2
	CMP dword [InCoopMode], 1
	jz  0x00567B4E

	cmp byte [_SessionClass__Session], 0
	jz  0x00567B4E
	
	jmp 0x00567BD3
@ENDHACK
	
@HACK 0x00567E58,  _TechnoClass__Base_Is_Attacked_Single_Player_Logic3
	CMP dword [InCoopMode], 1
	jz  0x00567DDF

	cmp byte [_SessionClass__Session], 0
	jz  0x00567DDF
	
	jmp 0x00567E65
@ENDHACK

@HACK 0x00554980,  _TActionClass_Operator___ACTION_LOSE_Multiplayer
	cmp dword [InCoopMode], 1 ; if coop don't set PlayeWins to true
	jz 0x00554941 

	cmp bl, [edx+9]
	jz  0x00554941
.Ret:
	jmp 0x00554985
@ENDHACK

@HACK 0x00554926,  _TActionClass_Operator___ACTION_WIN_Multiplayer
	cmp dword [InCoopMode], 1 ; if coop don't set PlayerLoses to true
	jz .Ret	

	cmp bh, [edx+9]
	jnz 0x00554941

.Ret:
	jmp 0x0055492B
@ENDHACK

@HACK 0x004D85A9,  _HouseClass__AI_Player_Lose_Flag_Set_Remove_Win
	cmp dword [InCoopMode], 1 ; if coop don't set PlayerLoses to true
	jz .Ret

	mov dword [0x006680C8], 1 ; PlayerWins
	
.Ret:
	jmp 0x004D85B3
@ENDHACK

@HACK 0x004D41CA, _HouseClass__AI_Player_Win_Flag_Set_Remove_Lose
	cmp dword [InCoopMode], 1 ; if coop don't set PlayerLoses to true
	jz .Ret

	mov dword [0x006680CC], 1 ; PlayerLoses
	
.Ret:
	jmp 0x04D41D4
@ENDHACK