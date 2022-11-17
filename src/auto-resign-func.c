#include <windows.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"

// Make sure the destruct frame is a multiple of 120, hopefully this can solve OOS bugs caused by disconnection on non matching frames

uint32_t HouseDestructFrames[20];


void SetDestructFrame(uint32_t houseId)
{
    int destFrame = Frame + 30;
    
    while (destFrame % 120)
        destFrame++;
    
    HouseDestructFrames[houseId] = destFrame;
}

void TimedDestruct()
{
    for (uint32_t i = 0; i < sizeof(HouseDestructFrames)/sizeof(HouseDestructFrames[0]); i++)
    {
        if (HouseDestructFrames[i] && Frame >= HouseDestructFrames[i])
        {
            HouseDestructFrames[i] = 0;
            HouseClass__Blowup_All(HouseClass__As_Pointer(i));
        }
    }
}
