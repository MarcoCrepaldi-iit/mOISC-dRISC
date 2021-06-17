	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _MOVMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _ZERO, _MULT
	exec %4, _TMP2
	exec %5, _TMP3
loop.%6: exec _ADDMCR, MCR 
	exec _TMP2, _MULT
	exec _SUBLMCR, MCR
	exec _ONE, _TMP3 -> exit.%6
	exec _NULL, _NULL -> loop.%6
exit.%6: exec _ADDMCR, MCR
	exec _TMP, _MULT
	exec _MEMMCR, MCR
	exec %1, _MULT
_SUBLMCR:	255
_ADDMCR:	204
_MEMMCR:	34
_ZERO:		0
_TMP:		0
_TMP2:		0
_TMP3:		0
_ONE:		1
_MULT:		0
