#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "rtti.h"

bool ReduceSovietMaxAircrafts = true;
bool PlayerIsSoviet = false;

bool ProductionLimitReached(RTTIType rttiType)
{
    switch(rttiType)
    {
        case RTTI_AIRCRAFTTYPE:
        {
            if (PlayerIsSoviet && ReduceSovietMaxAircrafts)
                return AircraftHeap_CurrentAircrafts + 74 >= AircraftHeap_MaxAircrafts;
            
            return AircraftHeap_CurrentAircrafts + 24 >= AircraftHeap_MaxAircrafts;
        }
        case RTTI_BUILDINGTYPE:
            return BuildingHeap_CurrentBuildings + 24 >= BuildingHeap_MaxBuildings;
        case RTTI_INFANTRYTYPE:
            return InfantryHeap_CurrentInfantries + 24 >= InfantryHeap_MaxInfantries;
        case RTTI_UNITTYPE:
            return UnitHeap_CurrentUnits + 24 >= UnitHeap_MaxUnits;
        case RTTI_VESSELTYPE:
            return VesselHeap_CurrentVessels + 24 >= VesselHeap_MaxVessels;
        default:
            return false;
    }
}
