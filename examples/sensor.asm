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
delay:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_delay, m_ptr
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
	exec Var_0_delay, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.0, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_4_delay
Label_4_delay:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_5_delay, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_6_delay, _TMP
	exec _MOVMCR, MCR
	exec Var_5_delay, Var_7_delay
	exec _SUBLMCR, MCR
	exec Var_6_delay, Var_7_delay
	exec _MOVMCR, MCR
	exec CHR, Var_7_delay
	exec _ANDMCR, MCR
	exec _icmp_sle, Var_7_delay -> Label_12_delay
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_8_delay
Label_8_delay:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_9_delay
Label_9_delay:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_10_delay, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_11_delay
	exec _ADDMCR, MCR
	exec Var_10_delay, Var_11_delay
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_11_delay, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_4_delay
Label_12_delay:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spi_ll:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_2_spi_ll, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_spi_ll, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_spi_ll, m_ptr
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
	exec Var_0_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_2_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MEMRMCR, MCR
	exec Var_14_spi_ll, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_15_spi_ll, Var_14_spi_ll
	exec _MOVMCR, MCR
	exec imm.10, Var_16_spi_ll
	exec _ANDMCR, MCR
	exec Var_15_spi_ll, Var_16_spi_ll
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_16_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_17_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.11, Var_18_spi_ll
	exec _ANDMCR, MCR
	exec Var_17_spi_ll, Var_18_spi_ll
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_19_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_20_spi_ll
	exec _SHLMCR, MCR
	exec Var_19_spi_ll, Var_20_spi_ll
	exec _MOVMCR, MCR
	exec Var_20_spi_ll, Var_21_spi_ll
	exec _ORMCR, MCR
	exec Var_18_spi_ll, Var_21_spi_ll
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_21_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_22_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_22_spi_ll, Var_23_spi_ll
	exec _ORMCR, MCR
	exec imm.5, Var_23_spi_ll
	exec _MEMRMCR, MCR
	exec Var_24_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_23_spi_ll, Var_24_spi_ll
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_25_spi_ll
Label_25_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_26_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_26_spi_ll, Var_27_spi_ll
	exec _SUBLMCR, MCR
	exec imm.7, Var_27_spi_ll
	exec _MOVMCR, MCR
	exec CHR, Var_27_spi_ll
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_27_spi_ll -> Label_46_spi_ll
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_28_spi_ll
Label_28_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_29_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_30_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_31_spi_ll
	exec _SUBLMCR, MCR
	exec Var_30_spi_ll, Var_31_spi_ll
	exec _MOVMCR, MCR
	exec Var_31_spi_ll, _TMP
	exec Var_29_spi_ll, _TMP2
	exec Var_29_spi_ll, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_114_
	exec _SHRMCR, MCR
	exec Var_29_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_32_spi_ll
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_114_
negativeOrZero_114_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_114_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_114_:		exec _SHRMCR, MCR
	exec Var_31_spi_ll, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_32_spi_ll
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_114_
exit2_114_:		exec _MOVMCR, MCR
	exec Var_29_spi_ll, Var_32_spi_ll
exit_114_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_33_spi_ll
	exec _ANDMCR, MCR
	exec Var_32_spi_ll, Var_33_spi_ll
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_33_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_34_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_35_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_35_spi_ll, Var_36_spi_ll
	exec _ORMCR, MCR
	exec Var_34_spi_ll, Var_36_spi_ll
	exec _MEMRMCR, MCR
	exec Var_37_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_36_spi_ll, Var_37_spi_ll
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_38_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_38_spi_ll, Var_39_spi_ll
	exec _ORMCR, MCR
	exec imm.1, Var_39_spi_ll
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_40_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_40_spi_ll, Var_41_spi_ll
	exec _ORMCR, MCR
	exec Var_39_spi_ll, Var_41_spi_ll
	exec _MEMRMCR, MCR
	exec Var_42_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_41_spi_ll, Var_42_spi_ll
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_43_spi_ll
Label_43_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_44_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_45_spi_ll
	exec _ADDMCR, MCR
	exec Var_44_spi_ll, Var_45_spi_ll
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_45_spi_ll, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_25_spi_ll
Label_46_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_47_spi_ll
Label_47_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_48_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_48_spi_ll, Var_49_spi_ll
	exec _SUBLMCR, MCR
	exec imm.7, Var_49_spi_ll
	exec _MOVMCR, MCR
	exec CHR, Var_49_spi_ll
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_49_spi_ll -> Label_79_spi_ll
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_50_spi_ll
Label_50_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_51_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_52_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_53_spi_ll
	exec _SUBLMCR, MCR
	exec Var_52_spi_ll, Var_53_spi_ll
	exec _MOVMCR, MCR
	exec Var_53_spi_ll, _TMP
	exec Var_51_spi_ll, _TMP2
	exec Var_51_spi_ll, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_145_
	exec _SHRMCR, MCR
	exec Var_51_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_54_spi_ll
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_145_
negativeOrZero_145_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_145_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_145_:		exec _SHRMCR, MCR
	exec Var_53_spi_ll, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_54_spi_ll
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_145_
exit2_145_:		exec _MOVMCR, MCR
	exec Var_51_spi_ll, Var_54_spi_ll
exit_145_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_55_spi_ll
	exec _ANDMCR, MCR
	exec Var_54_spi_ll, Var_55_spi_ll
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_55_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_56_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_56_spi_ll, Var_57_spi_ll
	exec _ORMCR, MCR
	exec imm.5, Var_57_spi_ll
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_58_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_58_spi_ll, Var_59_spi_ll
	exec _ORMCR, MCR
	exec Var_57_spi_ll, Var_59_spi_ll
	exec _MEMRMCR, MCR
	exec Var_60_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_59_spi_ll, Var_60_spi_ll
	exec _MEMRMCR, MCR
	exec Var_61_spi_ll, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_62_spi_ll, Var_61_spi_ll
	exec _MOVMCR, MCR
	exec imm.3, Var_63_spi_ll
	exec _ANDMCR, MCR
	exec Var_62_spi_ll, Var_63_spi_ll
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec Var_63_spi_ll, _TMP2
	exec Var_63_spi_ll, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_157_
	exec _SHRMCR, MCR
	exec Var_63_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_64_spi_ll
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_157_
negativeOrZero_157_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_157_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_157_:		exec _SHRMCR, MCR
	exec imm.1, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_64_spi_ll
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_157_
exit2_157_:		exec _MOVMCR, MCR
	exec Var_63_spi_ll, Var_64_spi_ll
exit_157_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_64_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_65_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_66_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_67_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_68_spi_ll
	exec _SUBLMCR, MCR
	exec Var_67_spi_ll, Var_68_spi_ll
	exec _MOVMCR, MCR
	exec Var_68_spi_ll, Var_69_spi_ll
	exec _SHLMCR, MCR
	exec Var_66_spi_ll, Var_69_spi_ll
	exec _MOVMCR, MCR
	exec Var_69_spi_ll, Var_70_spi_ll
	exec _ORMCR, MCR
	exec Var_65_spi_ll, Var_70_spi_ll
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_70_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_71_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_71_spi_ll, Var_72_spi_ll
	exec _ORMCR, MCR
	exec imm.1, Var_72_spi_ll
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_73_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_73_spi_ll, Var_74_spi_ll
	exec _ORMCR, MCR
	exec Var_72_spi_ll, Var_74_spi_ll
	exec _MEMRMCR, MCR
	exec Var_75_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_74_spi_ll, Var_75_spi_ll
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_76_spi_ll
Label_76_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_77_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_78_spi_ll
	exec _ADDMCR, MCR
	exec Var_77_spi_ll, Var_78_spi_ll
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_78_spi_ll, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_47_spi_ll
Label_79_spi_ll:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_80_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_80_spi_ll, Var_81_spi_ll
	exec _ORMCR, MCR
	exec imm.5, Var_81_spi_ll
	exec _MEMRMCR, MCR
	exec Var_82_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_81_spi_ll, Var_82_spi_ll
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> delay
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_83_spi_ll, _TMP
	exec _MOVMCR, MCR
	exec Var_83_spi_ll, Var_84_spi_ll
	exec _ORMCR, MCR
	exec imm.7, Var_84_spi_ll
	exec _MEMRMCR, MCR
	exec Var_85_spi_ll, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_84_spi_ll, Var_85_spi_ll
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_86_spi_ll, _TMP
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec Var_86_spi_ll, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spitransaction:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_spitransaction, m_ptr
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
	exec Var_0_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MEMRMCR, MCR
	exec Var_9_spitransaction, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_10_spitransaction, Var_9_spitransaction
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_10_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_11_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.14, Var_12_spitransaction
	exec _ANDMCR, MCR
	exec Var_11_spitransaction, Var_12_spitransaction
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_12_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_13_spitransaction
Label_13_spitransaction:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_14_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec Var_14_spitransaction, Var_15_spitransaction
	exec _SUBLMCR, MCR
	exec imm.7, Var_15_spitransaction
	exec _MOVMCR, MCR
	exec CHR, Var_15_spitransaction
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_15_spitransaction -> Label_34_spitransaction
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_16_spitransaction
Label_16_spitransaction:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_17_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_18_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_19_spitransaction
	exec _SUBLMCR, MCR
	exec Var_18_spitransaction, Var_19_spitransaction
	exec _MOVMCR, MCR
	exec Var_19_spitransaction, _TMP
	exec Var_17_spitransaction, _TMP2
	exec Var_17_spitransaction, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_219_
	exec _SHRMCR, MCR
	exec Var_17_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_20_spitransaction
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_219_
negativeOrZero_219_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_219_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_219_:		exec _SHRMCR, MCR
	exec Var_19_spitransaction, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_20_spitransaction
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_219_
exit2_219_:		exec _MOVMCR, MCR
	exec Var_17_spitransaction, Var_20_spitransaction
