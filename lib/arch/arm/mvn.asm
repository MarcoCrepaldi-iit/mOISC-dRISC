	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _XORMCR, MCR
	exec _NOTMASK, _TMP
	exec _NOTMASK2, _TMP	
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:		238
_XORMCR:		85
_TMP:			0
_NOTMASK:		32767
_NOTMASK2:		-32768