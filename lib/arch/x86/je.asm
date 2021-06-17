	exec _ANDMCR, MCR
	exec _CMP_EQUAL, _RESULT -> isNotEq.%4
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> %1
isNotEq.%4: 	exec _SUBLMCR, MCR
				exec _NULL, _NULL
_ANDMCR:	102
_SUBLMCR:	255
_CMP_EQUAL:	8
_NULL:		0
#
#
#
#	exec _MOVMCR, MCR
#	exec _ISEQUAL, _TMP
#	exec _SUBLMCR, MCR
#	exec _TMP2, _TMP2
#	exec _TMP2, _TMP -> noequal.%4
#	exec _NULL, _NULL -> %1
#noequal.%4: exec _NULL, NULL
#_SUBLMCR:	255
#_MOVMCR:	238
#_NULL:		0
#_TMP:		0
#_TMP2:		0
#_ZERO:		0