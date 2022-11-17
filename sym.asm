%include "macros/setsym.inc"
%include "macros/watcall.inc"

; ### Variables ###

; hotkeys
setcglob 0x006681C4, Bookmark1_Key
setcglob 0x006681C6, Bookmark2_Key
setcglob 0x006681C8, Bookmark3_Key
setcglob 0x006681CA, Bookmark4_Key
setcglob 0x006681AE, KeyScatter

setcglob 0x006016B0, ScreenWidth
setcglob 0x006016B4, ScreenHeight
setcglob 0x00669958, HouseClass__PlayerPtr
setcglob 0x006679D8, ScenarioName
setcglob 0x006680C4, Frame
setcglob 0x00687804, MpHouseFrameArray
setcglob 0x006805B0, IPXManagerClassObject
setcglob 0x0067F325, MaxAhead
setcglob 0x00669852, CreditClassFlags

; TFixedIHeapClass

setcglob 0x0065D820, AircraftHeap_MaxAircrafts
setcglob 0x0065D824, AircraftHeap_CurrentAircrafts
setcglob 0x0065D8B8, BuildingHeap_MaxBuildings
setcglob 0x0065D8BC, BuildingHeap_CurrentBuildings
setcglob 0x0065D9E8, InfantryHeap_MaxInfantries
setcglob 0x0065D9EC, InfantryHeap_CurrentInfantries
setcglob 0x0065DC48, UnitHeap_MaxUnits
setcglob 0x0065DC4C, UnitHeap_CurrentUnits
setcglob 0x0065DC94, VesselHeap_MaxVessels
setcglob 0x0065DC98, VesselHeap_CurrentVessels

; ### unsorted ###
setcglob 0x5D6148, start
setcglob 0x005CDD10, GetCDClass__GetCDClass
setcglob 0x00680884, CDList
setcglob 0x004F3660, INIClass_Get_Int
setcglob 0x005C0FE7, Set_Logic_Page
setcglob 0x005C23F0, Buffer_Fill_Rect
setcglob 0x005C4DE0, Buffer_Clear
setcglob 0x006807CC, GraphicsViewPortClass_HidPage
setcglob 0x0068065C, GraphicBufferClass_VisiblePage
setcglob 0x006807A4, GraphicsViewPortClass_SeenBuff
setcglob 0x0068A2C4, DefaultSelectButtons
setcglob 0x0068A254, downbuttons
setcglob 0x0068A1E4, upbuttons
setcglob 0x004A96E8, CC_Draw_Shape
setcglob 0x005DE63D, _exit
setcglob 0x00551A70, WinMain
setcglob 0x00666688, RulesINI
setcglob 0x004C7C60, INIClass__INIClass
setcglob 0x004F28C4, INIClass__Load
;setcglob 0x004F3660, INIClass__Get_Int
;setcglob 0x004F3A34, INIClass__Get_String
;setcglob 0x004F3ACC, INIClass__Get_Bool
setcglob 0x0067F2B4, SessionClass__Session ; AKA SessionType in our sources
setcglob 0x005C3900, strdup_
setcglob 0x005E55C8, strcpy_
setcglob 0x006679D3, ScenarioNumber
setcglob 0x005B8BAA, sprintf_
setcglob 0x00669958, HouseClass_PlayerPtr
setcglob 0x0054D07C, SidebarClass__One_Time
setcglob 0x0054D144, SidebarClass__Init_IO
setcglob 0x0054D340, SidebarClass__Reload_Sidebar
setcglob 0x00668250, MouseClass_Map
setcglob 0x0060174C, stripbariconswidthoffset
setcglob 0x005B8F30, MixFileClass_CCFileClass_Retrieve
setcglob 0x005B93F0, MixFileClass_CCFileClass_Cache
setcglob 0x00665F68, PKey__FastKey
setcglob 0x005CEC59, stristr_
setcglob 0x00687C04, ScrollDirection
setcglob 0x00604DE8, VideoBackBuffer
setcglob 0x005B373C, GameWindowProcedure
setcglob 0x00601758, SideBarPanelsHeight
setcglob 0x004627D4, CCFileClass__CCFileClass
setcglob 0x00462AD4, CCFileClass__OpenFile
setcglob 0x00462860, CCFileClass__WriteBytes
setcglob 0x00462AA8, CCFileClass__CloseHandle
setcglob 0x0067F5C0, MessageListClass__EditState ;bit 2 = chat edit active?
setcglob 0x0066818C, ScrollRate
setcglob 0x00528E44, Queue_Exit
setcglob 0x004A7C74, MainLoop
setcglob 0x005C5070, ExtractString
setcglob 0x005C21C0, HideMouse
setcglob 0x004D8270, HouseClass__MPlayer_Defeated
setcglob 0x004D5FC8, HouseClass__Is_Ally ;const HouseClass::Is_Ally(HousesType)
setcglob 0x00426158, Speak		
setcglob 0x005B3624, Check_For_Focus_Loss	
setcglob 0x004F4060, init_game	
setcglob 0x0065D9C8, HouseClassPointers
setcglob 0x0065D9A0, HouseClassPointersCount
setcglob 0x00680201, SelectedColor
setcglob 0x00680189, LastTextMessage
setcglob 0x00669924, GameActive
setcglob 0x006678E8, ScenarioClass__ScenOrRandom
setcglob 0x006013CC, EventClass__EventNames
setcglob 0x006013A8, EventClass__EventLength
setcglob 0x0067F2D6, MapName
setcglob 0x0067F2BA, mpBases
setcglob 0x0067F2C2, mpOreRegenerates
setcglob 0x0067F2C6, mpCrates
setcglob 0x0067F2CE, mpUnitCount
setcglob 0x0067F2D2, mpAiPlayers
setcglob 0x00680151, recording_mode
setcglob 0x006800F1, recording_file
setcglob 0x0066B074, EventClass__DoList
setcglob 0x006ABBBC, ConnectionLost
setcglob 0x006B1498, MainWindow
setcglob 0x0068044A, HumanPlayersLeft
setcglob 0x00665E08, WWMouseClass__WWMouse
setcglob 0x00665EB0, WinTimerClass__WindowsTimer
setcglob 0x006807F9, FrameTimerTicks
setcglob 0x006678F7, Waypoints


