	exec _MOVMCR, MCR
	exec %1, _TMP
	exec _ADDMCR, MCR
	exec %2, _TMP
	exec _MEMRMCR, MCR	
	exec _OP, _TMP
	exec _MOVMCR, MCR
	exec %3, _RESULT
	exec _SUBLMCR, MCR
	exec _OP, _RESULT
	exec _MOVMCR, MCR
	exec CHR, _RESULT
_MOVMCR:	238
_SUBLMCR:	255
_MEMRMCR:	17
_ADDMCR:	204
_RESULT:	0
_OP:		0
_TMP:		0
#
#
#
#	exec _SUBLMCR, MCR
#	exec _TMP, _TMP
#	exec _ADDMCR, MCR
#	exec %1, _TMP
#	exec %2, _TMP
#	exec _MEMRMCR, MCR
#	exec _OP, _TMP
#	exec _MOVMCR, MCR
#	exec _OP, _OP1
#	exec %3, _OP2
#	exec _ZERO, _TMP
#	exec _OP2, _OP2SAVE
#	exec _OP1, _OP1SAVE
#	exec _SUBLMCR, MCR
#	exec _OP1, _OP2SAVE -> isloweq.%4
#	exec _MOVMCR, MCR
#	exec _ONE, _ISGREATER
#	exec _ZERO, _ISEQUAL
#	exec _ZERO, _ISMINOR
#	exec _SUBLMCR, MCR
#	exec _NULL, _NULL -> run.%4
#isloweq.%4:	exec _SUBLMCR, MCR
#	exec _OP2, _OP1SAVE -> iseq.%4
#	exec _MOVMCR, MCR
#	exec _ONE, _ISMINOR
#	exec _ZERO, _ISEQUAL
#	exec _ZERO, _ISGREATER
#	exec _SUBLMCR, MCR
#	exec _NULL, NULL -> run.%4
#iseq.%4: exec _MOVMCR, MCR
#	exec _ZERO, _ISGREATER
#	exec _ONE, _ISEQUAL
#	exec _ZERO, _ISMINOR
#	exec _SUBLMCR, MCR
#run.%4:	exec _NULL, _NULL
#_MOVMCR:	238
#_SUBLMCR:	255
#_TMP:		0
#_OP:		0
#_OP1:		0
#_OP2:		0
#_OP1SAVE:	0
#_OP2SAVE:	0
#_ONE:		1
#_ZERO:		0
#_ISGREATER:	0
#_ISEQUAL:	0
#_ISMINOR:	0
#_ADDMCR:	204
#_MEMRMCR:	17
#_MEMMCR:	34
#_TMPy:		0
