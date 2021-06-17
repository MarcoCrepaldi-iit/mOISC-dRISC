	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _ADDMCR, MCR
	exec %1, _TMP
	exec %2, _TMP
	exec _MEMRMCR, MCR
	exec %3, _TMP
_SUBLMCR:	255
_ADDMCR:	204
_MEMRMCR:	17
_ZERO:		0
_TMP:		0

