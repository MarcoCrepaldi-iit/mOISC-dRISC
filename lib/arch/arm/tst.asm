	exec _MOVMCR, MCR
	exec %2, _OP2
	exec %1, _OP1
	exec _ANDMCR, MCR
	exec _OP1, _OP2
	exec _MOVMCR, MCR
	exec _OP2, _RESULT
	exec _SUBLMCR, MCR
	exec _ZERO, _RESULT -> setZflag.%4
	exec _MOVMCR, MCR
	exec _ZERO, _RESULT
	exec _SUBLMCR, MCR	
	exec _NULL, _NULL -> run.%4
setZflag.%4: exec _MOVMCR, MCR
	exec _CMP_EQUAL, _RESULT
run.%4: exec _SUBLMCR, MCR	
	exec _NULL, _NULL
_MOVMCR:	238
_ANDMCR:	102
_SUBLMCR:	255
_CMP_EQUAL:	8
_RESULT:	0
_NULL:		0
_ZERO:		0
_OP1:		0
_OP2:		0
#
#
#
#	exec _MOVMCR, MCR
#	exec %2, _OP2
#	exec %1, _OP1
#	exec _ANDMCR, MCR
#	exec _OP1, _OP2
#	exec _MOVMCR, MCR
#	exec _OP2, _RESULT
#	exec _SUBLMCR, MCR
#	exec _ZERO, _RESULT -> setZflag.%4
#	exec _MOVMCR, MCR
#	exec _ZERO, _ISEQUAL
#	exec _SUBLMCR, MCR	
#	exec _NULL, _NULL -> run.%4
#setZflag.%4: exec _MOVMCR, MCR
#	exec _ONE, _ISEQUAL
#run.%4: exec _SUBLMCR, MCR	
#	exec _NULL, _NULL
#_MOVMCR:	238
#_ANDMCR:	102
#_SUBLMCR:	255
#_OP1:		0
#_OP2:		0
#_RESULT:	0
#_ZERO:		0
#_ISEQUAL:	0
#_ONE:		1
