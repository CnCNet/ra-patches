#include <stdbool.h>
#include <stdint.h>

//HouseClass struct
//Should be rewritten to a proper struct
//Blank spaces mean something is in between
#define HC_RTTI 0x0
#define HC_ID 0X1
#define HC_Class 0x5

#define HC_HousesType 0x41
#define HC_FLAGS1 0x42 // ???
#define HC_FLAGS2 0x43 // 1 = isDead
#define HC_FLAGS3 0x44
#define HC_FLAGS4 0x45

#define HC_PreventWinTriggers 0x118
#define HC_Spent 0x173
#define HC_Harvested 0x177
#define HC_Stolen 0x17B
#define HC_CurrentUnitCount 0x17F
#define HC_CurrentBuildingCount 0x183
#define HC_CurrentInfantryCount 0x187
#define HC_CurrentVesselCount 0x18B
#define HC_CurrentAircraftCount 0x18F
#define HC_Tiberium 0x193
#define HC_Credits 0x197
#define HC_Storage_Cap 0x19B
#define HC_PLANES_BOUGHT 0x19F
#define HC_INFANTRY_BOUGHT 0x1A3
#define HC_UNITS_BOUGHT 0x1A7
#define HC_BUILDINGS_BOUGHT 0x1AB
#define HC_VESSELS_BOUGHT 0x1AF
#define HC_PLANES_KILLED 0x1B3
#define HC_INFANTRY_KILLED 0x1B7
#define HC_UNITS_KILLED 0x1BB
#define HC_BUILDINGS_KILLED 0x1BF
#define HC_VESSELS_KILLED 0x1C3
#define HC_BUILDINGS_CAPTURED 0x1C7
#define HC_CRATESFOUND 0x1CB

#define HC_Power 0x1E3
#define HC_Drain 0x1E7

#define HC_PLAYER_COLOR 0x178F
#define HC_PLAYER_NAME 0x1790

#define HC_IS_SPECTATOR 0x17B0
#define HC_Resigned 0x17BC
#define HC_SpawnLocation 0x17B4
//End of HouseClass struct

enum Houses
{
    H_MULTI1 = 12,
    H_MULTI2,
    H_MULTI3,
    H_MULTI4,
    H_MULTI5,
    H_MULTI6,
    H_MULTI7,
    H_MULTI8
};

//HouseClass Bitfield Definitions

enum HC_Bitfield1 {
HC_IsActive = 0x1,
HC_IsHuman = 0x2,
HC_PlayerControl = 0x4,
HC_ProductionStarted = 0x8,
HC_Autocreate = 0x10,
HC_AutoBaseAI = 0x20,
HC_Discovered = 0x40,
HC_MaxCapacity = 0x80
};

enum HC_Bitfield2 {
HC_Defeated = 0x1,
HC_ToDie = 0x2,
HC_ToWin = 0x4,
HC_ToLose = 0x8,
HC_CiviliansEvacuated = 0x10,
HC_RecalcNeeded = 0x20,
HC_Visionary = 0x40,
HC_Bit2_128 = 0x80 //LowOre?
};

enum HC_Bitfield3 {
HC_Bit3_1 = 0x1, //Spied
HC_Thieved = 0x2, //seems to be triggered when engineers enter too
HC_Repairing = 0x4,
HC_GPSActive = 0x8, //Called MapIsClear in later games
HC_Production = 0x10,
HC_Bit3_32 = 0x20, // Resigned?
HC_Bit3_64 = 0x40, //GaveUp?
HC_Paranoid = 0x80
};

//Members of this Bitfield are unknown
enum HC_Bitfield4 {
HC_Bit4_1 = 0x1,
HC_Bit4_2 = 0x2,
HC_Bit4_4 = 0x4,
HC_Bit4_8 = 0x8,
HC_Bit4_16 = 0x10,
HC_Bit4_32 = 0x20,
HC_Bit4_64 = 0x40,
HC_Bit4_128 = 0x80
};
