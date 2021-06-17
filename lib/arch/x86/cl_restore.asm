	exec _MOVMCR, MCR
	exec _RESTORE_ECX, _TMP
	exec _NEGATIVE, _TMPN
	exec _ANDMCR, MCR
	exec ecx, _TMP
	exec ecx, _TMPN
	exec _ORMCR, MCR
	exec _TMPN, _TMP
	exec cl, _TMP
	exec _MOVMCR, MCR
	exec _TMP, ecx
_MOVMCR:	238
_ANDMCR:	102
_ORMCR:		119
_TMP:		0
_TMPN:		0
_RESTORE_ECX: 	32512
_NEGATIVE:	-32768