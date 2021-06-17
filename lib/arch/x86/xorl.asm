	exec _MOVMCR, MCR
	exec %1, _TMP
	exec _XORMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %2
_MOVMCR:		238
_XORMCR:		85
_TMP:			0