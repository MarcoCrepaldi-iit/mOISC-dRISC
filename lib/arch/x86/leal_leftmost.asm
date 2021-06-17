	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _ADDMCR, MCR
	exec %1, _TMP
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %3
_SUBLMCR:	255
_ADDMCR:	204
_MEMRMCR:	17
_MOVMCR:	238
_TMP:		0
