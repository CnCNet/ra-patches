;
; Copyright (c) 2012 Toni Spets <toni.spets@iki.fi>
;
; Permission to use, copy, modify, and distribute this software for any
; purpose with or without fee is hereby granted, provided that the above
; copyright notice and this permission notice appear in all copies.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
;

; derived from ra95-hires
%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/extern.inc"
%include "macros/datatypes.inc"

extern _INIClass_Get_Int
extern _GraphicsViewPortClass_HidPage
extern _GraphicBufferClass_VisiblePage
extern _Buffer_Clear
extern _ScreenWidth
extern _ScreenHeight
cextern TrySetVideoMode

@LJMP 0x00552628, adjust_buffer1_height
@LJMP 0x00552637, adjust_buffer1_width
@LJMP 0x00552645, adjust_buffer2_height
@LJMP 0x00552654, adjust_buffer2_width

@LJMP 0x0054F380, kill_original_sidebar
@LJMP 0x0054D7CA, adjust_sidebar_bg_pos1
@LJMP 0x0054D7F0, adjust_sidebar_bg_pos2
@LJMP 0x0054D815, adjust_sidebar_bg_pos3

@LJMP 0x005275D8, adjust_powerbar_pos
@LJMP 0x00527735, adjust_powerbar_bg_pos1
@LJMP 0x0052775B, adjust_powerbar_bg_pos2

@LJMP 0x00553757, adjust_credits_tab_bg_pos
@LJMP 0x00553839, adjust_timer_tab_bg_pos
@LJMP 0x004ACEC5, adjust_timer_tab_caption_pos1
@LJMP 0x004ACEE4, adjust_timer_tab_caption_pos2
@LJMP 0x0054D165, adjust_repair_button_pos
@LJMP 0x0054D1D9, adjust_sell_button_pos
@LJMP 0x0054D237, adjust_map_button_pos
@LJMP 0x0054D08B, adjust_strip_pos

@LJMP 0x00527C0E, adjust_power_indicator_pos1
@LJMP 0x005278A3, adjust_power_indicator_pos2
@LJMP 0x005278AD, adjust_power_indicator_pos3
@LJMP 0x00527A4C, adjust_power_indicator_pos45

@LJMP 0x0049F600, _CellClass_Draw_It_Dont_Draw_Past_Map_Border

@LJMP 0x004ABBDF, _Shake_The_Screen_Height2
@LJMP 0x004AB8A8, _Shake_The_Screen_Height1

@LJMP 0x0053A376, _Start_Scenario_Set_Flag_To_Redraw_Screen
@LJMP 0x005523C6, _Set_Screen_Height_480_NOP
@LJMP 0x005525D7, _Set_Screen_Height_400_NOP
@LJMP 0x005525E6, _No_Black_Bars_In_640x480
@LJMP 0x00552974, _hires_ini
;@LJMP 0x004F479B, _hires_MainMenuClear 
;@LJMP 0x005B3DAA, _Load_Title_Screen_Clear_Background
@LJMP 0x005B3CD8, _hires_ScoreScreenBackground
;@LJMP 0x004F75FB, _hires_MainMenuClearPalette
@LJMP 0x0054D009, _hires_StripClass
@LJMP 0x004A9EA9, _hires_Center_VQA640_Videos

@LJMP 0x0050E7E9, _hires_Reconnect_Dialog_Fill_Rect2
@LJMP 0x0050E7F1, _hires_Reconnect_Dialog_Fill_Rect
@LJMP 0x0050E4FD, _hires_Reconnect_Dialog_Dialog_Box
@LJMP 0x0050E5D2, _hires_Reconnect_Dialog_Text_Print1
@LJMP 0x0050E554, _hires_Reconnect_Dialog_Text_Print2
@LJMP 0x0050E526, _hires_Reconnect_Dialog_Text_Print3
@LJMP 0x0050E5A0, _hires_Reconnect_Dialog_Text_Print4
@LJMP 0x0050E845, _hires_Reconnect_Dialog_Text_Print5

; These are per strip, there's a left and right strip in the sidebar
%define CAMEO_ITEMS 30
%define CAMEOS_SIZE 1560 ; memory size of all cameos in byte

global diff_height
global diff_width
cglobal SideBarPanelLeftPosX
cglobal SideBarPanelsPosY
cglobal fake480height

