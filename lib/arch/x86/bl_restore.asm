	exec _MOVMCR, MCR
	exec _RESTORE_EBX, _TMP
	exec _NEGATIVE, _TMPN
	exec _ANDMCR, MCR
	exec ebx, _TMP
	exec ebx, _TMPN
	exec _ORMCR, MCR
	exec _TMPN, _TMP
	exec bl, _TMP
	exec _MOVMCR, MCR
	exec _TMP, ebx
_MOVMCR:	238
_ANDMCR:	102
_ORMCR:		119
_TMP:		0
_TMPN:		0
_RESTORE_EBX: 	32512
_NEGATIVE:	-32768