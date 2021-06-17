---------------------------------------------------------------------------
-- dRISC 816 - Cyclone 10 LP FPGA Implementation
---------------------------------------------------------------------------
-- Module: behavioural ALU (dRISC_ALU)
-- Author: Marco Crepaldi
-- Organization: Istituto Italiano di Tecnologia, Electronic Design Lab
-- Date: August 18th 2020
-- Notes: with autogen hooks
---------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.dRISC_DEFINITIONS.all;

entity dRISC_ALU is

 port( MEM_A: in signed(MEMORY_WIDTH-1 downto 0); --E
		 MEM_B: in signed(MEMORY_WIDTH-1 downto 0); --D
		 MEM_MEM_B: in signed(MEMORY_WIDTH-1 downto 0); --F
		 
		 PC: in std_logic_vector(MEMORY_WIDTH-1 downto 0);
		 DATA: out signed(MEMORY_WIDTH-1 downto 0);
		 MCR: in std_logic_vector(REG_WIDTH-1 downto 0);
		 OVERFLOW: out std_logic;
		 CMP: out std_logic_vector(CMP_WIDTH-1 downto 0);
		 CPU_STOPin: in std_logic;
		 
		 CLK: in std_logic;
		 RST: in std_logic);
		 
end dRISC_ALU;

architecture BEHAVIOURAL of dRISC_ALU is
-- autogen:specific:0:addleq
signal ADDLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal OVR_ADDLEQ: std_logic;
-- autogen:endspecific
-- autogen:specific:0:shlleq
signal SHLLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
-- autogen:specific:0:shrleq
signal SHRLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
-- autogen:specific:0:orleq
signal ORLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
-- autogen:specific:0:andleq
signal ANDLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
-- autogen:specific:0:xorleq
signal XORLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
-- autogen:specific:0:xnorleq
signal XNORLEQ: signed(MEMORY_WIDTH-1 downto 0);
-- autogen:endspecific
signal SUBLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal MOVLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal PCLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal MEMLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal MEMRLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal PCSLEQ: signed(MEMORY_WIDTH-1 downto 0);
signal DATAuu: signed(MEMORY_WIDTH-1 downto 0);
signal CMPLEQ: std_logic_vector(CMP_WIDTH-1 downto 0);
signal CMPuu: std_logic_vector(CMP_WIDTH-1 downto 0);
signal OVR_SUBLEQ: std_logic;
signal OVERFLOWu: std_logic;

begin

COMBINATIONAL_OVR0: process(MEM_A(MEMORY_WIDTH-1), MEM_B(MEMORY_WIDTH-1), DATAuu(MEMORY_WIDTH-1)) 
begin
			-- autogen:specific:1:addleq
			OVR_ADDLEQ <= (((not DATAuu(MEMORY_WIDTH-1)) and MEM_A(MEMORY_WIDTH-1) and MEM_B(MEMORY_WIDTH-1)) or ((DATAuu(MEMORY_WIDTH-1) and (not MEM_A(MEMORY_WIDTH-1)) and (not MEM_B(MEMORY_WIDTH-1)))));
			-- autogen:endspecific
			OVR_SUBLEQ <= (((not DATAuu(MEMORY_WIDTH-1)) and not MEM_A(MEMORY_WIDTH-1) and MEM_B(MEMORY_WIDTH-1)) or ((DATAuu(MEMORY_WIDTH-1) and (MEM_A(MEMORY_WIDTH-1)) and (not MEM_B(MEMORY_WIDTH-1)))));
	
end process;

SELECTOR_OVR: process( 
-- autogen:specific:2:addleq
OVR_ADDLEQ, 
-- autogen:endspecific
OVR_SUBLEQ, 
MCR)

begin

			case MCR is 
				-- autogen:specific:3:addleq
				when MCR_addleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= OVR_ADDLEQ; 
				-- autogen:endspecific
				-- autogen:specific:3:shlleq
				when MCR_shlleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;
				-- autogen:endspecific
				-- autogen:specific:3:shrleq
				when MCR_shrleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;
				-- autogen:endspecific
				-- autogen:specific:3:orleq
				when MCR_orleq(REG_WIDTH-1 downto 0) =>  OVERFLOWu <= ZERO_CONST;
				-- autogen:endspecific
				-- autogen:specific:3:andleq
				when MCR_andleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;
				-- autogen:endspecific
				-- autogen:specific:3:xorleq
				when MCR_xorleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;		
				-- autogen:endspecific
				-- autogen:specific:3:xnorleq
				when MCR_xnorleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;
				-- autogen:endspecific
				when MCR_subleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= OVR_SUBLEQ; 
				when MCR_movleq(REG_WIDTH-1 downto 0) => OVERFLOWu <= ZERO_CONST;
				when MCR_pc(REG_WIDTH-1 downto 0) =>  	OVERFLOWu <= ZERO_CONST;										
				when MCR_mem(REG_WIDTH-1 downto 0) => 	OVERFLOWu <= ZERO_CONST;
				when MCR_memr(REG_WIDTH-1 downto 0) => 	OVERFLOWu <= ZERO_CONST;
				when MCR_pcs(REG_WIDTH-1 downto 0) =>   OVERFLOWu <= ZERO_CONST;
				when others => 
			
							OVERFLOWu <= OVR_SUBLEQ;
			end case;
	
end process;

