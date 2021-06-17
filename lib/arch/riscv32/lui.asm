	exec _MOVMCR, MCR
	exec _SIXTEEN, _TMP
	exec _SHLMCR, MCR
	exec %2, _TMP	
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:	238
_SHLMCR:	153
_TMP: 		0
_SIXTEEN:	16