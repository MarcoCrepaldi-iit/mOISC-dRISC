	exec _MOVMCR, MCR
	exec %2, _OP2
	exec %1, _OP1
	exec _ZERO, _TMP
	exec _ANDMCR, MCR
	exec _OP1, _OP2
	exec _MOVMCR, MCR
	exec _OP2, _RESULT
	exec _SUBLMCR, MCR
	exec _ZERO, _RESULT -> isNegOrZero.%4
	exec _MOVMCR, MCR
	exec _CMP_EQUAL, _RESULT
	exec _SUBLMCR, MCR	
	exec _NULL, _NULL -> run.%4
isNegOrZero.%4:	exec _SUBLMCR, MCR
	exec _RESULT, _TMP -> setZflag.%4
	exec _SUBLMCR, MCR	
	exec _NULL, _NULL -> run.%4
setZflag.%4:	exec _MOVMCR, MCR
	exec _CMP_NEQUAL, _RESULT
run.%4: exec _SUBLMCR, MCR	
	exec _NULL, _NULL
_MOVMCR:	238
_ANDMCR:	102
_SUBLMCR:	255
_ORMCR:		119
_CMP_EQUAL:	8
_CMP_NEQUAL: 6
_UNSET_ZF:	251
_RESULT_B:	0
_RESULT:	0
_NULL:		0
_ZERO:		0
_OP1:		0
_OP2:		0
_TMP:		0
#
#	exec _MOVMCR, MCR
#	exec %2, _RESULT
#	exec _SUBLMCR, MCR
#	exec %1, _RESULT
#	exec _MOVMCR, MCR
#	exec CHR, _RESULT
#_MOVMCR:	238
#_SUBLMCR:	255
#_RESULT:	0
#
#
#
#	exec _MOVMCR, MCR
#	exec %1, _OP1
#	exec %2, _OP2
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
#_OP1:		0
#_OP2:		0
#_OP1SAVE:	0
#_OP2SAVE:	0
#_ONE:		1
#_ZERO:		0
#_ISGREATER:	0
#_ISEQUAL:	0
#_ISMINOR:	0