[section .data]
    WidthTiles dd 0x14
    videointerlacemode db 0
    AdjustedWidth dd 0

    diff_width dd 0
    diff_height dd 0
    diff_top dd 0
    diff_left dd 0

    left_strip_offset dd 0
    right_strip_offset dd 0
    scorebackground db 0    

    _hires_NewGameText_top dd 0x96
    _hires_NewGameText_left dd 0x6E

    ExtendedSelectButtons8 times 824 dd 0 

    CellSize dd 100h
    fake480height dd 0
    
    SideBarPanelLeftPosX dd 0x1F0
    SideBarPanelsPosY dd 0x0B4
    

[section .rdata]
    str_options db "Options",0
    str_width db "Width",0
    str_height db "Height",0
    str_blackbackgroundpcx db "BLACKBACKGROUND.PCX",0




@HACK 0x004FCECF, adjust_SaveLoadGameDialog
    mov ecx, 0x46
    mov esi, 0x2C
	add ecx, [diff_left]
	add esi, [diff_top]
    jmp 0x004FCED9
@ENDHACK

@HACK 0x004FCEFA, adjust_SaveLoadGameDialogList
	mov ebx, 0x66
	mov ecx, 0x5E
	add ebx, [diff_left]
	add ecx, [diff_top]
    jmp 0x004FCF04
@ENDHACK

@HACK 0x004FCF04, adjust_SaveLoadGameDialogMissionDescriptionTop
    mov eax, 0x116
	add eax, [diff_top]
    jmp 0x004FCF09
@ENDHACK

@HACK 0x004FCED9, adjust_SaveLoadGameDialogMissionDescriptionLeft
    mov edi, 0x140
	add edi, [diff_left]
    jmp 0x004FCEDE
@ENDHACK

@HACK 0x004FCF35, adjust_SaveLoadGameDialogButtonsTop
    mov ecx, 0x13C
	add ecx, [diff_top]
    jmp 0x004FCF3A
@ENDHACK

@HACK 0x004FCF30, adjust_SaveLoadGameDialogButtonsLeft1
    mov ebx, 0x0E2
	add ebx, [diff_left]
    jmp 0x004FCF35
@ENDHACK

@HACK 0x004FCF09, adjust_SaveLoadGameDialogButtonsLeft2
    mov edi, 0x14E
	add edi, [diff_left]
    jmp 0x004FCF0E
@ENDHACK

@HACK 0x005502A8, adjust_SoundControlsDialogTop
    mov ecx, 0x36
	add ecx, [diff_top]
    jmp 0x005502AD
@ENDHACK

@HACK 0x005503B9, adjust_SoundControlsDialogLeft
    mov edi, 0x1C
	add edi, [diff_left]
    jmp 0x005503BE
@ENDHACK

@HACK 0x00550303, adjust_SoundControlsDialogSongListTop
    mov ecx, 0x0A2
	add ecx, [diff_top]
    jmp 0x00550308
@ENDHACK

@HACK 0x005502E3, adjust_SoundControlsDialogSongListLeft
    mov ebx, 0x3E
	add ebx, [diff_left]
    jmp 0x005502E8
@ENDHACK

@HACK 0x00550330, adjust_SoundControlsDialogSongListOkButtonTop
    mov edx, 0x136
	add edx, [diff_top]
    push edx
    jmp 0x00550335
@ENDHACK

@HACK 0x00550340, adjust_SoundControlsDialogSongListOkButtonLeft
    mov edx, 0x1B6
	add edx, [diff_left]
    push edx
    mov edx, 0x261
    jmp 0x00550345
@ENDHACK

@HACK 0x00550355, adjust_SoundControlsDialogSongListStopButtonTop
    mov eax, 0x136
	add eax, [diff_top]
    push eax
    jmp 0x0055035A
@ENDHACK

@HACK 0x0055035F, adjust_SoundControlsDialogSongListStopButtonLeft
    mov ecx, 0x3E
	add ecx, [diff_left]
    jmp 0x00550364
@ENDHACK

@HACK 0x0055037B, adjust_SoundControlsDialogSongListPlayButtonTop
    mov eax, 0x136
	add eax, [diff_top]
    push eax
    jmp 0x00550380
@ENDHACK

@HACK 0x00550385, adjust_SoundControlsDialogSongListPlayButtonLeft
    mov ecx, 0x62
	add ecx, [diff_left]
    jmp 0x0055038A
