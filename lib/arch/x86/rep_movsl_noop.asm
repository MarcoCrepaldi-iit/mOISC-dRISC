	exec _MOVMCR, MCR
	exec ecx, _ECX
	exec _ZERO, _TMP
	exec esi, _ESI
	exec es, _ES
	exec edi, _EDI
	exec _ES, _OFF
loop.%4: exec _MEMRMCR, MCR
	exec _TMP2, _ESI
	exec _ADDMCR, MCR
	exec _OFF, _EDI
	exec _MEMMCR, MCR
	exec _TMP2, _EDI
	exec _ADDMCR, MCR
	exec _CONSTFOUR, _ESI
	exec _CONSTMFOUR, _EDI	
	exec _SUBLMCR, MCR
	exec _ONECONST, _ECX -> exitloop.%4
	exec _NULL, _NULL -> loop.%4
exitloop.%4: exec _MOVMCR, MCR
	exec _EDI, edi
	exec _ESI, esi
	exec _ECX, ecx
_MEMMCR:	34
_MEMRMCR:	17
_ADDMCR:	204
_SUBLMCR:	255
_MOVMCR:	238
_TMP:		0
_TMP2:		0
_ZERO:		0
_CONSTFOUR:	4
_CONSTMFOUR:	4
_ONECONST:	1
_ESI:		0
_ES:		0
_EDI:		0
_ECX:		0
_OFF:		0
