%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%ifndef __GIT_REVISION__
%define __GIT_REVISION__ "????"
%endif

%ifndef __GIT_COMMIT__
%define __GIT_COMMIT__ "unknown"
%endif

StringZ str_version,  "3.03p r", __GIT_REVISION__, 0x0D, "git~", __GIT_COMMIT__, 0

@HACK 0x00589960 _Version_Name
	mov eax, str_version
	retn
@ENDHACK

