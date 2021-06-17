	exec _ANDMCR, MCR
	exec _CMP_SMALLER, _RESULT -> isNotLower.%4
	exec _MOVMCR, MCR
	exec _ONE, %1
isNotLower.%4: 	exec _SUBLMCR, MCR
				exec _NULL, _NULL
_ANDMCR:	102
_SUBLMCR:	255
_CMP_SMALLER:	4
_NULL:		0
_ONE:		1
#
#
#
#	exec _MOVMCR, MCR
#	exec _ISMINOR, _TMP
#	exec _SUBLMCR, MCR
#	exec _TMP2, _TMP2
#	exec _TMP2, _TMP -> nolower.%4
#	exec _NULL, _NULL -> %1
#nolower.%4: exec _NULL, NULL
#_SUBLMCR:	255
#_MOVMCR:	238
#_NULL:		0
#_TMP:		0
#_TMP2:		0
#_ZERO:		0