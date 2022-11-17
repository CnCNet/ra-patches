#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "houseclass.h"

bool PlayerConnected[8];
uint32_t LagWarningTime = 114; //120 or above = max sensitivity
uint32_t LagWarningDuration = 3000;

static int *remapControlType = (void *)0x00666E8A;
static int backColor = 0x0C; //black
static char LaggingPlayer[32];

void DrawConnectionLiveStats()
{
    if (QuickMatch)
        return;
    
    char names[256] = "";
    
    for (int i = 0; i < HumanPlayers; i++)
    {
        if (PlayerConnected[i]) continue;
        int *house = HouseClass__As_Pointer(12 + i); // 12 = Multi1 aka the first multiplayer house
        if (house == (void *)HouseClass__PlayerPtr) continue;
        char *playerName = (void *)house + HC_PLAYER_NAME;
        sprintf(names, "%s%s ", names, playerName);
    }
    
    Fancy_Text_Print("                                                                                                        ", 5, 15, remapControlType, backColor, 0x16);
    Fancy_Text_Print("Waiting for: %s", 5, 15, remapControlType, backColor, 0x16, names);
}


void CheckHouseFrames(uint32_t timeUntilReconDialog)
{
    static uint32_t LastTickCount;
    static uint32_t lastHouse;
    
    if (LagWarningDuration == 0 || QuickMatch)
        return;
    
    uint32_t tickCount = timeGetTime();
    
    if (!LastTickCount) 
        LastTickCount = tickCount;
    else if (tickCount - LastTickCount < LagWarningDuration)
        return;
    
    if (timeUntilReconDialog > LagWarningTime)
    {
        if (LaggingPlayer[0])
        {
            LaggingPlayer[0] = 0;
            lastHouse = 0;
            
            CreditClassFlags |= 1; 
            GScreenClass__Flag_To_Redraw(MouseClass_Map, 0);
        }
        return;
    }
    
    for (uint32_t i = 0; i < IPXManagerClass__Num_Connections(IPXManagerClassObject); i++)
    {
        if (MpHouseFrameArray[i] + MaxAhead <= Frame)
        {
            uint32_t house = IPXManagerClass__Connection_ID(IPXManagerClassObject, i);
            
            if (lastHouse != house)
            {
                lastHouse = house;
                LastTickCount = tickCount;
                
                lstrcpyA(LaggingPlayer, IPXManagerClass__Connection_Name(IPXManagerClassObject, house));
                CreditClassFlags |= 1; 
                GScreenClass__Flag_To_Redraw(MouseClass_Map, 0);
            }

            break;
        }
    }
}

void DrawReconNames()
{
    if (LaggingPlayer[0] && !QuickMatch)
        Fancy_Text_Print("Lag=%s     ", 160, 0, remapControlType, backColor, 0x16, LaggingPlayer);
    else
        Fancy_Text_Print("                   ", 160, 0, remapControlType, backColor, 0x16);
}
