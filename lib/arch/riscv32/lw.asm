	exec _MOVMCR, MCR
	exec %3, _ADDR
	exec %2, _TMP
	exec _ADDMCR, MCR
	exec _TMP, _ADDR
	exec _MEMRMCR, MCR
	exec %1, _ADDR
_MOVMCR:	238
_ADDMCR:	204
_MEMRMCR:	17
_TMP:		0
_ADDR:		0