exit_219_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_21_spitransaction
	exec _ANDMCR, MCR
	exec Var_20_spitransaction, Var_21_spitransaction
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_21_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_22_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_23_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec Var_23_spitransaction, Var_24_spitransaction
	exec _ORMCR, MCR
	exec Var_22_spitransaction, Var_24_spitransaction
	exec _MEMRMCR, MCR
	exec Var_25_spitransaction, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_24_spitransaction, Var_25_spitransaction
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_26_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec Var_26_spitransaction, Var_27_spitransaction
	exec _ORMCR, MCR
	exec imm.1, Var_27_spitransaction
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_28_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec Var_28_spitransaction, Var_29_spitransaction
	exec _ORMCR, MCR
	exec Var_27_spitransaction, Var_29_spitransaction
	exec _MEMRMCR, MCR
	exec Var_30_spitransaction, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_29_spitransaction, Var_30_spitransaction
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_31_spitransaction
Label_31_spitransaction:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_32_spitransaction, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_33_spitransaction
	exec _ADDMCR, MCR
	exec Var_32_spitransaction, Var_33_spitransaction
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_33_spitransaction, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_13_spitransaction
Label_34_spitransaction:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_35_spitransaction, _TMP
	exec _MEMRMCR, MCR
	exec Var_36_spitransaction, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_35_spitransaction, Var_36_spitransaction
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiselect:			exec _SUBLMCR, MCR
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
	exec Var_2_spiselect, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_3_spiselect, Var_2_spiselect
	exec _MOVMCR, MCR
	exec imm.10, Var_4_spiselect
	exec _ANDMCR, MCR
	exec Var_3_spiselect, Var_4_spiselect
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_4_spiselect, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_5_spiselect, _TMP
	exec _MOVMCR, MCR
	exec Var_5_spiselect, Var_6_spiselect
	exec _ANDMCR, MCR
	exec imm.10, Var_6_spiselect
	exec _MEMRMCR, MCR
	exec Var_7_spiselect, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_6_spiselect, Var_7_spiselect
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiunselect:			exec _SUBLMCR, MCR
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
	exec Var_2_spiunselect, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_3_spiunselect, Var_2_spiunselect
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_3_spiunselect, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_spiunselect, _TMP
	exec _MOVMCR, MCR
	exec Var_4_spiunselect, Var_5_spiunselect
	exec _ORMCR, MCR
	exec imm.7, Var_5_spiunselect
	exec _MEMRMCR, MCR
	exec Var_6_spiunselect, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_5_spiunselect, Var_6_spiunselect
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiLEDInit:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_spiLEDInit, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.15, Var_2_spiLEDInit
	exec _ORMCR, MCR
	exec Var_1_spiLEDInit, Var_2_spiLEDInit
	exec _MEMMCR, MCR
	exec Var_2_spiLEDInit, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_spiLEDInit, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_spiLEDInit, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_spiLEDInit, Var_4_spiLEDInit
	exec _MEMRMCR, MCR
	exec Var_5_spiLEDInit, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec imm.7, Var_5_spiLEDInit
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiWrite:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_1_spiWrite, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_spiWrite, m_ptr
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
	exec Var_0_spiWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_spiWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.0, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_6_spiWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_7_spiWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_8_spiWrite, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_6_spiWrite, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_7_spiWrite, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_8_spiWrite, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spi_ll
	exec _MEMRMCR, MCR
	exec Var_9_spiWrite, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec Var_9_spiWrite, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiRead:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_spiRead, m_ptr
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
	exec Var_0_spiRead, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_spiRead, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_5_spiRead, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.2, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_4_spiRead, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_5_spiRead, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spi_ll
	exec _MEMRMCR, MCR
	exec Var_6_spiRead, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec Var_6_spiRead, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
spiBurstWrite:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_2_spiBurstWrite, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_spiBurstWrite, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_spiBurstWrite, m_ptr
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
	exec Var_0_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_2_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiselect
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_7_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.16, Var_8_spiBurstWrite
	exec _ORMCR, MCR
	exec Var_7_spiBurstWrite, Var_8_spiBurstWrite
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_8_spiBurstWrite, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spitransaction
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_9_spiBurstWrite
Label_9_spiBurstWrite:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_10_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.17, Var_11_spiBurstWrite
	exec _ADDMCR, MCR
	exec Var_10_spiBurstWrite, Var_11_spiBurstWrite
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_11_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec Var_10_spiBurstWrite, Var_12_spiBurstWrite
	exec _SUBLMCR, MCR
	exec imm.5, Var_12_spiBurstWrite
	exec _MOVMCR, MCR
	exec CHR, Var_12_spiBurstWrite
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_12_spiBurstWrite -> Label_13_spiBurstWrite
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_19_spiBurstWrite
Label_13_spiBurstWrite:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_14_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_15_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec Var_15_spiBurstWrite, Var_16_spiBurstWrite
	exec _MOVMCR, MCR
	exec Var_14_spiBurstWrite, _TMP
	exec _ADDMCR, MCR
	exec Var_16_spiBurstWrite, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_17_spiBurstWrite
	exec _MEMRMCR, MCR
	exec Var_18_spiBurstWrite, Var_17_spiBurstWrite
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_18_spiBurstWrite, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spitransaction
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_9_spiBurstWrite
Label_19_spiBurstWrite:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiunselect
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setFrequency_868:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.18, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setFrequency_868, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setFrequency_868, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setFrequency_868, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setFrequency_915:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.19, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setFrequency_915, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.20, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setFrequency_915, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setFrequency_915, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setPreambleLength:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_RH_RF95_setPreambleLength, m_ptr
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
	exec Var_0_RH_RF95_setPreambleLength, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setPreambleLength, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec Var_3_RH_RF95_setPreambleLength, _TMP2
	exec Var_3_RH_RF95_setPreambleLength, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_350_
	exec _SHRMCR, MCR
	exec Var_3_RH_RF95_setPreambleLength, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_4_RH_RF95_setPreambleLength
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_350_
negativeOrZero_350_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_350_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_350_:		exec _SHRMCR, MCR
	exec imm.7, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_4_RH_RF95_setPreambleLength
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_350_
exit2_350_:		exec _MOVMCR, MCR
	exec Var_3_RH_RF95_setPreambleLength, Var_4_RH_RF95_setPreambleLength
