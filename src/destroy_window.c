#include <windows.h>
#include <stdbool.h>
#include <stdint.h>
#include "macros/patch.h"
#include "ra95.h"

CLEAR(0x00552272, 0x90, 0x00552279);
CALL(0x00552272, _Destroy_Window);

CLEAR(0x0055287A, 0x90, 0x00552881);
CALL(0x0055287A, _Destroy_Window);

CLEAR(0x005B3CA9, 0x90, 0x005B3CB0);
CALL(0x005B3CA9, _Destroy_Window);


BOOL WINAPI Destroy_Window(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam)
{
    typedef BOOL (WINAPI *DestroyWindow_)(HWND hWnd);
    
    DestroyWindow_ destroyWindow_ = (DestroyWindow_)GetProcAddress(GetModuleHandleA("User32.dll"), "DestroyWindow");
    
    if (destroyWindow_ && destroyWindow_(hWnd))
        return TRUE;
    
    return PostMessageA(hWnd, Msg, wParam, lParam);
}
