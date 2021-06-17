	exec _MOVMCR, MCR
	exec _RESTORE_EDX, _TMP
	exec _NEGATIVE, _TMPN
	exec _ANDMCR, MCR
	exec edx, _TMP
	exec edx, _TMPN
	exec _ORMCR, MCR
	exec _TMPN, _TMP
	exec dl, _TMP
	exec _MOVMCR, MCR
	exec _TMP, edx
_MOVMCR:	238
_ANDMCR:	102
_ORMCR:		119
_TMP:		0
_TMPN:		0
_RESTORE_EDX: 	32512
_NEGATIVE:	-32768