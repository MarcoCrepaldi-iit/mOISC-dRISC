	exec _MOVMCR, MCR
	exec %4, _TMP
	exec _SHLMCR, MCR
	exec %3, _TMP
	exec _ADDMCR, MCR
	exec %2, _TMP
	exec _MEMRMCR, MCR
	exec %1, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %2
_MOVMCR:	238
_ADDMCR:	204
_MEMRMCR:	17
_SHLMCR:	153
_TMPS:		0
_TMP:		0
_TMP2:		0