exit_350_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.21, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_4_RH_RF95_setPreambleLength, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_5_RH_RF95_setPreambleLength, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_6_RH_RF95_setPreambleLength, _TMP
	exec _MOVMCR, MCR
	exec imm.14, Var_7_RH_RF95_setPreambleLength
	exec _ANDMCR, MCR
	exec Var_6_RH_RF95_setPreambleLength, Var_7_RH_RF95_setPreambleLength
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.22, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_7_RH_RF95_setPreambleLength, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_8_RH_RF95_setPreambleLength, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModeIdle:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModeIdle, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModemConfig_Bw125Cr45Sf128:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.23, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.24, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModemConfig_Bw125Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.25, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.26, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setModemConfig_Bw125Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.27, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setModemConfig_Bw125Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModemConfig_Bw500Cr45Sf128:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.23, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.28, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModemConfig_Bw500Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.25, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.26, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setModemConfig_Bw500Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.27, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setModemConfig_Bw500Cr45Sf128, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModemConfig_Bw31_25Cr48Sf512:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.23, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.29, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModemConfig_Bw31_25Cr48Sf512, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.25, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.30, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setModemConfig_Bw31_25Cr48Sf512, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.27, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setModemConfig_Bw31_25Cr48Sf512, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModemConfig_Bw125Cr48Sf4096:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.23, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.31, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModemConfig_Bw125Cr48Sf4096, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.25, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.32, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setModemConfig_Bw125Cr48Sf4096, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.27, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setModemConfig_Bw125Cr48Sf4096, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setTxPower:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_RH_RF95_setTxPower, m_ptr
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
	exec Var_0_RH_RF95_setTxPower, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_setTxPower, _TMP
	exec _MOVMCR, MCR
	exec Var_3_RH_RF95_setTxPower, Var_4_RH_RF95_setTxPower
	exec _SUBLMCR, MCR
	exec imm.4, Var_4_RH_RF95_setTxPower
	exec _MOVMCR, MCR
	exec Var_4_RH_RF95_setTxPower, Var_5_RH_RF95_setTxPower
	exec _ORMCR, MCR
	exec imm.16, Var_5_RH_RF95_setTxPower
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_5_RH_RF95_setTxPower, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_6_RH_RF95_setTxPower, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_setModeTx:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_setModeTx, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.33, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.33, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_setModeTx, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_send:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_1_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_0_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_6_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec Var_6_RH_RF95_send, Var_7_RH_RF95_send
	exec _SUBLMCR, MCR
	exec imm.34, Var_7_RH_RF95_send
	exec _MOVMCR, MCR
	exec CHR, Var_7_RH_RF95_send
	exec _ANDMCR, MCR
	exec _icmp_sgt, Var_7_RH_RF95_send -> Label_9_RH_RF95_send
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_8_RH_RF95_send
Label_8_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_26_RH_RF95_send
Label_9_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setModeIdle
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_10_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.14, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_11_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.14, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_12_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_13_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_14_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_15_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_16_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_15_RH_RF95_send, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_16_RH_RF95_send, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiBurstWrite
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_17_RH_RF95_send, _TMP
	exec _MOVMCR, MCR
	exec imm.3, Var_18_RH_RF95_send
	exec _ADDMCR, MCR
	exec Var_17_RH_RF95_send, Var_18_RH_RF95_send
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.36, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_18_RH_RF95_send, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_19_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setModeTx
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_20_RH_RF95_send
Label_20_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.3, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.37, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiRead
	exec _MEMRMCR, MCR
	exec Var_21_RH_RF95_send, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, Var_22_RH_RF95_send
	exec _ANDMCR, MCR
	exec Var_21_RH_RF95_send, Var_22_RH_RF95_send
	exec _MOVMCR, MCR
	exec Var_22_RH_RF95_send, Var_23_RH_RF95_send
	exec _SUBLMCR, MCR
	exec imm.7, Var_23_RH_RF95_send
	exec _MOVMCR, MCR
	exec CHR, Var_23_RH_RF95_send
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_23_RH_RF95_send -> Label_24_RH_RF95_send
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_25_RH_RF95_send
Label_24_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_20_RH_RF95_send
Label_25_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.0, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_26_RH_RF95_send
Label_26_RH_RF95_send:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_27_RH_RF95_send, _TMP
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec Var_27_RH_RF95_send, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
RH_RF95_init:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.16, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_2_RH_RF95_init, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.38, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> delay
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiRead
	exec _MEMRMCR, MCR
	exec Var_3_RH_RF95_init, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_3_RH_RF95_init, Var_4_RH_RF95_init
	exec _SUBLMCR, MCR
	exec imm.16, Var_4_RH_RF95_init
	exec _MOVMCR, MCR
	exec CHR, Var_4_RH_RF95_init
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_4_RH_RF95_init -> Label_5_RH_RF95_init
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_6_RH_RF95_init
Label_5_RH_RF95_init:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_9_RH_RF95_init
Label_6_RH_RF95_init:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.39, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_7_RH_RF95_init, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.40, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiWrite
	exec _MEMRMCR, MCR
	exec Var_8_RH_RF95_init, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setModeIdle
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setModemConfig_Bw125Cr45Sf128
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setPreambleLength
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setFrequency_868
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_setTxPower
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.0, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_9_RH_RF95_init
Label_9_RH_RF95_init:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_10_RH_RF95_init, _TMP
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec Var_10_RH_RF95_init, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_low_scl:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_low_scl, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.16, Var_2_i2c_low_scl
	exec _ORMCR, MCR
	exec Var_1_i2c_low_scl, Var_2_i2c_low_scl
	exec _MEMMCR, MCR
	exec Var_2_i2c_low_scl, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_low_scl, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_low_scl, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_low_scl, Var_4_i2c_low_scl
	exec _MEMRMCR, MCR
	exec Var_5_i2c_low_scl, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_6_i2c_low_scl, Var_5_i2c_low_scl
	exec _MOVMCR, MCR
	exec Var_6_i2c_low_scl, Var_7_i2c_low_scl
	exec _ANDMCR, MCR
	exec imm.41, Var_7_i2c_low_scl
	exec _MEMRMCR, MCR
	exec Var_8_i2c_low_scl, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_7_i2c_low_scl, Var_8_i2c_low_scl
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_high_scl:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_high_scl, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.11, Var_2_i2c_high_scl
	exec _ANDMCR, MCR
	exec Var_1_i2c_high_scl, Var_2_i2c_high_scl
	exec _MEMMCR, MCR
	exec Var_2_i2c_high_scl, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_high_scl, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_high_scl, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_high_scl, Var_4_i2c_high_scl
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_low_sda:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_low_sda, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.33, Var_2_i2c_low_sda
	exec _ORMCR, MCR
	exec Var_1_i2c_low_sda, Var_2_i2c_low_sda
	exec _MEMMCR, MCR
	exec Var_2_i2c_low_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_low_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_low_sda, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_low_sda, Var_4_i2c_low_sda
	exec _MEMRMCR, MCR
	exec Var_5_i2c_low_sda, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_6_i2c_low_sda, Var_5_i2c_low_sda
	exec _MOVMCR, MCR
	exec Var_6_i2c_low_sda, Var_7_i2c_low_sda
	exec _ANDMCR, MCR
	exec imm.42, Var_7_i2c_low_sda
	exec _MEMRMCR, MCR
	exec Var_8_i2c_low_sda, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_7_i2c_low_sda, Var_8_i2c_low_sda
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_release_sda:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_release_sda, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.42, Var_2_i2c_release_sda
	exec _ANDMCR, MCR
	exec Var_1_i2c_release_sda, Var_2_i2c_release_sda
	exec _MEMMCR, MCR
	exec Var_2_i2c_release_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_release_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_release_sda, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_release_sda, Var_4_i2c_release_sda
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_drive_sda:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_drive_sda, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.33, Var_2_i2c_drive_sda
	exec _ORMCR, MCR
	exec Var_1_i2c_drive_sda, Var_2_i2c_drive_sda
	exec _MEMMCR, MCR
	exec Var_2_i2c_drive_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_drive_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_drive_sda, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_drive_sda, Var_4_i2c_drive_sda
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_high_sda:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_high_sda, %ma-Global_current_idr
	exec _MOVMCR, MCR
	exec imm.42, Var_2_i2c_high_sda
	exec _ANDMCR, MCR
	exec Var_1_i2c_high_sda, Var_2_i2c_high_sda
	exec _MEMMCR, MCR
	exec Var_2_i2c_high_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_high_sda, %ma-Global_current_idr
	exec _MEMRMCR, MCR
	exec Var_4_i2c_high_sda, %ma-Global_mOISC_idr
	exec _MEMMCR, MCR
	exec Var_3_i2c_high_sda, Var_4_i2c_high_sda
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_init:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_write:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_4_i2c_write, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_3_i2c_write, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_2_i2c_write, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_write, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_i2c_write, m_ptr
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
	exec Var_0_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_2_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_3_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_4_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MEMRMCR, MCR
	exec Var_19_i2c_write, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_20_i2c_write, Var_19_i2c_write
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_20_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_21_i2c_write
Label_21_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_22_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_22_i2c_write, Var_23_i2c_write
	exec _SUBLMCR, MCR
	exec imm.12, Var_23_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_23_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_23_i2c_write -> Label_38_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_24_i2c_write
Label_24_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_25_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_26_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.6, Var_27_i2c_write
	exec _SUBLMCR, MCR
	exec Var_26_i2c_write, Var_27_i2c_write
	exec _MOVMCR, MCR
	exec Var_27_i2c_write, _TMP
	exec Var_25_i2c_write, _TMP2
	exec Var_25_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_568_
	exec _SHRMCR, MCR
	exec Var_25_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_28_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_568_
