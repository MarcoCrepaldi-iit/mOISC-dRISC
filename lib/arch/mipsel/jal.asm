	exec _PCMCR, MCR
	exec _TMP1, $ra
	exec _SUBLMCR, MCR
	exec _PCMCR_FOUR, $ra
	exec _SUBLMCR, MCR
	exec _TMP1, _TMP1 -> %1
_PCMCR:		51
_SUBLMCR:	255
_TMP:		0
_TMP1:		0
_PCMCR_FOUR:		-12
