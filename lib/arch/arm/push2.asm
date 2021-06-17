	exec _ADDMCR, MCR
	exec _SPMONE, sp
	exec _MEMMCR, MCR
	exec %1, sp
	exec _ADDMCR, MCR
	exec _SPMONE, sp
	exec _MEMMCR, MCR
	exec %2, sp
_ADDMCR:	204
_MEMMCR:	34
_SPMONE:	-4
