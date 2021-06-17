	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _TMP2, _TMP2
	exec _ZERO, _ZERO
	exec _ZERO, %1 -> test.%4
	exec _TMP, _TMP -> %2
test.%4:	exec _MOVMCR, MCR
	exec %1, _TMP
	exec _SUBLMCR, MCR
	exec _TMP, _TMP2 -> %2
_SUBLMCR:	255
_MOVMCR:	238
_TMP:		0
_TMP2:		0
_ZERO:		0