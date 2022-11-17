#include <windows.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "houseclass.h"


void *HouseClass__As_Pointer_by_Color(uint8_t color, bool multiPlayerHousesOnly)
{
    void **housePointer = HouseClassPointers;
    
    for (size_t i = 0; i < HouseClassPointersCount; i++, housePointer++)
    {
        if (multiPlayerHousesOnly && i < 12)
            continue;
        
        uint8_t *houseColor = (uint8_t *)*housePointer + HC_PLAYER_COLOR;

        if (*houseColor == color)
            return *housePointer;
    }
    return 0;
}

