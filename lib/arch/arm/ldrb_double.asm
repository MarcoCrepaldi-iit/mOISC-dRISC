	exec _MEMRMCR, MCR
	exec %1, %2
	exec _ANDMCR, MCR
	exec _BMASK, %1
_MOVMCR:	238
_ANDMCR:		102
_BMASK:		255
_MEMMCR:	34
_MEMRMCR:	17
_TMP:		0