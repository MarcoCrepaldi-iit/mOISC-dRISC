	exec _MOVMCR, MCR
	exec %1, _TMP2
	exec _MEMRMCR, MCR
	exec _TMP3, _TMP2
	exec _PCSMCR, MCR
	exec _TMP1, _TMP2
_MOVMCR:	238
_MEMRMCR:	17
_PCSMCR:	0
_TMP1:		0
_TMP2:		0
_TMP3:		0