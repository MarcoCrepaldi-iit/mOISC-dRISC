	exec _SUBLMCR, MCR
	exec _TMP, _TMP
	exec _ADDMCR, MCR
	exec %1, _TMP
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _ZERO, _MULT
	exec %3, _TMP2
	exec %4, _TMP3
loop.%6: exec _ADDMCR, MCR 
	exec _TMP2, _MULT
	exec _SUBLMCR, MCR
	exec _ONE, _TMP3 -> exit.%6
	exec _NULL, _NULL -> loop.%6
exit.%6: exec _ADDMCR, MCR
	exec _TMP, _MULT
	exec _MOVMCR, MCR
	exec _MULT, %5
_SUBLMCR:	255
_ADDMCR:	204
_MOVMCR:	238
_ZERO:		0
_TMP:		0
_TMP2:		0
_TMP3:		0
_ONE:		1
_MULT:		0
#
#	exec _SUBLMCR, MCR
#	exec _TMP, _TMP
#	exec _ADDMCR, MCR
#	exec %1, _TMP
#	exec %2, _TMP
#	exec _MOVMCR, MCR
#	exec _TMP, %3
#_SUBLMCR:	255
#_ADDMCR:	204
#_MEMRMCR:	17
#_MOVMCR:	238
#_TMP:		0
