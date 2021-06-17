	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _SUBLMCR, MCR
	exec %1, _TMP
	exec _MOVMCR, MCR
	exec CHR, _RESULT
	exec _ANDMCR, MCR
	exec _CMP_SMALLER, _RESULT -> nomovlt.%4
	exec _MOVMCR, MCR
	exec %2, %1
nomovlt.%4: exec _SUBLMCR, MCR
	exec _NULL, _NULL
_NULL:		0
_ANDMCR:	102
_MOVMCR:	238
_SUBLMCR:	255
_CMP_SMALLER:	4
_TMP:		0
