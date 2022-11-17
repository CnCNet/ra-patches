%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "ra95.inc"

gbool LimitCpuUsage, false

;unfinished    
%macro sleephack 1
    hack %1
        call 0x004A765C
        
        cmp byte[LimitCpuUsage], 1
        jnz hackend
        push edx
        push ecx
        push 1
        call [_imp__Sleep]
        pop ecx
        pop edx
        jmp hackend
%endmacro

;those require timeBeginPeriod() call
sleephack 0x004A7C0E ;Sync_Delay();
sleephack 0x00529CB3 ;Wait_For_Players();

sleephack 0x004BC6BE ;Slide_Show(int,int) - Credits
sleephack 0x004BE76E ;Expansion_Dialog();
sleephack 0x004CA2DC ;RedrawOptionsMenu(void) - Options Dialog
sleephack 0x004C470E ;GameControlsClass::Process(void)
sleephack 0x004FD199 ;LoadOptionsClass::Process(void) - Load/Save/Delete Mission Dialog
sleephack 0x0050212A ;Main_Menu(ulong)
sleephack 0x00503A10 ;Select_MPlayer_Game(void)
sleephack 0x00504C7F ;WWMessageBox::Process(char *,char *,char *,char *,int)
sleephack 0x005099AC ;Net_Join_Dialog(void)
sleephack 0x0050D517 ;Net_New_Dialog(void)
sleephack 0x0050F4E9 ;Test_Null_Modem(void)
sleephack 0x0050F8CD ;Reconnect_Null_Modem(void)
sleephack 0x0050FF9E ;Select_Serial_Dialog(void)
sleephack 0x00510918 ;Advanced_Modem_Settings(SerialSettingsType *)
sleephack 0x005117A7 ;Com_Settings_Dialog(SerialSettingsType *)
sleephack 0x00513C59 ;Com_Scenario_Dialog(int) - Skirmish Dialog
sleephack 0x005199A4 ;Phone_Dialog(void)
sleephack 0x0051A696 ;Edit_Phone_Dialog(PhoneEntryClass *)
sleephack 0x0053C673 ;BGMessageBox(char *,int,int)
sleephack 0x0053C90D ;BGMessageBox(char *,int,int)
sleephack 0x005447F1 ;ScoreClass::Input_Name(char *,int,int,char *)
sleephack 0x00544840 ;ScoreClass::Input_Name(char *,int,int,char *)
sleephack 0x005507B0 ;SoundControlsClass::Process(void)
sleephack 0x00550F57 ;Special_Dialog(int)
sleephack 0x0055168A ;Fetch_Password(int,int,int)
sleephack 0x00551961 ;Fetch_Difficulty(int)
sleephack 0x0058D947 ;VisualControlsClass::Process(void)
sleephack 0x00590672 ;MPGSettings::Dialog(void)
sleephack 0x00594291 ;WOL_Chat_Dialog(WolapiObject *)
sleephack 0x0059EC16 ;Westwood Online Login
sleephack 0x005A4F99 ;WOL_GameSetupDialog::Show(void)
sleephack 0x005A9DC1 ;WOL_Options_Dialog(WolapiObject *,int)
sleephack 0x005AB1C6 ;WOL_Download_Dialog(IDownload *,RADownloadEventSink *,char *)

; Might need to sleep here too:
; 004ABD9F Shake_The_Screen
; 004BC6EA 004BC9AD Slide_Show
; 004FD47A 004FD700 LoadOptionsClass::Process(void)
; 00500FE8 00501027 Map_Selection
; 00501362 00501393 Cycle_Call_Back_Delay(int,PaletteClass &)
; 00505D62 MessageListClass::Manage
; 0050973E 0050956D 00509B8B Net_Join_Dialog
; 0050CBE1 0050D4FA 0050D847 Net_New_Dialog
; 0050EF8D ModemSignOff
; 0050F223 0050F2B1 0050F3A3 0050F42C 0050F598 0050F62F Test_Null_Modem
; 0050FAC4 0050FB0D Reconnect_Null_Modem
; 00515478 005154DE 005159C1 00515DC1 00515DF4 00515EEB 00516041 00516074 Com_Scenario_Dialog
; 005183E7 00518CE6 00518D19 00518E85 00518EB5 00519034 005193CE 005193FE 005194DF 00519512 Com_Show_Scenario_Dialog 
; 0053ADB3 Campaign_Do_Win
; 0053B3A7 Do_win
; 0053B69A Do_Lose
; 0053B7E5 Do_Restart
; 0053C6B6 BGMessageBox
; 00541F6D 00541FF9 Cycle_wait_click
; 00546426 0054645C 00546495 Call_Back_deay
; 005BD09E PaletteClass::Set
; 005D1421 005D1520 Get_Scenario_File_From_Host
; 005D1EF0 005D201A Send_Remote_File
