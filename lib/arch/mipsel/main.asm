	exec _PCMCR, MCR
	exec _TMP1, $ra
	exec _SUBLMCR, MCR
	exec _PCMCR_MAINRET, $ra
	exec _SUBLMCR, MCR
	exec _TMP1, _TMP1 -> main
_SUBLMCR:	255
_PCMCR:		51
_TMP1:		0
_PCMCR_MAINRET:	-12