negativeOrZero_568_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_568_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_568_:		exec _SHRMCR, MCR
	exec Var_27_i2c_write, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_28_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_568_
exit2_568_:		exec _MOVMCR, MCR
	exec Var_25_i2c_write, Var_28_i2c_write
exit_568_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_29_i2c_write
	exec _ANDMCR, MCR
	exec Var_28_i2c_write, Var_29_i2c_write
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_29_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_30_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_30_i2c_write, Var_31_i2c_write
	exec _SUBLMCR, MCR
	exec imm.0, Var_31_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_31_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_31_i2c_write -> Label_33_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_32_i2c_write
Label_32_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_34_i2c_write
Label_33_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_34_i2c_write
Label_34_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_35_i2c_write
Label_35_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_36_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_37_i2c_write
	exec _ADDMCR, MCR
	exec Var_36_i2c_write, Var_37_i2c_write
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_37_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_21_i2c_write
Label_38_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_39_i2c_write, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_40_i2c_write, Var_39_i2c_write
	exec _MOVMCR, MCR
	exec imm.33, Var_41_i2c_write
	exec _ANDMCR, MCR
	exec Var_40_i2c_write, Var_41_i2c_write
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_41_i2c_write, _TMP2
	exec Var_41_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_598_
	exec _SHRMCR, MCR
	exec Var_41_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_42_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_598_
negativeOrZero_598_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_598_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_598_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_42_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_598_
exit2_598_:		exec _MOVMCR, MCR
	exec Var_41_i2c_write, Var_42_i2c_write
exit_598_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_42_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_43_i2c_write
Label_43_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_44_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_44_i2c_write, Var_45_i2c_write
	exec _SUBLMCR, MCR
	exec imm.7, Var_45_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_45_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_45_i2c_write -> Label_60_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_46_i2c_write
Label_46_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_47_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_48_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_49_i2c_write
	exec _SUBLMCR, MCR
	exec Var_48_i2c_write, Var_49_i2c_write
	exec _MOVMCR, MCR
	exec Var_49_i2c_write, _TMP
	exec Var_47_i2c_write, _TMP2
	exec Var_47_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_612_
	exec _SHRMCR, MCR
	exec Var_47_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_50_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_612_
negativeOrZero_612_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_612_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_612_:		exec _SHRMCR, MCR
	exec Var_49_i2c_write, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_50_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_612_
exit2_612_:		exec _MOVMCR, MCR
	exec Var_47_i2c_write, Var_50_i2c_write
exit_612_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_51_i2c_write
	exec _ANDMCR, MCR
	exec Var_50_i2c_write, Var_51_i2c_write
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_51_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_52_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_52_i2c_write, Var_53_i2c_write
	exec _SUBLMCR, MCR
	exec imm.0, Var_53_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_53_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_53_i2c_write -> Label_55_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_54_i2c_write
Label_54_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_56_i2c_write
Label_55_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_56_i2c_write
Label_56_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_57_i2c_write
Label_57_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_58_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_59_i2c_write
	exec _ADDMCR, MCR
	exec Var_58_i2c_write, Var_59_i2c_write
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_59_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_43_i2c_write
Label_60_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_61_i2c_write, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_62_i2c_write, Var_61_i2c_write
	exec _MOVMCR, MCR
	exec imm.33, Var_63_i2c_write
	exec _ANDMCR, MCR
	exec Var_62_i2c_write, Var_63_i2c_write
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_63_i2c_write, _TMP2
	exec Var_63_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_640_
	exec _SHRMCR, MCR
	exec Var_63_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_64_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_640_
negativeOrZero_640_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_640_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_640_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_64_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_640_
exit2_640_:		exec _MOVMCR, MCR
	exec Var_63_i2c_write, Var_64_i2c_write
exit_640_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_64_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_65_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_65_i2c_write, Var_66_i2c_write
	exec _SUBLMCR, MCR
	exec imm.1, Var_66_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_66_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_66_i2c_write -> Label_69_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_67_i2c_write
Label_67_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_68_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_68_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_71_i2c_write
Label_69_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_70_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_70_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_71_i2c_write
Label_71_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.43, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_72_i2c_write
Label_72_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.43, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_73_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_73_i2c_write, Var_74_i2c_write
	exec _SUBLMCR, MCR
	exec imm.7, Var_74_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_74_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_74_i2c_write -> Label_89_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_75_i2c_write
Label_75_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_76_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.43, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_77_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_78_i2c_write
	exec _SUBLMCR, MCR
	exec Var_77_i2c_write, Var_78_i2c_write
	exec _MOVMCR, MCR
	exec Var_78_i2c_write, _TMP
	exec Var_76_i2c_write, _TMP2
	exec Var_76_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_667_
	exec _SHRMCR, MCR
	exec Var_76_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_79_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_667_
negativeOrZero_667_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_667_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_667_:		exec _SHRMCR, MCR
	exec Var_78_i2c_write, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_79_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_667_
exit2_667_:		exec _MOVMCR, MCR
	exec Var_76_i2c_write, Var_79_i2c_write
exit_667_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_80_i2c_write
	exec _ANDMCR, MCR
	exec Var_79_i2c_write, Var_80_i2c_write
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_80_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_81_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_81_i2c_write, Var_82_i2c_write
	exec _SUBLMCR, MCR
	exec imm.0, Var_82_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_82_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_82_i2c_write -> Label_84_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_83_i2c_write
Label_83_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_85_i2c_write
Label_84_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_85_i2c_write
Label_85_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_86_i2c_write
Label_86_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.43, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_87_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_88_i2c_write
	exec _ADDMCR, MCR
	exec Var_87_i2c_write, Var_88_i2c_write
	exec _MOVMCR, MCR
	exec imm.43, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_88_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_72_i2c_write
Label_89_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_90_i2c_write, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_91_i2c_write, Var_90_i2c_write
	exec _MOVMCR, MCR
	exec imm.33, Var_92_i2c_write
	exec _ANDMCR, MCR
	exec Var_91_i2c_write, Var_92_i2c_write
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_92_i2c_write, _TMP2
	exec Var_92_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_695_
	exec _SHRMCR, MCR
	exec Var_92_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_93_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_695_
negativeOrZero_695_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_695_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_695_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_93_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_695_
exit2_695_:		exec _MOVMCR, MCR
	exec Var_92_i2c_write, Var_93_i2c_write
exit_695_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_93_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_94_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_94_i2c_write, Var_95_i2c_write
	exec _SUBLMCR, MCR
	exec imm.1, Var_95_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_95_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_95_i2c_write -> Label_120_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_96_i2c_write
Label_96_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_97_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_97_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_98_i2c_write
Label_98_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_99_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_99_i2c_write, Var_100_i2c_write
	exec _SUBLMCR, MCR
	exec imm.7, Var_100_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_100_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_100_i2c_write -> Label_115_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_101_i2c_write
Label_101_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.13, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_102_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_103_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_104_i2c_write
	exec _SUBLMCR, MCR
	exec Var_103_i2c_write, Var_104_i2c_write
	exec _MOVMCR, MCR
	exec Var_104_i2c_write, _TMP
	exec Var_102_i2c_write, _TMP2
	exec Var_102_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_716_
	exec _SHRMCR, MCR
	exec Var_102_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_105_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_716_
negativeOrZero_716_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_716_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_716_:		exec _SHRMCR, MCR
	exec Var_104_i2c_write, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_105_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_716_
exit2_716_:		exec _MOVMCR, MCR
	exec Var_102_i2c_write, Var_105_i2c_write
exit_716_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_106_i2c_write
	exec _ANDMCR, MCR
	exec Var_105_i2c_write, Var_106_i2c_write
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_106_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_107_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec Var_107_i2c_write, Var_108_i2c_write
	exec _SUBLMCR, MCR
	exec imm.0, Var_108_i2c_write
	exec _MOVMCR, MCR
	exec CHR, Var_108_i2c_write
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_108_i2c_write -> Label_110_i2c_write
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_109_i2c_write
Label_109_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_111_i2c_write
Label_110_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_111_i2c_write
Label_111_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_112_i2c_write
Label_112_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_113_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_114_i2c_write
	exec _ADDMCR, MCR
	exec Var_113_i2c_write, Var_114_i2c_write
	exec _MOVMCR, MCR
	exec imm.35, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_114_i2c_write, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_98_i2c_write
