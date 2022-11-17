#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"

EventInfo EventLog[256];
uint32_t RandomClassLog[1024];
char MapHash[64];
uint32_t HouseDisconnectFrames[20];
uint32_t HouseAbortFrames[20];


void ExtOutOfSyncLog(FILE *stream)
{
    fprintf(stream, "MapName=%s\n", MapName);
    fprintf(stream, "MapHash=%s\n", MapHash);
    fprintf(stream, "UnitCount=%d\n", mpUnitCount);
    fprintf(stream, "AiPlayers=%d\n", mpAiPlayers);
    fprintf(stream, "Bases=%s\n", mpBases ? "Yes" : "No");
    fprintf(stream, "OreRegenerates=%s\n", mpOreRegenerates ? "Yes" : "No");
    fprintf(stream, "Crates=%s\n", mpCrates ? "Yes" : "No");
    fprintf(stream, "Aftermath=%s\n", aftermathenabled ? "Yes" : "No");
    fprintf(stream, "AftermathFastBuildSpeed=%s\n", aftermathfastbuildspeed ? "Yes" : "No");
    fprintf(stream, "FixFormationSpeed=%s\n", fixformationspeed ? "Yes" : "No");
    fprintf(stream, "SuperTeslaFix=%s\n", SuperTeslaFix ? "Yes" : "No");
    fprintf(stream, "FixRangeExploit=%s\n", infantryrangeexploitfix ? "Yes" : "No");
    fprintf(stream, "FixMagicBuild=%s\n", magicbuildfix ? "Yes" : "No");
    fprintf(stream, "ParabombsInMultiplayer=%s\n", parabombsinmultiplayer ? "Yes" : "No");
    fprintf(stream, "FixAIAlly=%s\n", fixaially ? "Yes" : "No");
    fprintf(stream, "MCVUndeploy=%s\n", mcvundeploy ? "Yes" : "No");
    fprintf(stream, "AllyReveal=%s\n", allyreveal ? "Yes" : "No");
    fprintf(stream, "ForcedAlliances=%s\n", forcedalliances ? "Yes" : "No");
    fprintf(stream, "BuildOffAlly=%s\n", buildoffally ? "Yes" : "No");
    fprintf(stream, "ShortGame=%s\n", shortgame ? "Yes" : "No");
    
    for (uint32_t i = 0; i < sizeof(EventLog)/sizeof(EventLog[0]); i++)
    {
        uint8_t eventId = EventLog[i].RawEvent[0];
        
        if (!eventId || eventId > 32)
            continue;
        
        fprintf(stream, 
            "event[%03d]= Id:%d Frame:%d EvFrame:%d (%s) ", 
            i, EventLog[i].HouseId, EventLog[i].Frame, EventLog[i].EventFrame, EventClass__EventNames[eventId]);
        
        for (uint8_t x = 5; x < 5 + EventClass__EventLength[eventId]; x++)
            fprintf(stream, "%02X", EventLog[i].RawEvent[x]);

        fprintf(stream, "%s\n", "");
    }

    for (uint32_t i = 0; i < sizeof(RandomClassLog)/sizeof(RandomClassLog[0]); i++)
        fprintf(stream, "rand[%d]=%x\n", i, RandomClassLog[i]);
    
    for (uint32_t i = 0; i < sizeof(HouseDisconnectFrames)/sizeof(HouseDisconnectFrames[0]); i++)
    {
        if (HouseDisconnectFrames[i])
            fprintf(stream, "ID:%d  DisconnectFrame:%d\n", i, HouseDisconnectFrames[i]);
    }
    
    for (uint32_t i = 0; i < sizeof(HouseAbortFrames)/sizeof(HouseAbortFrames[0]); i++)
    {
        if (HouseAbortFrames[i])
            fprintf(stream, "ID:%d  AbortFrame:%d\n", i, HouseAbortFrames[i]);
    }
    
}
