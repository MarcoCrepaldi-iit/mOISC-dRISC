	exec _MOVMCR, MCR
	exec %3, _TMP
	exec _ANDMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:		238
_ANDMCR:		102
_TMP:			0