setcglob 0x006ABBAC, PlanetWestwoodGameID ; aka WOLGameID in our sources

;RawFileClass
setcglob 0x005C0028, RawFileClass__RawFileClass ; RawFileClass::RawFileClass(char *)
setcglob 0x005C0314, RawFileClass__Read
setcglob 0x005C0210, RawFileClass__Is_Available
setcglob 0x004F8980, RawFileClass__DTOR
setcglob 0x005C056C, RawFileClass__Size

setcglob 0x005C22C0, Get_Mouse_X
setcglob 0x005C22E0, Get_Mouse_Y

; ### Functions ###

setcglob 0x004AE8C0, Fancy_Text_Print

; winapi
setcglob 0x005E663C, _imp__LoadLibraryA
setcglob 0x005E65C0, _imp__FreeLibrary
setcglob 0x005E65FC, _imp__GetProcAddress
setcglob 0x005E65D0, _imp__GetCurrentProcess
setcglob 0x005E6754, _imp__GetCurrentProcessId
setcglob 0x005E6758, _imp__GetCurrentThreadId
setcglob 0x005E658C, _imp__CreateFileA
setcglob 0x005E6864, _imp__MessageBoxA
setcglob 0x005E6724, _imp__ExitProcess
setcglob 0x005E65DC, _imp__GetExitCodeProcess
setcglob 0x005E6748, _imp__GetCommandLineA      
setcglob 0x005E6778, _imp__GetModuleHandleA
setcglob 0x005E66A8, _imp__timeGetTime
setcglob 0x005E66BC, _imp__DefWindowProcA
setcglob 0x005E667C, _imp__Sleep
setcglob 0x005E68B0, _imp__sendto 
setcglob 0x005E68B4, _imp__recvfrom
setcglob 0x005E65F0, _imp__GetModuleFileNameA
setcglob 0x005E65D4, _imp__GetCurrentThread
setcglob 0x005E6698, _imp__lstrcpyA
setcglob 0x005E6644, _imp__OutputDebugStringA
setcglob 0x005E66DC, _imp__PostMessageA
setcglob 0x005E65A8, _imp__EnterCriticalSection
setcglob 0x005E6598, _imp__DeleteCriticalSection
setcglob 0x005E662C, _imp__InitializeCriticalSection
setcglob 0x005E6638, _imp__LeaveCriticalSection