@ENDHACK

@HACK 0x005503B4, adjust_SoundControlsDialogShuffleButtonTop
    mov edi, 0x136
	add edi, [diff_top]
    push edi
    jmp 0x005503B9
@ENDHACK

@HACK 0x005503C1, adjust_SoundControlsDialogShuffleButtonLeft
    mov ecx, 0x0DE
	add ecx, [diff_left]
	push ecx
    jmp 0x005503C6
@ENDHACK

@HACK 0x005503E6, adjust_SoundControlsDialogRepeatButtonTop
    mov ecx, 0x136
	add ecx, [diff_top]
    push ecx
    jmp 0x005503EB
@ENDHACK

@HACK 0x005503F5, adjust_SoundControlsDialogRepeatButtonLeft
    mov edx, 0x164
	add edx, [diff_left]
	push edx
    jmp 0x005503FA
@ENDHACK

@HACK 0x0055040E, adjust_SoundControlsDialogMusicVolumeSliderTop
    mov ecx, 0x6E
	add ecx, [diff_top]
    jmp 0x00550413
@ENDHACK

@HACK 0x00550413, adjust_SoundControlsDialogMusicVolumeSliderLeft
    mov ebx, 0x142
	add ebx, [diff_left]
    jmp 0x00550418
@ENDHACK

@HACK 0x00550431, adjust_SoundControlsDialogSoundVolumeSliderTop
    mov ecx, 0x86
	add ecx, [diff_top]
    jmp 0x00550436
@ENDHACK

@HACK 0x00550436, adjust_SoundControlsDialogSoundVolumeSliderLeft
    mov ebx, 0x142
	add ebx, [diff_left]
    jmp 0x0055043B
@ENDHACK

@HACK 0x00550459, adjust_SoundControlsDialogGadgetOffsetTop
    mov ebx, 0x36
	add ebx, [diff_top]
    jmp 0x0055045E
@ENDHACK

@HACK 0x00503F0C, adjust_SurrenderDialogTop
    mov edx, 0x89
	add edx, [diff_top]
    jmp 0x00503F11
@ENDHACK

@HACK 0x00503F04, adjust_SurrenderDialogLeft
    mov eax, 0x50
	add eax, [diff_left]
    jmp 0x00503F09
@ENDHACK

@HACK 0x00503E3B, adjust_SurrenderDialogOkButtonTop
    mov ecx, 0x0E1
	add ecx, [diff_top]
    push ecx
    jmp 0x00503E40
@ENDHACK

@HACK 0x00503E4A, adjust_SurrenderDialogOkButtonLeft
    mov edx, 0x0DC
	add edx, [diff_left]
	push edx
    jmp 0x00503E4F
@ENDHACK

@HACK 0x00503E65, adjust_SurrenderDialogCancelButtonTop
    mov ecx, 0x0E1
	add ecx, [diff_top]
    push ecx
    jmp 0x00503E6A
@ENDHACK

@HACK 0x00503E74, adjust_SurrenderDialogCancelButtonLeft
    mov edx, 0x14A
	add edx, [diff_left]
    push edx
    jmp 0x00503E79
@ENDHACK

@HACK 0x00503F39, adjust_SurrenderDialogCaption
    mov ebx, 0x0B1
    add ebx, [diff_top]
    push ebx
    mov ebx, 0x140
	add ebx, [diff_left]
    push ebx
    jmp 0x00503F43
@ENDHACK


@HACK 0x00547118, adjust_ScrollingWidth1
    push ecx
    mov ecx, 0x21C
	add ecx, [diff_width]
    cmp eax, ecx
    pop ecx
    jmp 0x0054711D
@ENDHACK

@HACK 0x00547127, adjust_ScrollingWidth2
    push ecx
    mov ecx, 0x280
	add ecx, [diff_width]
    cmp esi, ecx
    pop ecx
    jmp 0x0054712D
@ENDHACK

@HACK 0x0054712F, adjust_ScrollingWidth3
    mov esi, 0x280
	add esi, [diff_width]
    jmp 0x00547134
@ENDHACK

@HACK 0x0054713B, adjust_ScrollingWidth4
    push ecx
    mov ecx, 0x21C
	add ecx, [diff_width]
    cmp esi, ecx
    pop ecx
    jmp 0x00547141
