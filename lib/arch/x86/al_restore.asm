	exec _MOVMCR, MCR
	exec _RESTORE_EAX, _TMP
	exec _NEGATIVE, _TMPN
	exec _ANDMCR, MCR
	exec eax, _TMP
	exec eax, _TMPN
	exec _ORMCR, MCR
	exec _TMPN, _TMP
	exec al, _TMP
	exec _MOVMCR, MCR
	exec _TMP, eax
_MOVMCR:	238
_ANDMCR:	102
_ORMCR:		119
_TMP:		0
_TMPN:		0
_RESTORE_EAX: 	32512
_NEGATIVE:	-32768


