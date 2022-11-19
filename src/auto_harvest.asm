;
; Copyright 2022-present CnCNet
; 
; Use of this source code is governed by an MIT-style
; license that can be found in the LICENSE file or at
; https://opensource.org/licenses/MIT.
;
; Author(s): CCHyper, tomsons26
;
%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"

sbyte AutoHarvesting, 0
sint RadioContact, 0 ; Temporary pointer to current radio contact.

; This patch stores the current Radio contact pointer ( TechnoClass * contact = Contact_With_Whom(); )
@HACK 0x0057BF18, _UnitClass__Per_Cell_Process_Contact_With_Whom_Patch
    mov esi, [ebp-1Ch] ; this
    mov esi, [esi+3Ah] ; Radio
    mov [RadioContact], esi
    
    ; stolen code for call to Transmit_Message
    mov esi, [ebp-1Ch]
    mov ebx, 0x00669928 ; LParam

    jmp 0x0057BF20
@ENDHACK

; If auto harvesting is enabled, assign them with the harvesting mission as soon as they exit the war factory.
@HACK 0x0057BF37, _UnitClass__Per_Cell_Process_AutoHarvest_Assign_Harvest_Mission_Patch
    mov al, [AutoHarvesting]
    test al, al
    jz .navcom_legal_check
    
    mov eax, [ebp-1Ch] ; this
    ; ====== Inlined operator UnitType() start
        mov edx, [eax+15Ch] ;Class
        add eax, 15Ch ; Class
        cmp edx, 0FFFFFFFFh
        jnz .op_ut_get_ptr

        xor eax, eax
        jmp .op_ut_exit

    .op_ut_get_ptr:
        mov edx, [0x00601830] ; FixedIHeapClass *CCPtr<UnitTypeClass>::Heap
        mov eax, [eax]
        imul eax, [edx+4h]
        mov edx, [edx+10h]
        add eax, edx

    .op_ut_exit:
        mov al, [eax+196h] ; unittype.Type
    ; ====== Inlined operator UnitType() end

    ; *this == UNIT_HARVESTER
    movsx eax, al
    cmp eax, 7 ; UNIT_HARVESTER
    jnz .navcom_legal_check
    
    ; contact != nullptr
    ;mov eax, [ebp-1Ch] ; this
    ;mov eax, [eax+3Ah] ; Radio
    test eax, RadioContact
    test eax, eax
    jz .navcom_legal_check
    
    ; contact->What_Am_I() == RTTI_BUILDING
    ;mov eax, [ebp-1Ch] ; this
    ;mov eax, [eax+3Ah] ; Radio
    ;mov al, [eax] ; this->RTTI
    mov al, [esi] ; Radio
    cmp al, 5 ; RTTI_BUILDING
    jz .navcom_legal_check
    
    mov eax, [ebp-1Ch] ; this
    ;mov eax, [eax+3Ah] ; Radio
    mov eax, RadioContact ; Radio
    ; ====== Inlined operator StructType() start
        mov edx, [eax+0CDh] ;Class
        add eax, 0CDh ; Class
        cmp edx, 0FFFFFFFFh
        jnz .op_bt_get_ptr

        xor eax, eax
        jmp .op_bt_exit

    .op_bt_get_ptr:
        mov edx, [0x0060181C] ; FixedIHeapClass *CCPtr<BuildingTypeClass>::Heap
        mov eax, [eax]
        imul eax, [edx+4h]
        mov edx, [edx+10h]
        add eax, edx

    .op_bt_exit:
        mov al, [eax+1A4h] ; structtype.Type
    ; ====== Inlined operator StructType() end
    
    ; *((BuildingClass*)contact) != STRUCT_REPAIR
    movsx eax, al
    cmp eax, 24 ; STRUCT_REPAIR
    jz .navcom_legal_check
    
    ; Order the unit to begin the harvesting mission.
    mov ebx, [ebp-1Ch] ; this
    mov ebx, [ebx+11h] ; vtable
    mov edx, 9 ; MISSION_HARVEST
    mov eax, [ebp-1Ch] ; this
    call dword [ebx+0FCh] ; Assign_Mission
    
    ; this->Edge_Of_World_AI()
    jmp 0x0057C038
    
.navcom_legal_check:
    ; !Target_Legal(NavCom)
    mov eax, [ebp-1Ch] ; this
    mov eax, [eax+0DFh] ; NavCom
    test eax, eax
    setnz al
    and eax, 0FFh
    jz 0x0057C020 ; scatter the unit
    
    ; Transmit_Message(RADIO_DOCKING)
    jmp 0x0057BF50

@ENDHACK
	