	exec _MOVMCR, MCR
	exec %3, _TMP
	exec _ADDMCR, MCR
	exec %2, _TMP
	exec _MEMRMCR, MCR
	exec %1, _TMP
_MOVMCR:	238
_MEMMCR:	34
_MEMRMCR:	17
_TMP:		0
