	exec _MOVMCR, MCR
	exec %3, _TMP
	exec _ORMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:	238
_ORMCR:		119
_TMP:		0