#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "houseclass.h"


char AutoAllyTeams[8];

void AutoAlly_ReadTeams(INIClass scenario)
{
    char team[4] = {0};
    for (int i = 0; i < 8; i++)
    {
        char waypoint[4] = {0};
        sprintf(waypoint, "%d", i);
        INIClass__Get_String(scenario, "AutoAllyWaypoints", waypoint, "", team, 4);
        AutoAllyTeams[i] = team[0];
    }
}

int GetWaypoint(short coords)
{
    for (int i = 0; i < 8; i++)
    {
        if (Waypoints[i] && Waypoints[i] == coords)
            return i;
    }
    return -1;
}

void AutoAlly_MakeAlly()
{
    void **hp1 = HouseClassPointers;
    for (size_t i = 0; i < HouseClassPointersCount; i++, hp1++)
    {
        void **hp2 = HouseClassPointers;
        for (size_t x = 0; x < HouseClassPointersCount; x++, hp2++)
        {
            if (*hp1 == *hp2)
                continue;
            
            int *spawn1 = (int *)(*hp1 + HC_SpawnLocation);
            int *spawn2 = (int *)(*hp2 + HC_SpawnLocation);
            int *id1 = (int *)(*hp1 + HC_ID);
            int *id2 = (int *)(*hp2 + HC_ID);
            int wp1 = GetWaypoint(*spawn1);
            int wp2 = GetWaypoint(*spawn2);
            
            if (*id1 < 12 || *id2 < 12 || wp1 == -1 || wp2 == -1)
                continue;

            if (AutoAllyTeams[wp1] && AutoAllyTeams[wp1] == AutoAllyTeams[wp2])
                HouseClass__Make_Ally(*hp1, *id2);
                
        }
    }
}

