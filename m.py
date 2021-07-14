# coding=utf-8
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Dynamic Reduced Instruction Set Computer (d'RISC) assembler and simulator
# 816 Version [a.k.a. multi-OISC (mOISC)]
#
# mOISC:
#
# memory width: 15bit (0-32767)
# memory parallelism: 16bit (2 bytes)
# I/O width: 8bit (1 byte)
#
# Standard mode (one instruction set computer)
#
# basic instruction set:	exec
#
# Fast mode (CISC mode)
#
# basic instruction set:    movleq, subleq, mem, memr, pc, pcs (6)
# complete instruction set: movleq (move), subleq, mem, memr, pc, pcs, addleq, 
#                           andleq, orleq, xorleq, xnorleq, shlleq, shrleq (14)
#
# Copyright (C) March 18, 2020, Marco Crepaldi, Istituto Italiano di Tecnologia (IIT)
# Electronic Design Laboratory (EDL)
# Via Melen 83, 16152, Genova, Italy
# 
# ---------------------------------------------------------------------------------------------------------------------
#
# dRISC 816 MACHINE DEFINITION 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Standard mode (one instruction set computer) 
#
# label: exec a, b -> c
# a = source memory address
# b = destination memory address
# c = jump memory address
# a, b, c are operands	
#
# a memory cell mem[x], stores one operand.
# if c is unspecified, implicitly c = next instruction address, for example,
#
#   876: exec h1, h2
#   877: exec l0, l0
#   878: ...
#
#       is equal to
# 
#   876: exec h1, h2 -> 877
#   877: exec l0, l0 -> 878
#   878: ...
#
# addresses 0x00 to 0x07 set and configure on the run the hardware operation (subleq or transport triggered), 
# interrupts and general purpose I/O
#
# addresses 0x00 to 0x07 are accessed only once during bootstrap 
# data is transferred in internal processor registers
# subsequent addressing to 0x00-0x07 update internal registers only
#
# execution for address (0x00 - 0x07):
# when these registers are directly addressed as b, therefore b in the program is within 0x00 and 0x07 execution is 
#		exec a, b, c: mem[b] = mem[a], pc = c
# 
# or (except for 0x00), in case of indirect addressing (mem[b] = 0x01 - 0x07)
#       exec a, b, c: mem[mem[b]] = mem[a], pc += 3
#       
# and (except for 0x00), if addressed as a, 
#       exec a, b, c: mem[a] = mem[mem[b]], pc += 3
#
# hence the operation for these registers the machine is transport triggered
#
# Fast mode (CISC mode)
#
# label: {movleq, subleq, mem, memr, pc, pcs, addleq, andleq, orleq, xorleq, xnorleq, shlleq, shrleq} a, b -> c
# note: movleq is used also for move
#
# a = source memory address
# b = destination memory address
# c = jump memory address
# a, b, c are operands	
#
# the logical operation is exactly the same of the standard mode, with the difference that "exec" is replaced by
# the specific opcode. this way the machine always sets an MCR per instruction. this mode is
# effective if code has a very high MCR change rate in standard mode, asymptotic to 50%
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# MACHINE REGISTERS
#
# b = 0x00 - MCR - Machine Code Register
#            sets the execution mode of the CPU and dynamically defines the type of running OISC. 
#            in standard mode at initialization it needs to be non-zero but among the possible values.
#            (its value at bootstrap defines the execution mode, standard or fast. a non-zero value defines a standard
#            execution mode, a 0 value defines a fast mode). during fast code MCR is express (CISC mode) in memory.
#
#            RW, non-blocking behavior
#
#   OISC subleq machine mode
# a = 0xFF - set exec to subleq 	a, b, c: mem[b] = mem[b] - mem[a], 		if mem[b] <= 0: pc = c; else: pc += 3
#
#   OISC tta machine mode (transport triggered hybrid architecture)
# a = 0xEE - set exec to movleq 	a, b, c: mem[b] = mem[a], 			if mem[b] <= 0: pc = c; else: pc += 3	
#     if (b < 8): set exec to mov   	a, b, c: mem[b] = mem[a],      			pc = c
# a = 0xCC - set exec to addleq 	a, b, c: mem[b] = mem[a] + mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x99 - set exec to shlleq 	a, b, c: mem[b] = mem[a] << mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3	
# a = 0x88 - set exec to shrleq 	a, b, c: mem[b] = mem[a] >> mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x77 - set exec to orleq 		a, b, c: mem[b] = mem[a] | mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x66 - set exec to andleq 	a, b, c: mem[b] = mem[a] & mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x55 - set exec to xorleq 	a, b, c: mem[b] = mem[a] ^ mem[b], 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x44 - set exec to xnorleq 	a, b, c: mem[b] = ~(mem[a] ^ mem[b]), 		if mem[b] <= 0: pc = c; else: pc += 3
# a = 0x33 - set exec to pc 		a, b, c: mem[b] = pc, 				pc += 3
# a = 0x22 - set exec to mem 		a, b, c: mem[mem[b]] = mem[a], 			pc += 3
# a = 0x11 - set exec to memr 		a, b, c: mem[a] = mem[mem[b]], 			pc += 3
# a = 0x00 - set exec to pcs 		a, b, c: -					if mem[b] == 0: pc = c; else; pc = mem[b]
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# b = 0x01 - CHR - CPU Halt Register
#            Halts the CPU until a physical reset is issued and shows overflow error for subleq or addleq.
#            when an overflow is detected CHR becomes 0x01 until a next correct subleq or addleq occurs.
#			 it also contains flags to identify the bigger/smaller/equal relationship between pointed operands.
#            CHR is updated only for a subleq or addleq machine mode and values hold until the next subleq/addled
#            operation is processed.
#
#            W (255), blocking behavior
#	     R, non-blocking behavior
#
# a = 0xFF - halts the cpu until an external RESET is issued in the physical pin
# a = 0x01 - overflow of the last subleq and addleq instructions. reset at a next correct add/subleq
# a = 0x02 - mem[b] > mem[a]
# a = 0x04 - mem[b] < mem[a]
# a = 0x08 - mem[b] = mem[a]
# a = 0x00, 0x03, 0x05, 0x06, 0x07, 0x09-0xFE - does nothing
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# b = 0x02 - IWR - Interrupt Wait Register
#            stops the processor and waits for an interrupt trigger (whose transition 0->1 or vice-versa is specified
#            in the ICR). when an interrupt on one of the specified phyisical pins INT0-INT7 occurs, the register
#            is cleared and ISR is updated with a 1 corresponding to the triggered input. 
#
#            W, blocking behavior
#	     R, non-blocking behavior
#
# a = 0x00-0xFF - stops the processor and waits for interrupt
#                 warning: writing 0x00 to IWR forces the CPU to wait indefinitely and has an effect of a functional
#                 CPU halt. The same effect occurs if trigger is waited, for instance on a non-input I/O.
#                 Only during bootstrap IWR can be initialized as 0x00.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# b = 0x03 - ICR - Interrupt Control Register
#            sets the trigger direction for external interrupts. 
#
#            RW, non-blocking behavior
#
# a = 0x00-0xFF - trigger direction of the INT0-INT7 pins, 0 = 0->1, 1 = 1->0
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# b = 0x04 - CSR - Clock Speed Register
#            immediately sets the CPU speed, with clock period Tclk = CSR/255 * K1 + K0, where K1 and K0 are 
#            implementation dependent. 
#
#            RW, Non-blocking behavior
#
# a = 0x00-0xFF - CPU speed
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# b = 0x05 - ISR - Interrupt Status Register
#            after IWR is set and when reinvoking the machine after interrupt, it identified the interrupt pin
#            that toggled.
#
#            RO, non-blocking behavior
#
# mem[b] = 0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01, where the logical 1 identifies INT0-INT7 IOR pins
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# 
# I/O REGISTERS
#
# b = 0x06 - IDR - Input/output Direction Register
#			 sets the direction of I/O pins, digital only
#
#	     RW, non-blocking behavior
#
# a = 0x00-0xFF - direction for each pin, 1 output, 0 input
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# b = 0x07 - IOR - Input/Output Register
#            writes or read the logic value of a I/O pin, digital only
#
#	     RW, non-blocking behavior
#
# a = 0x00-0xFF - logic value for each pin, high 1, low 0
#
# ---------------------------------------------------------------------------------------------------------------------
#
# ASSEMBLER USAGE
#
# command line: python3 -in m.py <programname> -out <codeout>
#               <programname> is the name of the assembler file without extension, <codeout> is the main name of the 
#               output files
#
# class usage and some methods:
#
# asm = DRISC()
#   instantiates the class
# 
# asm.assemble
#   assembles the program in program.asm and generates program.bin (binary code), and program.sym (symbols table for 
#   the simulator)
#
# asm.load
#   loads binary and symbol data for simulation
#
# asm.simulate
#   simulates the system, load() must be done in advance
#   umemprint: defines the length of the memory to be printed
#   umempsym: if false prints out the complete memory until umemprint
#             if true prints out only symbols defined in the symbols file until memprint 
#   
#   when IWR is set, the simulator waits for a keyboard input to simulate the position of the interrupt bit
#   the execution continues only when a currect bit specified in IWR is entered, with correct transition in ICR
#
# simulation starts from program counter = 0
#
# ---------------------------------------------------------------------------------------------------------------------
#
# ASSEMBLY (.asm/.fasm)
#
# '#' turn a line to a comment
# variables are analphanumeric but cannot start with a number, valid ones are, e.g., t0, line1, lab.1, a, b, g, etc...
# address is encoded incrementally where address 0 is the first non-commented line
# '\n', '\r' are allowed and do not represent addresses (same as '#'')
# use only '\t' or ' ' to separate labels with instructions/data
#
# assembly file structure:
#
# region 1 *** machine registers 
# region 2 *** program memory 
# region 3 *** data memory 
#
# machine registers - the first 8 addresses (0-7) must be reserved for bootstrap with the only sequence:
# MCR:	<value_mcr>
# CHR:	<value_chr>	
# IWR:	<value_iwr>
# ICR:	<value_icr>
# CSR:	<value_csr>
# ISR:	<value_dummy>
# IOR:  <value_ior>
# IDR:  <value_idr>
# where <value_*> is an 8 bit unsigned integer
#
# program memory - starting from address 8 the program memory can be arbitrarily specified, e.g.:
# label.0:			exec R5, T -> C
#				exec R5, R5
#				exec 10, 25
#               ...
#
#    ... or in CISC mode ...
#
#				subleq A0, A1 -> jp.325
#				movleq A2, _ADDR
#				xorleq A3, A2
#				memr A4, A5
#               ...
#
# data memory - data memory can be appended immediately at the end of the program, e.g.:
# R5:		123
# T:		-56
# C:		0
# ZERO:		0
# MONE:		-1
# ONE:		1
# ...
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# dRISC 816 (mOISC 816) - 1st 8 = IOR width, 2nd 16 = code/data memory width, irrespective of size
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

import sys
if sys.version_info.major < 3:
    sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot run this program with Python 2.\n")
    sys.exit(1)
import os
import re
import itertools
import struct
import time
import curses 
import binascii
try:
	import argparse
except:
	sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Python module argparse not found. If you want to install it, please run python3 -m pip install argparse (https://pypi.org/project/argparse/)\n")
	sys.exit(1)	
import datetime
try:
	from vcd import VCDWriter
except:
	sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Python module vcd not found. If you want to install it, please run python3 -m pip install pyvcd (https://pypi.org/project/pyvcd/)\n")
	sys.exit(1)	
from pathlib import Path

class DRISC:
	INSTRUCTION = "EXEC"
	MEMWIDTH = 15
	MEMADDRESSABLE = 16
	ADDRESSABLE = 2**MEMWIDTH-1
	CHARSET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ.$"
	NUMSET = "0123456789"
	MAX_JMP_LINE = 64
	CLK_10kHz = 10.0e3
	CLK_1MHz = 1.0e6
	CLK_50MHz = 50.0e6
	CLK_100MHz = 100.0e6

	def __init__(self):
		self.loaded = False

	def assemble(self, filein="program.asm", fileout="program.bin", filesym="program.sym", filemif="program.mif"):
		try:
			self.f = open(filein)
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't read input assembly file.\n")
			sys.exit(1)

		self.symbolic = []
		self.address = []
		self.data = []
		self.symbols = []
		addr = 0
		line = 0
		jump_info = 0

		try:
			while True:
				line += 1
				metadata = self.f.readline()
				if metadata == "":
					break
				if (metadata[0] != '#') and (metadata[0] != '\n') and (metadata[0] != '\r'):
					metadata = metadata.replace("\t","")
					metadata = metadata.replace("\n","")
					metadata = metadata.upper()
					metadata_splitted = metadata.split(":")
					if len(metadata_splitted) > 1: 
						proc = metadata_splitted[1]
						self.symbolic.append(metadata_splitted[0])
					else:
						proc = metadata_splitted[0]
						self.symbolic.append("")				
					if (self.INSTRUCTION in proc.upper()) == False:
						if (proc.replace(" ", "").replace("\t","").replace("\n","") != ""):
							numericstr = proc.replace(" ", "").replace("\t","").replace("\n","")
							if [i in self.CHARSET for i in numericstr] != [False] * len(numericstr):
								sys.stdout.write(bcolors.FAIL + "Assembly error. " + bcolors.ENDC + "Invalid syntax on line " + str(line) + ",\n")
								sys.stdout.write(metadata + ".\n")
								raise Exception
							else:
								if (addr == 0) and (self.symbolic[0] != "MCR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 0 is reserved to machine control register.\n")
									raise Exception
								elif (addr == 1) and (self.symbolic[1] != "CHR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 1 is reserved to CPU halt register.\n")
									raise Exception
								elif (addr == 2) and (self.symbolic[2] != "IWR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 2 is reserved to interrupt wait register.\n")
									raise Exception
								elif (addr == 3) and (self.symbolic[3] != "ICR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 3 is reserved to interrupt configuration register.\n")
									raise Exception
								elif (addr == 4) and (self.symbolic[4] != "CSR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 4 is reserved to clock speed register.\n")
									raise Exception
								elif (addr == 5) and (self.symbolic[5] != "ISR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 5 is reserved to interrupt status register (read-only), dummy value expected.\n")
									raise Exception	
								elif (addr == 6) and (self.symbolic[6] != "IDR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 6 is reserved to input/output direction register.\n")
									raise Exception	
								elif (addr == 7) and (self.symbolic[7] != "IOR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 7 is reserved to input/output register.\n")
									raise Exception									
								self.address.append(addr)
								self.data.append([numericstr])
								addr += 1
						else:
							sys.stdout.write("\nAssembly error. Invalid syntax on line " + str(line) + ".\n")
							sys.stdout.flush()
							raise Exception
					else:
						if addr <= 5:
							sys.stdout.write("\nError: Not all machine registers have been specified.\n")
							raise Exception
						cmd = proc.upper()				
						cmd_splitted = cmd.split(self.INSTRUCTION)
						if len(cmd_splitted) != 2:
							sys.stdout.write(bcolors.FAIL + "\nEXEC syntax error on line " + str(line) + ".\n" + bcolors.ENDC)
							raise Exception 
						operands = cmd_splitted[1]
						operands = operands.replace(" ","")
						operands_splitted = operands.split("->")
						mems = operands_splitted[0].split(",")
						
						if len(operands_splitted) == 1:
							operands_splitted.append(str(addr+3))
							if jump_info == 0: 
								sys.stdout.write(bcolors.OKGREEN + "Info: "+bcolors.ENDC+"Deteceted sequential instruction on address " + str(addr) + ", ")
							if jump_info != 0 and jump_info < self.MAX_JMP_LINE: 
								sys.stdout.write(str(addr) + ", ")
							if jump_info != 0 and jump_info == self.MAX_JMP_LINE: 
								sys.stdout.write(str(addr) + "...\n")
							jump_info += 1

						if len(mems) != 2:
							sys.stdout.write(bcolors.FAIL + "\nSyntax error on line " + str(line) + ".\n" + bcolors.ENDC)
							raise Exception

						if [i in self.CHARSET for i in mems[0]] == [False] * len(mems[0]):
							if int(mems[0]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC+ "Exceeding maximum addressable memory on line " + str(line) + ", operand A.\n")
								raise Exception
						if [i in self.CHARSET for i in mems[1]] == [False] * len(mems[1]):
							if int(mems[1]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC+ "Exceeding maximum addressable memory on line " + str(line) + ", operand B.\n")
								raise Exception
						if [i in self.CHARSET for i in operands_splitted[1]] == [False] * len(operands_splitted[1]):
							if int(operands_splitted[1]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC + "Exceeding maximum addressable memory on line " + str(line) + ", operand C.\n")
								raise Exception
						self.data.append([mems[0], mems[1], operands_splitted[1]])
						self.address.append(addr)
						addr += 3 
		except:
			sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Something is wrong, probably with the charset on line " + str(line) + ", or the program is too big to fit in the device.\n")
			self.f.close()
			sys.exit(1)

		self.f.close()

		self.opA = []
		self.opB = []
		self.opC = []
		for i in range(len(self.data)):
			if len(self.data[i]) == 3:
				self.opA.append(self.data[i][0])
				self.opB.append(self.data[i][1])
				self.opC.append(self.data[i][2])
			else:
				self.opA.append('')
				self.opB.append('')
				self.opC.append('')

		try:
			for item in self.symbolic:
				if self.symbolic.count(item) > 1 and item != "":
					raise Exception
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "duplicate symbol in memory " + str(item) + ".\n")
			sys.exit(1)

		try:
			for idx in range(len(self.data)):

				if [i in self.CHARSET for i in self.opA[idx]] != [False] * len(self.opA[idx]):
					if self.opA[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opA[idx])
				if [i in self.CHARSET for i in self.opB[idx]] != [False] * len(self.opB[idx]):
					if self.opB[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opB[idx])
				if [i in self.CHARSET for i in self.opC[idx]] != [False] * len(self.opC[idx]):
					if self.opC[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opC[idx])	
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "illegal symbol name on line " + str(idx) + "\n")
			sys.exit(1)
		self.symbols.sort()
		self.symbols_positional = list(self.symbols for self.symbols,_ in itertools.groupby(self.symbols))

		self.memory = []
		self.memory_address = []
		
		memaddr = 0
		for idx in range(len(self.data)):
			if len(self.data[idx]) == 3:
				self.memory.append(self.opA[idx])
				self.memory.append(self.opB[idx])
				self.memory.append(self.opC[idx])
				self.memory_address.append(memaddr)
				self.memory_address.append(memaddr+1)
				self.memory_address.append(memaddr+2)
				memaddr += 3
			else:
				self.memory.append(self.data[idx][0])
				memaddr += 1

		for idx in range(len(self.symbols_positional)):
				if self.symbols_positional[idx] in self.symbolic:
					index_addr = self.address[self.symbolic.index(self.symbols_positional[idx])]
				else:
					index_addr = memaddr
					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + " enforced memory map for symbol " + str(self.symbols_positional[idx]) + " at address " + str(memaddr) + ".\n")
					self.memory_address.append(index_addr)
					self.symbolic.append(self.symbols_positional[idx])
					self.address.append(index_addr)
					memaddr += 1
				for ridx in range(len(self.memory)):
					if self.memory[ridx] == self.symbols_positional[idx]:
						self.memory[ridx] = str(index_addr)

		if len(self.memory) > 2**self.MEMWIDTH-1:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("Exceeeing program memory.\n")			
			sys.exit(1)	

		self.binmemory = []
		for idx in range(len(self.memory)):
			self.binmemory.append(int(self.memory[idx]))
		
		try:
			self.fo = open(fileout, 'wb')
			for i in range(len(self.binmemory)):
				payload = struct.pack("<h", self.binmemory[i])
				self.fo.write(payload)
			self.fo.close()
		except struct.error:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("The binary format requires (-32767 -1) <= number <= 32767, at payload " + str(i) +".\n")			
			sys.exit(1)
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)
		try:
			self.fs = open(filesym, 'w')
			for i in range(len(self.symbolic)):
				if self.symbolic[i] != "":
					self.fs.write(self.symbolic[i] + "@" + str(self.address[i]) +"\n")
			self.fs.close()
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output symbols file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)

		try:
			self.fo = open(filemif, 'w')
			self.fo.write("DEPTH = " + str(2**self.MEMWIDTH) + ";\n")
			self.fo.write("WIDTH = " + str(self.MEMADDRESSABLE) + ";\n")
			self.fo.write("ADDRESS_RADIX = HEX;\n")
			self.fo.write("DATA_RADIX = HEX;\n")
			self.fo.write("CONTENT\n")
			self.fo.write("BEGIN\n")
			address = 0
			for i in range(len(self.binmemory)):
				udata = self.binmemory[i]
				self.fo.write('0x{0:0{1}X}'.format(address,4)[2:] + " : " + (binascii.hexlify(struct.pack(">h", udata)).decode('utf-8').upper())+";\n")
				
				address += 1
			self.fo.write("END;\n")
			self.fo.close()
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output MIF file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)

	def assemble_f(self, filein="program.fasm", fileout="program.bin", filesym="program.sym", filemif="program.mif"):
		self.OPCODE = ['subleq', 'movleq', 'addleq', 'shlleq', 'shrleq', 'orleq', 'andleq', 'xorleq', 'xnorleq', 'pc', 'mem', 'memr', 'pcs']
		self.MCRsVAL = [0xFF, 0xEE, 0xCC, 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00]
		try:
			self.f = open(filein)
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't read input assembly file.\n")
			sys.exit(1)

		self.symbolic = []
		self.address = []
		self.data = []
		self.symbols = []
		addr = 0
		line = 0
		jump_info = 0

		try:
			while True:
				line += 1
				metadata = self.f.readline()
				if metadata == "":
					break
				if (metadata[0] != '#') and (metadata[0] != '\n') and (metadata[0] != '\r'):
					metadata = metadata.replace("\t","")
					metadata = metadata.replace("\n","")
					metadata = metadata.upper()
					metadata_splitted = metadata.split(":")
					if len(metadata_splitted) > 1: 
						proc = metadata_splitted[1]
						self.symbolic.append(metadata_splitted[0])
					else:
						proc = metadata_splitted[0]
						self.symbolic.append("")

					found_opcode = False
					proc = re.sub(r"^\s+|\s+$", "", proc)
					proposed_opcode = proc.upper().split(" ")[0]
					for r in range(len(self.OPCODE)):
							#if self.OPCODE[r].upper()+" " in proc.upper():
							if self.OPCODE[r].upper() == proposed_opcode:
								found_opcode = True
								break

					if (found_opcode) == False:
						if (proc.replace(" ", "").replace("\t","").replace("\n","") != ""):
							numericstr = proc.replace(" ", "").replace("\t","").replace("\n","")
							if [i in self.CHARSET for i in numericstr] != [False] * len(numericstr):
								sys.stdout.write(bcolors.FAIL + "Assembly error. " + bcolors.ENDC + "Invalid syntax on line " + str(line) + ",\n")
								sys.stdout.write(metadata + ".\n")
								raise Exception
							else:
								if (addr == 0) and (self.symbolic[0] != "MCR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 0 is reserved to machine control register.\n")
									raise Exception
								elif (addr == 1) and (self.symbolic[1] != "CHR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 1 is reserved to CPU halt register.\n")
									raise Exception
								elif (addr == 2) and (self.symbolic[2] != "IWR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 2 is reserved to interrupt wait register.\n")
									raise Exception
								elif (addr == 3) and (self.symbolic[3] != "ICR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 3 is reserved to interrupt configuration register.\n")
									raise Exception
								elif (addr == 4) and (self.symbolic[4] != "CSR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 4 is reserved to clock speed register.\n")
									raise Exception
								elif (addr == 5) and (self.symbolic[5] != "ISR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 5 is reserved to interrupt status register (read-only), dummy value expected.\n")
									raise Exception	
								elif (addr == 6) and (self.symbolic[6] != "IDR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 6 is reserved to input/output direction register.\n")
									raise Exception	
								elif (addr == 7) and (self.symbolic[7] != "IOR"):
									sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Bootstrap error. Address 7 is reserved to input/output register.\n")
									raise Exception									
								self.address.append(addr)
								self.data.append([numericstr])
								addr += 1
						else:
							sys.stdout.write("\nAssembly error. Invalid syntax on line " + str(line) + ".\n")
							sys.stdout.flush()
							raise Exception
					else:
						if addr <= 7:
							sys.stdout.write("\nError: Not all machine registers have been specified.\n")
							raise Exception
						cmd = proc.upper()	
						proposed_opcode = proc.upper().split(" ")[0]
						opcode = ""
						for r in range(len(self.OPCODE)):
							#if self.OPCODE[r].upper()+" " in cmd:
							if self.OPCODE[r].upper() == proposed_opcode:
								opcode = self.OPCODE[r].upper()
								break
						if opcode == "":
							#print(cmd_splitted)
							sys.stdout.write(bcolors.FAIL + "\nError: Undefined assembler instruction on line " + str(line) + ".\n" + bcolors.ENDC)
							raise Exception 
						#cmd_splitted = cmd.split(opcode)
						cmd_splitted = ['', cmd[(len(opcode)+1):]]
						opcodeint = self.MCRsVAL[self.OPCODE.index(opcode.lower())]


						operands = cmd_splitted[1]
						operands = operands.replace(" ","")
						operands_splitted = operands.split("->")
						mems = operands_splitted[0].split(",")
						
						if len(operands_splitted) == 1:
							operands_splitted.append(str(addr+4))
							if jump_info == 0: 
								sys.stdout.write(bcolors.OKGREEN + "Info: "+bcolors.ENDC+"Deteceted sequential instruction on address " + str(addr) + ", ")
							if jump_info != 0 and jump_info < self.MAX_JMP_LINE: 
								sys.stdout.write(str(addr) + ", ")
							if jump_info != 0 and jump_info == self.MAX_JMP_LINE: 
								sys.stdout.write(str(addr) + "...\n")
							jump_info += 1

						if len(mems) != 2:
							sys.stdout.write(bcolors.FAIL + "\nSyntax error on line " + str(line) + ".\n" + bcolors.ENDC)
							raise Exception

						if [i in self.CHARSET for i in mems[0]] == [False] * len(mems[0]):
							if int(mems[0]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC+ "Exceeding maximum addressable memory on line " + str(line) + ", operand A.\n")
								raise Exception
						if [i in self.CHARSET for i in mems[1]] == [False] * len(mems[1]):
							if int(mems[1]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC+ "Exceeding maximum addressable memory on line " + str(line) + ", operand B.\n")
								raise Exception
						if [i in self.CHARSET for i in operands_splitted[1]] == [False] * len(operands_splitted[1]):
							if int(operands_splitted[1]) > self.ADDRESSABLE:
								sys.stdout.write(bcolors.FAIL + "\nError: " + bcolors.ENDC + "Exceeding maximum addressable memory on line " + str(line) + ", operand C.\n")
								raise Exception
						self.data.append([str(opcodeint), mems[0], mems[1], operands_splitted[1]])
						#print([str(opcodeint), mems[0], mems[1], operands_splitted[1]], addr)
						self.address.append(addr)
						addr += 4 
		except:
			sys.stdout.write(bcolors.FAIL + bcolors.FAIL + "Error: " + bcolors.ENDC + "" + bcolors.ENDC + "Something is wrong, probably with the charset on line " + str(line) + ", or the program is too big to fit in the device.\n")
			self.f.close()
			sys.exit(1)

		self.f.close()


		self.opMCR = []
		self.opA = []
		self.opB = []
		self.opC = []
		for i in range(len(self.data)):
			if len(self.data[i]) == 4:
				self.opMCR.append(self.data[i][0])
				self.opA.append(self.data[i][1])
				self.opB.append(self.data[i][2])
				self.opC.append(self.data[i][3])
			else:
				self.opMCR.append('')
				self.opA.append('')
				self.opB.append('')
				self.opC.append('')

		try:
			for item in self.symbolic:
				if self.symbolic.count(item) > 1 and item != "":
					raise Exception
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "duplicate symbol in memory " + str(item) + ".\n")
			sys.exit(1)

		try:
			for idx in range(len(self.data)):
				if [i in self.CHARSET for i in self.opMCR[idx]] != [False] * len(self.opMCR[idx]): 
					if int(self.opMCR[idx]) > 0xFF:
						raise Exception
				if [i in self.CHARSET for i in self.opA[idx]] != [False] * len(self.opA[idx]):
					if self.opA[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opA[idx])
				if [i in self.CHARSET for i in self.opB[idx]] != [False] * len(self.opB[idx]):
					if self.opB[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opB[idx])
				if [i in self.CHARSET for i in self.opC[idx]] != [False] * len(self.opC[idx]):
					if self.opC[idx][0] in self.NUMSET:
						raise Exception
					self.symbols.append(self.opC[idx])	
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "illegal symbol name on line " + str(idx) + ".\n")
			sys.exit(1)
		self.symbols.sort()
		self.symbols_positional = list(self.symbols for self.symbols,_ in itertools.groupby(self.symbols))

		self.memory = []
		self.memory_address = []
		
		memaddr = 0
		for idx in range(len(self.data)):
			if len(self.data[idx]) == 4:
				self.memory.append(self.opMCR[idx])
				self.memory.append(self.opA[idx])
				self.memory.append(self.opB[idx])
				self.memory.append(self.opC[idx])
				self.memory_address.append(memaddr)
				self.memory_address.append(memaddr+1)
				self.memory_address.append(memaddr+2)
				self.memory_address.append(memaddr+3)
				memaddr += 4
			else:
				self.memory.append(self.data[idx][0])
				memaddr += 1

		for idx in range(len(self.symbols_positional)):
				if self.symbols_positional[idx] in self.symbolic:
					index_addr = self.address[self.symbolic.index(self.symbols_positional[idx])]
				else:
					index_addr = memaddr
					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + " enforced memory map for undefined symbol " + str(self.symbols_positional[idx]) + " at address " + str(memaddr) + ".\n")
					self.memory_address.append(index_addr)
					self.symbolic.append(self.symbols_positional[idx])
					self.address.append(index_addr)
					memaddr += 1
				for ridx in range(len(self.memory)):
					if self.memory[ridx] == self.symbols_positional[idx]:
						self.memory[ridx] = str(index_addr)

		if len(self.memory) > 2**self.MEMWIDTH-1:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("Exceeeing program memory.\n")			
			sys.exit(1)	

		self.binmemory = []
		for idx in range(len(self.memory)):
			self.binmemory.append(int(self.memory[idx]))
		
		try:
			self.fo = open(fileout, 'wb')
			for i in range(len(self.binmemory)):
				payload = struct.pack("<h", self.binmemory[i])
				self.fo.write(payload)
			self.fo.close()
		except struct.error:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("The binary format requires -32768 <= number <= 32767, at payload " + str(i) +".\n")			
			sys.exit(1)
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output assembly file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)
		try:
			self.fs = open(filesym, 'w')
			for i in range(len(self.symbolic)):
				if self.symbolic[i] != "":
					self.fs.write(self.symbolic[i] + "@" + str(self.address[i]) +"\n")
			self.fs.close()
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output symbols file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)

		try:
			self.fo = open(filemif, 'w')
			self.fo.write("DEPTH = " + str(2**self.MEMWIDTH) + ";\n")
			self.fo.write("WIDTH = " + str(self.MEMADDRESSABLE) + ";\n")
			self.fo.write("ADDRESS_RADIX = HEX;\n")
			self.fo.write("DATA_RADIX = HEX;\n")
			self.fo.write("CONTENT\n")
			self.fo.write("BEGIN\n")
			address = 0
			for i in range(len(self.binmemory)):
				udata = self.binmemory[i]
				self.fo.write('0x{0:0{1}X}'.format(address,4)[2:] + " : " + (binascii.hexlify(struct.pack(">h", udata)).decode('utf-8').upper())+";\n")
				
				address += 1
			self.fo.write("END;\n")
			self.fo.close()
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't write output MIF file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)


	def load(self, filein="program.bin", filesym="program.sym"):
		self.CODERAM = []
		for _ in range(self.ADDRESSABLE+1):
			self.CODERAM.append(0)
		try:
			self.runfile = open(filein,'rb')
			index = 0
			while True:
				data = self.runfile.read(2)
				if data == b'':
					break
				dataint = struct.unpack("<h", data)[0]
				self.CODERAM[index] = dataint
				index += 1
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't read assembled file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)

		try:
			self.symfile = open(filesym, 'r')
			self.memmap = []
			self.reference = []
			while True:
				metadata = self.symfile.readline()
				if metadata == "":
					break
				metadata = metadata.split("@")
				self.memmap.append(metadata[0])
				self.reference.append(int(metadata[1]))
		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't read symbols file.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)

		self.loaded = True

	def simulate(self, umemprint=64, umempsym=True, printonly=None, vcd=False, vcdfile=None, utime=1000, iorovr=False, iorovr_value=0x00, debug=False):
		fastmode = False
		leq_pc_pipeline_stages = 11 # or 11 if ovf
		leq_pc_pipeline_stages_ovf = 11
		tta_pipeline_stages = 10
		memr_pipeline_stages = 11
		mem_pipeline_stages = 11
		pcs_pipeline_stages = 10
		itr_pipeline_stages_in = 12
		itr_pipeline_stages_out = 3	
		boot_pipeline_stages = 9
		pipeline = boot_pipeline_stages #leq_pc_pipeline_stages_ovf

		leq_pc_pipeline_stages_f = 13 # or 11 if ovf
		leq_pc_pipeline_stages_ovf_f = 13
		tta_pipeline_stages_f = 12
		memr_pipeline_stages_f = 13
		mem_pipeline_stages_f = 13
		pcs_pipeline_stages_f = 12
		itr_pipeline_stages_in_f = 14
		itr_pipeline_stages_out_f = 3	
		boot_pipeline_stages_f = 9
	
		self.ior_in_value = iorovr_value
		self.ior_in = iorovr
		self.debuginfo = debug
		if self.loaded == False:
			sys.stdout.write("Memory not loaded.\n")
			return
		if umemprint > len(self.CODERAM):
			sys.stdout.write("Too much memory to dump.\n")
			return
		if umemprint < 8:
			sys.stdout.write("Too little memory to dump.\n")
			return
		if umemprint != 0 and vcd is False:
			screen = curses.initscr()

		if vcd is True:
			if vcdfile is None:
				sys.stdout.write("Unspecified VCD file.\n")
				return				
			fvcd = open(vcdfile, 'w')
			currentDT = datetime.datetime.now()
			timescale_vcd_int = int((1/self.CLK_100MHz)/1.0e-9)
			timescale_vcd = str(timescale_vcd_int) + " ns";
			aiteration = 0
			titeration = int(self.CLK_10kHz/self.CLK_10kHz) * pipeline
			writer = VCDWriter(fvcd, timescale=timescale_vcd, date=str(currentDT))
			PCvcd = writer.register_var('PROCESSOR', 'PC', 'integer', size=16)
			MCRvcd = writer.register_var('PROCESSOR.REGISTERS', 'MCR', 'reg', size=8)
			CHRvcd = writer.register_var('PROCESSOR.REGISTERS', 'CHR', 'reg', size=8)
			IWRvcd = writer.register_var('PROCESSOR.REGISTERS', 'IWR', 'reg', size=8)
			ICRvcd = writer.register_var('PROCESSOR.REGISTERS', 'ICR', 'reg', size=8)
			CSRvcd = writer.register_var('PROCESSOR.REGISTERS', 'CSR', 'reg', size=8)
			ISRvcd = writer.register_var('PROCESSOR.REGISTERS', 'ISR', 'reg', size=8)
			IDRvcd = writer.register_var('PROCESSOR.REGISTERS', 'IDR', 'reg', size=8)
			IORvcd = writer.register_var('PROCESSOR.REGISTERS', 'IOR', 'reg', size=8)
			if self.debuginfo == True:
				LabelVCD = writer.register_var('VM', 'DEBUG.INFO', 'string')
			if printonly is not None:
				VMvcd =[]
				VMsymbols_addr = []
				self.symbols_to_print = printonly.upper().split(" ")
				symbols_included = []
				for i in range(len(self.symbols_to_print)):
							if self.symbols_to_print[i] in self.memmap:
								if self.symbols_to_print[i] not in symbols_included:
									symbols_included.append(self.symbols_to_print[i])
									VMvcd.append(writer.register_var('VM', self.symbols_to_print[i], 'integer', size=16))
									idx=self.reference[self.memmap.index(self.symbols_to_print[i])]
									VMsymbols_addr.append(idx)
									sys.stdout.write(bcolors.OKGREEN + "Info:" + bcolors.ENDC + " Found and attached symbol " + self.symbols_to_print[i]+' to simulation VCD output.\n')
								else:
									sys.stdout.write(bcolors.WARNING + "Warning:" + bcolors.ENDC + " Symbol " + self.symbols_to_print[i]+' already attached. Skipping.\n')
							else:
								sys.stdout.write(bcolors.WARNING + "Warning:" + bcolors.ENDC + " Symbol " + self.symbols_to_print[i]+' not found in the memory map.\n')



		K_10kHz = 10e-3
		K_1MHz = 1e-6
		K_50MHz = 20e-9
		K_100MHz = 10e-9
		self.delay = K_10kHz
		self.CSR_flag = False
		self.CHR_flag = False
		self.IWR_flag = False
		self.IOR_read_flag = False

		self.program_counter = 0
		self.MCR = 0
		self.ICR = 0
		self.IWR = 0
		self.ISR = 0
		self.CSR = 0
		self.CHR = 0
		self.IOR = 0
		self.IDR = 0

		self.MCR_prev = 0
		self.ICR_prev = 0
		self.IWR_prev = 0
		self.ISR_prev = 0
		self.CSR_prev = 0
		self.CHR_prev = 0
		self.IOR_prev = 0
		self.IDR_prev = 0
		self.CODERAM_PREV = [0] * len(self.CODERAM)
		
		try:		
			iteration = 0

			if vcd is True:
				writer.change(PCvcd, iteration, self.program_counter)
				writer.change(MCRvcd, iteration, self.MCR)
				writer.change(ICRvcd, iteration, self.ICR)
				writer.change(IWRvcd, iteration, self.IWR)
				writer.change(ISRvcd, iteration, self.ISR)
				writer.change(CSRvcd, iteration, self.CSR)
				writer.change(CHRvcd, iteration, self.CHR)
				writer.change(IORvcd, iteration, self.IOR)
				writer.change(IDRvcd, iteration, self.IDR)
				if self.debuginfo == True:
					writer.change(LabelVCD, iteration, self.memmap[self.reference.index(self.program_counter)])
				if printonly is not None:
					for i in range(len(VMvcd)):
						writer.change(VMvcd[i], iteration, self.CODERAM[VMsymbols_addr[i]])	

			sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Simulation started.\n')
			while (self.program_counter >= 0):
				self.MCR_prev = self.MCR
				self.ICR_prev = self.ICR
				self.IWR_prev = self.IWR
				self.ISR_prev = self.ISR
				self.CSR_prev = self.CSR
				self.CHR_prev = self.CHR
				self.IOR_prev = self.IOR
				self.IDR_prev = self.IDR
				self.CODERAM_PREV = self.CODERAM
				#print(self.program_counter)
				if fastmode and self.program_counter >= 8:
					self.MCR = self.CODERAM[self.program_counter]
					self.CODERAM[0] = self.MCR
					a = self.CODERAM[self.program_counter+1]
					b = self.CODERAM[self.program_counter+2]
					c = self.CODERAM[self.program_counter+3]
					d = self.CODERAM[b]
				else:
					a = self.CODERAM[self.program_counter]
					b = self.CODERAM[self.program_counter+1]
					c = self.CODERAM[self.program_counter+2]
					d = self.CODERAM[b]
				#e = self.CODERAM[a]
				#f = self.CODERAM[d]

				if (self.program_counter >= 0) and (self.program_counter <= 7):
					pipeline = boot_pipeline_stages
					if self.program_counter == 0:
						self.MCR = a & 0xFF
						if self.MCR == 0xFF:
							fastmode = False
						if self.MCR == 0x00:
							fastmode = True
							sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Bootstrapped processor in fast mode, with emitted MCR opcodes.\n')
							leq_pc_pipeline_stages = leq_pc_pipeline_stages_f # or 11 if ovf
							leq_pc_pipeline_stages_ovf = leq_pc_pipeline_stages_ovf_f
							tta_pipeline_stages = tta_pipeline_stages_f
							memr_pipeline_stages = memr_pipeline_stages_f
							mem_pipeline_stages = mem_pipeline_stages_f
							pcs_pipeline_stages = pcs_pipeline_stages_f
							itr_pipeline_stages_in = itr_pipeline_stages_in_f
							itr_pipeline_stages_out = itr_pipeline_stages_out_f
							boot_pipeline_stages = boot_pipeline_stages_f		
					elif self.program_counter == 1:
						self.CHR = a & 0xFF
						if self.CHR == 0xFF:
							self.CHR_flag = True
					elif self.program_counter == 2:
						self.IWR = a & 0xFF
					elif self.program_counter == 3:
						self.ICR = a & 0xFF
					elif self.program_counter == 4:
						self.CSR = a & 0xFF
						self.CSR_flag = True
					elif self.program_counter == 5:
						self.ISR = 0
					elif self.program_counter == 6:
						self.IDR = a & 0xFF
						self.IOR = self.IOR & self.IDR
					elif self.program_counter == 7:
						self.IOR = (a & 0xFF) & self.IDR
					self.program_counter += 1

				else:
					
					if b == 0x00:
						pipeline = tta_pipeline_stages
						self.MCR = self.CODERAM[a] & 0xFF
						self.CODERAM[0] = self.MCR
						self.program_counter = c	
					elif b == 0x01:
						pipeline = tta_pipeline_stages
						self.CHR = self.CODERAM[a] & 0xFF
						self.CODERAM[1] = self.CHR
						self.program_counter = c
						if self.CHR == 0xFF:
							self.CHR_flag = True
						# Hardware related
					elif b == 0x02:
						pipeline = itr_pipeline_stages_in
						self.IWR = self.CODERAM[a] & 0xFF
						self.CODERAM[2] = self.IWR
						self.program_counter = c
						#if self.IWR != 0:
						self.IWR_flag = True
						# Hardware related
					elif b == 0x03:
						pipeline = tta_pipeline_stages
						self.ICR = self.CODERAM[a] & 0xFF
						self.CODERAM[3] = self.ICR
						self.program_counter = c
						# Hardware related
					elif b == 0x04:
						pipeline = tta_pipeline_stages
						self.CSR = self.CODERAM[a] & 0xFF
						self.CODERAM[4] = self.CSR
						self.CSR_flag = True
						self.program_counter = c
						# Hardware related
					elif b == 0x05:
						pipeline = tta_pipeline_stages
						self.program_counter = c
					elif b == 0x06:
						pipeline = tta_pipeline_stages
						self.IDR = self.CODERAM[a] & 0xFF
						self.CODERAM[6] = self.IDR
						self.IOR = self.IOR & self.IDR
						self.CODERAM[7] = self.IOR
						self.program_counter = c
					elif b == 0x07:
						pipeline = tta_pipeline_stages
						self.IOR = ((self.IOR & ~self.IDR) & 0xFF) | ((self.CODERAM[a] & 0xFF) & self.IDR)
						self.CODERAM[7] = self.IOR
						self.program_counter = c
					else:

						if a == 0x07:
								if fastmode:
									pipeline = leq_pc_pipeline_stages_ovf_f
								else:
									pipeline = leq_pc_pipeline_stages_ovf
								sys.stdout.write("\nCPU Cycle: " + str(iteration)+"\n")
								sys.stdout.write(bcolors.OKGREEN + "CPU:" + bcolors.ENDC + " Got an IOR read access at PC: " + str(self.program_counter)+"\n")
								sys.stdout.write(bcolors.OKGREEN + "IDR: " + bcolors.ENDC + str(hex(self.IDR))+"\n")
								ior_user =False
								ior_updated = False
								if vcd is False:
									curses.endwin()
								while ior_user == False:
									if self.ior_in:
										response = input(bcolors.OKBLUE + 'CPU: [value] ' + bcolors.ENDC + '(enter = no changes): ')
									else:
										response = str(self.ior_in_value)
									try:
										response = response.replace(" ","")
										response = response.replace("\n","")
										response = response.replace("\r","")
										if response == "":
											sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
											break
										opr = response.split(",")
										if (int(opr[0]) >= 0) and (int(opr[0]) <= 255):
											if (((int(opr[0]) & ~self.IDR) & 0xFF)) != (self.IOR & ~self.IDR) & 0xFF:
												self.IOR = (self.IOR & self.IDR) | (((int(opr[0]) & ~self.IDR) & 0xFF))
												self.CODERAM[7] = self.IOR
												ior_user = True
												sys.stdout.write("Updated.\n\n")
												ior_updated = True
											else:
												ior_user = True
												sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
										else:
											ior_user = False	
									except:
										pass	
								if vcd is False:
									curses.initscr()
								if (vcd is True) and (ior_updated == True):
									writer.change(IORvcd, aiteration, self.IOR)

						if self.MCR & 0xFF == 0xFF:
							pipeline = leq_pc_pipeline_stages_ovf
							result = self.CODERAM[b] - self.CODERAM[a]
							#self.CHR = 0x00
							if (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 1) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 0) and (((result & 0x8000) >> self.MEMWIDTH) == 0):
								self.CHR = self.CHR | 0x01
							elif (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 0) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 1) and (((result & 0x8000) >> self.MEMWIDTH) == 1):
								self.CHR = self.CHR | 0x01
							else:
								self.CHR = self.CHR & 0xFE
							if result > 2**(self.MEMADDRESSABLE-1)-1:
								self.CHR = self.CHR | 0x01
								result = result & 0xFFFF;
							if result < -2**(self.MEMADDRESSABLE-1):
								self.CHR = self.CHR | 0x01
								result = result & 0xFFFF;	

							self.CHR = self.CHR & 0xF1
							if self.CODERAM[b] == self.CODERAM[a]:
								self.CHR = self.CHR | 0x08
							if self.CODERAM[b] > self.CODERAM[a]:
								self.CHR = self.CHR | 0x02
							if self.CODERAM[b] < self.CODERAM[a]:
								self.CHR = self.CHR | 0x04
							self.CODERAM[0x01] = self.CHR	

							self.CODERAM[b] = result 
						elif self.MCR & 0xFF == 0xEE:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = self.CODERAM[a]			
						elif self.MCR & 0xFF == 0xCC:
							pipeline = leq_pc_pipeline_stages_ovf
							result = self.CODERAM[a] + self.CODERAM[b]
							#self.CHR = 0x00	
							if (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 1) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 1) and (((result & 0x8000) >> self.MEMWIDTH) == 0):
								self.CHR = self.CHR | 0x01
							elif (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 0) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 0) and (((result & 0x8000) >> self.MEMWIDTH) == 1):
								self.CHR = self.CHR | 0x01
							else:
								self.CHR = self.CHR & 0xFE
							if result > 2**(self.MEMADDRESSABLE-1)-1:
								self.CHR = self.CHR | 0x01
								result = result & 0xFFFF;
							if result < -2**(self.MEMADDRESSABLE-1):
								self.CHR = self.CHR | 0x01
								result = result & 0xFFFF;	

							self.CHR = self.CHR & 0xF1
							if self.CODERAM[b] == self.CODERAM[a]:
								self.CHR = self.CHR | 0x08
							if self.CODERAM[b] > self.CODERAM[a]:
								self.CHR = self.CHR | 0x02
							if self.CODERAM[b] < self.CODERAM[a]:
								self.CHR = self.CHR | 0x04
							self.CODERAM[0x01] = self.CHR

							self.CODERAM[b] = result 					
						elif self.MCR & 0xFF == 0x99:
							pipeline = leq_pc_pipeline_stages_ovf
							result = (self.CODERAM[a] << (self.CODERAM[b])) 
							if result > 0x7FFF:
								result = result & 0x7FFF;
							self.CODERAM[b] = result
						elif self.MCR & 0xFF == 0x88:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = (self.CODERAM[a] >> (self.CODERAM[b]))								
						elif self.MCR & 0xFF == 0x77:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = (self.CODERAM[a] | self.CODERAM[b])
						elif self.MCR & 0xFF == 0x66:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = (self.CODERAM[a] & self.CODERAM[b]) 			
						elif self.MCR & 0xFF == 0x55:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = (self.CODERAM[a] ^ self.CODERAM[b]) 
						elif self.MCR & 0xFF == 0x44:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = (~(self.CODERAM[a] ^ self.CODERAM[b])) 
						elif self.MCR & 0xFF == 0x33:
							pipeline = leq_pc_pipeline_stages_ovf
							self.CODERAM[b] = self.program_counter
							#print("PC: program counter", self.program_counter)
						elif self.MCR & 0xFF == 0x22:
							pipeline = mem_pipeline_stages
							if a == 0x07:
									if fastmode:
										pipeline = leq_pc_pipeline_stages_ovf_f
									else:
										pipeline = leq_pc_pipeline_stages_ovf
									sys.stdout.write("\nCPU Cycle: " + str(iteration)+"\n")
									sys.stdout.write(bcolors.OKGREEN + "CPU:" + bcolors.ENDC + " Got an IOR read access at PC: " + str(self.program_counter)+"\n")
									sys.stdout.write(bcolors.OKGREEN + "IDR: " + bcolors.ENDC + str(hex(self.IDR))+"\n")
									ior_user =False
									ior_updated = False
									if vcd is False:
										curses.endwin()
									while ior_user == False:
										if self.ior_in:
											response = input(bcolors.OKBLUE + 'CPU: [value] ' + bcolors.ENDC + '(enter = no changes): ')
										else:
											response = str(self.ior_in_value)
										try:
											response = response.replace(" ","")
											response = response.replace("\n","")
											response = response.replace("\r","")
											if response == "":
												sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
												break
											opr = response.split(",")
											if (int(opr[0]) >= 0) and (int(opr[0]) <= 255):
												if (((int(opr[0]) & ~self.IDR) & 0xFF)) != (self.IOR & ~self.IDR) & 0xFF:
													self.IOR = (self.IOR & self.IDR) | (((int(opr[0]) & ~self.IDR) & 0xFF))
													self.CODERAM[7] = self.IOR
													ior_user = True
													sys.stdout.write("Updated.\n\n")
													ior_updated = True
												else:
													ior_user = True
													sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
											else:
												ior_user = False	
										except:
											pass	
									if vcd is False:
										curses.initscr()
									if (vcd is True) and (ior_updated == True):
										writer.change(IORvcd, aiteration, self.IOR)	
							 #e
							if d > 0x07:
								self.CODERAM[d] = self.CODERAM[a]
							#if d == 0x00:
							#	pipeline = tta_pipeline_stages
							#	self.MCR = self.CODERAM[a] & 0xFF
							#	self.CODERAM[0] = self.MCR
							if d == 0x01:
								pipeline = tta_pipeline_stages
								self.CHR = self.CODERAM[a] & 0xFF
								self.CODERAM[1] = self.CHR
								if self.CHR == 0xFF:
									self.CHR_flag = True
								# Hardware related
							elif d == 0x02:
								pipeline = itr_pipeline_stages_in
								self.IWR = self.CODERAM[a] & 0xFF
								self.CODERAM[2] = self.IWR
								#if self.IWR != 0:
								self.IWR_flag = True
								# Hardware related
							elif d == 0x03:
								pipeline = tta_pipeline_stages
								self.ICR = self.CODERAM[a] & 0xFF
								self.CODERAM[3] = self.ICR
								# Hardware related
							elif d == 0x04:
								pipeline = tta_pipeline_stages
								self.CSR = self.CODERAM[a] & 0xFF
								self.CODERAM[4] = self.CSR
								self.CSR_flag = True
								# Hardware related
							elif d == 0x05:
								pipeline = tta_pipeline_stages
							elif d == 0x06:
								pipeline = tta_pipeline_stages
								self.IDR = self.CODERAM[a] & 0xFF
								self.CODERAM[6] = self.IDR
								self.IOR = self.IOR & self.IDR
								#self.CODERAM[7] = self.IOR
							elif d == 0x07:
								pipeline = tta_pipeline_stages
								self.IOR = ((self.IOR & ~self.IDR) & 0xFF) | ((self.CODERAM[a] & 0xFF) & self.IDR)
								#self.IOR = ((self.CODERAM[a] & 0xFF) & self.IDR)
								self.CODERAM[7] = self.IOR
									

						elif self.MCR & 0xFF == 0x11:
							pipeline = memr_pipeline_stages
							if d == 0x07:
									if fastmode:
										pipeline = leq_pc_pipeline_stages_ovf_f
									else:
										pipeline = leq_pc_pipeline_stages_ovf
									sys.stdout.write("\nCPU Cycle: " + str(iteration)+"\n")
									sys.stdout.write(bcolors.OKGREEN + "CPU:" + bcolors.ENDC + " Got an IOR read access at PC: " + str(self.program_counter)+"\n")
									sys.stdout.write(bcolors.OKGREEN + "IDR: " + bcolors.ENDC + str(hex(self.IDR))+"\n")
									ior_user =False
									ior_updated = False
									if vcd is False:
										curses.endwin()
									while ior_user == False:
										if self.ior_in:
											response = input(bcolors.OKBLUE + 'CPU: [value] ' + bcolors.ENDC + '(enter = no changes): ')
										else:
											response = str(self.ior_in_value)
										try:
											response = response.replace(" ","")
											response = response.replace("\n","")
											response = response.replace("\r","")
											if response == "":
												sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
												break
											opr = response.split(",")
											if (int(opr[0]) >= 0) and (int(opr[0]) <= 255):
												if (((int(opr[0]) & ~self.IDR) & 0xFF)) != (self.IOR & ~self.IDR) & 0xFF:
													self.IOR = (self.IOR & self.IDR) | (((int(opr[0]) & ~self.IDR) & 0xFF))
													self.CODERAM[7] = self.IOR
													ior_user = True
													sys.stdout.write("Updated.\n\n")
													ior_updated = True
												else:
													ior_user = True
													sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "No changes.\n\n")
											else:
												ior_user = False	
										except:
											pass	
									if vcd is False:
										curses.initscr()
									if (vcd is True) and (ior_updated == True):
										writer.change(IORvcd, aiteration, self.IOR)		
							if a > 0x07:
								self.CODERAM[a] = self.CODERAM[d]
							#if a == 0x00:
							#	pipeline = tta_pipeline_stages
							#	self.MCR = self.CODERAM[d] & 0xFF
							#	self.CODERAM[0] = self.MCR
							if a == 0x01:
								pipeline = tta_pipeline_stages
								self.CHR = self.CODERAM[d] & 0xFF
								self.CODERAM[1] = self.CHR
								if self.CHR == 0xFF:
									self.CHR_flag = True
								# Hardware related
							elif a == 0x02:
								pipeline = itr_pipeline_stages_in
								self.IWR = self.CODERAM[d] & 0xFF
								self.CODERAM[2] = self.IWR
								#if self.IWR != 0:
								self.IWR_flag = True
								# Hardware related
							elif a == 0x03:
								pipeline = tta_pipeline_stages
								self.ICR = self.CODERAM[d] & 0xFF
								self.CODERAM[3] = self.ICR
								# Hardware related
							elif a == 0x04:
								pipeline = tta_pipeline_stages
								self.CSR = self.CODERAM[d] & 0xFF
								self.CODERAM[4] = self.CSR
								self.CSR_flag = True
								# Hardware related
							elif a == 0x05:
								pipeline = tta_pipeline_stages
							elif a == 0x06:
								pipeline = tta_pipeline_stages
								self.IDR = self.CODERAM[d] & 0xFF
								self.CODERAM[6] = self.IDR
								self.IOR = self.IOR & self.IDR
								#self.CODERAM[7] = self.IOR
							elif a == 0x07:
								pipeline = tta_pipeline_stages
								self.IOR = ((self.IOR & ~self.IDR) & 0xFF) | ((self.CODERAM[d] & 0xFF) & self.IDR)
								#self.IOR = ((self.CODERAM[a] & 0xFF) & self.IDR)
								self.CODERAM[7] = self.IOR	

						elif self.MCR & 0xFF == 0x00:
							pipeline = pcs_pipeline_stages
							self.program_counter = self.CODERAM[b] #d
							#print("PCS: program counter", self.program_counter)
						else:
							pipeline = leq_pc_pipeline_stages_ovf		
							result = self.CODERAM[b] - self.CODERAM[a]
							#self.CHR = 0x00
							if (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 1) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 0) and (((result & 0x8000) >> self.MEMWIDTH) == 0):
								self.CHR = self.CHR | 0x01
							elif (((self.CODERAM[b] & 0x8000) >> self.MEMWIDTH) == 0) and (((self.CODERAM[a] & 0x8000) >> self.MEMWIDTH) == 1) and (((result & 0x8000) >> self.MEMWIDTH) == 1):
								self.CHR = self.CHR | 0x01
							else:
								self.CHR = self.CHR & 0xFE

							self.CHR = self.CHR & 0xF1
							if self.CODERAM[b] == self.CODERAM[a]:
								self.CHR = self.CHR | 0x08
							if self.CODERAM[b] > self.CODERAM[a]:
								self.CHR = self.CHR | 0x02
							if self.CODERAM[b] < self.CODERAM[a]:
								self.CHR = self.CHR | 0x04
							self.CODERAM[0x01] = self.CHR	

							self.CODERAM[b] = result 

						if (self.CODERAM[b] <= 0) and self.MCR != 0x00 and self.MCR != 0x11 and self.MCR != 0x22 and self.MCR != 0x33:
							self.program_counter = c
						else:
							if fastmode:
								self.program_counter += 4
							else:
								self.program_counter += 3

				if umemprint != 0 and vcd is False:
					MAX_LINE,width = screen.getmaxyx()
					screen.clear()
					if (self.program_counter >= 0) and (self.program_counter < 8):
						self.bootstrapstr = " - Bootstrap"
					else:
						self.bootstrapstr = ""
					screen.addstr(0,0,'CPU: Cycle ' + str(iteration) + self.bootstrapstr)
					screen.addstr(1,0,'Program Counter\t\t\t (PC):\t\t' + str(self.program_counter))
					screen.addstr(2,0,'Machine Code Register\t\t (MCR):\t\t' + str(hex(self.MCR)))
					screen.addstr(3,0,'CPU Halt Register\t\t (CHR):\t\t' + str(hex(self.CHR)))
					screen.addstr(4,0,'Interrupt Wait Register\t (IWR):\t\t' + str(hex(self.IWR)))
					screen.addstr(5,0,'Interrupt Configuration Register\t\t (ICR):\t\t' + str(hex(self.ICR)))
					screen.addstr(6,0,'Clock Speed Register\t\t (CSR):\t\t' + str(hex(self.CSR)))
					screen.addstr(7,0,'Interrupt Status Register\t (ISR):\t\t' + str(hex(self.ISR)))
					screen.addstr(8,0,'Input/Output Register\t\t (IOR):\t\t' + str(hex(self.IOR)))
					screen.addstr(9,0,'Input/output Direction Register\t (IDR):\t\t' + str(hex(self.IDR)))
					curline = 10
					for idx in range(9, umemprint):
						if idx in self.reference:
							if printonly is not None:
								if self.memmap[self.reference.index(idx)] in printonly.upper():
									if len(self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):") < 8:
										screen.addstr(curline,0,self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):\t\t\t" + str(self.CODERAM[idx]) & 0xFFFF)
									else:
										screen.addstr(curline,0,self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):\t\t" + str(self.CODERAM[idx] & 0xFFFF))
									curline += 1								
							else:
								if len(self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):") < 8:
									screen.addstr(curline,0,self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):\t\t\t" + str(self.CODERAM[idx] & 0xFFFF))
								else:
									screen.addstr(curline,0,self.memmap[self.reference.index(idx)] +" ("+ str(idx) +"):\t\t" + str(self.CODERAM[idx] & 0xFFFF))
								curline += 1
						else:
							if umempsym == False:
								screen.addstr(curline,0,str(idx) +":\t\t" + str(self.CODERAM[idx] & 0xFF))
								curline += 1
						if curline >= MAX_LINE:
							break
					screen.refresh()					


				if vcd is False: 
					time.sleep(self.delay)


				if self.CSR_flag == True:
					 self.CSR_flag = False
					 if self.CSR == 0:
					 	titeration = int(self.CLK_100MHz/self.CLK_10kHz) * pipeline
					 	self.delay = K_10kHz
					 elif self.CSR == 64:
					 	titeration = int(self.CLK_100MHz/self.CLK_1MHz) * pipeline
					 	self.delay = K_1MHz
					 elif self.CSR == 128:
					 	titeration = int(self.CLK_100MHz/self.CLK_50MHz) * pipeline
					 	self.delay = K_50MHz
					 elif self.CSR == 192:
					 	titeration = int(self.CLK_100MHz/self.CLK_100MHz) * pipeline
					 	self.delay = K_100MHz
					 else:
					 	titeration = int(self.CLK_100MHz/self.CLK_10kHz) * pipeline
					 	self.delay = K_10kHz

				if self.CSR == 0:
					 	titeration = int(self.CLK_100MHz/self.CLK_10kHz) * pipeline
				elif self.CSR == 64:
					 	titeration = int(self.CLK_100MHz/self.CLK_1MHz) * pipeline
				elif self.CSR == 128:
					 	titeration = int(self.CLK_100MHz/self.CLK_50MHz) * pipeline
				elif self.CSR == 192:
					 	titeration = int(self.CLK_100MHz/self.CLK_100MHz) * pipeline
				else:
					 	titeration = int(self.CLK_100MHz/self.CLK_10kHz) * pipeline

				if self.CHR_flag == True:
					if vcd is False:
						curses.endwin()
					self.CHR_flag = False
					sys.stdout.write("\nCPU Cycle: " + str(iteration)+"\n")	
					sys.stdout.write(bcolors.OKBLUE + 'CPU: Processor halted.' + bcolors.ENDC + '\n')
					break


				if self.IWR_flag == True:
					self.IWR_flag = False
					interrupt_user = False
					if vcd is True:
						writer.change(PCvcd, aiteration+titeration, self.program_counter)
						if self.IWR_prev != self.IWR:
							writer.change(IWRvcd, aiteration+titeration, self.IWR)
						aiteration += titeration
					if vcd is False:
						curses.endwin()
					sys.stdout.write("\nCPU Cycle: " + str(iteration)+"\n")	
					sys.stdout.write(bcolors.OKGREEN + "CPU: Got an IWR write at PC: " + str(self.program_counter) + "\n" + bcolors.ENDC)
					sys.stdout.write(bcolors.OKGREEN + "IDR: "+ bcolors.ENDC + str(hex(self.IDR))+"\n")
					sys.stdout.write(bcolors.OKGREEN + "ICR: "+ bcolors.ENDC + str(hex(self.ICR))+"\n")
					sys.stdout.write(bcolors.OKGREEN + "IWR: "+ bcolors.ENDC + str(hex(self.IWR))+"\n")
					while interrupt_user == False:
						response = input(bcolors.OKBLUE + 'CPU: [\'P, T\', +time (ns)]' + bcolors.ENDC + ' (P = pin, 0 to 7, T = transition, 0=0->1, 1=1->0): ')
						try:
							response = response.replace(" ","")
							response = response.replace("\n","")
							response = response.replace("\r","")
							opr = response.split(",")
							if (int(opr[0]) >= 0) and (int(opr[0]) < 8):
								if (self.ICR & (0x01 << int(opr[0]))) == (int(opr[1]) << int(opr[0])):
									self.ISR = 0x01 << int(opr[0])
									self.CODERAM[5] = self.ISR
									if (self.ISR & self.IWR != 0x00) and (int(opr[2]) > 0):
										interrupt_user = True
							else:
								interrupt_user = False

						except:
							pass
					if vcd is False:
							curses.initscr()
					if int(opr[1]) == 0: 
						self.IOR = self.IOR | self.ISR
					self.IWR = 0
					self.IWR_prev = self.IWR
					sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + "Event received!\n\n")
					if vcd is True:
						writer.change(IWRvcd, aiteration+int(titeration/itr_pipeline_stages_in*itr_pipeline_stages_out)+int(opr[2]), self.IWR)
						if self.ISR_prev != self.ISR:
							writer.change(ISRvcd, aiteration+int(titeration/itr_pipeline_stages_in*itr_pipeline_stages_out)+int(opr[2]), self.ISR)
							self.ISR_prev = self.ISR
						if self.IOR_prev != self.IOR:
							writer.change(IORvcd, aiteration+int(titeration/itr_pipeline_stages_in*itr_pipeline_stages_out)+int(opr[2]), self.IOR)
							self.IOR_prev = self.IOR
						aiteration += int(opr[2])+int(titeration/itr_pipeline_stages_in*itr_pipeline_stages_out)
							

				iteration += 1
				if vcd is True:
					writer.change(PCvcd, aiteration+titeration, self.program_counter)
					if self.MCR_prev != self.MCR or self.CODERAM[0] != self.CODERAM_PREV[0]:
						writer.change(MCRvcd, aiteration+titeration, self.MCR)
					if self.ICR_prev != self.ICR or self.CODERAM[3] != self.CODERAM_PREV[3]:
						writer.change(ICRvcd, aiteration+titeration, self.ICR)
					if self.IWR_prev != self.IWR or self.CODERAM[2] != self.CODERAM_PREV[2]:
						writer.change(IWRvcd, aiteration+titeration, self.IWR)
					if self.ISR_prev != self.ISR or self.CODERAM[5] != self.CODERAM_PREV[5]:
						writer.change(ISRvcd, aiteration+titeration, self.ISR)
					if self.CSR_prev != self.CSR or self.CODERAM[4] != self.CODERAM_PREV[4]:
						writer.change(CSRvcd, aiteration+titeration, self.CSR)
					if self.CHR_prev != self.CHR or self.CODERAM[1] != self.CODERAM_PREV[1]:
						writer.change(CHRvcd, aiteration+titeration, self.CHR)
					if self.IOR_prev != self.IOR or self.CODERAM[7] != self.CODERAM_PREV[7]:
						writer.change(IORvcd, aiteration+titeration, self.IOR)
					if self.IDR_prev != self.IDR or self.CODERAM[6] != self.CODERAM_PREV[6]:
						writer.change(IDRvcd, aiteration+titeration, self.IDR)
					if printonly is not None:

						for i in range(len(VMvcd)):
								writer.change(VMvcd[i], aiteration+titeration, self.CODERAM[VMsymbols_addr[i]])	
					if self.debuginfo == True:
						if self.program_counter in self.reference:
							writer.change(LabelVCD, aiteration+titeration, self.memmap[self.reference.index(self.program_counter)])				

					aiteration += titeration
					if iteration == utime:
						sys.stdout.write('Simulation finished.\n')
						raise KeyboardInterrupt
		except KeyboardInterrupt:
			if vcd is False:
				curses.endwin()
				sys.stdout.write('\n' + bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Break.\n')
			else:
				fvcd.close()
				sys.stdout.write('\n' + bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'VCD file closed.\n')
			sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Simulation ended.\n')
		except IndexError:
			sys.stdout.write('\n' + bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Pointing to out of memory locations. Current a, b, c and d are: '+str(a)+", " +str(b)+", " +str(c)+", " +str(d)+". Check the stack pointer offset in memory (-spo argument in dc.py).\n")
			if vcd is False:
				curses.endwin()
				sys.stdout.write('\n' + bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Break.\n')
			else:
				fvcd.close()
				sys.stdout.write('\n' + bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'VCD file closed.\n')
			sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Simulation ended.\n')			


def ui_init():
    parser = argparse.ArgumentParser(description = "dRISC816/mOISC Assembler and Simulator - Copyright (C) 2020-2021 Marco Crepaldi - Electronic Design Laboratory - Istituto Italiano di Tecnologia")
    parser.add_argument('-in', metavar = 'filein', dest='filein', help="Input ASM file to be assembled. By default .asm extension will be enforced. Example: test_program (reads: test_program.asm)")
    parser.add_argument('-out', metavar = 'fileout', dest='fileout', help="Output dRISC binary, symbols and MIF files. By default .mif, .bin (machine code file), .sym (symbols text file for simulation) extension will be enforced. Example: test_program (writes: test_program.mif, test_program.bin, test_program.sym)")
    parser.add_argument('-simulate', metavar = 'sim', dest='sim', help="Input binary and symbols file to run simulation. By default .bin and .sym symbols will be enforced as inputs. Example: test_program (reads test_program.bin and test_program.sym)")
    parser.add_argument('-pmem', metavar = 'pmem', dest='pmem', help="Code memory to be parsed for printing (default is 12000 bytes)")
    parser.add_argument('-syms', metavar = 'syms', dest='syms', type=str, help="Symbols to be included in the simulation (comma separated, make sure you use \\$ to specify the character \'$\'). If omitted, $1 $2 $3 $4 $5 $6 $7 $8 $ra $sp $fp will be included") 
    parser.add_argument('-vcd', action="store_true", help="Creates a VCD file for simulation visualization and does not show the interactive simulation window. The file name is based on the --out string (e.g., writes: test_program.vcd). It must be used with -time, to specify simulation simulation time") 
    parser.add_argument('-debug', action="store_true", help="Add #DEBUG label information string in the simulation. It must be used with -vcd") 
    parser.add_argument('-iorovr', metavar="iorovr", dest='iorovr', help="Overrides IOR input requests by the simulator with the specified integer") 
    parser.add_argument('-time', metavar = 'time', dest='time', type=int, help="Specifies simulation runtime in clock cycles") 
    parser.add_argument('-f', action='store_true', help="Assembles or run simulation in fast mode (express MCR, CISC mode), with input file name extension .fasm. The binary code will be different compared to normal OISC mode") 
    args = parser.parse_args()
    return args

def main():
	arguments = ui_init()
	if (arguments.syms is not None) and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -syms must be specified with -simulate. Use \'-h\' for help. \n')
		sys.exit(1)			
	if (arguments.pmem is not None) and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -pmem must be specified with -simulate. Use \'-h\' for help. \n')
		sys.exit(1)	
	if (arguments.vcd is True) and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -vcd must be specified with -simulate. Use \'-h\' for help. \n')
		sys.exit(1)	
	if (arguments.vcd is True) and arguments.time is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -time must be specified with -vcd. Use \'-h\' for help. \n')
		sys.exit(1)	
	if (arguments.vcd is False) and arguments.sim is not None and arguments.debug is not None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -debug must be specified with -vcd. Use \'-h\' for help. \n')
		sys.exit(1)	
	if (arguments.vcd is False) and arguments.time is not None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -vcd must be specified with -time. Use \'-h\' for help. \n')
		sys.exit(1)	
	if (arguments.iorovr is not None) and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -iorovr must be specified with -simulate. Use \'-h\' for help. \n')
		sys.exit(1)		
	if ((arguments.f is True) and (arguments.sim is not None)):
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Argument -f does not apply with -simulate. Use \'-h\' for help. \n')
		sys.exit(1)			
	if (arguments.vcd is True):
		vcdFlag = True
	else:
		vcdFlag = False
	if (arguments.iorovr is not None):
		iorovr_value = int(arguments.iorovr)
		iorovr = False
	else:
		iorovr_value = 0
		iorovr = True

	if arguments.time is not None:
		utime = int(arguments.time)
	else:
		utime = 0

	if arguments.debug is not None:
		debuginfo = True
	else:
		debuginfo = False

	if arguments.filein is None and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Input file is missing. Use \'-h\' for help. \n')
		sys.exit(1)
	if arguments.fileout is None and arguments.sim is None:
		sys.stdout.write(bcolors.FAIL + 'Error: ' + bcolors.ENDC + 'Output file is missing. Use \'-h\' for help. \n')
		sys.exit(1)	
	asm = DRISC()
	if arguments.filein is not None and arguments.fileout is not None:
		p_codein = Path(arguments.filein)
		p_codeout = Path(arguments.fileout)
		codein = str(p_codein.with_suffix(''))
		codeout = str(p_codeout.with_suffix(''))
		if arguments.f is False:
			asm.assemble(filein=(codein+".asm"), fileout=(codeout+".bin"), filesym=(codeout+".sym"), filemif=(codeout+".mif"))	
		else:
			sys.stdout.write(bcolors.OKGREEN + 'Info: ' + bcolors.ENDC + 'Assembling in fast mode using MCR opcode emission.\n')
			asm.assemble_f(filein=(codein+".fasm"), fileout=(codeout+".bin"), filesym=(codeout+".sym"), filemif=(codeout+".mif"))
	if arguments.sim is not None:
		p_code = Path(arguments.sim)
		code = str(p_code.with_suffix(''))
		if arguments.pmem is None:
			umemprint = 12000
		else:
			umemprint = int(arguments.pmem)

		if arguments.syms is None:
			printonly = '$1 $2 $3 $4 $5 $6 $7 $8 $ra $sp $fp'
		else:
			printonly = arguments.syms.replace(",", " ")
		asm.load(filein=(code+".bin"), filesym=(code+".sym"))
		asm.simulate(umemprint=umemprint,printonly=printonly,vcd=vcdFlag,vcdfile=(code+".vcd"), utime=utime, iorovr=iorovr, iorovr_value=iorovr_value, debug=debuginfo)

main()


