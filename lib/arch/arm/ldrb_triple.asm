	exec _MOVMCR, MCR
	exec %3, _TMP2
	exec _ADDMCR, MCR
	exec %2, _TMP2
	exec _MEMRMCR, MCR
	exec %1, _TMP2
	exec _ANDMCR, MCR
	exec _BMASK, %1
_MOVMCR:	238
_ANDMCR:		102
_BMASK:		255
_MEMMCR:	34
_MEMRMCR:	17
_TMP:		0
