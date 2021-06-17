	exec _MOVMCR, MCR
	exec %4, _TMPS
	exec %4, _C
	exec _SHRMCR, MCR
	exec %3, _TMPS
	exec _MOVMCR, MCR
	exec _TMPS, _TMP
	exec _ANDMCR, MCR
	exec %2, _TMP
	exec _ONE, _C
	exec _MOVMCR, MCR
	exec _TMP, %1
_MOVMCR:		238
_ANDMCR:		102
_SHRMCR:		136
_TMP:			0
_TMPS:			0
_C:				0
_ONE:			1
