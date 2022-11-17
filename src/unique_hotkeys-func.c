#include <windows.h>
#include <stdio.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"

void CheckHotkeys(WORD* keys)
{
    for (int i = 13; i < 62; i++)
    {
        for (int x = 13; x < 62; x++)
        {
            if (i != x && keys[i] && keys[i] == keys[x])
                keys[x] = 0;
        }
    }
}
