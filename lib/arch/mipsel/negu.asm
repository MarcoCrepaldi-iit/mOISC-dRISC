	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _SUBLMCR, MCR
	exec _TMP2, _TMP2
	exec _TMP, _TMP2
	exec _MOVMCR, MCR
	exec _TMP2, %1	
_SUBLMCR:	255
_MOVMCR:	238
_TMP:		0
_TMP2:		0