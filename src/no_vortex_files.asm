;
; Copyright 2022-present CnCNet
; 
; Use of this source code is governed by an MIT-style
; license that can be found in the LICENSE file or at
; https://opensource.org/licenses/MIT.
;
; Author(s): CCHyper
;
%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"

; This patch removes the reading and writing of the chronal vortex
; fading remap tables, and instead now it generate them at runtime.

; Skip the theater check, always regenerate the fading table.
@SJMP 0x0058F731, 0x0058F73D

; Remove the reading of the _VTX.PAL files.
@HACK 0x0058F743, _ChronalVortexClass__Setup_Remap_Tables_Remove_VTX_Reading
    mov edi, [ebp-14h] ; this
    add edi, 11h ; VortexRemapTables

    jmp 0x0058F791
@ENDHACK

; Remove the writing of the _VTX.PAL files.
@SJMP 0x0058F7CF, 0x0058F7DC

; Remove the local scope destruction of "file".
@SJMP 0x0058F7DC, 0x0058F800