setcglob 0x005CEDA1, time
setcglob 0x005E0E50, gmtime
setcglob 0x005B8BAA, sprintf
setcglob 0x005E55C8, strcpy
setcglob 0x005BC8B7, atoi
setcglob 0x005CD97B, printf_
setcglob 0x005D41A5, fprintf

; watcall functions
setwatglob 0x005BC813, strtok, 2
setwatglob 0x005D41C6, fclose, 1
setwatglob 0x005D40B9, fopen, 2
setwatglob 0x004F3660, INIClass__Get_Int, 4
setwatglob 0x004F3ACC, INIClass__Get_Bool, 4
setwatglob 0x004F3A34, INIClass__Get_String, 6
setwatglob 0x004F2F08, INIClass__Save, 1
setwatglob 0x004D2CB0, HouseClass__As_Pointer, 1
setwatglob 0x00581CB0, UnitTrackerClass__Get_All_Totals, 1
setwatglob 0x005BBF80, OperatorNew, 1
setwatglob 0x005B88E0, FieldClass__FieldClass_String, 2
setwatglob 0x005B7A14, PacketClass__Add_Field, 2
setwatglob 0x005379FC, Save_Game, 3 ; (int,char *,int)
setwatglob 0x00537D10, Load_Game, 1 ; Load_Game(int)
setwatglob 0x004CAFF4, GScreenClass__Flag_To_Redraw, 2
setwatglob 0x004D8814, HouseClass__Blowup_All, 1
setwatglob 0x005C9D60, Set_Video_Mode, 4
setwatglob 0x005C2020, WWMouseClass__Erase_Mouse, 3 ; WWMouseClass::Erase_Mouse(GraphicViewPortClass *,int)
setwatglob 0x004CB010, GScreenClass__Input, 4 ; GScreenClass::Input(KeyNumType &,int &,int &)
setwatglob 0x004A56D8, Keyboard_Process, 1 ; Keyboard_Process(KeyNumType &)
setwatglob 0x004CB110, GScreenClass__Render, 1
setwatglob 0x005BBF30, WinTimerClass__Get_System_Tick_Count, 1
setwatglob 0x004D6060, HouseClass__Make_Ally, 2


;WTF FUNKY, FileClass is a competely different thing, this is CCFileClass
setwatglob 0x004627D4, FileClass__FileClass, 2
setwatglob 0x00462A30, FileClass__Is_Available, 1
setwatglob 0x004628B0, FileClass__Read, 3
setwatglob 0x004629CC, FileClass__Size, 1
setwatglob 0x004263A0, FileClass__dtor, 2

setwatglob 0x004FAAB8, IPXManagerClass__Connection_ID, 2 ; IPXManagerClass::Connection_ID(int) returns HousesType
setwatglob 0x004FAAAC, IPXManagerClass__Num_Connections, 1
setwatglob 0x004FAAD8, IPXManagerClass__Connection_Name, 2

setwatglob 0x005C3945, free, 1
setwatglob 0x005E1EF6, calloc, 2
setwatglob 0x005B8B50, strcmpi, 2
setwatglob 0x005D1220, strcmp, 2
setwatglob 0x005C50E0, strncmp, 3
setwatglob 0x005CED17, strnicmp, 3
setwatglob 0x005CEC59, strstr, 2

