	exec _MEMMCR, MCR
	exec %1, _TMP
	exec _ADDMCR, MCR
	exec _AUTOINC, _TMP
_ADDMCR:	204
_MEMMCR:	34
_AUTOINC:	4
