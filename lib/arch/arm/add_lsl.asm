	exec _MOVMCR, MCR
	exec %4, _TMPS
	exec _SHLMCR, MCR
	exec %3, _TMPS
	exec _ADDMCR, MCR
	exec %2, _TMPS
	exec _MOVMCR, MCR
	exec _TMPS, %1
_MOVMCR:	238
_ADDMCR:	204
_SHLMCR:	153
_TMPS:		0


