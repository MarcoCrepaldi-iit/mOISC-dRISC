---------------------------------------------------------------------------
-- dRISC 816 - Cyclone 10 LP FPGA Implementation
---------------------------------------------------------------------------
-- Module: processor finite state machine (dRISC_FSM)
-- Author: Marco Crepaldi
-- Organization: Istituto Italiano di Tecnologia, Electronic Design Lab
-- Date: 21 August 2020
-- Revisions: 5 November 2020
---------------------------------------------------------------------------

library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.dRISC_DEFINITIONS.all;

entity dRISC_FSM is
port (CLK: in std_logic;
		RST: in std_logic;
		PC: out std_logic_vector(MEMORY_WIDTH-1 downto 0);
	   MCR: out std_logic_vector(REG_WIDTH-1 downto 0);
	   CHR: out std_logic_vector(REG_WIDTH-1 downto 0);
	   IWR: out std_logic_vector(REG_WIDTH-1 downto 0);
	   ICR: out std_logic_vector(REG_WIDTH-1 downto 0);
	   CSR: out std_logic_vector(REG_WIDTH-1 downto 0);
	   ISR: out std_logic_vector(REG_WIDTH-1 downto 0);
		ISRin: in std_logic_vector(REG_WIDTH-1 downto 0);
	   IOR: out std_logic_vector(REG_WIDTH-1 downto 0);
		IORin: in std_logic_vector(REG_WIDTH-1 downto 0);
	   IDR: out std_logic_vector(REG_WIDTH-1 downto 0);
	
	   ALU_DATA: in signed(MEMORY_WIDTH-1 downto 0);
		CMP: in std_logic_vector(CMP_WIDTH-1 downto 0);
		A: out std_logic_vector(MEMORY_WIDTH-1 downto 0); 
		B: out std_logic_vector(MEMORY_WIDTH-1 downto 0);
		C: out std_logic_vector(MEMORY_WIDTH-1 downto 0);
		D: out signed(MEMORY_WIDTH-1 downto 0);
		E: out signed(MEMORY_WIDTH-1 downto 0); 
		F: out signed(MEMORY_WIDTH-1 downto 0);
		INTERRUPT_BLOCK: out std_logic;
		INTERRUPT: in std_logic;
		CPU_STOP: out std_logic;
		OVERFLOW: in std_logic;
		CPU_STOPin: in std_logic;

		MEM_address		:OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		MEM_data		:OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		MEM_rden		:OUT STD_LOGIC  := '1';
		MEM_wren		:OUT STD_LOGIC ;
		MEM_q		: IN STD_LOGIC_VECTOR (15 DOWNTO 0)
		);
end dRISC_FSM;

architecture BEHAVIOURAL of dRISC_FSM is

type STATE_DEF is (TTA_MEMR_WRITE_BACK, TTA_MEM_WRITE_BACK, FETCH_0_SAVE_MCR, FETCH_MCR, ISR_UPDATE, IWR_RESET, IWR_INT_SET, WAIT_FOR_INTERRUPT, ISR_WRITE_BACK, FETCH_A, 
TTA_WRITE_BACK, LEQ_PC_WRITE_BACK, MEM_WRITE_BACK, MEMR_WRITE_BACK, PCS_WRITE_BACK, RESET, CPU_CYCLE_START, FETCH_B_SAVE_A, FETCH_C_SAVE_B, FETCH_D_SAVE_C, FETCH_E_SAVE_D, 
FETCH_F_SAVE_E, FETCH_0_SAVE_F, BOOTSTRAP_CTRL, TTA_CTRL, EXEC_CTRL, LEQ_FLAGS_WRITE_BACK, 
CPU_HALT, IWR_INT_TRIGGER);

signal STATE, NEXT_STATE: STATE_DEF;
signal MCRu: std_logic_vector(REG_WIDTH-1 downto 0);

begin