@ENDHACK

@HACK 0x00547143, adjust_ScrollingLeft1
    mov edx, 0x140
	add edx, [diff_left]
    jmp 0x00547148
@ENDHACK

@HACK 0x00547176, adjust_Scrollingheight1
    push ecx
    mov ecx, 0x12c
	add ecx, [diff_height]
    cmp eax, ecx
    pop ecx
    jmp 0x0054717B
@ENDHACK

@HACK 0x00547185, adjust_Scrollingheight2
    push eax
    mov eax, 0x190
    add eax, [diff_height]
    cmp ecx, eax
    pop eax
    jmp 0x0054718B
@ENDHACK

@HACK 0x0054718D, adjust_Scrollingheight3
    mov ecx, 0x190
	add ecx, [diff_height]
    jmp 0x00547192
@ENDHACK

@HACK 0x00547192, adjust_ScrollingLeft2
    mov eax, 0x140
	add eax, [diff_left]
    jmp 0x00547197
@ENDHACK

@HACK 0x00547199, adjust_ScrollingTop
    mov edx, 0x0C8
    add edx, [diff_top]
    jmp 0x0054719E
@ENDHACK


@HACK 0x004AB8A3, adjust_ScreenShakeWidth1
    mov ecx, 0x280
    add ecx, [diff_width]
    jmp 0x004AB8A8
@ENDHACK

@HACK 0x004ABBFA, adjust_ScreenShakeWidth2
    mov eax, 0x280
    add eax, [diff_width]
    jmp 0x004ABBFF
@ENDHACK

@HACK 0x004AB8C8, adjust_ScreenShakeWidth3
    mov eax, 0x280
    add eax, [diff_width]
    push eax
    jmp 0x004AB8CD
@ENDHACK

@HACK 0x004ABC1C, adjust_ScreenShakeWidth4
    mov ecx, 0x280
    add ecx, [diff_width]
    push ecx
    jmp 0x004ABC21
@ENDHACK

@HACK 0x0053B32D, adjust_MissionAccomplishedTop
    mov ebx, 0x0B4
    add ebx, [diff_top]
    push ebx
    jmp 0x0053B332
@ENDHACK

@HACK 0x0053B335, adjust_MissionAccomplishedLeft
    mov ebx, 0x0B4
    add ebx, [diff_left]
    jmp 0x0053B33A
@ENDHACK

@HACK 0x0053AD3E, adjust_CampaignMissionAccomplishedTop
    mov edx, 0x0B4
    add edx, [diff_top]
    push edx
    jmp 0x0053AD43
@ENDHACK

@HACK 0x0053AD48, adjust_CampaignMissionAccomplishedLeft
    mov ebx, 0x0B4
    add ebx, [diff_left]
    jmp 0x0053AD4D
@ENDHACK

@HACK 0x0053B61D, adjust_DrawGameTop
    mov ebx, 0x0B4
    add ebx, [diff_top]
    jmp 0x0053B622
@ENDHACK

@HACK 0x0053B628, adjust_DrawGameLeft
    mov ebx, 0x0B4
    add ebx, [diff_left]
    jmp 0x0053B62D
@ENDHACK


hack 0x0055237B, 0x00552383 ; Video_Init(void)
    pushad
    call TrySetVideoMode
    cmp al, 1
    popad
    
    jnz 0x005523EE
    
    ; side bar strip offset left (left bar)
    mov eax, [left_strip_offset]
    mov ebx, [eax]
    add ebx, [diff_width]
    
    mov dword[_SideBarPanelLeftPosX], ebx
    mov [eax], ebx

    ; side bar strip offset left (right bar)
    mov eax, [right_strip_offset]
    mov ebx, [eax]
    add ebx, [diff_width]
    
    mov [eax], ebx
    
    jmp 0x005523E9


