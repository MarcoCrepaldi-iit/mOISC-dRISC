	exec _MEMRMCR, MCR
	exec %2, sp
	exec _ADDMCR, MCR
	exec _SPONE, sp
	exec _MEMRMCR, MCR
	exec %1, sp
	exec _ADDMCR, MCR
	exec _SPONE, sp
_ADDMCR:	204
_MEMRMCR:	17
_SPONE:		4


