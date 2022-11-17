#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "houseclass.h"

static int *remapControlType = (void *)0x00666E8A;
static int backColor = 0x0C; //black
static uint32_t FPS;


void CalcFrameRate()
{
    static uint32_t nextTick, lastFrame;
    
    uint32_t curTick = timeGetTime();
    
    if (!nextTick)
        nextTick = curTick + 500;

    if (curTick >= nextTick)
    {
        nextTick += 500;
        FPS = (uint32_t)((double)(Frame - lastFrame) + FPS*0.5);
        lastFrame = Frame;
        CreditClassFlags |= 1; 
        GScreenClass__Flag_To_Redraw(MouseClass_Map, 0);
    }
}

void PrintFrameRate()
{
    Fancy_Text_Print("FPS: %d      ", 260, 0, remapControlType, backColor, 0x16, FPS);
}