Label_115_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_116_i2c_write, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_117_i2c_write, Var_116_i2c_write
	exec _MOVMCR, MCR
	exec imm.33, Var_118_i2c_write
	exec _ANDMCR, MCR
	exec Var_117_i2c_write, Var_118_i2c_write
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_118_i2c_write, _TMP2
	exec Var_118_i2c_write, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_744_
	exec _SHRMCR, MCR
	exec Var_118_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_119_i2c_write
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_744_
negativeOrZero_744_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_744_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_744_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_119_i2c_write
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_744_
exit2_744_:		exec _MOVMCR, MCR
	exec Var_118_i2c_write, Var_119_i2c_write
exit_744_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_119_i2c_write, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_120_i2c_write
Label_120_i2c_write:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.39, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec imm.5, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
i2c_read:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_2_i2c_read, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_1_i2c_read, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec Var_0_i2c_read, m_ptr
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
	exec Var_0_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_1_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_2_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MEMRMCR, MCR
	exec Var_14_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_15_i2c_read, Var_14_i2c_read
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_15_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_16_i2c_read
Label_16_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_17_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_17_i2c_read, Var_18_i2c_read
	exec _SUBLMCR, MCR
	exec imm.12, Var_18_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_18_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_18_i2c_read -> Label_33_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_19_i2c_read
Label_19_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_20_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_21_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, Var_22_i2c_read
	exec _SUBLMCR, MCR
	exec Var_21_i2c_read, Var_22_i2c_read
	exec _MOVMCR, MCR
	exec Var_22_i2c_read, _TMP
	exec Var_20_i2c_read, _TMP2
	exec Var_20_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_785_
	exec _SHRMCR, MCR
	exec Var_20_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_23_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_785_
negativeOrZero_785_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_785_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_785_:		exec _SHRMCR, MCR
	exec Var_22_i2c_read, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_23_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_785_
exit2_785_:		exec _MOVMCR, MCR
	exec Var_20_i2c_read, Var_23_i2c_read
exit_785_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_24_i2c_read
	exec _ANDMCR, MCR
	exec Var_23_i2c_read, Var_24_i2c_read
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_24_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_25_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_25_i2c_read, Var_26_i2c_read
	exec _SUBLMCR, MCR
	exec imm.0, Var_26_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_26_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_26_i2c_read -> Label_28_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_27_i2c_read
Label_27_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_29_i2c_read
Label_28_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_29_i2c_read
Label_29_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_30_i2c_read
Label_30_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_31_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_32_i2c_read
	exec _ADDMCR, MCR
	exec Var_31_i2c_read, Var_32_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_32_i2c_read, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_16_i2c_read
Label_33_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_34_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_35_i2c_read, Var_34_i2c_read
	exec _MOVMCR, MCR
	exec imm.33, Var_36_i2c_read
	exec _ANDMCR, MCR
	exec Var_35_i2c_read, Var_36_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_36_i2c_read, _TMP2
	exec Var_36_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_815_
	exec _SHRMCR, MCR
	exec Var_36_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_37_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_815_
negativeOrZero_815_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_815_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_815_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_37_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_815_
exit2_815_:		exec _MOVMCR, MCR
	exec Var_36_i2c_read, Var_37_i2c_read
exit_815_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_37_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_38_i2c_read
Label_38_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_39_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_39_i2c_read, Var_40_i2c_read
	exec _SUBLMCR, MCR
	exec imm.7, Var_40_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_40_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_40_i2c_read -> Label_55_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_41_i2c_read
Label_41_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_42_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_43_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_44_i2c_read
	exec _SUBLMCR, MCR
	exec Var_43_i2c_read, Var_44_i2c_read
	exec _MOVMCR, MCR
	exec Var_44_i2c_read, _TMP
	exec Var_42_i2c_read, _TMP2
	exec Var_42_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_830_
	exec _SHRMCR, MCR
	exec Var_42_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_45_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_830_
negativeOrZero_830_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_830_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_830_:		exec _SHRMCR, MCR
	exec Var_44_i2c_read, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_45_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_830_
exit2_830_:		exec _MOVMCR, MCR
	exec Var_42_i2c_read, Var_45_i2c_read
exit_830_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_46_i2c_read
	exec _ANDMCR, MCR
	exec Var_45_i2c_read, Var_46_i2c_read
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_46_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_47_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_47_i2c_read, Var_48_i2c_read
	exec _SUBLMCR, MCR
	exec imm.0, Var_48_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_48_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_48_i2c_read -> Label_50_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_49_i2c_read
Label_49_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_51_i2c_read
Label_50_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_51_i2c_read
Label_51_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_52_i2c_read
Label_52_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_53_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_54_i2c_read
	exec _ADDMCR, MCR
	exec Var_53_i2c_read, Var_54_i2c_read
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_54_i2c_read, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_38_i2c_read
Label_55_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_56_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_57_i2c_read, Var_56_i2c_read
	exec _MOVMCR, MCR
	exec imm.33, Var_58_i2c_read
	exec _ANDMCR, MCR
	exec Var_57_i2c_read, Var_58_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_58_i2c_read, _TMP2
	exec Var_58_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_858_
	exec _SHRMCR, MCR
	exec Var_58_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_59_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_858_
negativeOrZero_858_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_858_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_858_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_59_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_858_
exit2_858_:		exec _MOVMCR, MCR
	exec Var_58_i2c_read, Var_59_i2c_read
exit_858_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_59_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_60_i2c_read
Label_60_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_61_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_61_i2c_read, Var_62_i2c_read
	exec _SUBLMCR, MCR
	exec imm.12, Var_62_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_62_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_62_i2c_read -> Label_77_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_63_i2c_read
Label_63_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_64_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_65_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, Var_66_i2c_read
	exec _SUBLMCR, MCR
	exec Var_65_i2c_read, Var_66_i2c_read
	exec _MOVMCR, MCR
	exec Var_66_i2c_read, _TMP
	exec Var_64_i2c_read, _TMP2
	exec Var_64_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_877_
	exec _SHRMCR, MCR
	exec Var_64_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_67_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_877_
negativeOrZero_877_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_877_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_877_:		exec _SHRMCR, MCR
	exec Var_66_i2c_read, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_67_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_877_
exit2_877_:		exec _MOVMCR, MCR
	exec Var_64_i2c_read, Var_67_i2c_read
exit_877_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.0, Var_68_i2c_read
	exec _ANDMCR, MCR
	exec Var_67_i2c_read, Var_68_i2c_read
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_68_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.8, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_69_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_69_i2c_read, Var_70_i2c_read
	exec _SUBLMCR, MCR
	exec imm.0, Var_70_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_70_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_70_i2c_read -> Label_72_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_71_i2c_read
Label_71_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_73_i2c_read
Label_72_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_73_i2c_read
Label_73_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_74_i2c_read
Label_74_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_75_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_76_i2c_read
	exec _ADDMCR, MCR
	exec Var_75_i2c_read, Var_76_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_76_i2c_read, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_60_i2c_read
Label_77_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_78_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_79_i2c_read, Var_78_i2c_read
	exec _MOVMCR, MCR
	exec imm.33, Var_80_i2c_read
	exec _ANDMCR, MCR
	exec Var_79_i2c_read, Var_80_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_80_i2c_read, _TMP2
	exec Var_80_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_909_
	exec _SHRMCR, MCR
	exec Var_80_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_81_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_909_
negativeOrZero_909_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_909_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_909_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_81_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_909_
exit2_909_:		exec _MOVMCR, MCR
	exec Var_80_i2c_read, Var_81_i2c_read
exit_909_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.4, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_81_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_82_i2c_read
Label_82_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_83_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_83_i2c_read, Var_84_i2c_read
	exec _SUBLMCR, MCR
	exec imm.7, Var_84_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_84_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_84_i2c_read -> Label_99_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_85_i2c_read
Label_85_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_86_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_87_i2c_read, Var_86_i2c_read
	exec _MOVMCR, MCR
	exec imm.33, Var_88_i2c_read
	exec _ANDMCR, MCR
	exec Var_87_i2c_read, Var_88_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_88_i2c_read, _TMP2
	exec Var_88_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_924_
	exec _SHRMCR, MCR
	exec Var_88_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_89_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_924_
negativeOrZero_924_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_924_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_924_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_89_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_924_
exit2_924_:		exec _MOVMCR, MCR
	exec Var_88_i2c_read, Var_89_i2c_read
exit_924_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_89_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_90_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_91_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_92_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_93_i2c_read
	exec _SUBLMCR, MCR
	exec Var_92_i2c_read, Var_93_i2c_read
	exec _MOVMCR, MCR
	exec Var_93_i2c_read, Var_94_i2c_read
	exec _SHLMCR, MCR
	exec Var_91_i2c_read, Var_94_i2c_read
	exec _MOVMCR, MCR
	exec Var_94_i2c_read, Var_95_i2c_read
	exec _ORMCR, MCR
	exec Var_90_i2c_read, Var_95_i2c_read
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_95_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_96_i2c_read
Label_96_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_97_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_98_i2c_read
	exec _ADDMCR, MCR
	exec Var_97_i2c_read, Var_98_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_98_i2c_read, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_82_i2c_read
