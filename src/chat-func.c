#include <windows.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "houseclass.h"

bool IgnoredColors[256];
bool ChatMuted = false;

static const char Whitelist[][12] = {
    "f ", "b ", "fb ", "fb? ", "front ", "back ", "base ", "home ", "help ", "chinook ", "cy ", 
    "nook ", "heli ", "south ", "north ", "east ", "west ", "bottom ", "top ", "left ", "right ", 
    "ally ", "a ", "yellow ", "blue ", "red ", "green ", "orange ", "grey ", "gray ", "teal ", "brown ",
    "go ", "gogo ", "attack ", "ally me ", "go south ", "go north ", "i tank ", "i build ", "you tank ",
    "you build ", "make tanks ", "make helis ", "tank ", "build ", "ref ", "refinery ", "ore ", "ore space ", 
    "ref space ", "space ", "make depot ", "depot ", "v2 ", "make v2 ", "make cy ", "take cy ", "take depot ",
    "repair ", "engi ", "use engi ", "send cy ", "need cy ", "wait ", "spec ", "specs ", "n ", "s ", "apc ", 
    "transport ", "make boats ", "boats ", "cruisers ", "gg ", "\0" };


bool OutgoingMessageAllowed()
{
    if (!ChatMuted)
        return true;
    
    int *myPtr = (void *)HouseClass__PlayerPtr;
    if (myPtr)
    {
        int *meIsSpectator = (void *)myPtr + HC_IS_SPECTATOR;
        uint8_t *myFlags = (uint8_t *)myPtr + HC_FLAGS2;
        bool meIsDead = (*myFlags & HC_Defeated) != 0;
    
        if (meIsDead || *meIsSpectator)
            return false;
    }
    
    char *text = LastTextMessage;
    
    if(strstr(LastTextMessage, "(Allies):") == LastTextMessage)
        text += 9;
    
    for (int i = 0; Whitelist[i][0]; i++)
    {
        if (strcmpi(text, Whitelist[i]) == 0)
            return true;
    }
    
    return false;
}

bool IncomingMessageAllowed()
{
    if (LastTextMessage[0] == '!')
    {
        void *senderPtr = HouseClass__As_Pointer_by_Color(SelectedColor, true);
        if (senderPtr)
        {
            int *senderIsSpectator = (void *)senderPtr + HC_IS_SPECTATOR;
            uint8_t *senderFlags = (uint8_t *)senderPtr + HC_FLAGS2;
            bool senderIsDead = (*senderFlags & HC_Defeated) != 0;
            
            int *myPtr = (void *)HouseClass__PlayerPtr;
            if (myPtr)
            {
                int *meIsSpectator = (void *)myPtr + HC_IS_SPECTATOR;
                uint8_t *myFlags = (uint8_t *)myPtr + HC_FLAGS2;
                bool meIsDead = (*myFlags & HC_Defeated) != 0;
                char *myNickname = (char *)myPtr + HC_PLAYER_NAME;

                if(strstr(LastTextMessage, "!spec ") == LastTextMessage)
                {
                    if ((meIsDead || *meIsSpectator) && !senderIsDead && !*senderIsSpectator)
                    {
                        char needle[256];
                        
                        if (strcmpi(LastTextMessage, "!spec ") == 0 ||
                            (lstrcpyA(needle, LastTextMessage + 6) && 
                            strtok(needle, " ") && 
                            strstr(myNickname, needle)))
                        {
                            ForceExit = true;
                        }
                        
                    }
                }
            }
        }
    }
    
    if (IgnoredColors[SelectedColor])
    {
        void *senderPtr = HouseClass__As_Pointer_by_Color(SelectedColor, true);
        if (senderPtr)
        {
            int *senderIsSpectator = (void *)senderPtr + HC_IS_SPECTATOR;
            uint8_t *senderFlags = (uint8_t *)senderPtr + HC_FLAGS2;
            bool senderIsDead = (*senderFlags & HC_Defeated) != 0;
            
            if (senderIsDead || *senderIsSpectator)
                return false;
        }
        
        char *text = LastTextMessage;
        
        if(strstr(LastTextMessage, "(Allies):") == LastTextMessage)
            text += 9;
        
        for (int i = 0; Whitelist[i][0]; i++)
        {
            if (strcmpi(text, Whitelist[i]) == 0)
                return true;
        }
        
        return false;
    }
    
    return true;
}
