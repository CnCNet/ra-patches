#include <stdbool.h>
#include "Sha256.h"

// This header is used for patches
// This header will be split up as it becomes larger

// ### Structs ###

typedef struct EventInfo
{
    uint32_t HouseId;
    uint32_t Frame;
    uint32_t EventFrame;
    uint8_t RawEvent[20];
}EventInfo;


// ### Constants ###

// ### Variables ###
extern int spawner_is_active;
extern int SideBarPanelLeftPosX;
extern uint8_t NetKey[];
extern uint32_t P2Pheader;
extern uint32_t fake480height;
extern uint32_t InCoopMode;
extern uint32_t harvestergemmapfix;

extern bool aftermathfastbuildspeed;
extern bool fixformationspeed;
extern bool SuperTeslaFix;
extern bool infantryrangeexploitfix;
extern bool magicbuildfix;
extern bool parabombsinmultiplayer;
extern bool fixaially;
extern bool mcvundeploy;
extern bool allyreveal;
extern bool forcedalliances;
extern bool buildoffally;
extern bool shortgame;
extern bool aftermathenabled;
extern bool ForceExit;
extern bool QuickMatch;


// ### Functions ###

unsigned long Crc32_ComputeBuf( unsigned long inCrc32, const void *buf, size_t bufLen );
void Sha256_UpdateFile(CSha256 *p, char *fileName);
void WriteLog();
void *HouseClass__As_Pointer_by_Color(uint8_t color, bool multiPlayerHousesOnly);
void HiresInit();
void AutoAlly_ReadTeams(INIClass scenario);

