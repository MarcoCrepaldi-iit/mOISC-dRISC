	exec _ADDMCR, MCR
	exec _SPMONE, esp
	exec _MEMMCR, MCR
	exec %1, esp
_ADDMCR:	204
_MEMMCR:	34
_SPMONE:	-4
