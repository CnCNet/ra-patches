/* GNU ld linker script for bin.dat */

ENTRY(_start);

SECTIONS
{
    .text             0x401000 : { bin.dat(AUTO) }
    .idata            0x5E6000 : { bin.dat(.idata) }
    .data             0x5E8000 : { bin.dat(DGROUP) }
    .bss              0x623000 : { bin.dat(.bss) }
    /DISCARD/                  : { bin.dat(.edata) }
    /DISCARD/                  : { bin.dat(.reloc) }

    /DISCARD/                  : { *(.drectve) }
    /DISCARD/                  : { *(.rdata$zzz) }
    .p_text      ALIGN(0x1000) : { *(.text) }
    .p_rdata     ALIGN(0x1000) : { *(.rdata) }
    .p_data      ALIGN(0x1000) : { *(.data) }
    .p_bss       ALIGN(0x1000) : { *(.bss) *(COMMON) }

    .rsrc        ALIGN(0x1000) : { *(.rsrc) }

    .patch       ALIGN(0x1000) : { *(.patch) }
}