gfunction HiresInit
    pushad
    
    ; adjust width
    MOV EAX, [_ScreenWidth]
    SUB EAX, 160
    MOV EBX, 24
    XOR EDX,EDX
    DIV EBX

    ; width of the game area, in tiles, 1 tile = 24px
    mov [WidthTiles], eax

    XOR EDX,EDX
    MOV EBX, 24
    MUL EBX

    ADD EAX, 160
    MOV [AdjustedWidth], EAX

    ; adjusted width in EAX
    MOV EDX, [AdjustedWidth]
    MOV EBX, [_ScreenHeight]

    SUB EDX, 640
    SUB EBX, 400

    MOV [diff_width], EDX
    MOV [diff_height], EBX

    ; adjust top and left
    MOV EAX, [_ScreenHeight]
    SHR EAX, 1
    SUB EAX, 200
    MOV [diff_top], EAX

    MOV EAX, [_ScreenWidth]
    SHR EAX, 1
    SUB EAX, 320
    MOV [diff_left], EAX

    MOV EDX, [AdjustedWidth]
    MOV EBX, [_ScreenHeight]
    
    MOV EDX, [AdjustedWidth]
    MOV EBX, [_ScreenHeight]

    popad
    retn
    

[section .text]
adjust_buffer1_height:
    mov edx, 0x190
    add edx, [diff_height]
    push edx
    jmp 0x0055262D

adjust_buffer1_width:
    mov ecx, 0x280
    add ecx, [diff_width]
    push ecx
    jmp 0x0055263C

adjust_buffer2_height:
    mov edx, 0x190
    add edx, [diff_height]
    push edx
    jmp 0x0055264A

adjust_buffer2_width:
    mov ecx, 0x280
    add ecx, [diff_width]
    push ecx
    jmp 0x00552659

@LJMP 0x0054DB14, set_game_area_width
set_game_area_width:
    mov ecx, [WidthTiles]
    jmp 0x0054DB19
    
kill_original_sidebar:
    retn

adjust_sidebar_bg_pos1:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x0054D7CF

adjust_sidebar_bg_pos2:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x0054D7F5

adjust_sidebar_bg_pos3:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x0054D81A

adjust_powerbar_pos:
    mov edx, 0x1e0
    add edx, [diff_width]
    jmp 0x005275DD

adjust_powerbar_bg_pos1:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x0052773A

adjust_powerbar_bg_pos2:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x00527760

adjust_credits_tab_bg_pos:
    mov ebx, 0x1e0
    add ebx, [diff_width]
    jmp 0x0055375C

adjust_timer_tab_bg_pos:
    mov ebx, 0x140
    add ebx, [diff_width]
    jmp 0x0055383E

adjust_timer_tab_caption_pos1:
    mov ebx, 0x190
    add ebx, [diff_width]
    push ebx
    jmp 0x004ACECA

adjust_timer_tab_caption_pos2:
    mov ebx, 0x190
    add ebx, [diff_width]
    push ebx
    jmp 0x004ACEE9

adjust_repair_button_pos:
    mov esi, 0x1f2
    add esi, [diff_width]
    jmp 0x0054D16A

adjust_sell_button_pos:
    mov edx, 0x21f
    add edx, [diff_width]
    jmp 0x0054D1DE

adjust_map_button_pos:
    mov edi, 0x24c
    add edi, [diff_width]
    jmp 0x0054D23C

adjust_strip_pos:
    mov edx, 0x1f0
    add edx, [diff_width]
    jmp 0x0054D090

adjust_power_indicator_pos1:
    mov ebx, 0x1e2
    add ebx, [diff_width]
    jmp 0x00527C13

adjust_power_indicator_pos2:
    mov eax, 0x1ea
    add eax, [diff_width]
    jmp 0x005278A8

adjust_power_indicator_pos3:
    mov edx, 0x1eb
    add edx, [diff_width]
    jmp 0x005278B2

adjust_power_indicator_pos45:
    mov eax, 0x1ec
    add eax, [diff_width]
    mov edx, 0x1ed
    add edx, [diff_width]
    jmp 0x00527A56

_hires_Reconnect_Dialog_Fill_Rect:
    mov     edx, [ebp-30h]
    add        edx, [diff_top]
    push    edx
    mov     ebx, [ebp-28h]
    add        ebx, [diff_left]
    push    ebx
    jmp        0x0050E7F9

_hires_Reconnect_Dialog_Fill_Rect2:
    mov     ecx, [ebp-24h]  ; Top
    add        ecx, [diff_top]
    push    ecx
    mov     eax, [ebp-34h]  ; Left
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E7F1

_hires_Reconnect_Dialog_Text_Print5:
    add        eax, [diff_top]
    push    eax
    mov        eax, 0x140
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E84B

