	exec _MOVMCR, MCR
	exec %3, _TMP
	exec %2, _TMP2
	exec %2, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero.%4
	exec _SHRMCR, MCR
	exec %2, _TMP
	exec _MOVMCR, MCR
	exec _TMP, %1
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit.%4 
negativeOrZero.%4: exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2.%4
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop.%4: exec _SHRMCR, MCR
	exec %3, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, %1
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP 
	exec _TMP, _TMP4 -> loop.%4
exit2.%4: exec _MOVMCR, MCR
	exec %2, %1
exit.%4: exec _SUBLMCR, MCR 
	exec _NULL, _NULL
_SUBLMCR:	255
_MOVMCR:	238
_SHRMCR:	136
_TMP:		0
_TMP2:		0
_TMP4:		0
_TMPZERO:	0
_NEGATIVE:	-32768
_ANDMCR:	102
_ZERO:		0
_ONETMP:	1
_ONECONST:	1
_ORMCR:		119
