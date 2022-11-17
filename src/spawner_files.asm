%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "macros/datatypes.inc"

extern __imp__GetCommandLineA
extern _stristr_
extern str_spawn_arg


gstring str_spawn_xdp, "SPAWN.XDP"
gstring str_spawnam_xdp, "SPAWNAM.XDP"

sstring str_mmm_ext, ".MMM"

@HACK 0x004F420D, _Init_Game_AFTRMATH_INI_File
    mov edx, 0x005EBB45 ; "AFTRMATH.INI"
    pushad
  
    call [__imp__GetCommandLineA]
    mov edx, str_spawn_arg
    call _stristr_
    test eax,eax
    popad
    jz .No_Spawner_AFTRMATH_INI_File
    mov edx, str_spawnam_xdp
    
.No_Spawner_AFTRMATH_INI_File:    
    jmp 0x004F4212
@ENDHACK

@HACK 0x0053A3E8, _Read_Scenario_Dont_Load_MPLAYER_INI_With_Spawner_Active
    pushad

    call [__imp__GetCommandLineA]

    mov edx, str_spawn_arg
    call _stristr_
    test eax,eax
    
    popad
    jne .Dont_Load_MPlayer_INI
    jmp .Ret
    
.Dont_Load_MPlayer_INI:
    jmp 0x0053A568
    
.Ret:
    test edx, edx
    jz 0x0053A568
    jmp 0x0053A3EE
@ENDHACK


@HACK 0x004F4197,  _Init_Game_RULES_File 
    CALL    0x00547810 ; SmudgeTypeClass::Init_Heap(void)
        
    pushad
    
    call [__imp__GetCommandLineA]

    MOV EDX, str_spawn_arg
    CALL _stristr_
    TEST EAX,EAX
    
    JE .Ret_RULES_INI
    
    popad
    mov     edx, str_spawn_xdp
    jmp     0x004F41A1
    
.Ret_RULES_INI:
    popad
    jmp     0x004F419C
@ENDHACK


@HACK 0x0054C013, _SessionClass__Read_Scenario_Descriptions_Map_Extension

    call [__imp__GetCommandLineA]

    mov EDX, str_spawn_arg
    call _stristr_
    test EAX,EAX
    
    je .Ret_MPR_extension
    
    push str_mmm_ext ; ".MMM"
    jmp 0x0054C018
    
.Ret_MPR_extension:
    push 0x005F0798 ; ".MPR"
    jmp 0x0054C018
@ENDHACK