	exec _MOVMCR, MCR
	exec %1, _TMP2
	exec %2, _TMP3
	exec _ZERO, _OP
loop.%4: exec _ADDMCR, MCR 
	exec _OP, _TMP3
	exec _SUBLMCR, MCR
	exec _ONE, _TMP2 -> exit.%4
	exec _NULL, _NULL -> loop.%4
exit.%4: exec _MOVMCR, MCR
	exec _TMP3, %3
_SUBLMCR:	255
_ADDMCR:	204
_MEMRMCR:	17
_ZERO:		0
_TMP:		0
_TMP2:		0
_OP:		0
_ONE:		1