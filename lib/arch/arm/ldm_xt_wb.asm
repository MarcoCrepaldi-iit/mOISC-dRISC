	exec _MEMRMCR, MCR
	exec %2, %1
	exec _ADDMCR, MCR
	exec _AUTOINC, %1
_ADDMCR:	204
_MEMRMCR:	17
_AUTOINC:	4
