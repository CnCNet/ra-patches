#include <windows.h>
#include "ra95.h"
#include "patch.h"
#include "Sha256.h"


void GenerateNetKey(uint32_t salt)
{
    CSha256 p;
    
    Sha256_Init(&p);
    
    Sha256_UpdateFile(&p, ScenarioName);
    Sha256_UpdateFile(&p, str_spawn_xdp);
    Sha256_UpdateFile(&p, str_spawnam_xdp);
    Sha256_Update(&p, (uint8_t *)0x401000, 1985536); // .text section
    Sha256_Update(&p, (uint8_t *)&salt, sizeof(salt));
    
    Sha256_Final(&p, NetKey);
    
    for (int i = 0; i < 9; i++)
    {
        Sha256_Init(&p);
        Sha256_Update(&p, NetKey + (i * SHA256_DIGEST_SIZE), SHA256_DIGEST_SIZE);
        Sha256_Update(&p, (uint8_t *)&salt, sizeof(salt));
        Sha256_Final(&p, NetKey + ((i + 1) * SHA256_DIGEST_SIZE));
    }
}
