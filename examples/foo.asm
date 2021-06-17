MCR:		255
CHR:		0
IWR:		0
ICR:		0
CSR:		0
ISR:		0
IDR:		0
IOR:		0
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> main
memcpy:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_2_memcpy, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_memcpy, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_memcpy, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_0_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_2_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_10_memcpy, _TMP
	exec _MOVMCR, MCR
	exec Var_10_memcpy, Var_11_memcpy
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_11_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_12_memcpy, _TMP
	exec _MOVMCR, MCR
	exec Var_12_memcpy, Var_13_memcpy
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_13_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_14_memcpy
Label_14_memcpy:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_15_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_16_memcpy, _TMP
	exec _MOVMCR, MCR
	exec Var_15_memcpy, Var_17_memcpy
	exec _SUBLMCR, MCR
	exec Var_16_memcpy, Var_17_memcpy
	exec _MOVMCR, MCR
	exec CHR, Var_17_memcpy
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_17_memcpy -> Label_31_memcpy
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_18_memcpy
Label_18_memcpy:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_19_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_20_memcpy, _TMP
	exec _MOVMCR, MCR
	exec Var_20_memcpy, Var_21_memcpy
	exec _MOVMCR, MCR
	exec Var_19_memcpy, _TMP
	exec _ADDMCR, MCR
	exec Var_21_memcpy, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_22_memcpy
	exec _MEMRMCR, MCR
	exec Var_23_memcpy, Var_22_memcpy
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_24_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_25_memcpy, _TMP
	exec _MOVMCR, MCR
	exec Var_25_memcpy, Var_26_memcpy
	exec _MOVMCR, MCR
	exec Var_24_memcpy, _TMP
	exec _ADDMCR, MCR
	exec Var_26_memcpy, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_27_memcpy
	exec _MEMMCR, MCR
	exec Var_23_memcpy, Var_27_memcpy
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_28_memcpy
Label_28_memcpy:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_29_memcpy, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_30_memcpy
	exec _ADDMCR, MCR
	exec Var_29_memcpy, Var_30_memcpy
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_30_memcpy, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_14_memcpy
Label_31_memcpy:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
foo:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_foo, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_0_foo, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_3_foo, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_foo, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_3_foo, Var_4_foo
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
main:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_main, %ma-Global_mOISC_csr
	exec _MEMMCR, MCR
	exec imm.7, Var_4_main
	exec _MEMRMCR, MCR
	exec Var_5_main, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec imm.8, Var_5_main
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_6_main
Label_6_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_7_main
Label_7_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_8_main, _TMP
	exec _MOVMCR, MCR
	exec Var_8_main, Var_9_main
	exec _SUBLMCR, MCR
	exec imm.9, Var_9_main
	exec _MOVMCR, MCR
	exec CHR, Var_9_main
	exec _ANDMCR, MCR
	exec _icmp_sle, Var_9_main -> Label_15_main
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_10_main
Label_10_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_11_main, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_11_main, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> foo
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_12_main
Label_12_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_13_main, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_14_main
	exec _ADDMCR, MCR
	exec Var_13_main, Var_14_main
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_14_main, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_7_main
Label_15_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_6_main
_SUBLMCR:		255
_MOVMCR:		238
_ADDMCR:		204
_SHLMCR:		153
_SHRMCR:		136
_ORMCR:		119
_ANDMCR:		102
_XORMCR:		85
_XNORMCR:		68
_PCMCR:		51
_MEMMCR:		34
_MEMRMCR:		17
_PCSMCR:		0
_NULL:		0
m_ptr:		31500
link_register:		0
_TMP:		0
%ma-Global_mOISC_ior:		980
Global_mOISC_ior:		7
%ma-Global_mOISC_idr:		982
Global_mOISC_idr:		6
%ma-Global_mOISC_isr:		984
Global_mOISC_isr:		5
%ma-Global_mOISC_csr:		986
Global_mOISC_csr:		4
%ma-Global_mOISC_icr:		988
Global_mOISC_icr:		3
%ma-Global_mOISC_iwr:		990
Global_mOISC_iwr:		2
%ma-Global_mOISC_chr:		992
Global_mOISC_chr:		1
%ma-Global_mOISC_mcr:		994
Global_mOISC_mcr:		0
imm.0:		1
Var_0_memcpy:		0
Var_1_memcpy:		0
Var_2_memcpy:		0
imm.1:		2
imm.2:		3
Var_10_memcpy:		0
Var_11_memcpy:		0
imm.3:		4
Var_12_memcpy:		0
Var_13_memcpy:		0
imm.4:		5
imm.5:		0
imm.6:		6
Var_15_memcpy:		0
Var_16_memcpy:		0
Var_17_memcpy:		0
_icmp_slt:		4
Var_19_memcpy:		0
Var_20_memcpy:		0
Var_21_memcpy:		0
Var_22_memcpy:		0
Var_23_memcpy:		0
Var_24_memcpy:		0
Var_25_memcpy:		0
Var_26_memcpy:		0
Var_27_memcpy:		0
Var_29_memcpy:		0
Var_30_memcpy:		0
Var_0_foo:		0
Var_3_foo:		0
Var_4_foo:		0
Var_4_main:		0
imm.7:		192
Var_5_main:		0
imm.8:		255
Var_8_main:		0
Var_9_main:		0
imm.9:		10
_icmp_sle:		12
Var_11_main:		0
_PCMCR_RETADDRBL:		-12
Var_13_main:		0
Var_14_main:		0
