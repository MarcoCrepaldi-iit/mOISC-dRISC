---------------------------------------------------------------------------
-- dRISC 816 - Cyclone 10 LP FPGA Implementation
---------------------------------------------------------------------------
-- Module: processor definitions package (dRISC_DEFINITIONS)
-- Author: Marco Crepaldi
-- Organization: Istituto Italiano di Tecnologia, Electronic Design Lab
-- Date: August 18th 2020
-- Notes: with autogen hooks
---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package dRISC_DEFINITIONS is

-- MEMORY_WIDTH is the number of bits per memory cell
constant MEMORY_WIDTH: Integer := 16;
-- REG_WIDTH is the width of the bootstrap registers
constant REG_WIDTH: Integer := 8;
constant BOOTSTRAP_REGS: Integer := 8;
-- counter for processor reset delay once the PLL has locked
constant RST_COUNT_MAX: Integer := 16;
constant CMP_WIDTH: Integer := 3;
constant HALF_REG_WIDTH: Integer := REG_WIDTH / 2;

-- CPU speed constants, 816 supports 4 run speeds
constant SPEED_10kHz: std_logic_vector(REG_WIDTH-1 downto 0) := "00000000";
constant SPEED_1MHz: std_logic_vector(REG_WIDTH-1 downto 0) := "01000000";
constant SPEED_50MHz: std_logic_vector(REG_WIDTH-1 downto 0) := "10000000";
constant SPEED_100MHz: std_logic_vector(REG_WIDTH-1 downto 0) := "11000000";

-- Constants set in the FSM
constant MEM_REG_TAP: std_logic_vector(MEMORY_WIDTH-REG_WIDTH-1 downto 0) := "00000000";
constant ONE_CONST_MEM: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000001";
constant ZERO_CONST_MEM: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000000";
constant ONE_CONST_REG: std_logic_vector(REG_WIDTH-1 downto 0) := "00000001";
constant ZERO_CONST_REG: std_logic_vector(REG_WIDTH-1 downto 0) := "00000000";
constant ZERO_CONST_Q_REG: std_logic_vector(HALF_REG_WIDTH-1 downto 0) := "0000";
constant ZERO_CONST_REG_Q: std_logic_vector(REG_WIDTH+HALF_REG_WIDTH-1 downto 0) := "000000000000";
constant ONE_CONST: std_logic := '1';
constant ZERO_CONST: std_logic := '0';
constant CMP_B_BIGGER: std_logic_vector(CMP_WIDTH-1 downto 0) := "001";
constant CMP_A_BIGGER: std_logic_vector(CMP_WIDTH-1 downto 0) := "010";
constant CMP_AB_EQUAL: std_logic_vector(CMP_WIDTH-1 downto 0) := "100";
constant CMP_NONE: std_logic_vector(CMP_WIDTH-1 downto 0) := "000";

-- Memory map addresses
constant ADDR_BOOTSTRAP: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000111";
constant MCR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000000";
constant CHR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000001";
constant IWR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000010";
constant ICR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000011";
constant CSR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000100";
constant ISR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000101";
constant IDR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000110";
constant IOR_addr: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000000000111";

-- Basic machine opcodes
constant MCR_subleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000011111111";
constant MCR_movleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000011101110";
constant MCR_pc: std_logic_vector(MEMORY_WIDTH-1 downto 0) :=     "0000000000110011";
constant MCR_mem: std_logic_vector(MEMORY_WIDTH-1 downto 0) :=    "0000000000100010";
constant MCR_memr: std_logic_vector(MEMORY_WIDTH-1 downto 0) :=   "0000000000010001";
constant MCR_pcs: std_logic_vector(MEMORY_WIDTH-1 downto 0) :=    "0000000000000000";

-- Additional machine opcodes handled by autogen
-- autogen:specific:0:addleq
constant MCR_addleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000011001100";
-- autogen:endspecific
-- autogen:specific:0:shlleq
constant MCR_shlleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000010011001";
-- autogen:endspecific
-- autogen:specific:0:shrleq
constant MCR_shrleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000010001000";
-- autogen:endspecific
-- autogen:specific:0:orleq
constant MCR_orleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) :=  "0000000001110111";
-- autogen:endspecific
-- autogen:specific:0:andleq
constant MCR_andleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000001100110";
-- autogen:endspecific
-- autogen:specific:0:xorleq
constant MCR_xorleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) := "0000000001010101";
-- autogen:endspecific
-- autogen:specific:0:xnorleq
constant MCR_xnorleq: std_logic_vector(MEMORY_WIDTH-1 downto 0) :="0000000001000100";
-- autogen:endspecific
	
-- CPU halt code
constant CHR_halt: std_logic_vector(REG_WIDTH-1 downto 0) :=   "11111111";	


end dRISC_DEFINITIONS;
