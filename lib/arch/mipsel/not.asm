	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _XNORMCR, MCR
	exec _ZERO, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:		238
_XNORMCR:		68
_TMP:			0
_ZERO:			0