%include "macros/patch.inc"
%include "macros/datatypes.inc"

extern spawner_is_active
cextern ExtractString

sstring UnableToSetVideoMode, "Error - Unable to set the video mode. The chosen game resolution is not supported, please go to the video options and change it. Enable Windowed mode if all resolutions fail."
sstring UnableToAllocateVideoBuffer, "Error - Unable to allocate primary video buffer. Please check your graphic card drivers or go to the video options and enable CnC-DDraw."
sstring CheckFirewall, "Failed to connect... Please check your connection, Anti-Virus and Firewall settings!"

@SET 0x005523F9, push UnableToSetVideoMode
@SET 0x005524CB, push UnableToAllocateVideoBuffer

hack 0x0050505F
    cmp dword[spawner_is_active], 0
    jz .out
    cmp edx, 266 ;Other system not responding ID
    jnz .out
    mov eax, CheckFirewall
    jmp 0x00505064
    
.out:
    call ExtractString
    jmp 0x00505064
