%1:		exec _MOVMCR, MCR
		exec esp, _TMP
		exec _SUBLMCR, MCR
		exec _DUMMYOFF, _TMP
		exec _MEMRMCR, MCR
		exec _TMP2, _TMP
		exec _MOVMCR, MCR
		exec _TMP2, CSR
		exec _SUBLMCR, MCR
		exec _TMP, _TMP
_MOVMCR:	238
_MEMRMCR:	17
_TMP:		0
_TMP2:		0
_DUMMYOFF:	-4