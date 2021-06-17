	exec _MOVMCR, MCR
	exec _KILLECX, _TMP
	exec _ANDMCR, MCR
	exec ecx, _TMP
	exec _MOVMCR, MCR
	exec _TMP, cl
_MOVMCR:	238
_ANDMCR:	102
_TMP:		0
_KILLECX: 	255