_hires_Reconnect_Dialog_Text_Print4:
    add        eax, [diff_top]
    push    eax
    mov        eax, 0x140
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E5A6

_hires_Reconnect_Dialog_Text_Print3:
    add        eax, [diff_top]
    push    eax
    mov        eax, 0x140
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E52C

_hires_Reconnect_Dialog_Text_Print2:
    add        eax, [diff_top]
    push    eax
    mov        eax, 0x140
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E55A

_hires_Reconnect_Dialog_Text_Print1:
    add        eax, [diff_top]
    push    eax
    mov        eax, 0x140
    add        eax, [diff_left]
    push    eax
    jmp        0x0050E5D8


_hires_Reconnect_Dialog_Dialog_Box:
    mov     edx, [0x006851A0] ; top
    add        edx, [diff_top]
    mov     eax, [0x0068519C] ; left
    add        eax, [diff_left]
    jmp        0x0050E508

_Receive_Remote_File_Gauge_Gadget:
    lea     eax, [ebp-104h]
    mov     ecx, 0xC0
    add        ecx, [diff_top]
    mov        ebx, 0xDC
    add        ebx, [diff_left]
    jmp        0x005D166B



_CellClass_Draw_It_Dont_Draw_Past_Map_Border:
    push    eax
    push    edx

    pop        edx
    pop        eax
    
    push    eax
    push    edx
    mov     ax, [eax]
    movsx   edx, ax
    mov     eax, 0x00668250 ; MouseClass Map
    call    0x004FE8AC ; MapClass::In_Radar(short)
    test    eax, eax
    jz        .Out

    pop        edx
    pop        eax
    mov     [ebp-0Ch], eax
    mov     edi, edx
    jmp        0x0049F605
    
.Out:    
    pop        edx
    pop        eax
    jmp        0x0049FC47 

_Start_Scenario_Set_Flag_To_Redraw_Screen:
    mov     ecx, 1
    lea     ebx, [CellSize]
    mov     edx, 1h
    mov     eax, 0x00668250 ; MouseClass Map
    call    0x004D2B6C ; HelpClass::Scroll_Map(DirType,int &,int)

    mov        edx, 1
    mov     eax, 0x00668250 ; MouseClass Map
    call    0x004CAFF4 ; GScreenClass::Flag_To_Redraw(int)

    mov     eax, 0x00668188 ; GameOptionsClass Options
    jmp        0x0053A37B

_hires_Center_VQA640_Videos:
    MOV EAX, [diff_top]
    push    eax
    MOV EAX, [diff_left]
    push    eax

    push    0
    push    0
    
    jmp        0x004A9EB1

_hires_ScoreScreenBackground:
    cmp        eax, 0x005F01EB
    JE        .Is_Score_Screen
    cmp        eax, 0x005F01F8
    JE        .Is_Score_Screen
    JMP        .Ret

.Is_Score_Screen:
    mov     BYTE [scorebackground], 1
    
.Ret:    
    push    ebp
    mov     ebp, esp
    push    ecx
    push    esi
    push    edi
    jmp        0x005B3CDE

%macro hires_Clear 0
    PUSH 0ch
    PUSH _GraphicsViewPortClass_HidPage
    CALL _Buffer_Clear
    ADD ESP,8
%endmacro

%macro hires_Clear_2 0
    PUSH 0
    PUSH _GraphicBufferClass_VisiblePage
    CALL _Buffer_Clear
    ADD ESP,8
%endmacro

_Load_Title_Screen_Clear_Background:
    mov     eax, 1
    
    hires_Clear
    
    jmp        0x005B3DAF

_hires_Sidebar_Cameos_Draw_Buttons:
    cmp     ebx, 1
    jge     0x0054E754
    jmp        0x0054E72F

_hires_Sidebar_Cameos_Height:
    mov     edx, 370h
    mov     ecx, 0A0h
    mov     esi, 210h
    mov     edi, 0B4h
    jmp        0x0054D09F

_hires_Sidebar_Cameos_AI: ; No idea if this does anything..
    mov     ecx, [eax+5]
    add        eax, CAMEO_ITEMS
    jmp        0x0054E4C4

