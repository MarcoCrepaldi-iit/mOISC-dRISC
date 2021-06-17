	exec _MOVMCR, MCR
	exec %3, _TMP
	exec _XORMCR, MCR
	exec _NOTMASK, _TMP
	exec _ANDMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %1
_SUBLMCR:		255
_MOVMCR:		238
_ANDMCR:		102
_XORMCR:		85
_TMP:			0
_TMP2:			0
_TMP3:			0
_ZERO:			0
_NULL:			0
_NOTMASK:		32767