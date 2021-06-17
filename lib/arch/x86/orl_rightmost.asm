	exec _SUBLMCR, MCR
	exec _TMPy, _TMPy
	exec _ADDMCR, MCR
	exec %3, _TMPy
	exec %2, _TMPy
	exec _MEMRMCR, MCR
	exec _OP, _TMPy
	exec _MOVMCR, MCR
	exec %1, _TMP
	exec _ORMCR, MCR
	exec _OP, _TMP
	exec _MEMMCR, MCR
	exec _TMP, _TMPy
_MOVMCR:		238
_ORMCR:		119
_SUBLMCR:	255
_ADDMCR:	204
_MEMRMCR:	17
_MEMMCR:	34
_ZERO:		0
_TMP:		0
_OP:		0
_TMPy:		0