_hires_DoRestartMissionClearBackground:
    push     ecx
    push    ebx
    push    edx
    push    eax
    
    mov     ebx, 0x0066995C
    mov     edx, _GraphicsViewPortClass_HidPage
    mov     eax, str_blackbackgroundpcx
    call    0x005B3CD8
    
    pop        eax
    pop        edx
    pop        ebx
    pop        ecx
    
    mov     eax, [0x00666904]
    jmp        0x0053B80B

_hires_RestateMissionClearBackground:
    push     ecx
    push    ebx
    push    edx
    push    eax

    mov     ebx, 0x0066995C
    mov     edx, _GraphicsViewPortClass_HidPage
    mov     eax, str_blackbackgroundpcx
    call    0x005B3CD8
    
    pop        eax
    pop        edx
    pop        ebx
    pop        ecx
    
    mov     ebx, 0x005F9348
    jmp        0x0053BE71

_hires_MainMenuClearBackground:
    
    hires_Clear
        
    mov ecx, eax
    push ecx
    
    pop eax
    mov ebx, 0x0066995C
    jmp 0x004F6097

_hires_Sidebar_Cameos_Init_IO6:     ; Down buttons
    add     esi, 0C2h
    add     esi, [diff_height]
    jmp        0x0054DF1B

_hires_Sidebar_Cameos_Init_IO5:     ; Down buttons
    add     ebx, 0C2h
    add     ebx, [diff_height]
    jmp        0x0054DF50

_hires_Sidebar_Cameos_Init_IO4:     ; Up buttons
    add     ebx, 0C2h
    add     ebx, [diff_height]
    jmp        0x0054DEC4

_hires_Sidebar_Cameos_Init_IO3:  ; Up buttons
    add     eax, 0C2h
    add     eax, [diff_height]
    jmp        0x0054DE90

_hires_Sidebar_Cameos_Scroll:
    add     edx, CAMEO_ITEMS
    cmp     edx, ebx
    jmp        0x0054E2B2    

_hires_Sidebar_Cameos_Deactivate2:
    cmp     ebx, CAMEOS_SIZE ; 208 / 52 = 4 items
    jmp        0x0054E1EE

_hires_Sidebar_Cameos_Deactivate:
    imul    edx, [ecx+19h], CAMEOS_SIZE
    add        edx, ExtendedSelectButtons8
    jmp        0x0054E1D9

_hires_Sidebar_Cameos_Activate3:
    cmp     ebx, CAMEOS_SIZE ; 208 / 52 = 4 items
    jmp        0x0054E178
        
_hires_Sidebar_Cameos_Activate2:
    imul    edx, [ecx+19h], CAMEOS_SIZE
    add        edx, ExtendedSelectButtons8
    jmp        0x0054E163

_hires_Sidebar_Cameos_Activate:
    imul    eax, [ecx+19h], CAMEOS_SIZE
    add        eax, ExtendedSelectButtons8
    jmp        0x0054E14E

_hires_Sidebar_Cameos_Init_IO2:
    cmp     esi, CAMEO_ITEMS ; items check
    jl      0x0054DFAE
    jmp        0x0054DFFD    

_hires_Sidebar_Cameos_Init_IO:
    imul    eax, [ecx+19h], CAMEOS_SIZE
    add        eax, ExtendedSelectButtons8
    jmp     0x0054DFBA
    
_hires_Sidebar_Cameos_Init:
    mov     edx, CAMEO_ITEMS*2 ; amount of total items to init
    mov     DWORD [0x00604D68], eax
    
    mov        eax, ExtendedSelectButtons8
    jmp     0x0054CF51
    
_hires_Sidebar_Cameos_Draw:
    add     eax, CAMEO_ITEMS; items to draw
    cmp     eax, edx
    jmp        0x0054E9C7

%macro _hires_adjust_width 1
    ;MOV ECX, [diff_width]
    ;MOV EAX, %1
    ;ADD [EAX], ECX
%endmacro

%macro _hires_adjust_height 1
    ;MOV ECX, [diff_height]
    ;MOV EAX, %1
    ;ADD [EAX], ECX
%endmacro

%macro _hires_adjust_top 1
    ;MOV ECX, [diff_top]
    ;MOV EAX, %1
    ;ADD [EAX], ECX
%endmacro

%macro _hires_adjust_left 1
    ;MOV ECX, [diff_left]
    ;MOV EAX, %1
    ;ADD [EAX], ECX
%endmacro

