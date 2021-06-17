	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _ADDMCR, MCR
	exec %3, _TMP
	exec %2, _TMP
	exec _MEMMCR, MCR
	exec %1, _TMP
_SUBLMCR:	255
_ADDMCR:	204
_MEMMCR:	34
_ZERO:		0
_TMP:		0
