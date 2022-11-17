#include <windows.h>
#include "ra95.h"
#include "patch.h"


// could use EnumDisplaySettings here but it might return resolutions in a unwanted order
bool TrySetVideoMode()
{
    bool fakeHeight = false;
    
    if (Set_Video_Mode(MainWindow, ScreenWidth, ScreenHeight, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 640, ScreenHeight = 400, 8) ||
        (Set_Video_Mode(MainWindow, 640, 480, 8) && (fakeHeight = true)) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 640, ScreenHeight = 480, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 800, ScreenHeight = 600, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1024, ScreenHeight = 768, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1152, ScreenHeight = 864, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1280, ScreenHeight = 720, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1280, ScreenHeight = 768, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1280, ScreenHeight = 800, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1280, ScreenHeight = 960, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1280, ScreenHeight = 1024, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1360, ScreenHeight = 768, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1440, ScreenHeight = 900, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1440, ScreenHeight = 1080, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1600, ScreenHeight = 900, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1600, ScreenHeight = 1000, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1600, ScreenHeight = 1200, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1680, ScreenHeight = 1050, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1920, ScreenHeight = 1080, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 1920, ScreenHeight = 1200, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 2560, ScreenHeight = 1080, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 2560, ScreenHeight = 1440, 8) ||
        Set_Video_Mode(MainWindow, ScreenWidth = 2560, ScreenHeight = 1600, 8))
    {
        HiresInit();
        
        if (fakeHeight && ScreenWidth == 640 && ScreenHeight == 400)
        {
            ScreenHeight = 480;
            fake480height = 1;
        }
        
        return true;
    }

    return false;
}