;Address  Ordinal Name                        Library 
;-------  ------- ----                        ------- 
;005E6508         CreateDIBitmap              GDI32   
;005E650C         CreatePalette               GDI32   
;005E6510         DeleteObject                GDI32   
;005E6514         GetDIBits                   GDI32
;005E6518         GetDeviceCaps               GDI32   
;005E651C         GetNearestPaletteIndex      GDI32   
;005E6520         GetObjectA                  GDI32   
;005E6524         GetStockObject              GDI32   
;005E6528         GetSystemPaletteEntries     GDI32   
;005E652C         RealizePalette              GDI32   
;005E6530         SelectPalette               GDI32   
;005E6538         FindExecutableA             SHELL32 
;005E653C         ShellExecuteA               SHELL32 
;005E6544         CoCreateInstance            ole32   
;005E6548         OleInitialize               ole32   
;005E654C         OleUninitialize             ole32   
;005E6554         RegCloseKey                 ADVAPI32
;005E6558         RegDeleteValueA             ADVAPI32
;005E655C         RegEnumKeyExA               ADVAPI32
;005E6560         RegOpenKeyExA               ADVAPI32
;005E6564         RegQueryInfoKeyA            ADVAPI32
;005E6568         RegQueryValueA              ADVAPI32
;005E656C         RegQueryValueExA            ADVAPI32
;005E6570         RegSetValueExA              ADVAPI32
;005E6578         ClearCommBreak              KERNEL32
;005E657C         ClearCommError              KERNEL32
;005E6580         CloseHandle                 KERNEL32
;005E6584         CreateDirectoryA            KERNEL32
;005E6588         CreateEventA                KERNEL32
;005E658C         CreateFileA                 KERNEL32
;005E6590         CreateProcessA              KERNEL32
;005E6594         CreateThread                KERNEL32
;005E659C         DeleteFileA                 KERNEL32
;005E65A0         DosDateTimeToFileTime       KERNEL32
;005E65A4         DuplicateHandle             KERNEL32
;005E65AC         EscapeCommFunction          KERNEL32
;005E65B0         FileTimeToDosDateTime       KERNEL32
;005E65B4         FindClose                   KERNEL32
;005E65B8         FindFirstFileA              KERNEL32
;005E65BC         FindNextFileA               KERNEL32
;005E65C0         FreeLibrary                 KERNEL32
;005E65C4         GetCommModemStatus          KERNEL32
;005E65C8         GetCommState                KERNEL32
;005E65CC         GetCurrentDirectoryA        KERNEL32
;005E65D0         GetCurrentProcess           KERNEL32
;005E65D8         GetDriveTypeA               KERNEL32
;005E65DC         GetExitCodeProcess          KERNEL32
;005E65E0         GetFileInformationByHandle  KERNEL32
;005E65E4         GetFileSize                 KERNEL32
;005E65E8         GetFileTime                 KERNEL32
;005E65EC         GetLastError                KERNEL32
;005E65F4         GetOverlappedResult         KERNEL32
;005E65F8         GetPriorityClass            KERNEL32
;005E65FC         GetProcAddress              KERNEL32
;005E6600         GetSystemDirectoryA         KERNEL32
;005E6604         GetSystemTime               KERNEL32
;005E6608         GetThreadContext            KERNEL32
;005E660C         GetVersion                  KERNEL32
;005E6610         GetVolumeInformationA       KERNEL32
;005E6614         GlobalAlloc                 KERNEL32
;005E6618         GlobalFree                  KERNEL32
;005E661C         GlobalLock                  KERNEL32
;005E6620         GlobalMemoryStatus          KERNEL32
;005E6624         GlobalReAlloc               KERNEL32
;005E6628         GlobalUnlock                KERNEL32
;005E6630         InterlockedDecrement        KERNEL32
;005E6634         InterlockedIncrement        KERNEL32
;005E663C         LoadLibraryA                KERNEL32
;005E6640         OpenFile                    KERNEL32
;005E6648         PurgeComm                   KERNEL32
;005E664C         ReadFile                    KERNEL32
;005E6650         ResetEvent                  KERNEL32
;005E6654         SetCommBreak                KERNEL32
;005E6658         SetCommState                KERNEL32
;005E665C         SetCommTimeouts             KERNEL32
;005E6660         SetCurrentDirectoryA        KERNEL32
;005E6664         SetErrorMode                KERNEL32
;005E6668         SetFilePointer              KERNEL32
;005E666C         SetFileTime                 KERNEL32
;005E6670         SetPriorityClass            KERNEL32
;005E6674         SetThreadPriority           KERNEL32
;005E6678         SetupComm                   KERNEL32
;005E667C         Sleep                       KERNEL32
;005E6680         TerminateThread             KERNEL32
;005E6684         WriteFile                   KERNEL32
;005E6688         _lclose                     KERNEL32
;005E668C         _llseek                     KERNEL32
;005E6690         _lread                      KERNEL32
;005E6694         _lwrite                     KERNEL32
;005E66A0         timeBeginPeriod             WINMM   
;005E66A4         timeEndPeriod               WINMM   
;005E66A8         timeGetTime                 WINMM   
;005E66AC         timeKillEvent               WINMM   
;005E66B0         timeSetEvent                WINMM   
;005E66B8         CreateWindowExA             USER32  
;005E66BC         DefWindowProcA              USER32  
;005E66C0         DialogBoxParamA             USER32  
;005E66C4         DispatchMessageA            USER32  
;005E66C8         GetActiveWindow             USER32  
;005E66CC         GetMessageA                 USER32  
;005E66D0         GetSystemMetrics            USER32  
;005E66D4         LoadIconA                   USER32  
;005E66D8         PeekMessageA                USER32  
;005E66E0         PostQuitMessage             USER32  
;005E66E4         RegisterClassA              USER32  
;005E66E8         RegisterWindowMessageA      USER32  
;005E66EC         SetFocus                    USER32  
;005E66F0         ShowCursor                  USER32  
;005E66F4         ShowWindow                  USER32  
;005E66F8         TranslateMessage            USER32  
;005E66FC         UpdateWindow                USER32  
;005E6700         wsprintfA                   USER32  
;005E6708         CloseHandle                 KERNEL32
;005E670C         CreateEventA                KERNEL32
;005E6710         CreateFileA                 KERNEL32
;005E6714         CreateMutexA                KERNEL32
;005E6718         CreateThread                KERNEL32
;005E671C         DeleteFileA                 KERNEL32
;005E6720         DosDateTimeToFileTime       KERNEL32
;005E6724         ExitProcess                 KERNEL32
;005E6728         ExitThread                  KERNEL32
;005E672C         FileTimeToDosDateTime       KERNEL32
;005E6730         FileTimeToLocalFileTime     KERNEL32
;005E6734         FindClose                   KERNEL32
;005E6738         FindFirstFileA              KERNEL32
;005E673C         FindNextFileA               KERNEL32
;005E6740         FreeLibrary                 KERNEL32
;005E6744         GetCPInfo                   KERNEL32
;005E6748         GetCommandLineA             KERNEL32
;005E674C         GetConsoleMode              KERNEL32
;005E6750         GetCurrentDirectoryA        KERNEL32
;005E6754         GetCurrentProcessId         KERNEL32
;005E6758         GetCurrentThreadId          KERNEL32
;005E675C         GetCurrentThread            KERNEL32
;005E6760         GetDiskFreeSpaceA           KERNEL32
;005E6764         GetEnvironmentStrings       KERNEL32
;005E6768         GetFileType                 KERNEL32
;005E676C         GetLastError                KERNEL32
;005E6770         GetLocalTime                KERNEL32
;005E6774         GetModuleFileNameA          KERNEL32
;005E6778         GetModuleHandleA            KERNEL32
;005E677C         GetProcAddress              KERNEL32
;005E6780         GetStdHandle                KERNEL32
;005E6784         GetTimeZoneInformation      KERNEL32
;005E6788         GetVersion                  KERNEL32
;005E678C         LoadLibraryA                KERNEL32
;005E6790         LocalFileTimeToFileTime     KERNEL32
;005E6794         ReadConsoleInputA           KERNEL32
;005E6798         ReadFile                    KERNEL32
;005E679C         ReleaseMutex                KERNEL32
;005E67A0         RtlUnwind                   KERNEL32
;005E67A4         SetConsoleCtrlHandler       KERNEL32
;005E67A8         SetConsoleMode              KERNEL32
;005E67AC         SetCurrentDirectoryA        KERNEL32
;005E67B0         SetErrorMode                KERNEL32
;005E67B4         SetEvent                    KERNEL32
;005E67B8         SetFilePointer              KERNEL32
;005E67BC         SetStdHandle                KERNEL32
;005E67C0         TlsAlloc                    KERNEL32
;005E67C4         TlsFree                     KERNEL32
;005E67C8         TlsGetValue                 KERNEL32
;005E67CC         TlsSetValue                 KERNEL32
;005E67D0         VirtualAlloc                KERNEL32
;005E67D4         VirtualFree                 KERNEL32
;005E67D8         WaitForSingleObject         KERNEL32
;005E67DC         WriteConsoleA               KERNEL32
;005E67E0         WriteFile                   KERNEL32
;005E67E8         _MpgPause@0                 mpgdll  
;005E67EC         _MpgPlay@16                 mpgdll  
;005E67F0         _MpgResume@0                mpgdll  
;005E67F4         _MpgSetCallback@8           mpgdll  
;005E67FC         DirectDrawCreate            DDRAW   
;005E6804         DirectSoundCreate           DSOUND  
;005E680C         ClipCursor                  USER32  
;005E6810         DdeAccessData               USER32  
;005E6814         DdeClientTransaction        USER32  
;005E6818         DdeConnect                  USER32  
;005E681C         DdeCreateStringHandleA      USER32  
;005E6820         DdeDisconnect               USER32  
;005E6824         DdeInitializeA              USER32  
;005E6828         DdeNameService              USER32  
;005E682C         DdeQueryStringA             USER32  
;005E6830         DdeUnaccessData             USER32  
;005E6834         DdeUninitialize             USER32  
;005E6838         DefWindowProcA              USER32  
;005E683C         DispatchMessageA            USER32  
;005E6840         FindWindowA                 USER32  
;005E6844         GetAsyncKeyState            USER32  
;005E6848         GetCursorPos                USER32  
;005E684C         GetDC                       USER32  
;005E6850         GetKeyState                 USER32  
;005E6854         GetMessageA                 USER32  
;005E6858         GetTopWindow                USER32  
;005E685C         LoadCursorA                 USER32  
;005E6860         MapVirtualKeyA              USER32  
;005E6864         MessageBoxA                 USER32  
;005E6868         PeekMessageA                USER32  
;005E686C         PostMessageA                USER32  
;005E6870         ReleaseDC                   USER32  
;005E6874         SendMessageA                USER32  
;005E6878         SetCursor                   USER32  
;005E687C         SetForegroundWindow         USER32  
;005E6880         ShowCursor                  USER32  
;005E6884         ShowWindow                  USER32  
;005E6888         ToAscii                     USER32  
;005E688C         TranslateMessage            USER32  
;005E6890         WaitForInputIdle            USER32  
;005E6898 15      __imp_ntohs                 WSOCK32 
;005E689C 103     __imp_WSAAsyncGetHostByName WSOCK32 
;005E68A0 10      __imp_inet_addr             WSOCK32 
;005E68A4 102     __imp_WSAAsyncGetHostByAddr WSOCK32 
;005E68A8 1       __imp_accept                WSOCK32 
;005E68AC 111     __imp_WSAGetLastError       WSOCK32 
;005E68B0 20      __imp_sendto                WSOCK32 
;005E68B4 17      __imp_recvfrom              WSOCK32 
;005E68B8 52      __imp_gethostbyname         WSOCK32 
;005E68BC 57      __imp_gethostname           WSOCK32 
;005E68C0 2       __imp_bind                  WSOCK32 
;005E68C4 9       __imp_htons                 WSOCK32 
;005E68C8 23      __imp_socket                WSOCK32 
;005E68CC 21      __imp_setsockopt            WSOCK32 
;005E68D0 7       __imp_getsockopt            WSOCK32 
;005E68D4 115     __imp_WSAStartup            WSOCK32 
;005E68D8 108     __imp_WSACancelAsyncRequest WSOCK32 
;005E68DC 101     __imp_WSAAsyncSelect        WSOCK32 
;005E68E0 3       __imp_closesocket           WSOCK32 
;005E68E4 116     __imp_WSACleanup            WSOCK32 
;005E68E8 11      __imp_inet_ntoa             WSOCK32 
;005E68EC 14      __imp_ntohl                 WSOCK32 
;005E68F0 8       __imp_htonl                 WSOCK32 
