	exec _MOVMCR, MCR
	exec _KILLEAX, _TMP
	exec _ANDMCR, MCR
	exec eax, _TMP
	exec _MOVMCR, MCR
	exec _TMP, al
_MOVMCR:	238
_ANDMCR:	102
_TMP:		0
_KILLEAX: 	255


