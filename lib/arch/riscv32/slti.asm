	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _SUBLMCR, MCR
	exec %3, _TMP -> isn.%4
s0.%4:	exec _MOVMCR, MCR
	exec _ZERO, %1
	exec _SUBLMCR, MCR
	exec _ZERO, _ZERO -> run.%4
isn.%4: exec _MOVMCR, MCR
	exec %3, _TMP
	exec _SUBLMCR, MCR
	exec %2, _TMP -> s0.%4
	exec _MOVMCR, MCR
	exec _ONE, %1
	exec _SUBLMCR, MCR
run.%4:	exec _TMP, _TMP
_SUBLMCR:	255
_MOVMCR:	238
_TMP:		0
_ONE:		1
_ZERO:		0


