#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "houseclass.h"
#include "patch.h"


void PrintDoList()
{
    FILE *file = fopen("dolist.txt", "wt");
    if (file)
    {
        for (int i = 12; i < 20; i++) // Multi1 (12) -> Multi8 (19)
        {
            void *house = HouseClass__As_Pointer(i);
            if (house)
            {
                char *name = (char *)house + HC_PLAYER_NAME;
                if (name)
                    fprintf(file, "%s: ID:%d\n", name, i);
            }
        }

        for (uint32_t i = 0; i < sizeof(EventClass__DoList)/sizeof(EventClass__DoList[0]); i++)
        {
            uint8_t eventId = EventClass__DoList[i][0];
            
            if (!eventId || eventId > 32)
                continue;
            
            uint32_t *xx = (uint32_t *)(EventClass__DoList[i] + 1);
            uint32_t frame = *xx & 0x03FFFFFF;
            uint32_t houseId = *xx * 2 >> 0x1B;
            
            fprintf(file, 
                "event[%03d]= Id:%d Frame:%d (%s) ", 
                i, houseId, frame, EventClass__EventNames[eventId]);
            
            for (uint8_t x = 5; x < 5 + EventClass__EventLength[eventId]; x++)
                fprintf(file, "%02X", EventClass__DoList[i][x]);

            fprintf(file, "%s\n", "");
        }
        
        fclose(file);
    }
}
