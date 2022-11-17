%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "ini.inc"
%include "macro.inc"

%define EXT_SpawnLocation 			0x17B4

extern str_multi1
extern str_multi2
extern str_multi3
extern str_multi4
extern str_multi5
extern str_multi6
extern str_multi7
extern str_multi8
extern str_SpawnLocations

extern multi1_spawn
extern multi2_spawn
extern multi3_spawn
extern multi4_spawn
extern multi5_spawn
extern multi6_spawn
extern multi7_spawn
extern multi8_spawn


; Save spawn location in EXTENDED HouseClass so we can dump this info for statistics
@HACK 0x0053E6B0, _Create_Units_Save_Spawn_Location_In_HouseClass
	xor eax, eax ; just to be sure
	mov ax, [ebp-0x30] ; SpawnLocation
	mov dword [esi+EXT_SpawnLocation], eax

.Ret:
	mov eax, [ebp-0x1C]
	and eax, 7Fh
	jmp 0x0053E6B6
@ENDHACK

@HACK 0x0053E534, _Create_Units_First_Spawn_Save_Waypoint_number_In_ECX
    mov ecx, eax
    jmp 0x0053E6A9
@ENDHACK

;@HACK 0x0053DDEB, _Read_Scenario_INI_Spawn_Locations
;	push eax
;	pushad
;	
;	lea esi, [ebp-140]
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi1, -1
;	mov dword [multi1_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi2, -1
;	mov dword [multi2_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi3, -1
;	mov dword [multi3_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi4, -1
;	mov dword [multi4_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi5, -1
;	mov dword [multi5_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi6, -1
;	mov dword [multi6_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi7, -1
;	mov dword [multi7_spawn], eax
;	
;	INI_Get_Int_ esi, str_SpawnLocations, str_multi8, -1
;	mov dword [multi8_spawn], eax
;	
;	popad
;	pop eax
;	call 0x0053E204 ; Create_Units(int)
;	jmp 0x0053DDF0
;@ENDHACK	

@HACK 0x0053E6A9, _Create_Units_Spawn_Location
; [ebp-0x30] is spawn location local variable
	mov ebx, dword [ebp-0x1B]
	sar ebx, 18h
	cmp dword ebx, 0x0c
	je .Spawn_Multi1
	
	cmp dword ebx, 0x0d
	je .Spawn_Multi2
	
	cmp dword ebx, 0x0e
	je .Spawn_Multi3
	
	cmp dword ebx, 0x0f
	je .Spawn_Multi4
	
	cmp dword ebx, 0x10
	je .Spawn_Multi5
	
	cmp dword ebx, 0x11
	je .Spawn_Multi6
	
	cmp dword ebx, 0x12
	je .Spawn_Multi7
	
	cmp dword ebx, 0x13
	je .Spawn_Multi8
	
.Ret:
	mov eax, dword [ebp-0x30]
	mov word [ebp-0x1C], ax
	jmp 0x0053E6B0
	
.Spawn_Multi1:
	mov eax, dword [multi1_spawn]
	
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0

.Spawn_Multi2:
	mov eax, dword [multi2_spawn]
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi3:
	mov eax, dword [multi3_spawn]
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi4:
	mov eax, dword [multi4_spawn]
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi5:
	mov eax, dword [multi5_spawn]
	
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
    
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi6:
	mov eax, dword [multi6_spawn]
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi7:
	mov eax, dword [multi7_spawn]
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	
	xor edi, edi
	mov word di, [eax]
	mov eax, edi
	
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
	
.Spawn_Multi8:
	mov eax, dword [multi8_spawn]
	
	cmp eax, dword -1
	jz .Ret
    
    ; Fix up "used spawn locations" local array
    mov dword [ebp+ecx*4-0x1BC], 0 ; Set previously game selected spawn location as free
    mov dword [ebp+eax*4-0x1BC], 1 ; Set the spawn location we just loaded from the ini as used
	
	add eax, eax
	add eax, 2
	add eax, 0x006678F5 ; Waypoints
	xor edi, edi
	mov WORD di, [eax]
	mov eax, edi
	mov dword [ebp-0x30], eax
	jmp 0x0053E6B0
@ENDHACK