#include <windows.h>
#include "ra95.h"
#include "patch.h"
#include "Sha256.h"


uint32_t GetCRC32(uint32_t inCrc32, char *fileName)
{
    FileClass file;
    FileClass__FileClass(file, fileName);
    if (FileClass__Is_Available(file))
    {
        int size = FileClass__Size(file);
        if (size > 0)
        {
            void *buf = calloc(size, sizeof(char));
            if (buf)
            {
                if (FileClass__Read(file, buf, size) == size)
                    inCrc32 = Crc32_ComputeBuf(inCrc32, buf, size);
                
                free(buf);
            }
        }
    }
    FileClass__dtor(file, 0);
    
    return inCrc32;
}

void Sha256_UpdateFile(CSha256 *p, char *fileName)
{
    FileClass file;
    FileClass__FileClass(file, fileName);
    if (FileClass__Is_Available(file))
    {
        int size = FileClass__Size(file);
        if (size > 0)
        {
            void *buf = calloc(size, sizeof(char));
            if (buf)
            {
                if (FileClass__Read(file, buf, size) == size)
                    Sha256_Update(p, buf, size);
                
                free(buf);
            }
        }
    }
    FileClass__dtor(file, 0);
}
