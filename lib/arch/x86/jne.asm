	exec _ANDMCR, MCR
	exec _CMP_EQUAL, _RESULT -> %1
_ANDMCR:	102
_CMP_EQUAL:	8
#
#
#
#	exec _MOVMCR, MCR
#	exec _ISEQUAL, _TMP
#	exec _SUBLMCR, MCR
#	exec _TMP2, _TMP2
#	exec _TMP2, _TMP -> %1
#_SUBLMCR:	255
#_MOVMCR:	238
#_NULL:		0
#_TMP:		0
#_TMP2:		0
#_ZERO:		0