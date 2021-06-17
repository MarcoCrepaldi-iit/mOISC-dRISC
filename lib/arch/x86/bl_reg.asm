	exec _MOVMCR, MCR
	exec _KILLEBX, _TMP
	exec _ANDMCR, MCR
	exec ebx, _TMP
	exec _MOVMCR, MCR
	exec _TMP, bl
_MOVMCR:	238
_ANDMCR:	102
_TMP:		0
_KILLEBX: 	255


