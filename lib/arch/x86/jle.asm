	exec _ANDMCR, MCR
	exec _CMP_EQUAL_SMALLER, _RESULT -> isNotLowerEq.%4
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> %1
isNotLowerEq.%4: 	exec _SUBLMCR, MCR
					exec _NULL, _NULL
_ANDMCR:	102
_SUBLMCR:	255
_CMP_EQUAL_SMALLER: 12
_NULL:		0
#
#
#
#	exec _MOVMCR, MCR
#	exec _ISEQUAL, _TMP
#	exec _SUBLMCR, MCR
#	exec _TMP2, _TMP2
#	exec _TMP2, _TMP -> isnotequal.%4
#	exec _NULL, _NULL -> %1
#isnotequal.%4: exec _MOVMCR, MCR
#	exec _ZERO, _TMP2
#	exec _ISMINOR, _TMP
#	exec _SUBLMCR, MCR
#	exec _TMP2, _TMP -> isnotminor.%4
#	exec _NULL, _NULL -> %1
#isnotminor.%4: exec _NULL, NULL
#_SUBLMCR:	255
#_MOVMCR:	238
#_NULL:		0
#_TMP:		0
#_TMP2:		0
#_ZERO:		0