COMBINATIONAL0: process(PC, MEM_A, MEM_B, MEM_MEM_B) 
begin

			-- autogen:specific:4:addleq
			ADDLEQ <= resize(MEM_A+MEM_B, MEMORY_WIDTH);
			-- autogen:endspecific
			-- autogen:specific:4:shlleq
			SHLLEQ <= signed(shift_left(unsigned(MEM_A), natural(to_integer(unsigned(MEM_B)))));
			-- autogen:endspecific
			-- autogen:specific:4:shrleq
			SHRLEQ <= signed(shift_right(unsigned(MEM_A), natural(to_integer(unsigned(MEM_B)))));
			-- autogen:endspecific	
			-- autogen:specific:4:orleq
			for i in 0 to MEMORY_WIDTH-1 loop 
				ORLEQ(i) <= MEM_A(i) or MEM_B(i); 
			end loop;
			-- autogen:endspecific
			-- autogen:specific:4:andleq
			for i in 0 to MEMORY_WIDTH-1 loop 
				ANDLEQ(i) <= MEM_A(i) and MEM_B(i); 
			end loop;
			-- autogen:endspecific
			-- autogen:specific:4:xorleq
			for i in 0 to MEMORY_WIDTH-1 loop 
				XORLEQ(i) <= MEM_A(i) xor MEM_B(i); 
			end loop;
			-- autogen:endspecific
			-- autogen:specific:4:xnorleq
			for i in 0 to MEMORY_WIDTH-1 loop 
				XNORLEQ(i) <= MEM_A(i) xnor MEM_B(i); 
			end loop;
			-- autogen:endspecific
			SUBLEQ <= resize(MEM_B-MEM_A, MEMORY_WIDTH);
			MOVLEQ <= MEM_A;
			PCLEQ <= signed(PC);
			MEMLEQ <= (MEM_A);
			MEMRLEQ <= (MEM_MEM_B);
			PCSLEQ <= (MEM_B);
			if MEM_B > MEM_A then
				CMPLEQ <= CMP_B_BIGGER;
			elsif MEM_B < MEM_A then
				CMPLEQ <= CMP_A_BIGGER;
			else
				CMPLEQ <= CMP_AB_EQUAL;
			end if;
	
end process;

SELECTOR: process(CPU_STOPin, CLK, RST, MCR, 
-- autogen:specific:5:shrleq
SHRLEQ, 
-- autogen:endspecific
-- autogen:specific:5:shlleq
SHLLEQ, 
-- autogen:endspecific
-- autogen:specific:5:addleq
ADDLEQ, 
-- autogen:endspecific
-- autogen:specific:5:orleq
ORLEQ, 
-- autogen:endspecific
-- autogen:specific:5:andleq
ANDLEQ, 
-- autogen:endspecific
-- autogen:specific:5:xorleq
XORLEQ, 
-- autogen:endspecific
-- autogen:specific:5:xnorleq
XNORLEQ,
-- autogen:endspecific
SUBLEQ, 
MOVLEQ,  
PCLEQ, 
MEMLEQ, 
MEMRLEQ, 
PCSLEQ,
CMPLEQ)
begin

	if RST = '1' then
	
		DATAuu <= (others => '0');
		CMPuu <= CMP_NONE;
		
	elsif CLK'event and CLK = '1' then
	
		if CPU_STOPin = '1' then
			case MCR is 
				-- autogen:specific:6:addleq
				when MCR_addleq(REG_WIDTH-1 downto 0) => DATAuu <= ADDLEQ;
																	  CMPuu <= CMPLEQ;
				-- autogen:endspecific	
				-- autogen:specific:6:shlleq
				when MCR_shlleq(REG_WIDTH-1 downto 0) => DATAuu <= SHLLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific	
				-- autogen:specific:6:shrleq
				when MCR_shrleq(REG_WIDTH-1 downto 0) => DATAuu <= SHRLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific	
				-- autogen:specific:6:orleq
				when MCR_orleq(REG_WIDTH-1 downto 0) =>  DATAuu <= ORLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific	
				-- autogen:specific:6:andleq
				when MCR_andleq(REG_WIDTH-1 downto 0) => DATAuu <= ANDLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific	
				-- autogen:specific:6:xorleq
				when MCR_xorleq(REG_WIDTH-1 downto 0) => DATAuu <= XORLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific	
				-- autogen:specific:6:xnorleq
				when MCR_xnorleq(REG_WIDTH-1 downto 0) => DATAuu <= XNORLEQ;
																	  CMPuu <= CMP_NONE;					
				-- autogen:endspecific				  
				when MCR_movleq(REG_WIDTH-1 downto 0) => DATAuu <= MOVLEQ;
																	  CMPuu <= CMP_NONE;				
				when MCR_subleq(REG_WIDTH-1 downto 0) => DATAuu <= SUBLEQ;
																	  CMPuu <= CMPLEQ;				
				when MCR_pc(REG_WIDTH-1 downto 0) => DATAuu <= PCLEQ;
																 CMPuu <= CMP_NONE;					
				when MCR_mem(REG_WIDTH-1 downto 0) => DATAuu <= MEMLEQ;
																	CMPuu <= CMP_NONE;					
				when MCR_memr(REG_WIDTH-1 downto 0) => DATAuu <= MEMRLEQ;
																	CMPuu <= CMP_NONE;					
				when MCR_pcs(REG_WIDTH-1 downto 0) =>	DATAuu <= PCSLEQ;
																	CMPuu <= CMP_NONE;					
				when others => DATAuu <= SUBLEQ;			
									CMPuu <= CMPLEQ;					
			end case;
		end if;
		
	end if;
	
end process;

DATA <= DATAuu;
CMP <= CMPuu;
OVERFLOW <= OVERFLOWu;

end BEHAVIOURAL;

