---------------------------------------------------------------------------
-- dRISCe - Cyclone 10 LP FPGA Implementation
---------------------------------------------------------------------------
-- Module: Cyclone 10 LP I/O Controller (Synchronous Mode)
-- Author: Marco Crepaldi
-- Organization: Istituto Italiano di Tecnologia, Electronic Design Lab
-- Date: 22 April 2020
---------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use work.dRISC_DEFINITIONS.all;

entity dRISC_IOCONTROLLER is
	port(		
			CLK: in std_logic;
			RST: in std_logic;
			INTERRUPT_BLOCK: in std_logic;
			IOR: in std_logic_vector(REG_WIDTH-1 downto 0); 
			IWR: in std_logic_vector(REG_WIDTH-1 downto 0);
			ICR: in std_logic_vector(REG_WIDTH-1 downto 0);
			ISR: out std_logic_vector(REG_WIDTH-1 downto 0);
			INTERRUPT: out std_logic;
			CPU_STOP: out std_logic
			);
end dRISC_IOCONTROLLER;

architecture BEHAVIOURAL of dRISC_IOCONTROLLER is

type STATE_DEF is (RESET, WAIT_FOR_IWR, EDGE_DETECT, EDGE_DETECT_DIR, EDGE_DECIDE, LEAVE, RESYNC);

signal STATE, NEXT_STATE: STATE_DEF;
signal CLKu: std_logic;
signal CPU_STOPu: std_logic;
signal INTERRUPT_BLOCKu: std_logic;
signal DETECT_PREV: std_logic_vector(REG_WIDTH-1 downto 0);
signal DETECT_PREVu: std_logic_vector(REG_WIDTH-1 downto 0);

begin

CLKu <= CLK;

REGISTER0: process(CLKu, RST, NEXT_STATE, CPU_STOPu, INTERRUPT_BLOCK)
begin

	if RST = '1' then
	
		STATE <= RESET;
		CPU_STOP <= '1';
		INTERRUPT_BLOCKu <= '0';
		DETECT_PREVu <= (others => '0');
		
	elsif CLKu'event and CLKu='1' then
	
		STATE <= NEXT_STATE;
		CPU_STOP <= CPU_STOPu;
		INTERRUPT_BLOCKu <= INTERRUPT_BLOCK;
		DETECT_PREVu <= DETECT_PREV;
		
	end if;
	
end process;

NETWORK0: process(CLKu, RST, STATE, IWR, ICR, INTERRUPT_BLOCKu, DETECT_PREVu)
variable DETECT: std_logic_vector(REG_WIDTH-1 downto 0);
variable ISRt: std_logic_vector(REG_WIDTH-1 downto 0);
variable edge: Integer;

begin
	if RST = '1' then
		NEXT_STATE <= RESET;
	elsif CLKu'event and CLKu='1' then
	
		case (STATE) is
			when RESET => 	

						DETECT := (others => '0');
						ISRt := (others => '0');
						edge := 0;		

						NEXT_STATE <= WAIT_FOR_IWR;

						ISR <= (others => '0');
						DETECT_PREV <= (others => '0');						
						INTERRUPT <= '0';
						CPU_STOPu <= '1';
						
	
			when WAIT_FOR_IWR => 
	
						for i in 0 to REG_WIDTH-1 loop
							DETECT(i) := IOR(i) and IWR(i);
						end loop; 
						
						if INTERRUPT_BLOCKu = '0' then
							NEXT_STATE <= WAIT_FOR_IWR;
						else
							NEXT_STATE <= EDGE_DETECT;
						end if;

						DETECT_PREV <= DETECT;
						INTERRUPT <= '0';
						CPU_STOPu <= '1';		
						 
			when EDGE_DETECT => 

						edge := 0;			
						for i in 0 to REG_WIDTH-1 loop
							DETECT(i) := IOR(i) and IWR(i);
						end loop; 
						
						if DETECT = DETECT_PREVu then
							NEXT_STATE <= EDGE_DETECT;
						else
						  	NEXT_STATE <= EDGE_DETECT_DIR;
						end if;

						INTERRUPT <= '0';
						CPU_STOPu <= '0';
						
						 
			when EDGE_DETECT_DIR => 
			
						for i in 0 to REG_WIDTH-1 loop
							if( DETECT(i) = '1') and (DETECT_PREVu(i) = '0') and (ICR(i) = '1') then
								edge := 1;
								ISRt(i) := '1';
							elsif (DETECT(i) = '0') and (DETECT_PREVu(i) = '1') and (ICR(i) = '0') then
								edge := 1;
								ISRt(i) := '1';
							else
								ISRt(i) := '0';
							end if;
						end loop;
						
						NEXT_STATE <= EDGE_DECIDE;
						
						INTERRUPT <= '0';
						CPU_STOPu <= '0';
						
						 
			when EDGE_DECIDE => 
			
						if edge = 1 then
							NEXT_STATE <= LEAVE;
						else
							NEXT_STATE <= EDGE_DETECT;
						end if;
						
						DETECT_PREV <= DETECT;
						CPU_STOPu <= '0';
						
									 
			when LEAVE => 

						NEXT_STATE <= RESYNC;
						
					 	ISR <= ISRt;						
						INTERRUPT <= '1';						
						CPU_STOPu <= '1';
						
			-- This is necessary due to possible metastability conditions.
			when RESYNC => 
			
						NEXT_STATE <= RESET;

						ISR <= ISRt;						
						INTERRUPT <= '1';
						CPU_STOPu <= '1';
						
	
			when others => 
			
						NEXT_STATE <= RESET;
						
						
		end case;	
		
	end if;
	
end process;

end BEHAVIOURAL;
