	exec _PCMCR, MCR
	exec _TMP1, lr
	exec _SUBLMCR, MCR
	exec _PCMCR_MAINRET, lr
	exec _SUBLMCR, MCR
	exec _TMP1, _TMP1 -> _main
_SUBLMCR:	255
_PCMCR:		51
_TMP1:		0
_PCMCR_MAINRET:	-12
_THUMB:		0