Label_99_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_release_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_100_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_101_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_101_i2c_read, _TMP
	exec _ADDMCR, MCR
	exec imm.0, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_102_i2c_read
	exec _MEMMCR, MCR
	exec Var_100_i2c_read, Var_102_i2c_read
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.5, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_103_i2c_read
Label_103_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_104_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_104_i2c_read, Var_105_i2c_read
	exec _SUBLMCR, MCR
	exec imm.7, Var_105_i2c_read
	exec _MOVMCR, MCR
	exec CHR, Var_105_i2c_read
	exec _ANDMCR, MCR
	exec _icmp_slt, Var_105_i2c_read -> Label_120_i2c_read
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_106_i2c_read
Label_106_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_107_i2c_read, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_108_i2c_read, Var_107_i2c_read
	exec _MOVMCR, MCR
	exec imm.33, Var_109_i2c_read
	exec _ANDMCR, MCR
	exec Var_108_i2c_read, Var_109_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec Var_109_i2c_read, _TMP2
	exec Var_109_i2c_read, _TMPZERO
	exec _ONECONST, _ONETMP
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ZERO, _TMP2 -> negativeOrZero_963_
	exec _SHRMCR, MCR
	exec Var_109_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_110_i2c_read
	exec _SUBLMCR, MCR
	exec _TMP, _TMP -> exit_963_
negativeOrZero_963_:		exec _ANDMCR, MCR
	exec _NEGATIVE, _TMPZERO
	exec _SUBLMCR, MCR
	exec _TMPZERO, _TMP4 -> exit2_963_
	exec _MOVMCR, MCR
	exec _ZERO, _TMP4
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
loop_963_:		exec _SHRMCR, MCR
	exec imm.6, _ONETMP
	exec _ORMCR, MCR
	exec _NEGATIVE, _ONETMP
	exec _MOVMCR, MCR
	exec _ONETMP, Var_110_i2c_read
	exec _ZERO, _TMP4
	exec _ONECONST, _ONETMP
	exec _SUBLMCR, MCR
	exec _ONECONST, _TMP
	exec _TMP, _TMP4 -> loop_963_
exit2_963_:		exec _MOVMCR, MCR
	exec Var_109_i2c_read, Var_110_i2c_read
exit_963_:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_110_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_111_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.12, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_112_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_113_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.12, Var_114_i2c_read
	exec _SUBLMCR, MCR
	exec Var_113_i2c_read, Var_114_i2c_read
	exec _MOVMCR, MCR
	exec Var_114_i2c_read, Var_115_i2c_read
	exec _SHLMCR, MCR
	exec Var_112_i2c_read, Var_115_i2c_read
	exec _MOVMCR, MCR
	exec Var_115_i2c_read, Var_116_i2c_read
	exec _ORMCR, MCR
	exec Var_111_i2c_read, Var_116_i2c_read
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_116_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_117_i2c_read
Label_117_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_118_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, Var_119_i2c_read
	exec _ADDMCR, MCR
	exec Var_118_i2c_read, Var_119_i2c_read
	exec _MOVMCR, MCR
	exec imm.6, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec Var_119_i2c_read, _TMP
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_103_i2c_read
Label_120_i2c_read:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_drive_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_low_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.7, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_121_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec imm.2, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_122_i2c_read, _TMP
	exec _MOVMCR, MCR
	exec Var_122_i2c_read, _TMP
	exec _ADDMCR, MCR
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_123_i2c_read
	exec _MEMMCR, MCR
	exec Var_121_i2c_read, Var_123_i2c_read
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_scl
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.13, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_high_sda
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
MAX30205_read:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MEMRMCR, MCR
	exec Var_0_MAX30205_read, m_ptr
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
	exec Var_0_MAX30205_read, _TMP
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_3_MAX30205_read, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.1, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.29, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.5, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_3_MAX30205_read, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_read
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec link_register, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _PCSMCR, MCR
	exec _TMP, link_register
