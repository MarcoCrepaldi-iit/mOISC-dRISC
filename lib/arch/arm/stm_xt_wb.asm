	exec _MEMMCR, MCR
	exec %2, %1
	exec _ADDMCR, MCR
	exec _AUTOINC, %1
_ADDMCR:	204
_MEMMCR:	34
_AUTOINC:	4
