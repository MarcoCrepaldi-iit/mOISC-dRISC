	exec _MOVMCR, MCR
	exec %4, _TMPS
	exec _SHLMCR, MCR
	exec %3, _TMPS
	exec _ADDMCR, MCR
	exec %2, _TMPS
	exec _MEMMCR, MCR
#	exec _TMPS, %1
	exec %1, _TMPS
_MOVMCR:	238
_ADDMCR:	204
_MEMMCR:	34
_SHLMCR:	153
_TMPS:		0


