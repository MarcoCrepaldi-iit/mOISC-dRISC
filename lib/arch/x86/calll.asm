	exec _PCMCR, MCR
	exec _TMP, isp
	exec _SUBLMCR, MCR
	exec _PCMCR_CALLOFF, isp
	exec _ADDMCR, MCR
	exec _SPMONE, esp
	exec _MEMMCR, MCR
	exec isp, esp
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> %1
_MOVMCR:	238
_PCMCR:		51
_ADDMCR:	204
_SUBLMCR:	255
_TMP:		0
_PCMCR_CALLOFF:	-24
_MEMMCR:	34
_MEMRMCR:	17
_SPMONE:	-4