REGISTER0: process(CLK, RST, NEXT_STATE, CPU_STOPin)
begin

	if RST = '1' then
	
		STATE <= RESET;
	
	elsif CLK'event and CLK='1' then
	
		if CPU_STOPin = '1' then
			STATE <= NEXT_STATE;
		end if;
		
	end if;
	
end process;

MCR <= MCRu;

NETWORK0: process(STATE, MEM_q, IORin, ISRin, INTERRUPT, CLK, RST, ALU_DATA, OVERFLOW, CMP, CPU_STOPin)
variable PCi: natural := 0;
variable PCi_new: natural := 0;
variable PCi_newp: natural := 0;
variable Ai: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable Bi: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable Ci: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable Di: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable Ei: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable Fi: STD_LOGIC_VECTOR (MEMORY_WIDTH-1 DOWNTO 0);
variable MCRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable CHRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable IWRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable ICRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable CSRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable ISRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable IDRi: std_logic_vector(REG_WIDTH-1 downto 0);
variable IORi: std_logic_vector(REG_WIDTH-1 downto 0);
variable ISRi_new: std_logic_vector(REG_WIDTH-1 downto 0);	
variable ALU_DATAi: signed(MEMORY_WIDTH-1 DOWNTO 0);
variable F_MODE_OFFSET: natural := 0;
variable F_MODE: std_logic := '0';

