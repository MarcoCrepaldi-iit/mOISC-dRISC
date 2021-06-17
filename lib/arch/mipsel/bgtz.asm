	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec %1, _TMP -> test.%4
	exec _TMP, _TMP -> run.%4
test.%4:	exec _MOVMCR, MCR
			exec %1, _TMP2
			exec _SUBLMCR, MCR
			exec _TMP, _TMP
			exec _TMP, _TMP2 -> run1.%4:
run.%4:	exec _TMP, _TMP -> %2
run1.%4:	exec _TMP, _TMP
_MOVMCR:	238
_SUBLMCR:	255
_TMP:		0
_TMP2:		0