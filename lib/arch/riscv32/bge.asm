	exec _MOVMCR, MCR
	exec %1, _TMP
	exec %2, _TMP2
	exec _SUBLMCR, MCR
	exec _TMP2, _TMP -> test.%4
	exec _TMP, _TMP -> %3
test.%4:	exec _MOVMCR, MCR
			exec %1, _TMP
			exec %2, _TMP2
			exec _SUBLMCR, MCR
			exec _TMP, _TMP2 -> %3
_MOVMCR:	238
_SUBLMCR:	255
_TMP:		0
_TMP2:		0
