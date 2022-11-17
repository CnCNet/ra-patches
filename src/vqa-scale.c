#include <windows.h>
#include "macros/patch.h"
#include "ra95.h"

extern int ScreenWidth;
extern int ScreenHeight;

// override all 3 methods for now (it's not optional yet)
//CALL(0x005B3105, _scale_vqa);
//CALL(0x005B30F0, _scale_vqa);
//CALL(0x005B311A, _scale_vqa);

//CALL(0x0050126B, _scale_cursor_x);
//CALL(0x0050127B, _scale_cursor_y);

void scale_vqa(char *src, char *dst, int src_h, int src_w, int bufsiz)
{
    float scale = (ScreenWidth / src_w > ScreenHeight / src_h) ? (float)ScreenHeight / src_h: (float)ScreenWidth / src_w;

    int dst_w = (int)(src_w * scale);
    int dst_h = (int)(src_h * scale);
    int dst_x = (ScreenWidth - dst_w) / 2;
    int dst_y = (ScreenHeight - dst_h) / 2;

    for (int x = 0; x < dst_w; x++) {
        for (int y = 0; y < dst_h; y++) {
            dst[(x + dst_x) + (ScreenWidth * (y + dst_y))] = 
                src[(unsigned int)(x / scale) + (src_w * (unsigned int)(y / scale))];
        }
    }
}

int scale_cursor_x()
{
    float scale = (ScreenWidth / 640 > ScreenHeight / 400) ? (float)ScreenHeight / 400 : (float)ScreenWidth / 640;
    int dst_w = (int)(640 * scale);
    int dst_x = ScreenWidth / 2 - dst_w / 2;
    int x = Get_Mouse_X();
    
    return x < dst_x ? 0 : (x - dst_x) * ((float)640 / dst_w);
}

int scale_cursor_y()
{
    float scale = (ScreenWidth / 640 > ScreenHeight / 400) ? (float)ScreenHeight / 400 : (float)ScreenWidth / 640;
    int dst_h = (int)(400 * scale);
    int dst_y = ScreenHeight / 2 - dst_h / 2;
    int y = Get_Mouse_Y();

    return y < dst_y ? 0 : (y - dst_y) * ((float)400 / dst_h);
}
