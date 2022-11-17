/*
 * Copyright (c) 2012, 2013, 2014 Toni Spets <toni.spets@iki.fi>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <winsock2.h>
#include <windows.h>
#include "macros/patch.h"
#include "ra95.h"
#include "patch.h"
#include "Sha256.h"

CALL(0x005A8B31, _NetHack_SendTo);
CALL(0x005A89AE, _NetHack_RecvFrom);

struct ListAddress
{
    unsigned int port;
    unsigned int ip;
};

// globals referenced in spawner
struct ListAddress AddressList[8];
uint16_t TunnelId;
int TunnelIp;
uint16_t TunnelPort;
int PortHack;
uint32_t P2Pheader;
uint8_t NetKey[SHA256_DIGEST_SIZE * 10];
uint8_t PlayerId;

void xormemcpy(void *dst, const void *src, size_t len, uint8_t *key, uint32_t keyLen)
{
    uint8_t *s = (uint8_t *)src;
    uint8_t *d = (uint8_t *)dst;
    for(uint32_t i = 0; i < len; i++)
        d[i]=s[i]^key[i%keyLen];
}

WINAPI int Tunnel_SendTo(int sockfd, const void *buf, size_t len, int flags, struct sockaddr_in *dest_addr, int addrlen)
{
    char TempBuf[1024+9];

    uint32_t *crc32 = (void *)TempBuf+4;
    *crc32 = Crc32_ComputeBuf(P2Pheader, buf, len);
    
    uint8_t *playerId = (void *)TempBuf+8;
    *playerId = PlayerId;
    
    // copy packet to our buffer
    xormemcpy(TempBuf+9, buf, len, NetKey, sizeof(NetKey));
    
    if (TunnelPort)
    {
        uint16_t *BufFrom = (void *)TempBuf;
        uint16_t *BufTo = (void *)TempBuf + 2;
        
        // pull dest port to header
        *BufFrom = TunnelId;
        *BufTo = dest_addr->sin_port;

        dest_addr->sin_port = TunnelPort;
        dest_addr->sin_addr.s_addr = TunnelIp;
    }
    else
    {
        uint32_t *header = (void *)TempBuf;
        *header = P2Pheader;
    }
        
    return sendto(sockfd, TempBuf, len+9, flags, (struct sockaddr *)dest_addr, addrlen);
}

WINAPI int Tunnel_RecvFrom(int sockfd, void *buf, size_t len, int flags, struct sockaddr_in *src_addr, int *addrlen)
{
    char TempBuf[1024+9];
    
    // call recvfrom first to get the packet
    int ret = recvfrom(sockfd, TempBuf, sizeof TempBuf, flags, (struct sockaddr *)src_addr, addrlen);
    
    if (ret <= 9)
        return -1;
    
    uint8_t *playerId = (void *)TempBuf+8;
    //we don't want to receive our own packets (the game would drop)
    if (*playerId == PlayerId)
        return -1;
    
    if (TunnelPort)
    {
        uint16_t *BufFrom = (void *)TempBuf;
        uint16_t *BufTo = (void *)TempBuf + 2;
    
        if (*BufTo != TunnelId)
            return -1;

        src_addr->sin_port = *BufFrom;
        src_addr->sin_addr.s_addr = 0;
    }
    else 
    {
        uint32_t *header = (void *)TempBuf;
        
        if (*header != P2Pheader)
            return -1;
    }
    
    xormemcpy(buf, TempBuf+9, ret-9, NetKey, sizeof(NetKey));
    
    uint32_t *crc32 = (void *)TempBuf+4;
    
    if (*crc32 != Crc32_ComputeBuf(P2Pheader, buf, ret-9))
        return -1;
    
    return ret-9;
}

WINAPI int NetHack_SendTo(int sockfd, const void *buf, size_t len, int flags, const struct sockaddr_in *dest_addr, int addrlen)
{
    struct sockaddr_in TempDest;

    // pull index
    int i = dest_addr->sin_addr.s_addr - 1;

    // validate index
    if (i >= 8 || i < 0)
        return -1;

    TempDest.sin_family         = AF_INET;
    TempDest.sin_port           = AddressList[i].port;
    TempDest.sin_addr.s_addr    = AddressList[i].ip;

    // do call to sendto
    return Tunnel_SendTo(sockfd, buf, len, flags, &TempDest, addrlen);
}

WINAPI int NetHack_RecvFrom(int sockfd, void *buf, size_t len, int flags, struct sockaddr_in *src_addr, int *addrlen)
{
    // call recvfrom first to get the packet
    int ret = Tunnel_RecvFrom(sockfd, buf, len, flags, src_addr, addrlen);
    
    // bail out if error
    if (ret == -1)
        return ret;

    // now, we need to map src_addr ip/port to index by reversing the search!
    for (int i = 0; i < 8; i++) {
        // compare ip
        if (src_addr->sin_addr.s_addr == AddressList[i].ip) {
            // compare port
            if (!PortHack && src_addr->sin_port != AddressList[i].port)
                continue;

            // found it, set this index to source addr
            src_addr->sin_addr.s_addr = i + 1;
            src_addr->sin_port = 0;
            break;
        }
    }

    return ret;
}
