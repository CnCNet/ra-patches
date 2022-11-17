typedef uint8_t RTTIType;

enum RTTIType {
    RTTI_INVALID = -1,

    RTTI_FIRST = 0,

    RTTI_NONE = 0,
    RTTI_AIRCRAFT = 1,
    RTTI_AIRCRAFTTYPE = 2,
    RTTI_ANIM = 3,
    RTTI_ANIMTYPE = 4,
    RTTI_BUILDING = 5,
    RTTI_BUILDINGTYPE = 6,
    RTTI_BULLET = 7,
    RTTI_BULLETTYPE = 8,
    RTTI_CELL = 9,
    RTTI_FACTORY = 10,
    RTTI_HOUSE = 11,
    RTTI_HOUSETYPE = 12,
    RTTI_INFANTRY = 13,
    RTTI_INFANTRYTYPE = 14,
    RTTI_OVERLAY = 15,
    RTTI_OVERLAYTYPE = 16,
    RTTI_SMUDGE = 17,
    RTTI_SMUDGETYPE = 18,
    RTTI_SPECIAL = 19,			//super weapon cameos
    RTTI_TEAM = 20,
    RTTI_TEAMTYPE = 21,
    RTTI_TEMPLATE = 22,
    RTTI_TEMPLATETYPE = 23,
    RTTI_TERRAIN = 24,
    RTTI_TERRAINTYPE = 25,
    RTTI_TRIGGER = 26,
    RTTI_TRIGGERTYPE = 27,
    RTTI_UNIT = 28,
    RTTI_UNITTYPE = 29,
    RTTI_VESSEL = 30,
    RTTI_VESSELTYPE = 31,
    RTTI_LAST = 31,

    RTTI_COUNT = 32

};