; handles Width and Height redalert.ini options
_hires_ini:

    PUSH EBX
    PUSH EDX
    
    .width:
    MOV ECX, 640            ; default
    MOV EDX, str_options    ; section
    MOV EBX, str_width      ; key
    LEA EAX, [EBP-0x54]     ; this
    CALL _INIClass_Get_Int
    TEST EAX,EAX
    JE .height
    MOV DWORD [_ScreenWidth], EAX

.height:
    MOV ECX, 400
    MOV EDX, str_options
    MOV EBX, str_height
    LEA EAX, [EBP-0x54]
    CALL _INIClass_Get_Int
    TEST EAX,EAX
    JE .cleanup
    MOV DWORD [_ScreenHeight], EAX

.cleanup:

    call HiresInit

.Ret:    
    POP EDX
    POP EBX

    JMP 0x00552979
    
_Fill_Rect_test:

    mov al, 0
    push    eax
    mov     cx, 0     ; [ebp-0ACh]           ; top
    push    cx                     ; __int16
    mov     ax, 0     ; [ebp-0B0h]           ; left
    push    ax                     ; __int16
    mov     dx, 1000  ; [ebp-0B4h]
    push    dx                     ; __int16
    mov     bx, 1500  ; [ebp-0B8h]
    push    bx                     ; __int16
    mov    ebx, [0x006AC274] ; GraphicViewPortClass LogicPage
    push    ebx
    jmp    0x00507B65

_hires_Power_Usage_Indicator_Height:
    cmp        ecx, 0x186
    jge        .No_Draw
    jmp        .Ret
    
.No_Draw:
    jmp        0x00527C23
    
    
.Ret:    
    mov     eax, [0x006877B8]
    call    0x004A96E8
    jmp        0x00527C23

_hires_StripClass:
    MOV DWORD [EBX+0x104F], 0x1F0 ; left strip offset left
    MOV DWORD [EBX+0x1053], 0x0B4 ; left strip offset top
    MOV DWORD [EBX+0x132F], 0x0B4 ; right strip offset top
    MOV DWORD [EBX+0x132B], 0x236 ; right strip offset left

    LEA EAX, [EBX+0x104F]
    MOV [left_strip_offset], EAX
    LEA EAX, [EBX+0x132B]
    MOV [right_strip_offset], EAX

    MOV EAX,EBX
    JMP 0x0054D033

    MOV EBX, [diff_top]
    MOV EAX, [diff_left]
    CMP    BYTE [scorebackground], 1
    je .Display_Top_Left
    
    CMP EDX, 190h
    je .Jump_Background_Skip

.Display_Top_Left:
    MOV EBX, 0
    MOV EAX, 0
    
.Jump_Background_Skip:
    MOV BYTE [scorebackground], 0
    PUSH EBX    
    PUSH EAX
    PUSH 0
    PUSH 0
    JMP 0x005B3DC7
    
.No_Change:
    push    0
    push    0
    push    0
    push    0
    jmp        0x005B3DC7

_hires_MainMenuClear:
    hires_Clear
    mov eax,1
    jmp 0x004F47A0

_hires_MainMenuClearPalette:
    hires_Clear
    mov eax,[0x006807E8]
    jmp 0x004F7600

_Blacken_Screen_Border_Menu:
    call 0x005C9E60
    mov eax, 1

    jmp 0x00502243
    
_Blacken_Screen_Border_Menu2:
    hires_Clear_2
    mov eax, 1

    jmp 0x00502293

_Shake_The_Screen_Height2:
    mov        eax, [_ScreenHeight]
    sub        eax, 2
    jmp        0x004ABBE4

_Shake_The_Screen_Height1:
    mov        eax, [_ScreenHeight]
    sub        eax, 2
    jmp        0x004AB8AD
    
_Set_Screen_Height_400_NOP:
    cmp        DWORD [fake480height], 1
    je        .No_Change
    
    jmp        0x00552628
    
.No_Change:
    mov        DWORD [_ScreenHeight], 190h
    jmp        0x005525ED
    
_No_Black_Bars_In_640x480:
    cmp        DWORD [fake480height], 1
    je        .No_Change
    jmp        0x00552628
    
.No_Change:
    jmp        0x005525ED
    
_Set_Screen_Height_480_NOP:
    mov     DWORD [_ScreenHeight], ebx
    mov        DWORD [fake480height], 1
    jmp     0x005523EE
