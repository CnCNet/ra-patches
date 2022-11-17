#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"


void Read_Scenario_INI_ex(INIClass scenario)
{
    InCoopMode = INIClass__Get_Bool(scenario, "Basic", "IsCoopMode", false);
    harvestergemmapfix = INIClass__Get_Bool(scenario, "Basic", "HarvestClosestGems", false);
    AutoAlly_ReadTeams(scenario);
}