begin

	if RST = '1' then
	
		NEXT_STATE <= RESET;
		
	elsif CLK'event and CLK='1' then
	
		if CPU_STOPin = '1' then
			case (STATE) is
	
				when RESET => 	
				
							PCi := 0;
							PCi_new :=0;
							PCi_newp :=0;
							
							F_MODE_OFFSET := 0;
							F_MODE := '0';
							
							ISRi_new := (others => '0');
							ALU_DATAi:=(others => '0');
							Ai := (others => '0');
							Bi := (others => '0');
							Ci := (others => '0');
							Di := (others => '0');
							Ei := (others => '0');
							Fi := (others => '0');
							MCRi := (others => '0');
							CHRi := (others => '0');
							IWRi := (others => '0');
							ICRi := (others => '0');
							CSRi := (others => '0');
							ISRi := (others => '0');
							IDRi := (others => '0');
							IORi := (others => '0');							
														
							MEM_address <= (others => '0');
							MEM_data <= (others => '0');
							MEM_wren <= '0';
							MEM_rden <= '0';							
							
							NEXT_STATE <= CPU_CYCLE_START;

							PC <= std_logic_vector(to_unsigned(PCi, MEMORY_WIDTH));
							A <= Ai;
							B <= Bi;
							C <= Ci;
							D <= signed(Di);
							E <= signed(Ei);
							F <= signed(Fi);
							MCRu <= (others => '0');
							CHR <= (others => '0');
							IWR <= (others => '0');
							ICR <= (others => '0');
							CSR <= (others => '0');
							ISR <= (others => '0');
							IDR <= (others => '0');
							IOR <= (others => '0');							

							INTERRUPT_BLOCK <= '0';
							CPU_STOP <= '0';
							
							
				when CPU_CYCLE_START => 		

							PCi := PCi_new;
							IORi := IORin;
							
							MEM_address <= IOR_addr;
							MEM_data <= MEM_REG_TAP & std_logic_vector(IORi);
							MEM_wren <= '1';
							MEM_rden <= '0';
							
							if F_MODE = '0' or PCi < BOOTSTRAP_REGS then
								NEXT_STATE <= FETCH_A; 
							else
								NEXT_STATE <= FETCH_MCR;
							end if;

							PC <= std_logic_vector(to_unsigned(PCi, MEMORY_WIDTH));
							MCRu <= MCRi; 			
							IOR <= IORi;								
							INTERRUPT_BLOCK <= '0';							
							CPU_STOP <= '0';						

				when FETCH_MCR =>	  				
				
							MEM_address <= std_logic_vector(to_unsigned(PCi, MEMORY_WIDTH));
							MEM_rden <= '1';
							MEM_wren <= '0';		
					
							NEXT_STATE <= FETCH_0_SAVE_MCR;			
							
				when FETCH_0_SAVE_MCR =>	 							

							MCRi := MEM_q(REG_WIDTH-1 downto 0);
													
							MEM_rden <= '0';		
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_A;
							
							MCRu <= MCRi;		
							
				when FETCH_A =>	                 

							MEM_address <= std_logic_vector(to_unsigned(PCi+F_MODE_OFFSET, MEMORY_WIDTH));
							MEM_rden <= '1';
							MEM_wren <= '0';
							
							NEXT_STATE <= FETCH_B_SAVE_A;	
							

				when FETCH_B_SAVE_A =>		

							Ai := MEM_q;
													
							MEM_address <= std_logic_vector(to_unsigned(PCi+1+F_MODE_OFFSET, MEMORY_WIDTH));
							MEM_rden <= '1';		
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_C_SAVE_B;
							
							A <= Ai;		
							

				when FETCH_C_SAVE_B =>		

							Bi := MEM_q;
													
							MEM_address <= std_logic_vector(to_unsigned(PCi+2+F_MODE_OFFSET, MEMORY_WIDTH));
							MEM_rden <= '1';
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_D_SAVE_C;
							
							B <= Bi;		
							

				when FETCH_D_SAVE_C  =>		

							Ci := MEM_q;
														
							MEM_address <= Bi;
							MEM_rden <= '1';
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_E_SAVE_D;
							
							C <= Ci;		
							

				when FETCH_E_SAVE_D => 		
	
							Di := MEM_q;
						
							MEM_address <= Ai;
							MEM_rden <= '1';	
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_F_SAVE_E;

							D <= signed(Di);		
							
							
				when FETCH_F_SAVE_E =>		

							Ei := MEM_q;
						
							MEM_address <= Di;
							MEM_rden <= '1';	
							MEM_wren <= '0';							
							
							NEXT_STATE <= FETCH_0_SAVE_F;

							E <= signed(Ei);		
							

				when FETCH_0_SAVE_F =>		
	
							Fi := MEM_q;
							
							MEM_address <= (others => '0');
							MEM_rden <= '0';
							MEM_wren <= '0';							
							
							if PCi < BOOTSTRAP_REGS then
								NEXT_STATE <= BOOTSTRAP_CTRL;
							elsif to_integer(unsigned(Bi)) < BOOTSTRAP_REGS then
								NEXT_STATE <= TTA_CTRL;
							else
								NEXT_STATE <= EXEC_CTRL;
							end if;

							F <= signed(Fi);		
							
							
				when BOOTSTRAP_CTRL =>	
	
							PCi_new := PCi + 1;

							MEM_rden <= '0';
							MEM_wren <= '0';								
							
							if PCi = to_integer(unsigned(MCR_addr)) then
								MCRi := Ai(REG_WIDTH-1 downto 0);
								MCRu <= MCRi;
								if MCRi = ZERO_CONST_REG then
									F_MODE := '1';
									F_MODE_OFFSET := 1;
								else
									F_MODE := '0';
									F_MODE_OFFSET := 0;
								end if;
							elsif PCi = to_integer(unsigned(CHR_addr)) then
								CHRi := Ai(REG_WIDTH-1 downto 0);
								CHR <= CHRi;
							elsif PCi = to_integer(unsigned(IWR_addr)) then
								IWRi := Ai(REG_WIDTH-1 downto 0);
								IWR <= IWRi;
							elsif PCi = to_integer(unsigned(ICR_addr)) then
								ICRi := Ai(REG_WIDTH-1 downto 0);
								ICR <= ICRi;
							elsif PCi = to_integer(unsigned(CSR_addr)) then
								CSRi := Ai(REG_WIDTH-1 downto 0);
								CSR <= CSRi;
							elsif PCi = to_integer(unsigned(ISR_addr)) then
								ISRi := (others => '0');
								ISR <= ISRi;
							elsif PCi = to_integer(unsigned(IDR_addr)) then
								IDRi := Ai(REG_WIDTH-1 downto 0);
								IDR <= IDRi;
								for i in 0 to REG_WIDTH-1 loop
										IORi(i) := IORi(i) and IDRi(i);
								end loop;
								IOR <= IORi;						
							elsif PCi = to_integer(unsigned(IOR_addr)) then
								IORi := Ai(REG_WIDTH-1 downto 0);
								for i in 0 to REG_WIDTH-1 loop
										IORi(i) := IORi(i) and IDRi(i);
								end loop;
								IOR <= IORi;							
							end if;
							
							NEXT_STATE <= CPU_CYCLE_START;	
							
							
				when TTA_CTRL =>	

							MEM_rden <= '0';
							MEM_wren <= '0';		
	
							if Bi = MCR_addr then
								MCRi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0); 
								NEXT_STATE <= TTA_WRITE_BACK;
							elsif Bi = CHR_addr then
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);
								CHRi := Ei(REG_WIDTH-1 downto 0);
								if CHRi = CHR_halt then
									NEXT_STATE <= CPU_HALT;
								else
									NEXT_STATE <= TTA_WRITE_BACK;
								end if;
							elsif Bi = IWR_addr then
								IWRi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);
								NEXT_STATE <= IWR_INT_TRIGGER;
							elsif Bi = ICR_addr then
								ICRi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);
								NEXT_STATE <= TTA_WRITE_BACK;
							elsif Bi = CSR_addr then
								CSRi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);
								NEXT_STATE <= TTA_WRITE_BACK;
							elsif Bi = ISR_addr then
								PCi_new := to_integer(unsigned(Ci));
								NEXT_STATE <= CPU_CYCLE_START;										
							elsif Bi = IDR_addr then
								IDRi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);		
								for i in 0 to REG_WIDTH-1 loop
										IORi(i) := IORi(i) and IDRi(i);
								end loop;
								NEXT_STATE <= TTA_WRITE_BACK;
							elsif Bi = IOR_addr then	
								IORi := Ei(REG_WIDTH-1 downto 0);
								MCRu <= MCR_movleq(REG_WIDTH-1 downto 0);		
								for i in 0 to REG_WIDTH-1 loop
										IORi(i) := IORi(i) and IDRi(i);
								end loop;
								Ei(REG_WIDTH-1 downto 0) := IORi;
								E <= signed(Ei);
								NEXT_STATE <= TTA_WRITE_BACK;
							end if;

							ICR <= ICRi;
							IDR <= IDRi;
							IOR <= IORi;
							IWR <= IWRi;							
							CSR <= CSRi;	
							CHR <= CHRi;		
							
						 
				when EXEC_CTRL => 
	
							MEM_rden <= '0';
							MEM_wren <= '0';		
	
							if MCRi = MCR_pc(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= LEQ_PC_WRITE_BACK;
							elsif MCRi = MCR_memr(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= MEMR_WRITE_BACK; --
							elsif MCRi = MCR_mem(REG_WIDTH-1 downto 0) then
							   NEXT_STATE <= MEM_WRITE_BACK; --
							elsif MCRi = MCR_pcs(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= PCS_WRITE_BACK; --
							else
								NEXT_STATE <= LEQ_PC_WRITE_BACK;
							end if;							
							

				when TTA_WRITE_BACK =>  	

							ALU_DATAi := ALU_DATA;
							
							MEM_address <= Bi;
							MEM_data <= std_logic_vector(ALU_DATAi);
							MEM_wren <= '1';
							MEM_rden <= '0';

							PCi_new := to_integer(unsigned(Ci));
							
							NEXT_STATE <= CPU_CYCLE_START;	
						
							
							  
				when LEQ_PC_WRITE_BACK => 
	
							ALU_DATAi := ALU_DATA;
							
							if to_integer(signed(ALU_DATAi)) <= 0 then
								PCi_new := to_integer(unsigned(Ci));
							else
								PCi_new := PCi + 3 + F_MODE_OFFSET;
							end if;							
							
							MEM_address <= Bi;
							MEM_data <= std_logic_vector(ALU_DATAi);
							MEM_wren <= '1';
							MEM_rden <= '0';
							
							if MCRi = MCR_pc(REG_WIDTH-1 downto 0) then 
								NEXT_STATE <= CPU_CYCLE_START;	
							elsif MCRi = MCR_movleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;	
							-- autogen:specific:0:shrleq
							elsif MCRi = MCR_shrleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;
							-- autogen:endspecific
							-- autogen:specific:0:shlleq
							elsif MCRi = MCR_shlleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;	
							-- autogen:endspecific	
							-- autogen:specific:0:andleq						
							elsif MCRi = MCR_andleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;			
							-- autogen:endspecific
							-- autogen:specific:0:orleq							
							elsif MCRi = MCR_orleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;	
							-- autogen:endspecific	
							-- autogen:specific:0:xorleq							
							elsif MCRi = MCR_xorleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;	
							-- autogen:endspecific	
							-- autogen:specific:0:xnorleq								
							elsif MCRi = MCR_xnorleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= CPU_CYCLE_START;		
							-- autogen:endspecific								
							elsif MCRi = MCR_subleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= LEQ_FLAGS_WRITE_BACK;
							-- autogen:specific:0:addleq
							elsif MCRi = MCR_addleq(REG_WIDTH-1 downto 0) then
								NEXT_STATE <= LEQ_FLAGS_WRITE_BACK;	
							-- autogen:endspecific
							else
								NEXT_STATE <= LEQ_FLAGS_WRITE_BACK;
							end if;
							
							 
				when MEMR_WRITE_BACK => 
	
							ALU_DATAi := ALU_DATA;
							
							MEM_address <= Ai;
							MEM_data <= std_logic_vector(ALU_DATAi);
							MEM_wren <= '1';
							MEM_rden <= '0';
							
							PCi_new := PCi + 3 + F_MODE_OFFSET;
							
							NEXT_STATE <= TTA_MEMR_WRITE_BACK;								 
							
							 
				when MEM_WRITE_BACK => 	
	
							ALU_DATAi := ALU_DATA;
							
							MEM_address <= Di;	
							MEM_data <= std_logic_vector(ALU_DATAi);
							MEM_wren <= '1';						
							MEM_rden <= '0';

							PCi_new := PCi + 3 + F_MODE_OFFSET;

							NEXT_STATE <= TTA_MEM_WRITE_BACK;								
							
							
				when TTA_MEM_WRITE_BACK =>
				
							MEM_rden <= '0';
							MEM_wren <= '0';		
	
							if Di = CHR_addr then
								CHRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							elsif Di = IWR_addr then
								IWRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							elsif Di = ICR_addr then
								ICRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							elsif Di = CSR_addr then
								CSRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							elsif Di = IDR_addr then
								IDRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							elsif Di = IOR_addr then	
								IORi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));
							end if;
							
							if CHRi = CHR_halt then
								NEXT_STATE <= CPU_HALT;
							elsif Di = IWR_addr then
								NEXT_STATE <= IWR_INT_TRIGGER;
							else
								NEXT_STATE <= CPU_CYCLE_START;
							end if;		
							
							ICR <= ICRi;
							IDR <= IDRi;
							IOR <= IORi;
							IWR <= IWRi;							
							CSR <= CSRi;	
							CHR <= CHRi;			
							

				when TTA_MEMR_WRITE_BACK =>
				
							MEM_rden <= '0';
							MEM_wren <= '0';		
							
							if Ai = CHR_addr then
								CHRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));									
							elsif Ai = IWR_addr then
								IWRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));							
							elsif Ai = ICR_addr then
								ICRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));							
							elsif Ai = CSR_addr then
								CSRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));						
							elsif Ai = IDR_addr then
								IDRi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));							
							elsif Ai = IOR_addr then	
								IORi := std_logic_vector(ALU_DATAi(REG_WIDTH-1 downto 0));							
							end if;

							if CHRi = CHR_halt then
								NEXT_STATE <= CPU_HALT;
							elsif Ai = IWR_addr then
								NEXT_STATE <= IWR_INT_TRIGGER;									
							else
								NEXT_STATE <= CPU_CYCLE_START;
							end if;							
							
							ICR <= ICRi;
							IDR <= IDRi;
							IOR <= IORi;
							IWR <= IWRi;							
							CSR <= CSRi;	
							CHR <= CHRi;	
							
							
				when PCS_WRITE_BACK => 
	
							ALU_DATAi := ALU_DATA;

							MEM_rden <= '0';
							MEM_wren <= '0';								
							
							PCi_newp := to_integer(unsigned(ALU_DATAi));
							if to_integer(signed(ALU_DATAi)) = 0 then
								PCi_new := to_integer(unsigned(Ci));
							else
								PCi_new := PCi_newp + 3 + F_MODE_OFFSET;
							end if;

							NEXT_STATE <= CPU_CYCLE_START;											
													
				
				when LEQ_FLAGS_WRITE_BACK =>							

							MEM_address <= CHR_addr;
							MEM_data <= ZERO_CONST_REG_Q & CMP & OVERFLOW;	
							
							MEM_rden <= '0';						
							MEM_wren <= '1';
								
							CHRi := ZERO_CONST_Q_REG & CMP & OVERFLOW;
							
							NEXT_STATE <= CPU_CYCLE_START;
							
							CHR <= CHRi;
													
							
				when CPU_HALT =>	
	
							NEXT_STATE <= CPU_HALT;

							CPU_STOP <= '1';
							
							
				when IWR_INT_TRIGGER => 
	
							MEM_address <= IWR_addr;
							MEM_data <= MEM_REG_TAP & std_logic_vector(IWRi);
							MEM_wren <= '1';
							MEM_rden <= '0';
							
							NEXT_STATE <= IWR_INT_SET;	
							

				when IWR_INT_SET =>	
	
							MEM_wren <= '0';
							MEM_rden <= '0';
							
							NEXT_STATE <= WAIT_FOR_INTERRUPT;	
							
							INTERRUPT_BLOCK <= '1';
							
	
				when WAIT_FOR_INTERRUPT =>   
	
							ISRi_new := ISRin;

							MEM_rden <= '0';
							MEM_wren <= '0';								
	
							if INTERRUPT = '1' then
									NEXT_STATE <= ISR_WRITE_BACK; 
							else
									NEXT_STATE <= WAIT_FOR_INTERRUPT;
							end if;
														
							INTERRUPT_BLOCK <= '0';
							

				when ISR_WRITE_BACK =>	

							MEM_address <= ISR_addr;
							MEM_data <= MEM_REG_TAP & std_logic_vector(ISRi_new);
							MEM_wren <= '1';
							MEM_rden <= '0';

							NEXT_STATE <= ISR_UPDATE;

							INTERRUPT_BLOCK <= '0'; 
							
							
				when ISR_UPDATE =>	
	
							ISRi := ISRi_new;
							
							MEM_wren <= '0';
							MEM_rden <= '0';
							
							NEXT_STATE <= IWR_RESET;

							ISR <= ISRi;
							
							
				when IWR_RESET => 
	
							IWRi := (others => '0');	
							PCi_new := to_integer(unsigned(Ci));							
							
							MEM_rden <= '0';
							MEM_wren <= '0';
							
							NEXT_STATE <= CPU_CYCLE_START;							

							IWR <= IWRi;		

							
											
				when others => 	NEXT_STATE <= RESET;
				
			end case;
		end if;
		
	end if;
	
end process;

end BEHAVIOURAL;
