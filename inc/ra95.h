#include <stdbool.h>
#include <stdint.h>

// This header works with sym.asm which defines the Vanilla symbols
// This header will be split up as it becomes larger

// ### Structs ###


// ### types ###

typedef char INIClass[64];
typedef char FileClass[128];
typedef char IPXManagerClass[128];
typedef uint8_t EventClass[20];

// ### Functions ###

void INIClass__Put_Int(INIClass iniClass, char *section, char *key, int value);
void INIClass__Put_Bool(INIClass iniClass, char *section, char *key, bool value);
void INIClass__Put_String(INIClass iniClass, char *section, char *key, char *value);
int INIClass__Get_Int(INIClass iniClass, char *section, char *key, int defaultValue);
bool INIClass__Get_Bool(INIClass iniClass, char *section, char *key, bool defaultValue);
void INIClass__Get_String(INIClass iniClass, char *section, char *key, char *defaultValue, char *returnedString, int size);
void INIClass__Save(INIClass iniClass, FileClass fileClass);

void FileClass__FileClass(FileClass fileClass, char *fileName);
bool FileClass__Is_Available(FileClass fileClass);
int FileClass__Size(FileClass fileClass);
int FileClass__Read(FileClass fileClass, void *buf, size_t len);
void FileClass__dtor(FileClass fileClass, int flags);

uint32_t IPXManagerClass__Connection_ID(IPXManagerClass ipxManagerClass, uint32_t id);
size_t IPXManagerClass__Num_Connections(IPXManagerClass ipxManagerClass);
char *IPXManagerClass__Connection_Name(IPXManagerClass ipxManagerClass, uint32_t house);

void GScreenClass__Flag_To_Redraw(void * map, int unknown);
int *HouseClass__As_Pointer(int house);
void HouseClass__Blowup_All(int *this_);
void HouseClass__Make_Ally(int *this, int id);

void Fancy_Text_Print(char *format, uint32_t x, uint32_t y, int *remapControlType, uint32_t backColor, int textPrintType, ...);
int *UnitTrackerClass__Get_All_Totals(int *typePointer);
void Check_For_Focus_Loss();

void *memcpy(void *dest, const void *src, size_t n);
void Queue_Exit();

bool Set_Video_Mode(HWND hwnd, int width, int height, int bpp);

void WWMouseClass__Erase_Mouse(void *this, void *graphicViewPortClass, BOOL unk);
void GScreenClass__Input(void *this, short *keyNumType, int *mouseX, int *mouseY);
void Keyboard_Process(short *keyNumType);
void GScreenClass__Render(void *this);

int Get_Mouse_X();
int Get_Mouse_Y();

// ### Variables ###

extern int HumanPlayers;
extern int ScreenWidth;
extern int ScreenHeight;
extern int HouseClass__PlayerPtr;
extern void **HouseClassPointers;
extern size_t HouseClassPointersCount;
extern uint8_t SelectedColor;
extern char LastTextMessage[];
extern uint32_t MpHouseFrameArray[7];
extern uint32_t Frame;
extern IPXManagerClass IPXManagerClassObject;
extern uint32_t MaxAhead;
extern char MouseClass_Map[];
extern uint8_t CreditClassFlags;
extern uint32_t GameActive;
extern char *EventClass__EventNames[];
extern uint8_t EventClass__EventLength[];
extern EventClass EventClass__DoList[4096];
extern HWND MainWindow;
extern void *GraphicsViewPortClass_HidPage;
extern void *WWMouseClass__WWMouse;
extern void *WinTimerClass__WindowsTimer;
extern uint32_t FrameTimerTicks;
extern short Waypoints[8];


extern uint32_t AircraftHeap_MaxAircrafts;
extern uint32_t AircraftHeap_CurrentAircrafts;
extern uint32_t BuildingHeap_MaxBuildings;
extern uint32_t BuildingHeap_CurrentBuildings;
extern uint32_t InfantryHeap_MaxInfantries;
extern uint32_t InfantryHeap_CurrentInfantries;
extern uint32_t UnitHeap_MaxUnits;
extern uint32_t UnitHeap_CurrentUnits;
extern uint32_t VesselHeap_MaxVessels;
extern uint32_t VesselHeap_CurrentVessels;

extern char ScenarioName[];
extern char str_spawn_xdp[];
extern char str_spawnam_xdp[];
extern char SessionClass__Session;
extern char MapName[];
extern uint32_t mpBases;
extern uint32_t mpOreRegenerates;
extern uint32_t mpCrates;
extern uint32_t mpUnitCount;
extern uint32_t mpAiPlayers;
extern uint32_t HumanPlayersLeft;


#ifndef WWDEBUG
#define printf_(format, ...)
#else
void printf_(char *fmt, ...);
#endif