led_init:			exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec link_register, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
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
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_main, _TMP
	exec _ADDMCR, MCR
	exec imm.0, _TMP
	exec _MEMRMCR, MCR
	exec Var_4_main.0, _TMP
	exec _MOVMCR, MCR
	exec imm.5, Var_4_main
	exec _MOVMCR, MCR
	exec imm.5, Var_4_main.0
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMMCR, MCR
	exec imm.1, _TMP
	exec _MEMRMCR, MCR
	exec Var_5_main, %ma-Global_mOISC_csr
	exec _MEMMCR, MCR
	exec imm.20, Var_5_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> spiLEDInit
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> i2c_init
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_6_main, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_7_main, Var_6_main
	exec _MOVMCR, MCR
	exec Var_7_main, Var_8_main
	exec _ANDMCR, MCR
	exec imm.44, Var_8_main
	exec _MEMRMCR, MCR
	exec Var_9_main, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_8_main, Var_9_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.9, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> delay
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_10_main, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_11_main, Var_10_main
	exec _MOVMCR, MCR
	exec Var_11_main, Var_12_main
	exec _ORMCR, MCR
	exec imm.45, Var_12_main
	exec _MEMRMCR, MCR
	exec Var_13_main, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_12_main, Var_13_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_init
	exec _MEMRMCR, MCR
	exec Var_14_main, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_14_main, Var_15_main
	exec _SUBLMCR, MCR
	exec imm.5, Var_15_main
	exec _MOVMCR, MCR
	exec CHR, Var_15_main
	exec _ANDMCR, MCR
	exec _icmp_eq, Var_15_main -> Label_18_main
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_16_main
Label_16_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_17_main
Label_17_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_17_main
Label_18_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_19_main
Label_19_main:		exec _SUBLMCR, MCR
	exec _NULL, _NULL
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.5, _TMP
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_20_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_20_main, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> MAX30205_read
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.1, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.5, _TMP
	exec imm.5, _TMP
	exec _MOVMCR, MCR
	exec _TMP, Var_21_main
	exec _MOVMCR, MCR
	exec imm.3, _TMP
	exec _ADDMCR, MCR
	exec m_ptr, _TMP
	exec _MEMRMCR, MCR
	exec Var_22_main, _TMP
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_21_main, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec Var_22_main, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> RH_RF95_send
	exec _MEMRMCR, MCR
	exec Var_23_main, m_ptr
	exec _SUBLMCR, MCR
	exec imm.0, m_ptr
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_24_main, %ma-Global_mOISC_csr
	exec _MEMMCR, MCR
	exec imm.5, Var_24_main
	exec _MEMRMCR, MCR
	exec Var_25_main, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_26_main, Var_25_main
	exec _MOVMCR, MCR
	exec Var_26_main, Var_27_main
	exec _ORMCR, MCR
	exec imm.21, Var_27_main
	exec _MEMRMCR, MCR
	exec Var_28_main, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_27_main, Var_28_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> delay
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_29_main, %ma-Global_mOISC_ior
	exec _MEMRMCR, MCR
	exec Var_30_main, Var_29_main
	exec _MOVMCR, MCR
	exec Var_30_main, Var_31_main
	exec _ANDMCR, MCR
	exec imm.46, Var_31_main
	exec _MEMRMCR, MCR
	exec Var_32_main, %ma-Global_mOISC_ior
	exec _MEMMCR, MCR
	exec Var_31_main, Var_32_main
	exec _MOVMCR, MCR
	exec m_ptr, _TMP
	exec _ADDMCR, MCR
	exec imm.4, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec imm.0, _TMP
	exec _ADDMCR, MCR
	exec imm.0, m_ptr
	exec _MEMMCR, MCR
	exec _TMP, m_ptr
	exec _PCMCR, MCR
	exec _TMP, link_register
	exec _SUBLMCR, MCR
	exec _PCMCR_RETADDRBL, link_register
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> delay
	exec _MEMRMCR, MCR
	exec _TMP, m_ptr
	exec _MOVMCR, MCR
	exec _TMP, m_ptr
	exec _MEMRMCR, MCR
	exec Var_33_main, %ma-Global_mOISC_csr
	exec _MEMMCR, MCR
	exec imm.20, Var_33_main
	exec _SUBLMCR, MCR
	exec _NULL, _NULL -> Label_19_main
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
%ma-Global_mOISC_ior:		22331
Global_mOISC_ior:		7
%ma-Global_mOISC_idr:		22333
Global_mOISC_idr:		6
%ma-Global_mOISC_isr:		22335
Global_mOISC_isr:		5
%ma-Global_mOISC_csr:		22337
Global_mOISC_csr:		4
%ma-Global_mOISC_icr:		22339
Global_mOISC_icr:		3
%ma-Global_mOISC_iwr:		22341
Global_mOISC_iwr:		2
%ma-Global_mOISC_chr:		22343
Global_mOISC_chr:		1
%ma-Global_mOISC_mcr:		22345
Global_mOISC_mcr:		0
%ma-Global_current_idr:		22347
Global_current_idr:		192
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
Var_0_delay:		0
Var_5_delay:		0
Var_6_delay:		0
Var_7_delay:		0
_icmp_sle:		12
Var_10_delay:		0
Var_11_delay:		0
Var_0_spi_ll:		0
Var_1_spi_ll:		0
Var_2_spi_ll:		0
imm.7:		8
imm.8:		9
imm.9:		10
Var_14_spi_ll:		0
Var_15_spi_ll:		0
Var_16_spi_ll:		0
imm.10:		247
Var_17_spi_ll:		0
Var_18_spi_ll:		0
imm.11:		127
Var_19_spi_ll:		0
Var_20_spi_ll:		0
imm.12:		7
Var_21_spi_ll:		0
Var_22_spi_ll:		0
Var_23_spi_ll:		0
Var_24_spi_ll:		0
Var_26_spi_ll:		0
Var_27_spi_ll:		0
Var_29_spi_ll:		0
Var_30_spi_ll:		0
Var_31_spi_ll:		0
Var_32_spi_ll:		0
_TMP2:		0
_TMP4:		0
_TMPZERO:		0
_ONECONST:		1
_ONETMP:		1
_ZERO:		0
_NEGATIVE:		-32768
Var_33_spi_ll:		0
Var_34_spi_ll:		0
Var_35_spi_ll:		0
Var_36_spi_ll:		0
Var_37_spi_ll:		0
Var_38_spi_ll:		0
Var_39_spi_ll:		0
Var_40_spi_ll:		0
Var_41_spi_ll:		0
Var_42_spi_ll:		0
Var_44_spi_ll:		0
Var_45_spi_ll:		0
Var_48_spi_ll:		0
Var_49_spi_ll:		0
Var_51_spi_ll:		0
Var_52_spi_ll:		0
Var_53_spi_ll:		0
Var_54_spi_ll:		0
Var_55_spi_ll:		0
Var_56_spi_ll:		0
Var_57_spi_ll:		0
Var_58_spi_ll:		0
Var_59_spi_ll:		0
Var_60_spi_ll:		0
Var_61_spi_ll:		0
Var_62_spi_ll:		0
Var_63_spi_ll:		0
Var_64_spi_ll:		0
Var_65_spi_ll:		0
Var_66_spi_ll:		0
Var_67_spi_ll:		0
Var_68_spi_ll:		0
Var_69_spi_ll:		0
Var_70_spi_ll:		0
Var_71_spi_ll:		0
Var_72_spi_ll:		0
Var_73_spi_ll:		0
Var_74_spi_ll:		0
Var_75_spi_ll:		0
Var_77_spi_ll:		0
Var_78_spi_ll:		0
Var_80_spi_ll:		0
Var_81_spi_ll:		0
Var_82_spi_ll:		0
imm.13:		11
_PCMCR_RETADDRBL:		-12
Var_83_spi_ll:		0
Var_84_spi_ll:		0
Var_85_spi_ll:		0
Var_86_spi_ll:		0
Var_0_spitransaction:		0
Var_9_spitransaction:		0
Var_10_spitransaction:		0
Var_11_spitransaction:		0
Var_12_spitransaction:		0
imm.14:		255
Var_14_spitransaction:		0
Var_15_spitransaction:		0
Var_17_spitransaction:		0
Var_18_spitransaction:		0
Var_19_spitransaction:		0
Var_20_spitransaction:		0
Var_21_spitransaction:		0
Var_22_spitransaction:		0
Var_23_spitransaction:		0
Var_24_spitransaction:		0
Var_25_spitransaction:		0
Var_26_spitransaction:		0
Var_27_spitransaction:		0
Var_28_spitransaction:		0
Var_29_spitransaction:		0
Var_30_spitransaction:		0
Var_32_spitransaction:		0
Var_33_spitransaction:		0
Var_35_spitransaction:		0
Var_36_spitransaction:		0
Var_2_spiselect:		0
Var_3_spiselect:		0
Var_4_spiselect:		0
Var_5_spiselect:		0
Var_6_spiselect:		0
Var_7_spiselect:		0
Var_2_spiunselect:		0
Var_3_spiunselect:		0
Var_4_spiunselect:		0
Var_5_spiunselect:		0
Var_6_spiunselect:		0
Var_1_spiLEDInit:		0
Var_2_spiLEDInit:		0
imm.15:		59
Var_3_spiLEDInit:		0
Var_4_spiLEDInit:		0
Var_5_spiLEDInit:		0
Var_0_spiWrite:		0
Var_1_spiWrite:		0
Var_6_spiWrite:		0
Var_7_spiWrite:		0
Var_8_spiWrite:		0
Var_9_spiWrite:		0
Var_0_spiRead:		0
Var_4_spiRead:		0
Var_5_spiRead:		0
Var_6_spiRead:		0
Var_0_spiBurstWrite:		0
Var_1_spiBurstWrite:		0
Var_2_spiBurstWrite:		0
Var_7_spiBurstWrite:		0
Var_8_spiBurstWrite:		0
imm.16:		128
Var_10_spiBurstWrite:		0
Var_11_spiBurstWrite:		0
imm.17:		-1
Var_12_spiBurstWrite:		0
_icmp_eq:		8
Var_14_spiBurstWrite:		0
Var_15_spiBurstWrite:		0
Var_16_spiBurstWrite:		0
Var_17_spiBurstWrite:		0
Var_18_spiBurstWrite:		0
imm.18:		217
Var_1_RH_RF95_setFrequency_868:		0
Var_2_RH_RF95_setFrequency_868:		0
Var_3_RH_RF95_setFrequency_868:		0
imm.19:		228
Var_1_RH_RF95_setFrequency_915:		0
imm.20:		192
Var_2_RH_RF95_setFrequency_915:		0
Var_3_RH_RF95_setFrequency_915:		0
Var_0_RH_RF95_setPreambleLength:		0
Var_3_RH_RF95_setPreambleLength:		0
Var_4_RH_RF95_setPreambleLength:		0
imm.21:		32
Var_5_RH_RF95_setPreambleLength:		0
Var_6_RH_RF95_setPreambleLength:		0
Var_7_RH_RF95_setPreambleLength:		0
imm.22:		33
Var_8_RH_RF95_setPreambleLength:		0
Var_1_RH_RF95_setModeIdle:		0
imm.23:		29
imm.24:		114
Var_1_RH_RF95_setModemConfig_Bw125Cr45Sf128:		0
imm.25:		30
imm.26:		116
Var_2_RH_RF95_setModemConfig_Bw125Cr45Sf128:		0
imm.27:		38
Var_3_RH_RF95_setModemConfig_Bw125Cr45Sf128:		0
imm.28:		146
Var_1_RH_RF95_setModemConfig_Bw500Cr45Sf128:		0
Var_2_RH_RF95_setModemConfig_Bw500Cr45Sf128:		0
Var_3_RH_RF95_setModemConfig_Bw500Cr45Sf128:		0
imm.29:		72
Var_1_RH_RF95_setModemConfig_Bw31_25Cr48Sf512:		0
imm.30:		148
Var_2_RH_RF95_setModemConfig_Bw31_25Cr48Sf512:		0
Var_3_RH_RF95_setModemConfig_Bw31_25Cr48Sf512:		0
imm.31:		120
Var_1_RH_RF95_setModemConfig_Bw125Cr48Sf4096:		0
imm.32:		196
Var_2_RH_RF95_setModemConfig_Bw125Cr48Sf4096:		0
Var_3_RH_RF95_setModemConfig_Bw125Cr48Sf4096:		0
Var_0_RH_RF95_setTxPower:		0
Var_3_RH_RF95_setTxPower:		0
Var_4_RH_RF95_setTxPower:		0
Var_5_RH_RF95_setTxPower:		0
Var_6_RH_RF95_setTxPower:		0
Var_1_RH_RF95_setModeTx:		0
imm.33:		64
Var_2_RH_RF95_setModeTx:		0
Var_0_RH_RF95_send:		0
Var_1_RH_RF95_send:		0
Var_6_RH_RF95_send:		0
Var_7_RH_RF95_send:		0
imm.34:		251
_icmp_sgt:		2
imm.35:		13
Var_10_RH_RF95_send:		0
Var_11_RH_RF95_send:		0
Var_12_RH_RF95_send:		0
Var_13_RH_RF95_send:		0
Var_14_RH_RF95_send:		0
Var_15_RH_RF95_send:		0
Var_16_RH_RF95_send:		0
Var_17_RH_RF95_send:		0
Var_18_RH_RF95_send:		0
imm.36:		34
Var_19_RH_RF95_send:		0
imm.37:		18
Var_21_RH_RF95_send:		0
Var_22_RH_RF95_send:		0
Var_23_RH_RF95_send:		0
Var_27_RH_RF95_send:		0
Var_2_RH_RF95_init:		0
imm.38:		200
Var_3_RH_RF95_init:		0
Var_4_RH_RF95_init:		0
imm.39:		14
Var_7_RH_RF95_init:		0
imm.40:		15
Var_8_RH_RF95_init:		0
Var_10_RH_RF95_init:		0
Var_1_i2c_low_scl:		0
Var_2_i2c_low_scl:		0
Var_3_i2c_low_scl:		0
Var_4_i2c_low_scl:		0
Var_5_i2c_low_scl:		0
Var_6_i2c_low_scl:		0
Var_7_i2c_low_scl:		0
imm.41:		63
Var_8_i2c_low_scl:		0
Var_1_i2c_high_scl:		0
Var_2_i2c_high_scl:		0
Var_3_i2c_high_scl:		0
Var_4_i2c_high_scl:		0
Var_1_i2c_low_sda:		0
Var_2_i2c_low_sda:		0
Var_3_i2c_low_sda:		0
Var_4_i2c_low_sda:		0
Var_5_i2c_low_sda:		0
Var_6_i2c_low_sda:		0
Var_7_i2c_low_sda:		0
imm.42:		191
Var_8_i2c_low_sda:		0
Var_1_i2c_release_sda:		0
Var_2_i2c_release_sda:		0
Var_3_i2c_release_sda:		0
Var_4_i2c_release_sda:		0
Var_1_i2c_drive_sda:		0
Var_2_i2c_drive_sda:		0
Var_3_i2c_drive_sda:		0
Var_4_i2c_drive_sda:		0
Var_1_i2c_high_sda:		0
Var_2_i2c_high_sda:		0
Var_3_i2c_high_sda:		0
Var_4_i2c_high_sda:		0
Var_0_i2c_write:		0
Var_1_i2c_write:		0
Var_2_i2c_write:		0
Var_3_i2c_write:		0
Var_4_i2c_write:		0
Var_19_i2c_write:		0
Var_20_i2c_write:		0
Var_22_i2c_write:		0
Var_23_i2c_write:		0
Var_25_i2c_write:		0
Var_26_i2c_write:		0
Var_27_i2c_write:		0
Var_28_i2c_write:		0
Var_29_i2c_write:		0
Var_30_i2c_write:		0
Var_31_i2c_write:		0
Var_36_i2c_write:		0
Var_37_i2c_write:		0
Var_39_i2c_write:		0
Var_40_i2c_write:		0
Var_41_i2c_write:		0
Var_42_i2c_write:		0
Var_44_i2c_write:		0
Var_45_i2c_write:		0
Var_47_i2c_write:		0
Var_48_i2c_write:		0
Var_49_i2c_write:		0
Var_50_i2c_write:		0
Var_51_i2c_write:		0
Var_52_i2c_write:		0
Var_53_i2c_write:		0
Var_58_i2c_write:		0
Var_59_i2c_write:		0
Var_61_i2c_write:		0
Var_62_i2c_write:		0
Var_63_i2c_write:		0
Var_64_i2c_write:		0
Var_65_i2c_write:		0
Var_66_i2c_write:		0
Var_68_i2c_write:		0
Var_70_i2c_write:		0
imm.43:		12
Var_73_i2c_write:		0
Var_74_i2c_write:		0
Var_76_i2c_write:		0
Var_77_i2c_write:		0
Var_78_i2c_write:		0
Var_79_i2c_write:		0
Var_80_i2c_write:		0
Var_81_i2c_write:		0
Var_82_i2c_write:		0
Var_87_i2c_write:		0
Var_88_i2c_write:		0
Var_90_i2c_write:		0
Var_91_i2c_write:		0
Var_92_i2c_write:		0
Var_93_i2c_write:		0
Var_94_i2c_write:		0
Var_95_i2c_write:		0
Var_97_i2c_write:		0
Var_99_i2c_write:		0
Var_100_i2c_write:		0
Var_102_i2c_write:		0
Var_103_i2c_write:		0
Var_104_i2c_write:		0
Var_105_i2c_write:		0
Var_106_i2c_write:		0
Var_107_i2c_write:		0
Var_108_i2c_write:		0
Var_113_i2c_write:		0
Var_114_i2c_write:		0
Var_116_i2c_write:		0
Var_117_i2c_write:		0
Var_118_i2c_write:		0
Var_119_i2c_write:		0
Var_0_i2c_read:		0
Var_1_i2c_read:		0
Var_2_i2c_read:		0
Var_14_i2c_read:		0
Var_15_i2c_read:		0
Var_17_i2c_read:		0
Var_18_i2c_read:		0
Var_20_i2c_read:		0
Var_21_i2c_read:		0
Var_22_i2c_read:		0
Var_23_i2c_read:		0
Var_24_i2c_read:		0
Var_25_i2c_read:		0
Var_26_i2c_read:		0
Var_31_i2c_read:		0
Var_32_i2c_read:		0
Var_34_i2c_read:		0
Var_35_i2c_read:		0
Var_36_i2c_read:		0
Var_37_i2c_read:		0
Var_39_i2c_read:		0
Var_40_i2c_read:		0
Var_42_i2c_read:		0
Var_43_i2c_read:		0
Var_44_i2c_read:		0
Var_45_i2c_read:		0
Var_46_i2c_read:		0
Var_47_i2c_read:		0
Var_48_i2c_read:		0
Var_53_i2c_read:		0
Var_54_i2c_read:		0
Var_56_i2c_read:		0
Var_57_i2c_read:		0
Var_58_i2c_read:		0
Var_59_i2c_read:		0
Var_61_i2c_read:		0
Var_62_i2c_read:		0
Var_64_i2c_read:		0
Var_65_i2c_read:		0
Var_66_i2c_read:		0
Var_67_i2c_read:		0
Var_68_i2c_read:		0
Var_69_i2c_read:		0
Var_70_i2c_read:		0
Var_75_i2c_read:		0
Var_76_i2c_read:		0
Var_78_i2c_read:		0
Var_79_i2c_read:		0
Var_80_i2c_read:		0
Var_81_i2c_read:		0
Var_83_i2c_read:		0
Var_84_i2c_read:		0
Var_86_i2c_read:		0
Var_87_i2c_read:		0
Var_88_i2c_read:		0
Var_89_i2c_read:		0
Var_90_i2c_read:		0
Var_91_i2c_read:		0
Var_92_i2c_read:		0
Var_93_i2c_read:		0
Var_94_i2c_read:		0
Var_95_i2c_read:		0
Var_97_i2c_read:		0
Var_98_i2c_read:		0
Var_100_i2c_read:		0
Var_101_i2c_read:		0
Var_102_i2c_read:		0
Var_104_i2c_read:		0
Var_105_i2c_read:		0
Var_107_i2c_read:		0
Var_108_i2c_read:		0
Var_109_i2c_read:		0
Var_110_i2c_read:		0
Var_111_i2c_read:		0
Var_112_i2c_read:		0
Var_113_i2c_read:		0
Var_114_i2c_read:		0
Var_115_i2c_read:		0
Var_116_i2c_read:		0
Var_118_i2c_read:		0
Var_119_i2c_read:		0
Var_121_i2c_read:		0
Var_122_i2c_read:		0
Var_123_i2c_read:		0
Var_0_MAX30205_read:		0
Var_3_MAX30205_read:		0
Var_4_main:		0
Var_4_main.0:		0
Var_5_main:		0
Var_6_main:		0
Var_7_main:		0
Var_8_main:		0
imm.44:		239
Var_9_main:		0
Var_10_main:		0
Var_11_main:		0
Var_12_main:		0
imm.45:		16
Var_13_main:		0
Var_14_main:		0
Var_15_main:		0
Var_20_main:		0
Var_21_main:		0
Var_22_main:		0
Var_23_main:		0
Var_24_main:		0
Var_25_main:		0
Var_26_main:		0
Var_27_main:		0
Var_28_main:		0
Var_29_main:		0
Var_30_main:		0
Var_31_main:		0
imm.46:		223
Var_32_main:		0
Var_33_main:		0
