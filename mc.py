# coding=utf-8
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Dynamic Reduced Instruction Set Computer (d'RISC) [a.k.a. multi-OISC (mOISC)] cross-compiler/translator and linker 
# Copyright (C) March 18, 2020, Marco Crepaldi, Istituto Italiano di Tecnologia (IIT)
# Electronic Design Laboratory (EDL)
# Via Melen 83, 16152, Genova, Italy
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# taken from GNU Blender: https://svn.blender.org/svnroot/bf-blender/trunk/blender/build_files/scons/tools/bcolors.py
class bcolors:
    HEADER = '\033[95m'
    OKGREEN = '\033[92m'
    OKBLUE = '\033[94m'
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
try:
	import argparse
except:
	sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Python module argparse not found. If you want to install it, please run python3 -m pip install argparse\n")
	sys.exit(1)	
from pathlib import Path
from dataclasses import dataclass

class arch_to_drisc:
	_MIPSEL = 'mipsel'
	_X86 = 'x86'
	_ARM = 'arm'
	_RISCV32 = 'riscv32'
	_LL = 'll'



	def __init__(self, intermediate='mipsel', linker=True):
		self.intermediate = intermediate
		self.linker = linker
		if self.intermediate != self._MIPSEL and self.intermediate != self._X86 and self.intermediate != self._ARM and self.intermediate != self._RISCV32 and self.intermediate != self._LL:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + self.intermediate + " architecture not implemented.\n")
			sys.exit(1)
		self.stack_offset = '31500'			
		self.sp_offset = self.stack_offset
		self.esp_offset = '0' #self.stack_offset
		self.es_offset = '0'
		self.isp_offset = self.stack_offset
		self.lr_offset = self.stack_offset
		self.CODERAM_LBL = []
		self.CODERAM_MNEMONIC = []
		self.DATARAM_LBL = []
		self.DATARAM_VALUE = []
		self.BOOTSTRAP = ['MCR', 'CHR', 'IWR', 'ICR', 'CSR', 'ISR', 'IDR', 'IOR']
		self.BOOTSTRAP_DMEM = ['255', '0', '0', '0', '0', '0', '0', '0']
		self.primitive_directory = "./lib/arch"
		self.primitives_mipsel = ['sra','beq', 'movz', 'lui', 'not', 'add', 'and', 'move', 'or', 'sll', 'srl', 'sub', 'xnor', 'xor', 'lw', 'sw','label','j','jr','nop','jal','main','slti','beqz','bgtz','bnez','bne','negu','bgez','__setcsr','__seticr','__setidr','__setiwr','__setchr', '__setior', '__getior','__getisr']
		self.primitives_x86 = ['al_restore', 'bl_restore', 'cl_restore', 'dl_restore', 'leal_leftmost_quadruple','testb','setl','movl_rightmost_vector_zero','movl_leftmost_vector_zero', 'movl_rightmost_triple', 'movl_leftmost_zero', 'movl_rightmost_zero', 'al_reg', 'bl_reg', 'dl_reg', 'main_redirect', 'rep_movsl_noop', 'movl_leftmost_triple', 'rep_movsl', 'cl_reg', 'addl_leftmost', 'addl_rightmost', 'jl', 'leal', 'leal_leftmost', 'jne', 'jle', 'jg', 'je', 'sarl','jge', '__setior','__setcsr', '__setidr', '__seticr', '__setiwr', '__setchr', '__getior', '__getisr', 'jmp','addl','shll','andl','orl','orl_leftmost','orl_rightmost','calll', 'subl', 'subl_rightmost', 'subl_leftmost', 'xorl', 'retl', 'popl', 'main', 'pushl', 'label', 'movl', 'movl_rightmost', 'movl_leftmost', 'cmpl', 'cmpl_rightmost', 'cmpl_leftmost']
		self.primitives_arm = ['movlt','ldr_triple_lsl_wb','str_triple_lsl','tst','blx', 'add_lsl','bx_noex', 'main_redirect', 'ble', 'bge', 'ldr_double_const','lsl','mvn','bne','stm_xt','stm_xt_wb','stm_xt_op','ldm_xt','ldm_xt_wb','ldm_xt_op','blt','asr','ldr_triple_lsl','beq', 'bic', 'ldrb_double', 'ldrb_triple', 'pop', 'pop2','lsr','rsb','orr','orr_lsl', 'and', 'and_lsr', 'bl','push', 'push2', 'push3', 'push4', 'push5', 'push6', 'bgt','cmp', 'ldr_double', 'ldr_triple','b', 'move', 'mov_pc_lr', 'add', 'str_double', 'str_triple', 'sub', '_main','label','__setcsr','__seticr','__setidr','__setiwr','__setchr', '__setior', '__getior','__getisr','cmn']
		self.primitives_riscv32 = ['sra','bge','blt','beq', 'lui', 'not', 'add', 'and', 'mv', 'or', 'sll', 'srl', 'sub', 'xnor', 'xor', 'lw', 'sw','label','j','jr','nop','call','main','slti','beqz','bgtz','bnez','bne','bgez','__setcsr','__seticr','__setidr','__setiwr','__setchr', '__setior', '__getior','__getisr']
		self.primitives_ll = ['constant','global', 'label','add','icmp','getelementptr','and','alloca','bitcast_to','sext_to','store','inttoptr','br','load']
		#self.primitives_ll = ['icmp','and','br']

		if intermediate == self._MIPSEL:
			self.primitives = self.primitives_mipsel
		elif intermediate == self._X86:
			self.primitives = self.primitives_x86
		elif intermediate == self._ARM:
			self.primitives = self.primitives_arm
		elif intermediate == self._RISCV32:
			self.primitives = self.primitives_riscv32
		elif intermediate == self._LL:
			self.primitives = self.primitives_ll
		self.mnemonic = 'exec'
		self.macro_primitives_exec = []
		self.macro_primitives_dmem = []
		self.macro_primitives_dmem_data = []
		for _ in self.primitives:
			self.macro_primitives_exec.append([])
			self.macro_primitives_dmem.append([])
			self.macro_primitives_dmem_data.append([])
		self.NUMSET = "-0123456789"
		self.immvar = 0
		self.immvarprefix = "imm."
		self.lvar = 0
		# fast mode (express MCR)
		self.MCRsSYM = ['_SUBLMCR', '_MOVMCR', '_ADDMCR', '_SHLMCR', '_SHRMCR', '_ORMCR', '_ANDMCR', '_XORMCR', '_XNORMCR', '_PCMCR','_MEMMCR','_MEMRMCR','_PCSMCR']
		self.MCRsVAL = [0xFF, 0xEE, 0xCC, 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00]
		self.OPCODE = ['subleq', 'movleq', 'addleq', 'shlleq', 'shrleq', 'orleq', 'andleq', 'xorleq', 'xnorleq', 'pc', 'mem', 'memr', 'pcs']
		self._INSTR_ID = 'exec'
		self._MEMID	  = ':'
		self.PCMCR_RESCALE = '_PCMCR_'

	def set_stack_offset(self, stack_offset):
		self.stack_offset = stack_offset			
		self.sp_offset = self.stack_offset
		self.esp_offset = self.stack_offset
		self.es_offset = '0'
		self.isp_offset = self.stack_offset
		self.lr_offset = self.stack_offset
		self.llvm_m_ptr = self.stack_offset

	def load_primitives(self):
		try:
			for primitive in self.primitives:
				fp = open(self.primitive_directory + "/" + self.intermediate + '/' + primitive + ".asm",'r')
				while True:
					line = fp.readline().replace('\t','').replace('\n','').replace('\r','')
					if line != "":
						if line[0] != '#':
							if self.mnemonic in line:
								self.macro_primitives_exec[self.primitives.index(primitive)].append(line)
							else:
								line = line.replace(' ','')
								meta = line.split(':')
								if meta[1] == '':
									self.macro_primitives_exec[self.primitives.index(primitive)].append(line)
								else:
									self.macro_primitives_dmem[self.primitives.index(primitive)].append(meta[0])
									self.macro_primitives_dmem_data[self.primitives.index(primitive)].append(meta[1])
					else:
	   					break
				fp.close()
				for i in range(len(self.macro_primitives_dmem)):
					for j in range(len(self.macro_primitives_dmem[i])):
						if (self.macro_primitives_dmem[i][j] not in self.DATARAM_LBL) and (self.macro_primitives_dmem[i][j] not in self.BOOTSTRAP):
							self.DATARAM_LBL.append(self.macro_primitives_dmem[i][j])
							self.DATARAM_VALUE.append(self.macro_primitives_dmem_data[i][j])
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot load " + self.intermediate + " primitives. Some of them may be missing.\n")
				sys.exit(1)				

	def update_links_riscv32(self, primitivein, operands, operands_len, isref=False):
			self.isdefined0 = False
			self.isdefined1 = False
			self.isdefined2 = False			
			self.tomem0 = ''
			self.tomem1 = ''
			self.tomem2 = ''
			self.lvar += 1
			for idx in range(len(operands)):
				if [i in self.NUMSET for i in operands[idx]] == [True] * len(operands[idx]):
					if idx == 0:
						self.tomem0 = str(operands[idx])
					elif idx == 1:
						self.tomem1 = str(operands[idx])
					elif idx == 2:
						self.tomem2 = str(operands[idx])						
					indices = [i for i, x in enumerate(self.DATARAM_VALUE) if x == str(operands[idx]) and self.DATARAM_LBL[i][0:len(self.immvarprefix)] == self.immvarprefix]
					if indices == []:
						operands[idx] = self.immvarprefix + str(self.immvar)
						self.immvar += 1
						if idx == 0:
							self.isdefined0 = True
						elif idx == 1:
							self.isdefined1 = True
						elif idx == 2:
							self.isdefined2 = True
					else:
						operands[idx] = self.DATARAM_LBL[indices[0]] 

			newprimitive = []

			for primitive in primitivein:
							if len(operands) >= 3:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))	
							elif len(operands) == 2:
								tmp = primitive.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))
							else:
								tmp = primitive.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))

							newprimitive.append(tmp)
			if isref == False:
				if (len(operands) > 0):
					if (operands[0] not in self.DATARAM_LBL) and (operands[0] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[0])
						if (self.isdefined0 == True):
							self.DATARAM_VALUE.append(self.tomem0)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 1):
					if (operands[1] not in self.DATARAM_LBL) and (operands[1] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[1])
						if (self.isdefined1 == True):
							self.DATARAM_VALUE.append(self.tomem1)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 2):
					if (operands[2] not in self.DATARAM_LBL) and (operands[2] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[2])
						if (self.isdefined2 == True):
							self.DATARAM_VALUE.append(self.tomem2)
						else:
							self.DATARAM_VALUE.append('0')
	
			return newprimitive		

	def update_links(self, primitivein, operands, operands_len, isref=False):
			self.isdefined0 = False
			self.isdefined1 = False
			self.isdefined2 = False			
			self.tomem0 = ''
			self.tomem1 = ''
			self.tomem2 = ''
			self.lvar += 1
			for idx in range(len(operands)):
				if [i in self.NUMSET for i in operands[idx]] == [True] * len(operands[idx]):
					if idx == 0:
						self.tomem0 = str(operands[idx])
					elif idx == 1:
						self.tomem1 = str(operands[idx])
					elif idx == 2:
						self.tomem2 = str(operands[idx])						
					indices = [i for i, x in enumerate(self.DATARAM_VALUE) if x == str(operands[idx]) and self.DATARAM_LBL[i][0:len(self.immvarprefix)] == self.immvarprefix]
					if indices == []:
						operands[idx] = self.immvarprefix + str(self.immvar)
						self.immvar += 1
						if idx == 0:
							self.isdefined0 = True
						elif idx == 1:
							self.isdefined1 = True
						elif idx == 2:
							self.isdefined2 = True
					else:
						operands[idx] = self.DATARAM_LBL[indices[0]] 

			newprimitive = []

			for primitive in primitivein:
							if len(operands) >= 3:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))	
							elif len(operands) == 2:
								tmp = primitive.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))
							else:
								tmp = primitive.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))

							newprimitive.append(tmp)
			if isref == False:
				if (len(operands) > 0):
					if (operands[0] not in self.DATARAM_LBL) and (operands[0] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[0])
						if (self.isdefined0 == True):
							self.DATARAM_VALUE.append(self.tomem0)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 1):
					if (operands[1] not in self.DATARAM_LBL) and (operands[1] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[1])
						if (self.isdefined1 == True):
							self.DATARAM_VALUE.append(self.tomem1)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 2):
					if (operands[2] not in self.DATARAM_LBL) and (operands[2] not in self.BOOTSTRAP):
						self.DATARAM_LBL.append(operands[2])
						if (self.isdefined2 == True):
							self.DATARAM_VALUE.append(self.tomem2)
						else:
							self.DATARAM_VALUE.append('0')
	
			return newprimitive			

	def update_links_x86(self, primitivein, operands, operands_len, isref=False):
			self.isdefined0 = False
			self.isdefined1 = False
			self.isdefined2 = False		
			self.isdefined3 = False
			self.isdefined4 = False		
			self.tomem0 = ''
			self.tomem1 = ''
			self.tomem2 = ''
			self.tomem3 = ''
			self.tomem4 = ''
			self.lvar += 1

			for i in range(len(operands)):
				try:
					idata = int(operands[i])
				except:
					idata = -1
				if idata > 0x7FFF:
					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Immediate bigger than 0x7FFF, " + operands[i] + ". Killed to 0x7FFF. \n")
					operands[i] = str(0x7FFF)
			for idx in range(len(operands)):
				if [i in self.NUMSET for i in operands[idx]] == [True] * len(operands[idx]):
					if idx == 0:
						self.tomem0 = str(operands[idx])
					elif idx == 1:
						self.tomem1 = str(operands[idx])
					elif idx == 2:
						self.tomem2 = str(operands[idx])
					elif idx == 3:
						self.tomem3 = str(operands[idx])
					elif idx == 4:
						self.tomem4 = str(operands[idx])						
					indices = [i for i, x in enumerate(self.DATARAM_VALUE) if x == str(operands[idx]) and self.DATARAM_LBL[i][0:len(self.immvarprefix)] == self.immvarprefix]
					if indices == []:
						operands[idx] = self.immvarprefix + str(self.immvar)
						self.immvar += 1
						if idx == 0:
							self.isdefined0 = True
						elif idx == 1:
							self.isdefined1 = True
						elif idx == 2:
							self.isdefined2 = True
						elif idx == 3:
							self.isdefined3 = True
						elif idx == 4:
							self.isdefined4 = True
					else:
							operands[idx] = self.DATARAM_LBL[indices[0]] 

			newprimitive = []

			for primitive in primitivein:
							if len(operands) >= 5:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", operands[3])
								tmp = tmp.replace("%5", operands[4])
								tmp = tmp.replace("%6", str(self.lvar))	
							elif len(operands) >= 4:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", operands[3])
								tmp = tmp.replace("%5", str(self.lvar))	
							elif len(operands) >= 3:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))	
							elif len(operands) == 2:
								tmp = primitive.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))
							else:
								tmp = primitive.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))

							newprimitive.append(tmp)
			if isref == False:
				if (len(operands) > 0):
					if (operands[0] not in self.DATARAM_LBL) and (operands[0] not in self.BOOTSTRAP) and (operands[0][0:4] != 'l___') and (operands[0][0] != '_'):
						self.DATARAM_LBL.append(operands[0])
						if (self.isdefined0 == True):
							self.DATARAM_VALUE.append(self.tomem0)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 1):
					if (operands[1] not in self.DATARAM_LBL) and (operands[1] not in self.BOOTSTRAP) and (operands[1][0:4] != 'l___') and (operands[1][0] != '_'):
						self.DATARAM_LBL.append(operands[1])
						if (self.isdefined1 == True):
							self.DATARAM_VALUE.append(self.tomem1)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 2):
					if (operands[2] not in self.DATARAM_LBL) and (operands[2] not in self.BOOTSTRAP) and (operands[2][0:4] != 'l___') and (operands[2][0] != '_'):
						self.DATARAM_LBL.append(operands[2])
						if (self.isdefined2 == True):
							self.DATARAM_VALUE.append(self.tomem2)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 3):
					if (operands[3] not in self.DATARAM_LBL) and (operands[3] not in self.BOOTSTRAP) and (operands[3][0:4] != 'l___') and (operands[3][0] != '_'):
						self.DATARAM_LBL.append(operands[3])
						if (self.isdefined3 == True):
							self.DATARAM_VALUE.append(self.tomem3)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 4):
					if (operands[4] not in self.DATARAM_LBL) and (operands[4] not in self.BOOTSTRAP) and (operands[4][0:4] != 'l___') and (operands[4][0] != '_'):
						self.DATARAM_LBL.append(operands[4])
						if (self.isdefined4 == True):
							self.DATARAM_VALUE.append(self.tomem4)
						else:
							self.DATARAM_VALUE.append('0')
	
			return newprimitive	

	def update_links_arm(self, primitivein, operands, operands_len, isref=False):
			self.isdefined0 = False
			self.isdefined1 = False
			self.isdefined2 = False		
			self.isdefined3 = False
			self.isdefined4 = False		
			self.isdefined5 = False
			self.tomem0 = ''
			self.tomem1 = ''
			self.tomem2 = ''
			self.tomem3 = ''
			self.tomem4 = ''
			self.tomem5 = ''
			self.lvar += 1

			for i in range(len(operands)):
				try:
					idata = int(operands[i])
				except:
					idata = -1
				if idata > 0x7FFF:
					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Immediate bigger than 0x7FFF, " + operands[i] + ". Killed to 0x7FFF. \n")
					operands[i] = str(0x7FFF)
			for idx in range(len(operands)):
				if [i in self.NUMSET for i in operands[idx]] == [True] * len(operands[idx]):
					if idx == 0:
						self.tomem0 = str(operands[idx])
					elif idx == 1:
						self.tomem1 = str(operands[idx])
					elif idx == 2:
						self.tomem2 = str(operands[idx])
					elif idx == 3:
						self.tomem3 = str(operands[idx])
					elif idx == 4:
						self.tomem4 = str(operands[idx])
					elif idx == 5:
						self.tomem5 = str(operands[idx])	
					indices = [i for i, x in enumerate(self.DATARAM_VALUE) if x == str(operands[idx]) and self.DATARAM_LBL[i][0:len(self.immvarprefix)] == self.immvarprefix]
					if indices == []:
						operands[idx] = self.immvarprefix + str(self.immvar)
						self.immvar += 1
						if idx == 0:
							self.isdefined0 = True
						elif idx == 1:
							self.isdefined1 = True
						elif idx == 2:
							self.isdefined2 = True
						elif idx == 3:
							self.isdefined3 = True
						elif idx == 4:
							self.isdefined4 = True
						elif idx == 5:
							self.isdefined5 = True
					else:
						operands[idx] = self.DATARAM_LBL[indices[0]] 

			newprimitive = []

			for primitive in primitivein:
							if len(operands) >= 6:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", operands[3])
								tmp = tmp.replace("%5", operands[4])
								tmp = tmp.replace("%6", operands[5])	
								tmp = tmp.replace("%7", str(self.lvar))
							elif len(operands) >= 5:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", operands[3])
								tmp = tmp.replace("%5", operands[4])
								tmp = tmp.replace("%6", str(self.lvar))	
							elif len(operands) >= 4:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", operands[3])
								tmp = tmp.replace("%5", str(self.lvar))	
							elif len(operands) >= 3:
								tmp = primitive.replace("%3", operands[2])
								tmp = tmp.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))	
							elif len(operands) == 2:
								tmp = primitive.replace("%2", operands[1])
								tmp = tmp.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))
							else:
								tmp = primitive.replace("%1", operands[0])
								tmp = tmp.replace("%4", str(self.lvar))

							newprimitive.append(tmp)
			if isref == False:
				if (len(operands) > 0):
					if (operands[0] not in self.DATARAM_LBL) and (operands[0] not in self.BOOTSTRAP) and (operands[0][0:4] != 'l___') and (operands[0][0:2] != 'LC') and (operands[0][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[0])
						if (self.isdefined0 == True):
							self.DATARAM_VALUE.append(self.tomem0)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 1):
					if (operands[1] not in self.DATARAM_LBL) and (operands[1] not in self.BOOTSTRAP) and (operands[1][0:4] != 'l___') and (operands[1][0:2] != 'LC') and (operands[1][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[1])
						if (self.isdefined1 == True):
							self.DATARAM_VALUE.append(self.tomem1)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 2):
					if (operands[2] not in self.DATARAM_LBL) and (operands[2] not in self.BOOTSTRAP) and (operands[2][0:4] != 'l___') and (operands[2][0:2] != 'LC') and (operands[2][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[2])
						if (self.isdefined2 == True):
							self.DATARAM_VALUE.append(self.tomem2)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 3):
					if (operands[3] not in self.DATARAM_LBL) and (operands[3] not in self.BOOTSTRAP) and (operands[3][0:4] != 'l___') and (operands[3][0:2] != 'LC') and (operands[3][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[3])
						if (self.isdefined3 == True):
							self.DATARAM_VALUE.append(self.tomem3)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 4):
					if (operands[4] not in self.DATARAM_LBL) and (operands[4] not in self.BOOTSTRAP) and (operands[4][0:4] != 'l___') and (operands[4][0:2] != 'LC') and (operands[4][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[4])
						if (self.isdefined4 == True):
							self.DATARAM_VALUE.append(self.tomem4)
						else:
							self.DATARAM_VALUE.append('0')
				if (len(operands) > 5):
					if (operands[5] not in self.DATARAM_LBL) and (operands[5] not in self.BOOTSTRAP) and (operands[5][0:4] != 'l___') and (operands[5][0:2] != 'LC') and (operands[5][0:3] != '.LC'):
						self.DATARAM_LBL.append(operands[5])
						if (self.isdefined5 == True):
							self.DATARAM_VALUE.append(self.tomem5)
						else:
							self.DATARAM_VALUE.append('0')	
			return newprimitive	

	def push_initial_vars(self):
		self.DATARAM_LBL.append('$sp')
		self.DATARAM_VALUE.append(self.sp_offset)

	def push_initial_vars_riscv32(self):
		self.DATARAM_LBL.append('sp')
		self.DATARAM_VALUE.append(self.sp_offset)

	def push_initial_vars_arm(self):
		self.DATARAM_LBL.append('sp')
		self.DATARAM_VALUE.append(self.sp_offset)
		self.DATARAM_LBL.append('lr')
		self.DATARAM_VALUE.append(self.lr_offset)

	def push_initial_vars_x86(self):
		self.DATARAM_LBL.append('esp')
		self.DATARAM_VALUE.append(self.esp_offset)
		self.DATARAM_LBL.append('isp')
		self.DATARAM_VALUE.append(self.isp_offset)
		self.DATARAM_LBL.append('es')
		self.DATARAM_VALUE.append(self.es_offset)

	def translate(self, filename="t0.arch", fileout="t0.asm", llvm_cc='fast'):
		if self.intermediate == self._MIPSEL:
			self.compile_mips(filename=filename, fileout=fileout)
		if self.intermediate == self._X86:
			self.compile_x86(filename=filename, fileout=fileout)
		if self.intermediate == self._ARM:
			self.compile_arm(filename=filename, fileout=fileout)	
		if self.intermediate == self._RISCV32:
			self.compile_riscv32(filename=filename, fileout=fileout)	
		if self.intermediate == self._LL:
			self.compile_llvm(filename=filename, fileout=fileout, cc=llvm_cc)

	def llvm_adjust_line(self, linein):
		newline = linein
		newline = re.sub(r"^\s+|\s+$", "", newline)
		newline = newline.replace('\n',"")
		newline = newline.replace('\r',"")
		return newline

	def llvm_compact_generics(self, token):
		ntoken = []
		ingeneric = False
		inGlobal = False
		chars = ""
		for i in range(len(token)):
			if token[i][0] == self.LLVM_GENERICS_MANDATORY_START and token[i][len(token[i])-1] != self.LLVM_GENERICS_MANDATORY_END and token[i][len(token[i])-2] != self.LLVM_GENERICS_MANDATORY_END:
				ingeneric = True
			elif (token[i][0] != self.LLVM_GENERICS_MANDATORY_START) and (token[i][len(token[i])-1] == self.LLVM_GENERICS_MANDATORY_END):
				chars += token[i]
				ntoken.append(chars)
				ingeneric = False
				chars = ""
			else:
				ntoken.append(token[i])
			if ingeneric == True:
				chars += token[i] + " "		
		return ntoken

	@dataclass
	class LLVM_IR:
		name: ['']
		positional_required: ['']
		leftmost: False
		required: ['']
		positional_name: ['']
		actual_values: ['']

	def llvm_lexer_initialize(self):
		self.LLVM_LEXER_MTYPE = []
		self.LLVM_LEXER_OTYPE = []
		self.LLVM_LEX = []
		self.llvm_initialize_functend()


	def llvm_lexer_populate(self, token):
		#m = re.findall('\[(.+?)\]', text)
		required = []
		positional_required = []
		positional_name = []
		leftmost = False
		name = []
		chars = ""
		position = 0
		isvar = False
		if token == []:
			return
		if token[1] == self.LLVM_ASSIGN:
				leftmost = True
		else:
				leftmost = False
		if len(token) > 2:
			if token[2] == self.LLVM_ASSIGN:
					leftmost = True
		for i in range(len(token)):
			if token[i][0] == self.LLVM_GENERICS_MANDATORY_START and (token[i][len(token[i])-1] == self.LLVM_GENERICS_MANDATORY_END or token[i][len(token[i])-2] == self.LLVM_GENERICS_MANDATORY_END) or self.LLVM_GLOBAL == token[i][0] or self.LLVM_ARB == token[i][0]:
				required.append(token[i])
				positional_required.append(position)
				#position += 1
			elif not self.llvm_is_delimiter(token[i]) and token[i] != self.LLVM_PTR and token[i] != self.LLVM_ASSIGN and self.LLVM_GLOBAL != token[i][0]:
				#if name == "":
					name.append(token[i])
					positional_name.append(position)
				#else:
				#	name += " " + token[i]
			elif self.llvm_is_delimiter(token[i]) and token[i] != self.LLVM_ASSIGN and token[i] != self.LLVM_PTR:
				
					required.append(token[i])
					positional_required.append(position)

			if token[i][0] == self.LLVM_ARB: 
					name.append(token[i])
					positional_name.append(position)				

			position += 1

		actual = [''] * len(required)
		self.LLVM_LEX.append(self.LLVM_IR(name=name, required=required, positional_required=positional_required, leftmost=leftmost, positional_name=positional_name, actual_values=actual))




	def llvm_load_commands(self):
		try:
			self.llvm_lexer_initialize()
			self.primitives = os.listdir(self.primitive_directory + "/" + self.intermediate)
			i = 0
			L = len(self.primitives)
			while i < (L):
				if self.primitives[i][0] == '.':
					self.primitives.remove(self.primitives[i])
				i += 1
				L = len(self.primitives)
			
			for primitive in self.primitives:
				fp = open(self.primitive_directory + "/" + self.intermediate + '/' + primitive,'r')
				while True:
					rawline = fp.readline()
					if rawline != "" and rawline != "#":
						line = self.llvm_adjust_line(rawline)
						token = self.llvm_token(line)
						token = self.llvm_remove_comments(token)
						token = self.llvm_compact_generics(token)
						self.llvm_lexer_populate(token)
						#print("TOKEN: ", token)
						

					else:
	   					break
				fp.close()
			#for i in range(len(self.LLVM_LEX)):
			#	print(self.LLVM_LEX[i])
			#	print("")
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot load " + self.intermediate + " commands. Some of them may be missing.\n")
				sys.exit(1)	


	def llvm_parse_left_toright(self, line):
		chars = ""
		newline = line
		i = -1
		if line != "":
			for i in range(len(line)):
				if self.llvm_isnot_blank(line[i]):
					chars += line[i]
				else:
					break
		newline=line[i+1:]
		return chars, newline

	def llvm_token_is_comment(self, data):
		if data == self.LLVM_COMMENT:
			return True
		else:
			return False

	def llvm_remove_comments(self, token):
		tokens = []
		for i in range(len(token)):
			if self.llvm_token_is_comment(token[i]):
				break
			else:
				tokens.append(token[i])
		return tokens


	def llvm_token(self, line):
			newline = line
			tokenp = []
			token = []
			while newline != "":
				t, newline = self.llvm_parse_left_toright(newline)
				tokenp.append(t)
			for i in range(len(tokenp)):
				chars = ""
				for j in range(len(tokenp[i])):
					if self.llvm_is_delimiter(tokenp[i][j]):
						if chars != "":
							token.append(chars)
						token.append(tokenp[i][j])
						chars = ""
					else:
						chars += tokenp[i][j]
				if chars != "":
					token.append(chars)
			return token

	def llvm_isnot_blank(self,c):
		if c == " " or c == "\t":
			return False
		else:
			return True

	def llvm_is_alphanum(self, c):
		if (c.upper() in self.LLVM_NUMSET) or (c.upper() in self.LLVM_ALPHASET):
			return True
		else:
			return False

	def llvm_is_delimiter(self, c):
		if c in self.LLVM_DELIMITSET:
			return True
		else:
			return False


	def llvm_print_lex(self):
		for i in range(len(self.LLVM_LEX)):
			sys.stdout.write("node name: " + self.LLVM_LEX[i].name +"\n")
			sys.stdout.write("node most: " + self.LLVM_LEX[i].leftmost + "\n")
			sys.stdout.write("positionals: " + self.LLVM_LEX[i].positional_required + "\n")

	def llvm_print_lex_single(self, lex):
			print("\tnode name:\t\t", lex.name)
			print("\tnode name positionals:\t", lex.positional_name)
			print("\tnode leftmost:\t\t", lex.leftmost)
			print("\trequired positionals:\t", lex.positional_required)
			print("\trequired:\t\t", lex.required)
			print("\trequired actuals:\t", lex.actual_values)

	def llvm_decode_instr(self, token):
		if token == []:
			return False
		llvmtype = self.llvm_detect_type(token)
		datac = []
		if llvmtype == self.LLVM_iTYPE_LABEL:
			datac = [i for idx, i in enumerate(self.LLVM_LEX) if self.LLVM_LEX[idx].name == ["label"]]
		elif llvmtype == self.LLVM_iTYPE_LEFTMOST:
			datac = [i for idx, i in enumerate(self.LLVM_LEX) if self.LLVM_LEX[idx].leftmost == True]
		elif llvmtype == self.LLVM_iTYPE_RIGHTMOST:
			datac = [i for idx, i in enumerate(self.LLVM_LEX) if self.LLVM_LEX[idx].leftmost == False]
		elif llvmtype == self.LLVM_iTYPE_FUNCTEND:
			datac = [i for idx, i in enumerate(self.LLVM_LEX) if self.LLVM_LEX[idx].name == [self.LLVM_FUNCTEND]]


		if len(datac) == 1:
			#sys.stdout.write("decoded instruction: \n")
			actual_null = [str(token[0])] #[''] * len(datac[0].required)
			newdatac = self.LLVM_IR(name=datac[0].name, required=datac[0].required, positional_required=datac[0].positional_required, leftmost=datac[0].leftmost, positional_name=datac[0].positional_name, actual_values=actual_null)
			self.LLVM_I.append(newdatac)
			#self.llvm_print_lex_single(self.LLVM_I[len(self.LLVM_I)-1])
			return True
		elif len(datac) > 1:
			i = 0
			while (i < (len(datac))):
				found = True
				foundR = False
				enterR = False
				j = 0
				#print("DATAC: ", datac[i])
				#print("TOKEN; ", token)
				while (j < (len(datac[i].name))):
					if datac[i].name[j] != '$':
						if datac[i].positional_name[j] < len(token):
							if datac[i].name[j] != token[datac[i].positional_name[j]]:
								found = False
								break
						else:
							found = False
							break
					else:
						enterR = True
						if j == len(datac[i].name)-1:
							found = True
							break
						r = j+1
						k = datac[i].positional_name[j]
						foundR = False
						while k < len(token):
								if datac[i].name[r] == "$":
									foundR = True
									break
								elif token[k] == datac[i].name[r]:
									foundR = True
								k += 1

					j += 1
					if enterR == True and foundR == False:
						found = False
						break
					if foundR == True:
						found = True
						break

				if found == True:
					break
				i += 1
			if found:
				#sys.stdout.write("decoded instruction: \n")
				actual_values = []
				j = 0
				offset = 0
				while j < len(datac[i].required):
				#for j in range(len(datac[i].required)):
					if datac[i].required[j] == "$":
						k = datac[i].positional_required[j]
						initial = k + 1
						arb = []
						while k < len(token):
							if token[k] != datac[i].required[j+1]:
								arb.append(token[k])
							else:
								#arb.append(token[k])
								offset = k - initial
								j += 1
								break
							k += 1
						actual_values.append(arb)
						actual_values.append(token[k])
					else:
					#if datac[i].positional_name[datac[i].positional_required[i]+1
						actual_values.append(token[datac[i].positional_required[j]+offset])
					
					j += 1
				datac[i].actual_values = actual_values
				newdatac = self.LLVM_IR(name=datac[i].name, required=datac[i].required, positional_required=datac[i].positional_required, leftmost=datac[i].leftmost, positional_name=datac[i].positional_name, actual_values=actual_values)
				self.LLVM_I.append(newdatac)
				#self.llvm_print_lex_single(datac[i])
				#self.llvm_print_lex_single(self.LLVM_I[len(self.LLVM_I)-1])
				return True
			else:
				return False

	@dataclass
	class LLVM_F:
		Function: ""
		FunctionAllocs: [[""]]
		FunctionMaps:[""]
		FunctionIns: [""]
		FunctionOuts: [""]
		FunctionType: [""]

	def llvm_push_dram(self, label, value):
		if label not in self.LLVM_DRAM:
			self.LLVM_DRAM.append(label)
			self.LLVM_DRAM_VALUE.append(str(value))		

	def llvm_push_immediate_dram(self, value):
			immediates = []
			values = []
			for i in range(len(self.LLVM_DRAM)):
				if self.LLVM_DRAM[i][0:4] == "imm.":
					immediates.append(self.LLVM_DRAM[i])
					values.append(self.LLVM_DRAM_VALUE[i])
			if str(value) in values:
				return immediates[values.index(str(value))]
			label = self.LLVM_CONST + str(self.immediate)
			self.LLVM_DRAM.append(label)
			self.LLVM_DRAM_VALUE.append(str(value))
			self.immediate += 1
			return label

	def llvm_call_retrieve_operands(self, args, thisfunc_index):
		operands = []
		for i in range(len(args)):

				if args[i][0] == "%":
					op0 = self.LLVM_WRITER_VAR + args[i][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
					self.llvm_push_dram(op0, 0)
				elif args[i][0] == "@":
					op0 = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+args[i][1:]
				else:
					newimmediate = self.llvm_push_immediate_dram(args[i])
					op0 = newimmediate	
				operands.append(op0)

		return operands

	def llvm_probe_operands(self, bases, thisfunc_index, index):
				lbases = len(bases)

				if lbases < 1: 
					return None
				op0 = ""
				op1 = ""
				op2 = ""
				op3 = ""
				op0_inAllocs = False
				op1_inAllocs = False
				op2_inAllocs = False
				op3_inAllocs = False

				BASE0 = bases[0]
				if lbases >= 2:
					BASE1 = bases[1]
				if lbases >= 3:
					BASE2 = bases[2]
				if lbases== 4:
					BASE3 = bases[3]

				if self.LLVM_I[index].actual_values[BASE0] in self.LLVM_FUNC[thisfunc_index].FunctionAllocs:
					op0_inAllocs = True
				if lbases >= 2:
					if self.LLVM_I[index].actual_values[BASE1] in self.LLVM_FUNC[thisfunc_index].FunctionAllocs:
						op1_inAllocs = True
				if lbases >= 3:
					if self.LLVM_I[index].actual_values[BASE2] in self.LLVM_FUNC[thisfunc_index].FunctionAllocs:
						op2_inAllocs = True
				if lbases == 4:
					if self.LLVM_I[index].actual_values[BASE3] in self.LLVM_FUNC[thisfunc_index].FunctionAllocs:
						op3_inAllocs = True

				if self.LLVM_I[index].actual_values[BASE0][0] == "%":
					op0 = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE0][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
					self.llvm_push_dram(op0, 0)
				elif self.LLVM_I[index].actual_values[BASE0][0] == "@":
					op0 = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[BASE0][1:]
				else:
					newimmediate = self.llvm_push_immediate_dram(self.LLVM_I[index].actual_values[BASE0])
					op0 = newimmediate	
				if lbases >= 2:
					if op1_inAllocs:
						#print(self.LLVM_FUNC[thisfunc_index].FunctionMaps)
						#print(self.LLVM_FUNC[thisfunc_index].FunctionAllocs)
						offset = int(self.LLVM_FUNC[thisfunc_index].FunctionMaps[int(self.LLVM_FUNC[thisfunc_index].FunctionAllocs.index(self.LLVM_I[index].actual_values[BASE1]))])
						newimmediate = self.llvm_push_immediate_dram(offset)
						op1 = newimmediate
					elif not op1_inAllocs:
						if self.LLVM_I[index].actual_values[BASE1][0] == "@":
							op1 = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[BASE1][1:]
						elif self.LLVM_I[index].actual_values[BASE1][0] == "%":
							op1 = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE1][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
							self.llvm_push_dram(op1, 0)
						else:
							newimmediate = self.llvm_push_immediate_dram(self.LLVM_I[index].actual_values[BASE1])
							op1 = newimmediate

				if lbases >= 3:
					if op2_inAllocs:
						#print(self.LLVM_FUNC[thisfunc_index].FunctionMaps)
						#print(self.LLVM_FUNC[thisfunc_index].FunctionAllocs)
						offset = int(self.LLVM_FUNC[thisfunc_index].FunctionMaps[int(self.LLVM_FUNC[thisfunc_index].FunctionAllocs.index(self.LLVM_I[index].actual_values[BASE2]))])
						newimmediate = self.llvm_push_immediate_dram(offset)
						op2 = newimmediate
					elif not op2_inAllocs:
						if self.LLVM_I[index].actual_values[BASE2][0] == "@":
							op2 = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[BASE2][1:]
						elif self.LLVM_I[index].actual_values[BASE2][0] == "%":
							op2 = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE2][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
							self.llvm_push_dram(op2, 0)						
						else:
							newimmediate = self.llvm_push_immediate_dram(self.LLVM_I[index].actual_values[BASE2])
							op2 = newimmediate

				if lbases == 4:
					if op3_inAllocs:
						#print(self.LLVM_FUNC[thisfunc_index].FunctionMaps)
						#print(self.LLVM_FUNC[thisfunc_index].FunctionAllocs)
						offset = int(self.LLVM_FUNC[thisfunc_index].FunctionMaps[int(self.LLVM_FUNC[thisfunc_index].FunctionAllocs.index(self.LLVM_I[index].actual_values[BASE3]))])
						newimmediate = self.llvm_push_immediate_dram(offset)
						op3 = newimmediate
					elif not op2_inAllocs:
						if self.LLVM_I[index].actual_values[BASE3][0] == "@":
							op3 = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[BASE3][1:]
						elif self.LLVM_I[index].actual_values[BASE3][0] == "%":
							op3 = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE3][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
							self.llvm_push_dram(op2, 0)						
						else:
							newimmediate = self.llvm_push_immediate_dram(self.LLVM_I[index].actual_values[BASE3])
							op3 = newimmediate

				return [op0, op1, op2, op3], [op0_inAllocs, op1_inAllocs, op2_inAllocs, op3_inAllocs]

	def llvm_get_label(self, base, thisfunc_index, index):
		lbl = self.LLVM_WRITER_LABEL + self.LLVM_I[index].actual_values[base] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
		lbl = lbl.replace(self.LLVM_VAR, "")
		return lbl

	def llvm_clang9_compat_generate_operands(self, operands):
				onlytypes = True
				newoperands = []
				idx = 0
				for i in range(len(operands)):
						if operands[i] not in self.LLVM_DECL_TYPES:
							if operands[i] not in self.LLVM_DELIMITSET:
								onlytypes = False
				if onlytypes: 
					for i in range(len(operands)):
							if operands[i] in self.LLVM_DECL_TYPES:
								newoperands.append(operands[i])
								newoperands.append('%'+str(idx))
								idx += 1
							elif operands[i] in self.LLVM_DELIMITSET:
								newoperands.append(operands[i])	
					return newoperands
				else:
					return operands
					

	def llvm_compiler_funct_preload(self):
		self.LLVM_FUNC = []

		index = 0
		thisfunc_index = 0
		alloc_index = 0
		while index < len(self.LLVM_I):
			if self.LLVM_I[index].name == ['alloca', 'align']:
				alloc_index += 1
				self.LLVM_FUNC[thisfunc_index].FunctionType.append(self.LLVM_I[index].actual_values[1])
				self.LLVM_FUNC[thisfunc_index].FunctionAllocs.append(self.LLVM_I[index].actual_values[0])
				self.LLVM_FUNC[thisfunc_index].FunctionMaps.append(alloc_index)
			if self.LLVM_I[index].name == ['alloca', 'x', 'align']:
				for i in range(int(self.LLVM_I[index].actual_values[2])):
					alloc_index += 1
					self.LLVM_FUNC[thisfunc_index].FunctionType.append(self.LLVM_I[index].actual_values[3])
					self.LLVM_FUNC[thisfunc_index].FunctionAllocs.append(self.LLVM_I[index].actual_values[0])
					self.LLVM_FUNC[thisfunc_index].FunctionMaps.append(alloc_index)
			elif self.LLVM_I[index].name == ['define', '$'] or self.LLVM_I[index].name == ['define', 'dso_local', '$']:
				ins = self.llvm_clang9_compat_generate_operands(self.LLVM_I[index].actual_values[3])
				self.LLVM_FUNC.append(self.LLVM_F(Function=self.LLVM_I[index].actual_values[1], FunctionOuts=self.LLVM_I[index].actual_values[0], FunctionIns=ins, FunctionAllocs=[], FunctionMaps=[], FunctionType=[]))
				#print(self.LLVM_FUNC[len(self.LLVM_FUNC)-1])
			elif self.LLVM_I[index].name ==['define', 'void', '$'] or self.LLVM_I[index].name ==['define', 'dso_local', 'void', '$']:
				ins = self.llvm_clang9_compat_generate_operands(self.LLVM_I[index].actual_values[2])
				self.LLVM_FUNC.append(self.LLVM_F(Function=self.LLVM_I[index].actual_values[0], FunctionOuts='void', FunctionIns=ins, FunctionAllocs=[], FunctionMaps=[], FunctionType=[]))
				#print(self.LLVM_FUNC[len(self.LLVM_FUNC)-1])
			elif self.LLVM_I[index].name == ['}']:
				alloc_index = 0
				thisfunc_index += 1
			index += 1
		#for i in range(len(self.LLVM_FUNC)):
		#	print(self.LLVM_FUNC[i])

	def llvm_get_function_index(self, name):
		for idx in range(len(self.LLVM_FUNC)):
			if self.LLVM_FUNC[idx].Function == name:
				break
		return idx

	def llvm_function_extract_args(self, thisfunc_index):
		arguments = []
		arglist = self.LLVM_FUNC[thisfunc_index].FunctionIns
		#print("ARGLIST:", arglist, self.LLVM_DECL_TYPES, self.LLVM_DELIMITSET)
		for i in range(len(arglist)):
			if (arglist[i] not in self.LLVM_DECL_TYPES) and (arglist[i] not in self.LLVM_DELIMITSET):
				arguments.append(arglist[i])
		#print("ARGUMENTS:", arguments)
		return arguments

	def llvm_call_extract_args(self, BASE, index):
		arguments = []
		arglist = self.LLVM_I[index].actual_values[BASE]
		for i in range(len(arglist)):
			if arglist[i] not in self.LLVM_DECL_TYPES and arglist[i] not in self.LLVM_DELIMITSET:
				arguments.append(arglist[i])
		return arguments

	def llvm_get_function_alloc_num(self, thisfunc_index):
		return len(self.LLVM_FUNC[thisfunc_index].FunctionAllocs)

	def llvm_check_vectorized_operands(self, op):
		ops = []
		for i in range(len(self.LLVM_DRAM)):
			if op == self.LLVM_DRAM[i]:
				ops.append(self.LLVM_DRAM[i])
			elif op in self.LLVM_DRAM[i] and self.LLVM_DRAM[i][len(op)] == ".":
				ops.append(self.LLVM_DRAM[i])
		return ops				

	def llvm_compiler(self, mp=32500, cc='fast'):

		inFunc = False
		self.llvm_ir_cc = cc
		
		self.LLVM_IRAM = []
		self.LLVM_DRAM = []
		self.LLVM_DRAM_VALUE = []
		

		for i in range(len(self.BOOTSTRAP)):
			self.LLVM_IRAM.append(self.BOOTSTRAP[i] + ":\t\t" + self.BOOTSTRAP_DMEM[i])
		self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
		self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + "main")
		for i in range(len(self.LLVM_MCRsSYM)):
			self.LLVM_DRAM.append(self.LLVM_MCRsSYM[i])
			self.LLVM_DRAM_VALUE.append(self.LLVM_MCRsVAL[i])

		self.LLVM_DRAM.append('_NULL')
		self.LLVM_DRAM_VALUE.append('0')

		self.LLVM_DRAM.append(self.LLVM_MP)
		self.LLVM_DRAM_VALUE.append(str(mp))
		self.LLVM_DRAM.append(self.LLVM_LR)
		self.LLVM_DRAM_VALUE.append(0)

		self.llvm_push_dram('_TMP', 0)


		self.LLVM_CONST = "imm."

		index = 0
		self.immediate = 0
		thisfunc_index = 0
		alloc_index = 0
		icmp_type = ""

		while index < len(self.LLVM_I):
			#print(self.LLVM_I[index].name)
			if self.LLVM_I[index].name == ['global', 'inttoptr', 'to', 'align'] or self.LLVM_I[index].name == ['dso_local', 'global', 'inttoptr', 'to', 'align']:
				self.llvm_push_dram(self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:], self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:])
				self.llvm_push_dram(self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:], self.LLVM_I[index].actual_values[4])

			elif self.LLVM_I[index].name == ['global', 'null', 'align'] or self.LLVM_I[index].name == ['dso_local', 'global', 'null', 'align']:
				self.llvm_push_dram(self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:],self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:])

				self.llvm_push_dram(self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:], 0)

			elif self.LLVM_I[index].name == ['global', 'align'] or self.LLVM_I[index].name == ['dso_local', 'global', 'align']:
				self.llvm_push_dram(self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:],self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:])

				self.llvm_push_dram(self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:],self.LLVM_I[index].actual_values[2])

			elif self.LLVM_I[index].name == ['constant', 'x', '$', 'align']:
				self.llvm_push_dram(self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:], self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:]+self.LLVM_WRITER_VECT+str(0))
				for i in range(int(self.LLVM_I[index].actual_values[2])):
					self.llvm_push_dram(self.LLVM_WRITER_GLOBAL+self.LLVM_I[index].actual_values[0][1:]+self.LLVM_WRITER_VECT+str(i), self.LLVM_I[index].actual_values[6][1+3*i])

			elif self.LLVM_I[index].name == ['alloca', 'align']:

				pass
			elif self.LLVM_I[index].name == ['alloca', 'x', 'align']:

				pass
			elif self.LLVM_I[index].name == ['}']:
				inFunc = False
				thisfunc_index = callerfunc_index

			elif self.LLVM_I[index].name ==['define', 'void', '$'] or self.LLVM_I[index].name ==['define', 'dso_local', 'void', '$']:
				callerfunc_index = thisfunc_index 
				thisfunc_index = self.llvm_get_function_index(self.LLVM_I[index].actual_values[0])
				self.LLVM_IRAM.append(self.LLVM_I[index].actual_values[0][1:] + ":\t\t" + self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL)
				inFunc = True
				#print(self.LLVM_FUNC[thisfunc_index])

				if self.llvm_ir_cc == 'std':
					one = self.llvm_push_immediate_dram(1)

					myself_ir_vars = self.llvm_function_extract_args(thisfunc_index)
					myself_variables = self.llvm_call_retrieve_operands(myself_ir_vars, thisfunc_index)
					#print(thisfunc_index, myself_ir_vars, myself_variables)

					for idx_var in range(len(myself_variables)):

						self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + myself_variables[len(myself_variables)-1-idx_var] + ", " + self.LLVM_MP)	
						self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)	
				elif self.llvm_ir_cc == 'fast':
					pass
				else:
					sys.stdout.write(bcolors.FAIL +'Invalid calling convention. ' + bcolors.ENDC)
					raise Exception	

				#pushes link register
				one = self.llvm_push_immediate_dram(1)

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_LR + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)

			elif self.LLVM_I[index].name == ['store', 'align'] or self.LLVM_I[index].name == ['store', 'volatile', 'align']:	

				BASE0 = 1
				BASE1 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
	
				if op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + "_TMP")
				elif not op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + op1)


			elif self.LLVM_I[index].name == ['load', 'align'] or self.LLVM_I[index].name == ['load', 'volatile', 'align']:

				BASE0 = 0
				BASE1 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]

				if op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + "_TMP")
				elif not op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + op1)

			elif self.LLVM_I[index].name == ['define', '$'] or self.LLVM_I[index].name == ['define', 'dso_local', '$']:
				callerfunc_index = thisfunc_index 
				thisfunc_index = self.llvm_get_function_index(self.LLVM_I[index].actual_values[1])
				self.LLVM_IRAM.append(self.LLVM_I[index].actual_values[1][1:] + ":\t\t" + self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL)
				#print(self.LLVM_FUNC[thisfunc_index])
				inFunc = True	


				if self.llvm_ir_cc == 'std':
					one = self.llvm_push_immediate_dram(1)

					myself_ir_vars = self.llvm_function_extract_args(thisfunc_index)
					myself_variables = self.llvm_call_retrieve_operands(myself_ir_vars, thisfunc_index)
					#print(thisfunc_index, myself_ir_vars, myself_variables)

					for idx_var in range(len(myself_variables)):

						self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + myself_variables[len(myself_variables)-1-idx_var] + ", " + self.LLVM_MP)	
						self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)	
				elif self.llvm_ir_cc == 'fast':
					pass
				else:
					sys.stdout.write(bcolors.FAIL +'Invalid calling convention. ' + bcolors.ENDC)
					raise Exception								

				#pushes link register
				one = self.llvm_push_immediate_dram(1)

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_LR + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)
				
			elif self.LLVM_I[index].name == ['sext', 'to']:
				BASE0 = 0
				BASE1 = 2
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
	
				if op1_inAllocs:

					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + "_TMP")
				elif not op1_inAllocs:

					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)
				

			elif self.LLVM_I[index].name == ['label']:
				BASE0 = 0
				self.LLVM_IRAM.append(self.llvm_get_label(BASE0, thisfunc_index, index) + ":\t" + self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL)

			elif self.LLVM_I[index].name == ['br', 'label']:
				BASE0 = 0
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE0, thisfunc_index, index)) 

			elif self.LLVM_I[index].name == ['getelementptr', 'inbounds']:
				BASE0 = 0 #where to save
				BASE1 = 4 #the pointer/structure
				BASE2 = 7 #for index
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]				
				op2_inAllocs = allocs[2]

				structure_tmp = self.LLVM_I[index].actual_values[BASE1]
				if structure_tmp[0] == "@":
					structure = structure_tmp[1:]
					ptr = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+structure
					self.llvm_push_dram(ptr, ptr[len(self.LLVM_WRITER_PTR):])
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + ptr + ", " + "_TMP")
				elif op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")	
				else:
					structure = structure_tmp[1:]
					#ptr = self.LLVM_WRITER_PTR + self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE1][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:] 
					ptr = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE1][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:] 
					#self.llvm_push_dram(ptr, ptr[len(self.LLVM_WRITER_PTR):])
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + ptr + ", " + "_TMP")
				
				if self.LLVM_I[index].actual_values[BASE2][0] != '%':
					base = self.LLVM_I[index].actual_values[BASE2]
					newimmediate = self.llvm_push_immediate_dram(base)
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")
				else:
					newimmediate = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE2][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
					self.llvm_push_dram(newimmediate, 0)
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")


				wb = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE0][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
				self.llvm_push_dram(wb, 0)

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + wb)


			elif self.LLVM_I[index].name == ['getelementptr', 'inbounds', 'x', 'x']:
				BASE0 = 0 #where to save
				BASE1 = 10 #the pointer/structure
				BASE2 = 13 #for base
				BASE3 = 16 #for offset
				#print(self.LLVM_I[index])

				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2, BASE3], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op3 = ops[3]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]				
				op2_inAllocs = allocs[2]
				op3_inAllocs = allocs[3]

				structure_tmp = self.LLVM_I[index].actual_values[BASE1]
				if structure_tmp[0] == "@":
					structure = structure_tmp[1:]
					ptr = self.LLVM_WRITER_PTR+self.LLVM_WRITER_GLOBAL+structure
					self.llvm_push_dram(ptr, ptr[len(self.LLVM_WRITER_PTR):])
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + ptr + ", " + "_TMP")
				elif op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")					
				else:
					structure = structure_tmp[1:]
					#ptr = self.LLVM_WRITER_PTR + self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE1][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:] 
					ptr = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE1][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:] 
					#self.llvm_push_dram(ptr, ptr[len(self.LLVM_WRITER_PTR):])
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + ptr + ", " + "_TMP")
				
				if self.LLVM_I[index].actual_values[BASE2][0] != '%':
					base = self.LLVM_I[index].actual_values[BASE2]
					newimmediate = self.llvm_push_immediate_dram(base)
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")
				else:
					newimmediate = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE2][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
					self.llvm_push_dram(newimmediate, 0)
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")

				if self.LLVM_I[index].actual_values[BASE3][0] != '%':
					offset = self.LLVM_I[index].actual_values[BASE3]
					newimmediate = self.llvm_push_immediate_dram(offset)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")
				else:
					newimmediate = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE3][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
					self.llvm_push_dram(newimmediate, 0)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + newimmediate + ", " + "_TMP")
				

				wb = self.LLVM_WRITER_VAR + self.LLVM_I[index].actual_values[BASE0][1:] + self.LLVM_WRITER_UNDERSCORE + self.LLVM_FUNC[thisfunc_index].Function[1:]
				self.llvm_push_dram(wb, 0)

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + wb)

			elif self.LLVM_I[index].name == ['ret']:
				one = self.llvm_push_immediate_dram(1)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_LR + ", " + self.LLVM_MP)	
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)		

				BASE0 = 1
				ops, allocs = self.llvm_probe_operands([BASE0], thisfunc_index, index)
				func_out = ops[0]

				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + func_out + ", " + self.LLVM_MP)


				self.LLVM_IRAM.append(self.LLVM_MCR_PCS)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_LR)	

			elif self.LLVM_I[index].name == ['ret', 'void']:
				one = self.llvm_push_immediate_dram(1)

				self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_LR + ", " + self.LLVM_MP)	
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)				

				self.LLVM_IRAM.append(self.LLVM_MCR_PCS)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_LR)			

			elif self.LLVM_I[index].name == ['call', 'void', "$"]:

				callfunc_index = self.llvm_get_function_index(self.LLVM_I[index].actual_values[0])
				func_label = self.LLVM_I[index].actual_values[0][1:]
				callee_ir_vars = self.llvm_function_extract_args(callfunc_index)
				callee_variables = self.llvm_call_retrieve_operands(callee_ir_vars, callfunc_index)
				BASEcall = 2
				ir_call_args = self.llvm_call_extract_args(BASEcall, index)
				caller_variables = self.llvm_call_retrieve_operands(ir_call_args, thisfunc_index)

				#pushes stack pointer
				mp_save_point = self.llvm_push_immediate_dram(1 + self.llvm_get_function_alloc_num(thisfunc_index))

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + mp_save_point + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)

				if self.llvm_ir_cc == 'fast':
					# fast calling convention
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					for idx_var in range(len(callee_variables)):
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + caller_variables[idx_var] + ", " + callee_variables[idx_var])	
				elif self.llvm_ir_cc == 'std':
					one = self.llvm_push_immediate_dram(1)

					for idx_var in range(len(caller_variables)):

						self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + caller_variables[idx_var] + ", " + "_TMP")
						self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
						self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)
				else:
					sys.stdout.write(bcolors.FAIL +'Invalid calling convention. ' + bcolors.ENDC)
					raise Exception						
					

				self.llvm_push_dram(self.LLVM_FMODE_RESCALE_LINK, self.LLVM_FMODE_RESCALE_LINK_VAL)
				self.LLVM_IRAM.append(self.LLVM_MCR_PC)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_LR)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_FMODE_RESCALE_LINK + ", " + self.LLVM_LR)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + func_label)
				

				self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)

				#extract arguments
				#copy arguments from thisfunc_index inners to next func inners	
				#save link register, jump
				# if void do nothing
				# if not void save output called function output ot local function inners
				pass
			elif self.LLVM_I[index].name == ['call', "$"]:
				callfunc_index = self.llvm_get_function_index(self.LLVM_I[index].actual_values[2])
				func_label = self.LLVM_I[index].actual_values[2][1:]
				callee_ir_vars = self.llvm_function_extract_args(callfunc_index)
				callee_variables = self.llvm_call_retrieve_operands(callee_ir_vars, callfunc_index)
				BASEcall = 4
				ir_call_args = self.llvm_call_extract_args(BASEcall, index)
				caller_variables = self.llvm_call_retrieve_operands(ir_call_args, thisfunc_index)

				#pushes stack pointer
				mp_save_point = self.llvm_push_immediate_dram(1 + self.llvm_get_function_alloc_num(thisfunc_index))

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + mp_save_point + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)

				if self.llvm_ir_cc == 'fast':
					# fast calling convention
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					for idx_var in range(len(callee_variables)):
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + caller_variables[idx_var] + ", " + callee_variables[idx_var])	
				elif self.llvm_ir_cc == 'std':
					one = self.llvm_push_immediate_dram(1)

					for idx_var in range(len(caller_variables)):

						self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + caller_variables[idx_var] + ", " + "_TMP")
						self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
						self.LLVM_IRAM.append(self.LLVM_MCR_MEM)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)
				else:
					sys.stdout.write(bcolors.FAIL +'Invalid calling convention. ' + bcolors.ENDC)
					raise Exception					

				self.llvm_push_dram(self.LLVM_FMODE_RESCALE_LINK, self.LLVM_FMODE_RESCALE_LINK_VAL)
				self.LLVM_IRAM.append(self.LLVM_MCR_PC)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_LR)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_FMODE_RESCALE_LINK + ", " + self.LLVM_LR)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + func_label)

				BASE0 = 0
				one = self.llvm_push_immediate_dram(1)
				ops, allocs = self.llvm_probe_operands([BASE0], thisfunc_index, index)
				func_pop = ops[0]

				self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + func_pop + ", " + self.LLVM_MP)	
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + self.LLVM_MP)
				


				self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + self.LLVM_MP)

				#extract arguments
				#copy arguments from thisfunc_index inners to next func inners	
				#save link register, jump
				# if void do nothing
				# if not void save output called function output ot local function inners
				pass

			elif self.LLVM_I[index].name == ['and']:
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)

			elif self.LLVM_I[index].name == ['or']:
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_ORLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)

			elif self.LLVM_I[index].name == ['shl']:
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_SHLLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)

			elif self.LLVM_I[index].name == ['ashr']:
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.llvm_push_dram("_TMP2", 0)
				self.llvm_push_dram("_TMP4", 0)
				self.llvm_push_dram("_TMPZERO", 0)
				self.llvm_push_dram("_ONECONST", 1)
				self.llvm_push_dram("_ONETMP", 1)
				self.llvm_push_dram("_ZERO", 0)
				self.llvm_push_dram("_NEGATIVE", -32768)
				label0 = "negativeOrZero" + self.LLVM_WRITER_UNDERSCORE + str(index) + self.LLVM_WRITER_UNDERSCORE 
				label1 = "loop" + self.LLVM_WRITER_UNDERSCORE + str(index) + self.LLVM_WRITER_UNDERSCORE 
				label2 = "exit2" + self.LLVM_WRITER_UNDERSCORE + str(index) + self.LLVM_WRITER_UNDERSCORE 
				label3 = "exit" + self.LLVM_WRITER_UNDERSCORE + str(index) + self.LLVM_WRITER_UNDERSCORE 

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP2")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMPZERO")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ONECONST" + ", " + "_ONETMP")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ZERO" + ", " + "_TMP4")
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ZERO" + ", " + "_TMP2" + self.LLVM_EXEC_HASJ + label0)
				self.LLVM_IRAM.append(self.LLVM_MCR_SHRLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + "_TMP" + self.LLVM_EXEC_HASJ + label3)
				self.LLVM_IRAM.append(label0 + ":\t" + self.LLVM_MCR_ANDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_NEGATIVE" + ", " + "_TMPZERO")
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMPZERO" + ", " + "_TMP4" + self.LLVM_EXEC_HASJ + label2)
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ZERO" + ", " + "_TMP4")
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ONECONST" + ", " + "_TMP")
				self.LLVM_IRAM.append(label1 + ":\t" + self.LLVM_MCR_SHRLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + "_ONETMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_ORLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_NEGATIVE" + ", " + "_ONETMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ONETMP" + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ZERO" + ", " + "_TMP4")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ONECONST" + ", " + "_ONETMP")
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_ONECONST" + ", " + "_TMP")
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "_TMP" + ", " + "_TMP4" + self.LLVM_EXEC_HASJ + label1)
				self.LLVM_IRAM.append(label2 + ":\t" + self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)
				self.LLVM_IRAM.append(label3 + ":\t" + self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC_NULL)



			elif self.LLVM_I[index].name[0] == 'icmp': 
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + "CHR" + ", " + op0)

				icmp_type = self.LLVM_I[index].name[1]

			elif self.LLVM_I[index].name == ['br', 'i1', 'label', 'label']:
				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0], thisfunc_index, index)
				op0 = ops[0]
				op0_inAllocs = allocs[0]

				if icmp_type == 'sle':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_sle + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_sle, self.LLVM_icmp_sle_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))

				elif icmp_type == 'slt':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_slt + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_slt, self.LLVM_icmp_slt_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))

				elif icmp_type == 'ne':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_ne + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_ne, self.LLVM_icmp_ne_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))

				elif icmp_type == 'sgt':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_sgt + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_sgt, self.LLVM_icmp_sgt_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))

				elif icmp_type == 'sge':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_sge + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_sge, self.LLVM_icmp_sge_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))

				elif icmp_type == 'eq':
					self.LLVM_IRAM.append(self.LLVM_MCR_ANDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_icmp_eq + ", " + op0 + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE2, thisfunc_index, index))
					self.llvm_push_dram(self.LLVM_icmp_eq, self.LLVM_icmp_eq_val)
					self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC_NULL + self.LLVM_EXEC_HASJ + self.llvm_get_label(BASE1, thisfunc_index, index))
				else:
					print(bcolors.FAIL +'Unknown branch: ' + icmp_type + bcolors.ENDC)
					return False

			elif self.LLVM_I[index].name == ['add', 'nsw']:

				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)

			elif self.LLVM_I[index].name == ['sub', 'nsw']:

				BASE0 = 0
				BASE1 = 2
				BASE2 = 4
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1, BASE2], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op2 = ops[2]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]
				op2_inAllocs = allocs[2]

				self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)
				self.LLVM_IRAM.append(self.LLVM_MCR_SUBLEQ)
				self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op2 + ", " + op0)


			elif self.LLVM_I[index].name == ['call', 'void', 'memset', 'p0i8', 'i64', 'align', 'i1', 'false'] or self.LLVM_I[index].name == ['call', 'void', 'memset', 'p0i8', 'i32', 'align', 'i1', 'false'] or self.LLVM_I[index].name == ['call', 'void', 'memset', 'p0i8', 'i16', 'align', 'i1', 'false']:
				BASE0 = 7
				BASE1 = 10
				BASE2 = 13
				i64_bytes = int(self.LLVM_I[index].actual_values[BASE2])
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]	
				#print(ops, allocs, self.LLVM_FUNC[thisfunc_index])
				#not fully implemented
				if not op0_inAllocs:
					ops0 = self.llvm_check_vectorized_operands(op0)	
					for i in range(len(ops0)):
						self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
						self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + ops0[i])
				else:
					sys.stdout.write(bcolors.FAIL +'memset not implemented on stack ' + bcolors.ENDC)
					raise Exception

			elif self.LLVM_I[index].name == ['declare', 'void', 'memset', 'p0i8', 'i64', 'nocapture', 'writeonly', 'i1', 'immarg'] or self.LLVM_I[index].name == ['declare', 'void', 'memset', 'p0i8', 'i32', 'nocapture', 'writeonly', 'i1', 'immarg'] or self.LLVM_I[index].name == ['declare', 'void', 'memset', 'p0i8', 'i16', 'nocapture', 'writeonly', 'i1', 'immarg']:
				pass


			elif self.LLVM_I[index].name == ['bitcast', 'to']:

				BASE0 = 0
				BASE1 = 2
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]
				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]

				if op1_inAllocs:

					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + "_TMP")
				elif not op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)


			elif self.LLVM_I[index].name == ['bitcast', 'x', 'to']:

				BASE0 = 0
				BASE1 = 5
				BASE2 = 2
				ops, allocs = self.llvm_probe_operands([BASE0, BASE1], thisfunc_index, index)
				op0 = ops[0]
				op1 = ops[1]

				op0_inAllocs = allocs[0]
				op1_inAllocs = allocs[1]

				if op1_inAllocs:
					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
					self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0 + ", " + "_TMP")

					if int(self.LLVM_I[index].actual_values[BASE2]) > 1:
						for i in range(int(self.LLVM_I[index].actual_values[BASE2])-1):
							op0_v = op0 + "." + str(i) 
							self.llvm_push_dram(op0_v, 0)
							#imm_off = self.llvm_push_immediate_dram(1+i)
							one = self.llvm_push_immediate_dram(1)
							#self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
							#self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + "_TMP")
							self.LLVM_IRAM.append(self.LLVM_MCR_ADDLEQ)
							#self.LLVM_IRAM.append(self.LLVM_EXEC + " " + self.LLVM_MP + ", " + "_TMP")
							#self.LLVM_IRAM.append(self.LLVM_EXEC + " " + imm_off + ", " + "_TMP")
							self.LLVM_IRAM.append(self.LLVM_EXEC + " " + one + ", " + "_TMP")
							self.LLVM_IRAM.append(self.LLVM_MCR_MEMR)
							self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op0_v + ", " + "_TMP")

				elif not op1_inAllocs:

					self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
					self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1 + ", " + op0)

					if int(self.LLVM_I[index].actual_values[BASE2]) > 1:
						for i in range(int(self.LLVM_I[index].actual_values[BASE2])-1):
							op0_v = op0 + "." + str(i) 
							self.llvm_push_dram(op0_v, 0)
							op1_v = op1 + "." + str(i)
							self.llvm_push_dram(op1_v, 0)

							self.LLVM_IRAM.append(self.LLVM_MCR_MOVLEQ)
							self.LLVM_IRAM.append(self.LLVM_EXEC + " " + op1_v + ", " + op0_v)

			else:
				sys.stdout.write(bcolors.FAIL +'Unknown instruction: ' + bcolors.ENDC)
				for i in range(len(self.LLVM_I[index].name)):
					sys.stdout.write(self.LLVM_I[index].name[i])
					if i != len(self.LLVM_I[index].name)-1:
						sys.stdout.write(', ')
				sys.stdout.write('\n')
				return False
									

			index += 1
		return True


	def llvm_detect_type(self, token):
		if token == []:
			return self.LLVM_iTYPE_NONE

		if len(token) >= 2:
			if token[1] == self.LLVM_LABEL and len(token) == 2:
				return self.LLVM_iTYPE_LABEL

			elif token[1] == self.LLVM_ASSIGN:
				return self.LLVM_iTYPE_LEFTMOST

			else:
				return self.LLVM_iTYPE_RIGHTMOST
		else:
			return self.LLVM_iTYPE_FUNCTEND

	def llvm_initialize_functend(self):
		self.LLVM_LEX.append(self.LLVM_IR(name=[self.LLVM_FUNCTEND], required=[], positional_required=[], leftmost=False, positional_name=[0], actual_values=[]))


	def llvm_linker_writer(self, fileout):
		try:

			fo = open(fileout,'w')
			vaddr = 0
			self.remap_list = []
			self.remap_addr = []
			for i in range(len(self.LLVM_IRAM)):
						fo.write(self.LLVM_IRAM[i]+"\n")
						if i <= 7:
							vaddr += 1
						else:
							vaddr += 3
			for i in range(len(self.LLVM_DRAM)):	
					self.remap_list.append(self.LLVM_DRAM[i])
					self.remap_addr.append(vaddr)		
					vaddr += 1
			for i in range(len(self.LLVM_DRAM)):	
				if self.linker == True:
					if self.LLVM_DRAM[i][0:4] == "%ma-":
								idxremap = self.remap_list.index(self.LLVM_DRAM_VALUE[i])
								self.LLVM_DRAM_VALUE[i] = str(self.remap_addr[idxremap])
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"IR Pointer at address " + str(vaddr)+" remapped to " + str(self.LLVM_DRAM[i]) + ".\n")
								sys.stdout.write(str(self.LLVM_DRAM[i]) + " replaced with " + str(self.LLVM_DRAM[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )	
					fo.write(self.LLVM_DRAM[i] + ":\t\t" + str(self.LLVM_DRAM_VALUE[i])+ "\n")
				else:
					fo.write(self.LLVM_DRAM[i] + ":\t\t" + str(self.LLVM_DRAM_VALUE[i])+ "\n")
				vaddr += 1

			fo.close()



		except Exception as e:
			sys.stdout.write("An internal Python " + str(e.__class__) + " error occurred.\n")
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)


	def compile_llvm(self, filename="t0.ll", fileout="t0.asm", cc='fast'):
		#self.llvm_instructions()
		self.LLVM_CC = ['fast','std']

		if cc not in self.LLVM_CC:
			sys.stdout.write(bcolors.FAIL +'Invalid calling convention.\n' + bcolors.ENDC)
			sys.exit(1)
		else:
			sys.stdout.write(bcolors.OKGREEN +"Info: Using " + str(cc) + " calling convention.\n" + bcolors.ENDC)

		self.LLVM_I = []

		self.LLVM_MCRsSYM = ['_SUBLMCR', '_MOVMCR', '_ADDMCR', '_SHLMCR', '_SHRMCR', '_ORMCR', '_ANDMCR', '_XORMCR', '_XNORMCR', '_PCMCR','_MEMMCR','_MEMRMCR','_PCSMCR']
		self.LLVM_MCRsVAL = [0xFF, 0xEE, 0xCC, 0x99, 0x88, 0x77, 0x66, 0x55, 0x44, 0x33, 0x22, 0x11, 0x00]

		self.LLVM_SKIP_INITIAL_TOKENS = ['attributes','source_filename','target','!']
		self.LLVM_NUMSET = self.NUMSET
		self.LLVM_ALPHASET = "QWERTYUIOPASDFGHJKLZXCVBNM%*_#"
		self.LLVM_DELIMITSET =",;.:()][={}!\""
		self.LLVM_COMMENT = ";"
		self.LLVM_VAR = "%"
		self.LLVM_LABEL = ":"
		self.LLVM_ASSIGN = "="
		self.LLVM_GLOBAL = "@"
		self.LLVM_PTR = "*"
		self.LLVM_ARB = "$"
		self.LLVM_FUNCTEND = '}'
		self.LLVM_iTYPE_LABEL = 0
		self.LLVM_iTYPE_LEFTMOST = 1
		self.LLVM_iTYPE_RIGHTMOST = 2
		self.LLVM_iTYPE_FUNCTEND = 3
		self.LLVM_iTYPE_NONE = -1


		self.LLVM_DECL = ['i8','i16','i32','i64']
		self.LLVM_DECL_PTR = ['i8*','i16*','i32*','i64*']
		self.LLVM_DECL_TYPES = self.LLVM_DECL+self.LLVM_DECL_PTR

		self.LLVM_WRITER_LABEL = "Label_"
		self.LLVM_WRITER_GLOBAL = "Global_"
		self.LLVM_WRITER_PTR = "%ma-"
		self.LLVM_WRITER_TAB = "\t"
		self.LLVM_WRITER_VECT = "."
		self.LLVM_WRITER_VAR = "Var_"
		self.LLVM_WRITER_UNDERSCORE = "_"
		self.LLVM_MP = "m_ptr"
		self.LLVM_LR = "link_register"
		self.LLVM_FMODE_RESCALE_LINK = "_PCMCR_RETADDRBL"
		self.LLVM_FMODE_RESCALE_LINK_VAL = -12
		self.LLVM_MCR_SUBLEQ = "\texec _SUBLMCR, MCR"
		self.LLVM_MCR_MOVLEQ = "\texec _MOVMCR, MCR"
		self.LLVM_MCR_ADDLEQ = "\texec _ADDMCR, MCR"
		self.LLVM_MCR_ORLEQ = "\texec _ORMCR, MCR"
		self.LLVM_MCR_ANDLEQ = "\texec _ANDMCR, MCR"
		self.LLVM_MCR_XORLEQ = "\texec _XORMCR, MCR"
		self.LLVM_MCR_XNORLEQ = "\texec _XNORMCR, MCR"
		self.LLVM_MCR_SHRLEQ = "\texec _SHRMCR, MCR"
		self.LLVM_MCR_SHLLEQ = "\texec _SHLMCR, MCR"		
		self.LLVM_MCR_MEM = "\texec _MEMMCR, MCR"	
		self.LLVM_MCR_MEMR = "\texec _MEMRMCR, MCR"	
		self.LLVM_MCR_PC = "\texec _PCMCR, MCR"	
		self.LLVM_MCR_PCS = "\texec _PCSMCR, MCR"	
		self.LLVM_EXEC_NULL = "\texec _NULL, _NULL"
		self.LLVM_EXEC_HASJ = " -> "
		self.LLVM_EXEC = "\texec"
		self.LLVM_icmp_sle_val = 12
		self.LLVM_icmp_sle = "_icmp_sle"
		self.LLVM_icmp_slt_val = 4
		self.LLVM_icmp_slt = "_icmp_slt"
		self.LLVM_icmp_sgt_val = 2
		self.LLVM_icmp_sgt = "_icmp_sgt"
		self.LLVM_icmp_sge_val = 10
		self.LLVM_icmp_sge = "_icmp_sge"
		self.LLVM_icmp_eq_val = 8
		self.LLVM_icmp_eq = "_icmp_eq"
		self.LLVM_icmp_ne_val = 8
		self.LLVM_icmp_ne = "_icmp_eq"

		self.LLVM_GENERICS_MANDATORY_START = "<"
		self.LLVM_GENERICS_MANDATORY_END = ">"
		self.LLVM_GENERICS_GLOBAL = "!"
		self.LLVM_GENERICS_OBJ = "."

		self.LLVM_SC_LABELS = []
		self.LLVM_SC_FUNCS = []
		self.LLVM_SC_FUNC = ""
		self.llvm_load_commands()
		#self.llvm_print_lex()
		fp = open(filename,'r')
		try:
			while True:
				rawline = fp.readline()
				line = self.llvm_adjust_line(rawline)
				token = self.llvm_token(line)
				token = self.llvm_remove_comments(token)
				if token != []:
					if token[0] not in self.LLVM_SKIP_INITIAL_TOKENS:
						if not self.llvm_decode_instr(token):
							print("Unknown token: ", token)
							sys.stdout.write(bcolors.FAIL +"\nError: " + bcolors.ENDC +"Unknown token.\n")
							raise Exception
						#print("")
				if rawline == "":
					break
			fp.close()
		except Exception as e:
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)

		#print(self.LLVM_I)
		self.llvm_compiler_funct_preload()
		try:
			return_value = self.llvm_compiler(mp=self.llvm_m_ptr,cc=cc)
		except:
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)
		if not return_value:
			sys.stdout.flush()
			sys.stdout.write(bcolors.FAIL +'One or more instructions not coded.\n' + bcolors.ENDC)
			sys.exit(1)			

		#for i in range(len(self.LLVM_IRAM)):
		#	print(self.LLVM_IRAM[i])
		#for i in range(len(self.LLVM_DRAM)):
		#	print(self.LLVM_DRAM[i], ":", self.LLVM_DRAM_VALUE[i])			

		self.llvm_linker_writer(fileout)

	def compile_arm(self, filename="t0.arm", fileout="t0.asm"):
		fp = open(filename,'r')
		addr = 0
		lineidx = 0
		bytenum = 0
		newLabel = False
		self.push_initial_vars_arm()
		self.asm_writer = []
		self.inGetIOR = False
		self.inGetISR = False
		redirect_main = False
		self.current_label = ""
		try:
			operands = ['null']
			operands_len = len(operands)
			primitivein = self.macro_primitives_exec[self.primitives.index('_main')]
			drisc_asm = self.update_links_arm(primitivein, operands, operands_len)
			self.asm_writer.append(drisc_asm)
			while True:

				line = fp.readline()
				if line == '':
					break
				else:
					line = line.replace('\n','').replace('\r','')
				line = re.sub(r"^\s+|\s+$", "", line)
				linetmp = ''
				for g in range(len(line)):
					if line[g] != '@':
						linetmp += line[g]
					else:
						break
				line = linetmp
				#if line == '':
				#	line = '#'
				lineidx += 1
				if (line == '') or (len(line) < 3):
					line = '@@@'
				#print(line)
				if ((line[0] != '@') and (line[0] != '.')) or (line[0:2] == '.L'):
					if "[" in line:
						self.isAddressing = True
					else:
						self.isAddressing = False
					line = line.replace("]", "")
					line = line.replace("[", "")
					line = line.replace("{", "")
					line = line.replace("}", "")
					line = line.replace('\t',' ')
					line = line.replace('#', '')
					if ('$l___' in line):
						line = line.replace('$l___', '%ma-l___')
					if ('$.L' in line):
						line = line.replace('$.L', '%ma-.L')
					line = re.sub(r"^\s+|\s+$", "", line)
					line = line.replace(', ', ',')
					if (line[0:4] != 'l___') and ('l___' in line) and ("+" in line):
						line = line.replace('+','.')

					isref = False
					
					if line[0:4] == 'sub ':
						metadata = line.split('sub ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('sub')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'lsr ':
						metadata = line.split('lsr ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('lsr')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'lsl ':
						metadata = line.split('lsl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('lsl')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'asr ':
						metadata = line.split('asr ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('asr')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'rsb ':
						metadata = line.split('rsb ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('rsb')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bic ':
						metadata = line.split('bic ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bic')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'str ':
						metadata = line.split('str ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('str_double')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('str_triple')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							if "lsl" in operands[3]:
								operands[3] = operands[3].split("lsl ")[1]
								primitivein = self.macro_primitives_exec[self.primitives.index('str_triple_lsl')]
						
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
							else:
								sys.stdout.write(bcolors.FAIL +'Error: Unsupported math in and on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception	
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:6] == 'movlt ':
						metadata = line.split('movlt ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('movlt')]
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'strb ':
						metadata = line.split('strb ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('str_double')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('str_triple')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'orr ':
						metadata = line.split('orr ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('orr')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							if "lsl" in operands[3]:
								operands[3] = operands[3].split("lsl ")[1]
								primitivein = self.macro_primitives_exec[self.primitives.index('orr_lsl')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
							else:	
								sys.stdout.write(bcolors.FAIL +'Error: Unsupported math in and on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception															
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'and ':
						metadata = line.split('and ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('and')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							if "lsr" in operands[3]:
								operands[3] = operands[3].split("lsr ")[1]
								primitivein = self.macro_primitives_exec[self.primitives.index('and_lsr')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
							else:	
								sys.stdout.write(bcolors.FAIL +'Error: Unsupported math in and on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception															
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'ldrb ':
						metadata = line.split('ldrb ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('ldrb_double')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('ldrb_triple')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'ldr ':
						metadata = line.split('ldr ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						write_back = False
						for i in range(operands_len):
							if "!" in operands[i]:
								write_back = True
								write_back_idx = i
								operands[i] = operands[i].replace("!", "")
								break
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							if self.inGetIOR == True:
								self.inGetIOR = False
								operands=['r0', 'IOR']
								primitivein = self.macro_primitives_exec[self.primitives.index('move')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)	
								sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding ldr operand in procedure ' + '__getior' + " entry point on line " + str(lineidx) + ' with IOR.\n' + bcolors.ENDC)
							elif self.inGetISR == True:
								self.inGetISR = False
								operands=['r0', 'ISR']
								primitivein = self.macro_primitives_exec[self.primitives.index('move')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)	
								sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding ldr operand in procedure ' + '__getisr'+ " entry point on line " + str(lineidx) + ' with ISR.\n' + bcolors.ENDC)
							elif operands[1][0:2] == 'LC':
								primitivein = self.macro_primitives_exec[self.primitives.index('ldr_double_const')]
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						
							elif operands[1][0:3] == '.LC':
								primitivein = self.macro_primitives_exec[self.primitives.index('ldr_double_const')]
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)								
							else:
								primitivein = self.macro_primitives_exec[self.primitives.index('ldr_double')]
						
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('ldr_triple')]
						
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							if "lsl" in operands[3]:
								operands[3] = operands[3].split("lsl ")[1]
								if write_back and write_back_idx == 3:
									#print(operands)
									primitivein = self.macro_primitives_exec[self.primitives.index('ldr_triple_lsl_wb')]
								else:
									primitivein = self.macro_primitives_exec[self.primitives.index('ldr_triple_lsl')]
						
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
							else:
								sys.stdout.write(bcolors.FAIL +'Error: Unsupported math in and on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception									
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception													
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'add ':
						metadata = line.split('add ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 3:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('add')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							if "lsl" in operands[3]:
								#print("got it!!!!")
								operands[3] = operands[3].split("lsl ")[1]
								primitivein = self.macro_primitives_exec[self.primitives.index('add_lsl')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
							else:	
								sys.stdout.write(bcolors.FAIL +'Error: Unsupported math in and on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception															
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception	
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'cmp ':
						metadata = line.split('cmp ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('cmp')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'cmn ':
						metadata = line.split('cmn ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('cmn')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'tst ':
						metadata = line.split('tst ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('tst')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'mvn ':
						metadata = line.split('mvn ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('mvn')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'mov ':
						metadata = line.split('mov ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands[0] == 'pc' and operands[1] == 'lr':
							primitivein = self.macro_primitives_exec[self.primitives.index('mov_pc_lr')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						else:
							if self.inGetIOR == True:
								self.inGetIOR = False
								operands=['r0', 'IOR']
								primitivein = self.macro_primitives_exec[self.primitives.index('move')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)	
								sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding mov operand in procedure ' + '__getior' + " entry point on line " + str(lineidx) + ' with IOR.\n' + bcolors.ENDC)

							elif self.inGetISR == True:
								self.inGetISR = False
								operands=['r0', 'ISR']
								primitivein = self.macro_primitives_exec[self.primitives.index('move')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)	
								sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding mov operand in procedure ' + '__getisr'+ " entry point on line " + str(lineidx) + ' with ISR.\n' + bcolors.ENDC)
							else:
								primitivein = self.macro_primitives_exec[self.primitives.index('move')]
								
								drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)	

						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:2] == 'b ':
						metadata = line.split('b ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('b')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'bl ':
						metadata = line.split('bl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bl')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'blx ':
						metadata = line.split('blx ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						sys.stdout.write(bcolors.WARNING +'Warning: Mapping a blx instruction with no instruction set change, on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('blx')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'bx ':
						metadata = line.split('bx ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						sys.stdout.write(bcolors.WARNING +'Warning: Mapping a bx instruction with no instruction set change, on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bx_noex')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bne ':
						metadata = line.split('bne ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bne')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bge ':
						metadata = line.split('bge ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bge')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'ble ':
						metadata = line.split('ble ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('ble')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bgt ':
						metadata = line.split('bgt ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bgt')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'blt ':
						metadata = line.split('blt ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('blt')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'beq ':
						metadata = line.split('beq ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('beq')]
						
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)							
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'pop ':
						metadata = line.split('pop ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 1:	
							primitivein = self.macro_primitives_exec[self.primitives.index('pop')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)						
						elif operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('pop2')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'ldm ':
						metadata = line.split('ldm ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if "!" not in operands[0]:
							primitivein = self.macro_primitives_exec[self.primitives.index('ldm_xt_op')]
							first_op = operands[0]
							drisc_asm = self.update_links_arm(primitivein, [first_op], 1, isref=isref)
							self.asm_writer.append(drisc_asm)
							primitivein = self.macro_primitives_exec[self.primitives.index('ldm_xt')]
							for h in range(1,operands_len):
								operands_roll = [operands[h]]
								drisc_asm = self.update_links_arm(primitivein, operands_roll, 1, isref=isref)
								self.asm_writer.append(drisc_asm)
						else:
							primitivein = self.macro_primitives_exec[self.primitives.index('ldm_xt_wb')]
							first_op = operands[0].replace("!","")
							for h in range(1,operands_len):
								operands_roll = [first_op, operands[h]]
								drisc_asm = self.update_links_arm(primitivein, operands_roll, 2, isref=isref)
								self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'stm ':
						metadata = line.split('stm ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if "!" not in operands[0]:
							primitivein = self.macro_primitives_exec[self.primitives.index('stm_xt_op')]
							first_op = operands[0]
							drisc_asm = self.update_links_arm(primitivein, [first_op], 1, isref=isref)
							self.asm_writer.append(drisc_asm)
							primitivein = self.macro_primitives_exec[self.primitives.index('stm_xt')]
							for h in range(1,operands_len):
								operands_roll = [operands[h]]
								drisc_asm = self.update_links_arm(primitivein, operands_roll, 1, isref=isref)
								self.asm_writer.append(drisc_asm)
						else:
							primitivein = self.macro_primitives_exec[self.primitives.index('stm_xt_wb')]
							first_op = operands[0].replace("!","")
							for h in range(1,operands_len):
								operands_roll = [first_op, operands[h]]
								drisc_asm = self.update_links_arm(primitivein, operands_roll, 2, isref=isref)
								self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'push ':
						metadata = line.split('push ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 1:	
							primitivein = self.macro_primitives_exec[self.primitives.index('push')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)						
						elif operands_len == 2:
							primitivein = self.macro_primitives_exec[self.primitives.index('push2')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 3:
							primitivein = self.macro_primitives_exec[self.primitives.index('push3')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 4:
							primitivein = self.macro_primitives_exec[self.primitives.index('push4')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 5:							
							primitivein = self.macro_primitives_exec[self.primitives.index('push5')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						elif operands_len == 6:							
							primitivein = self.macro_primitives_exec[self.primitives.index('push6')]
							
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=isref)
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Too many registers to push on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___getisr') or (line[0:8] == '__getisr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Got procedure ' + line[0:9] + " entry point on line " + str(lineidx) + '. Using label.\n' + bcolors.ENDC)
						self.inGetISR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetISR = True
						newLabel = False
					elif (line[0:9] == '___getior') or (line[0:8] == '__getior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Got procedure ' + line[0:9] + " entry point on line " + str(lineidx) + '. Using label.\n' + bcolors.ENDC)
						self.inGetIOR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetIOR = True
						newLabel = False
					elif (line[0:9] == '___setcsr') or (line[0:8] == '__setcsr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setcsr')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___seticr') or (line[0:8] == '__seticr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__seticr')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setior') or (line[0:8] == '__setior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setior')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif (line[0:9] == '___setidr')  or (line[0:8] == '__setidr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setidr')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setiwr')  or (line[0:8] == '__setiwr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setiwr')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setchr')  or (line[0:8] == '__setchr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setchr')]
						drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False	
					elif (':' in line):						
						line = line.replace(" ","")
						#print('label!', line)
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						#print(operands, line)
						if (operands_len != 1):
								sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the ARM assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception
						#if (line[0:3] != '$__'):
						#if (line[0:1] != '$'):
						if (line[0:5] == 'main:'):					
							redirect_main = True
							#print("GOT MAIN: ", line)
							#operands[0] = "_" + operands[0]
							primitivein = self.macro_primitives_exec[self.primitives.index('main_redirect')]
							#primitivein = self.macro_primitives_exec[self.primitives.index('label')]
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
							self.current_label = "_" + metadata[0]
							newLabel = True
						else:
							primitivein = self.macro_primitives_exec[self.primitives.index('label')]
							drisc_asm = self.update_links_arm(primitivein, operands, operands_len, isref=True)
							self.current_label = metadata[0]
							newLabel = True
						self.asm_writer.append(drisc_asm)
						bytenum = 0
						
						
					else:
						sys.stdout.write(bcolors.FAIL +'Unsupported operator on line ' + str(lineidx) + ", " + line + ".\n" + bcolors.ENDC)
						raise Exception
					addr += 1
					#print(drisc_asm)
				if line[0:5] == '.comm':
					tmp = line.split('.comm')
					metadata = tmp[1].split(',') 
					metadata[2] = metadata[2].split('@')[0]
					metadata[2] = metadata[2].replace(' ', '')
					metadata[2] = metadata[2].replace('\t','')
					metadata[1] = metadata[1].replace(' ', '')
					metadata[1] = metadata[1].replace('\t','')
					metadata[0] = metadata[0].replace(' ', '')
					metadata[0] = metadata[0].replace('\t','')			
					for i in range(0, (int(metadata[1])*int(metadata[2]))):
						if i == 0:
				 			self.DATARAM_LBL.append(metadata[0])
				 			self.DATARAM_VALUE.append('0')	
						else:
				 			self.DATARAM_LBL.append(metadata[0]+"."+str(i))
				 			self.DATARAM_VALUE.append('0')					 								

				if line[0:5] == '.long':
				 	if newLabel == True:
				 		self.asm_writer.pop()
				 	line = line.replace('\t',' ')
				 	metadata = line.split(" ")
				 	#print('long!!!', newLabel)
				 	if metadata[1][0:4] == "l___":
				 		metadata[1] = "%ma-" + metadata[1] #metadata[1].replace("l___", "%ma-l___")
				 	elif metadata[1][0:2] == ".L":
				 		metadata[1] = "%ma-" + metadata[1]
				 	elif metadata[1][0:1] == "_":
				 		metadata[1] = "%ma-" + metadata[1]
				 	elif metadata[1][0:1] != "-" and metadata[1][0:1] not in self.NUMSET:
				 		metadata[1] = "%ma-" + metadata[1]				 	
				 	try:
				 		idata = int(metadata[1])
				 		if idata > 0x7FFF:
				 			metadata[1] = str(idata-2**32)
				 			sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Long bigger than 0x7FFF, " + self.current_label + ". Making negative. \n")
				 	except:
				 		pass
											
				 	if bytenum == 0:
				 		#self.asm_writer.append([self.current_label+":\t\t" + metadata[1]])
				 		self.DATARAM_LBL.append(self.current_label)
				 		self.DATARAM_VALUE.append(metadata[1])
				 	else:
				 		self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 		self.DATARAM_VALUE.append(metadata[1])
				 		#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + metadata[1]])
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')				 	
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	newLabel = False
				if line[0:6] == ".globl":
					self.isGlobl = True
				if line[0:9] == '.zerofill':
					line = line.replace('\t',' ')
					metadata = line.split(",")
					self.DATARAM_LBL.append(metadata[2])
					self.DATARAM_VALUE.append('0')	

		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "cannot virtualize target.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)
		clen = 0
		for i in range(len(self.asm_writer)):
				for j in range(len(self.asm_writer[i])):
					clen += 1

		try:

			fo = open(fileout,'w')
			vaddr = 0
			self.remap_list = []
			self.remap_addr = []
			for i in range(len(self.BOOTSTRAP)):
					fo.write(self.BOOTSTRAP[i] + ":\t\t" + self.BOOTSTRAP_DMEM[i]+ "\n")
					vaddr += 1
			for i in range(len(self.asm_writer)):
					for j in range(len(self.asm_writer[i])):
						fo.write(self.asm_writer[i][j]+"\n")
						vaddr += 3
			vblock = vaddr
			for i in range(len(self.DATARAM_LBL)):
					#if self.DATARAM_LBL[i][0:4] == "l___" and "_p_" not in self.DATARAM_LBL[i]:
					#		self.remap_list.append(self.DATARAM_LBL[i])
					#		self.remap_addr.append(vaddr)		
					self.remap_list.append(self.DATARAM_LBL[i])
					self.remap_addr.append(vaddr)		
					vaddr += 1
			vaddr = vblock
			for i in range(len(self.DATARAM_LBL)):	
				if self.linker == True:
					if self.DATARAM_VALUE[i][0] == "%" and self.DATARAM_LBL[i][0:2] == 'LC':
						#	print('remap', self.DATARAM_LBL[i], self.DATARAM_LBL[i][4:])
							if (self.DATARAM_VALUE[i][4:] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_VALUE[i][4:])
							#	print(idxremap)
								remap_tmp = self.DATARAM_VALUE[i]
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								lastaddr = self.remap_addr[idxremap]
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive .long at address " + str(vaddr)+" remapped to " + str(self.DATARAM_LBL[i]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " value replaced with " + str(remap_tmp[4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								#sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for .long directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					if self.DATARAM_VALUE[i][0] == "%" and self.DATARAM_LBL[i][0:2] == '.L':
							#print('remap', self.DATARAM_LBL[i], self.DATARAM_VALUE[i])
							if (self.DATARAM_VALUE[i][4:] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_VALUE[i][4:])
							#	print(idxremap)
								remap_tmp = self.DATARAM_VALUE[i]
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								lastaddr = self.remap_addr[idxremap]
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive .long at address " + str(vaddr)+" remapped to " + str(self.DATARAM_LBL[i]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " value replaced with " + str(remap_tmp[4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								#sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for .long directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				else:
					if self.DATARAM_VALUE[i][0] == "%" and self.DATARAM_LBL[i][0:2] == 'LC':
						self.DATARAM_VALUE[i] = self.DATARAM_VALUE[i][4:]
					if self.DATARAM_VALUE[i][0] == "%" and self.DATARAM_LBL[i][0:2] == '.L':
						self.DATARAM_VALUE[i] = self.DATARAM_VALUE[i][4:]
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				vaddr += 1
			if redirect_main == True:
				sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"main: has been redirected to _main: .\n")

			fo.close()



		except Exception as e:
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)

	def compile_x86(self, filename="t0.x86", fileout="t0.asm"):
		fp = open(filename,'r')
		addr = 0
		lineidx = 0
		bytenum = 0
		newLabel = False
		self.push_initial_vars_x86()
		self.asm_writer = []
		self.inGetIOR = False
		self.inGetISR = False
		self.isGlobl = False
		redirect_main = False
		try:
			operands = ['null']
			operands_len = len(operands)
			primitivein = self.macro_primitives_exec[self.primitives.index('main')]
			drisc_asm = self.update_links_x86(primitivein, operands, operands_len)
			self.asm_writer.append(drisc_asm)
			alFlag = False
			blFlag = False
			clFlag = False
			dlFlag = False
			while True:

				line = fp.readline()
				if line == '':
					break
				else:
					line = line.replace('\n','').replace('\r','')
				line = re.sub(r"^\s+|\s+$", "", line)
				linetmp = ''
				for g in range(len(line)):
					if line[g] != '#':
						linetmp += line[g]
					else:
						break
				line = linetmp
				if line == '':
					line = '#'
				lineidx += 1

				if ((line[0] != '#') and (line[0] != '.')) or (line[0:2] == '.L'):
					if ("(" in line) and (")" in line):
						leal_no_addr = True
					else:
						leal_no_addr = False

					line = line.replace(" ", "  ")
					line = line.replace(":(", " ")
					#if ",  (" in line:
					#	line = line.replace(",  (", ",  ")
					if " (" in line:
						line = line.replace(" (", "0 ")
					elif "\t(" in line:
						line = line.replace("(", "0 ")
					else:
						line = line.replace("(", " ")
					line = line.replace("  ", " ")
					line = line.replace(")", "")
					#line = line.replace("(", "")

					if alFlag == True:
						alFlag = False
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Restored %al on line " + str(lineidx) + " to %eax.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('al_restore')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
					if blFlag == True:
						blFlag = False
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Restored %bl on line " + str(lineidx) + " to %ebx.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('bl_restore')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
					if clFlag == True:
						clFlag = False
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Restored %cl on line " + str(lineidx) + " to %ecx.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('cl_restore')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
					if dlFlag == True:
						dlFlag = False
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Restored %dl on line " + str(lineidx) + " to %edx.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('dl_restore')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)

					if "%al" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %al on line " + str(lineidx) + ". Killed %eax to 8 bit.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('al_reg')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						alFlag = True
						self.asm_writer.append(drisc_asm)
					if "%bl" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %bl on line " + str(lineidx) + ". Killed %ebx to 8 bit.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('bl_reg')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						blFlag = True
					if "%cl" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %cl on line " + str(lineidx) + ". Killed %ecx to 8 bit.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('cl_reg')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						clFlag = True
					if "%dl" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %dl on line " + str(lineidx) + ". Killed %edx to 8 bit.\n")
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('dl_reg')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						dlFlag = True
					if "%ax" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %ax on line " + str(lineidx) + ". Replaced with %eax. \n")
						line = line.replace("%ax", "%eax")
					if "%bx" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %bx on line " + str(lineidx) + ". Replaced with %ebx. \n")
						line = line.replace("%bx", "%bax")
					if "%cx" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %cx on line " + str(lineidx) + ". Replaced with %ecx. \n")
						line = line.replace("%cx", "%cax")
					if "%dx" in line:
						sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found %dx on line " + str(lineidx) + ". Replaced with %edx. \n")
						line = line.replace("%dx", "%dax")

					line = line.replace('\t',' ')
					line = line.replace('%', '')
					if ('$l___' in line):
						line = line.replace('$l___', '%ma-l___')
					if ('$.L' in line):
						line = line.replace('$.L', '%ma-.L')
					if ('$non_lazy_ptr' not in line):
						line = line.replace('$', '')
					line = re.sub(r"^\s+|\s+$", "", line)
					line = line.replace(', ', ',')
					if (line[0:4] != 'l___') and ('l___' in line) and ("+" in line):
						line = line.replace('+','.')

					isref = False
					if line[0:6] == 'pushl ':
						metadata = line.split('pushl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('pushl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:6] == 'calll ':
						metadata = line.split('calll ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('calll')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'popl ':
						metadata = line.split('popl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('popl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'sarl ':
						metadata = line.split('sarl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('sarl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'xorl ':
						metadata = line.split('xorl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('xorl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'shll ':
						metadata = line.split('shll ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('shll')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'setl ':
						metadata = line.split('setl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('setl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'andl ':
						metadata = line.split('andl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('andl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:6] == 'testb ':
						metadata = line.split('testb ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('testb')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:9] == 'rep;movsl':
						metadata = line.split('rep;movsl')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = ['_NULL']
						operands_len = 1
						primitivein = self.macro_primitives_exec[self.primitives.index('rep_movsl_noop')] 
						#print(bcolors.FAIL +"Operands"+bcolors.ENDC, operands, operands_len)
						#print(ldet)
						#print(rdet)	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:10] == 'rep;movsl ':
						metadata = line.split('rep;movsl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						ldet = operands[0].split(" ")
						rdet = operands[1].split(" ")
						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						#print(ldet, rdet)
						#print(len(ldet), len(rdet), rdet[1])
						if len(ldet) > 1:
							if ldet[1] == '':
								ldet = [ldet[0]]
							elif ldet[0] == '':
								ldet = [ldet[1]]
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the rep:movsl line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if len(rdet) > 1:
							if rdet[0] == '':
								rdet = [rdet[1]]
							elif rdet[1] == '':	
							    rdet = [rdet[0]]
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the rep:movsl line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception		
						operands = [ldet[0], ldet[1], rdet[0], rdet[1]]
						operands_len = 4
						primitivein = self.macro_primitives_exec[self.primitives.index('rep_movsl')] 
						#print(bcolors.FAIL +"Operands"+bcolors.ENDC, operands, operands_len)
						#print(ldet)
						#print(rdet)	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'orl ':
						metadata = line.split('orl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						ldet = operands[0].split(" ")
						rdet = operands[1].split(" ")
						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						#print(ldet, rdet)
						#print(len(ldet), len(rdet), rdet[1])
						if len(ldet) > 1:
							if ldet[1] == '':
								ldet = [ldet[0]]
							elif ldet[0] == '':
								ldet = [ldet[1]]
						if len(rdet) > 1:
							if rdet[0] == '':
								rdet = [rdet[1]]
							elif rdet[1] == '':	
							    rdet = [rdet[0]]		
						if len(ldet) > 1:
							operands = [ldet[0], ldet[1], operands[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('orl_leftmost')]
						elif len(rdet) > 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('orl_rightmost')] 
						else:
							operands_len = 2
							primitivein = self.macro_primitives_exec[self.primitives.index('orl')] 
							
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'subl ':
						metadata = line.split('subl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						ldet = operands[0].split(" ")
						rdet = operands[1].split(" ")
						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						#print(ldet, rdet)
						#print(len(ldet), len(rdet), rdet[1])
						if len(ldet) > 1:
							if ldet[1] == '':
								ldet = [ldet[0]]
							elif ldet[0] == '':
								ldet = [ldet[1]]
						if len(rdet) > 1:
							if rdet[0] == '':
								rdet = [rdet[1]]
							elif rdet[1] == '':	
							    rdet = [rdet[0]]		
						if len(ldet) > 1:
							operands = [ldet[0], ldet[1], operands[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('subl_leftmost')]
						elif len(rdet) > 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('subl_rightmost')] 
						else:
							operands_len = 2
							#print('center subl')
							primitivein = self.macro_primitives_exec[self.primitives.index('subl')] 
							
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False

					elif line[0:4] == 'retl':
						metadata = line.split('retl ')
						if len(metadata) != 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						operands = ['_NULL']
						operands_len = 1
						if self.inGetIOR == True:
							self.inGetIOR = False
							primitivein = self.macro_primitives_exec[self.primitives.index('__getior')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
							self.asm_writer.append(drisc_asm)
						if self.inGetISR == True:
							self.inGetISR = False
							primitivein = self.macro_primitives_exec[self.primitives.index('__getisr')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
							self.asm_writer.append(drisc_asm)							
						#if operands_len < 1:
						#	sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
						#	raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('retl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'ret':
						metadata = line.split('ret ')
						if len(metadata) != 1:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						operands = ['_NULL']
						operands_len = 1
						if self.inGetIOR == True:
							self.inGetIOR = False
							primitivein = self.macro_primitives_exec[self.primitives.index('__getior')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
							self.asm_writer.append(drisc_asm)
						if self.inGetISR == True:
							self.inGetISR = False
							primitivein = self.macro_primitives_exec[self.primitives.index('__getisr')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
							self.asm_writer.append(drisc_asm)							
						#if operands_len < 1:
						#	sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
						#	raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('retl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'addl ':
						metadata = line.split('addl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						ldet = operands[0].split(" ")
						rdet = operands[1].split(" ")
						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						#print(ldet, rdet)
						#print(len(ldet), len(rdet), rdet[1])
						if len(ldet) > 1:
							if ldet[1] == '':
								ldet = [ldet[0]]
							elif ldet[0] == '':
								ldet = [ldet[1]]
						if len(rdet) > 1:
							if rdet[0] == '':
								rdet = [rdet[1]]
							elif rdet[1] == '':	
							    rdet = [rdet[0]]		
						if len(ldet) > 1:
							operands = [ldet[0], ldet[1], operands[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('addl_leftmost')]
						elif len(rdet) > 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('addl_rightmost')] 
						else:
							operands_len = 2
							primitivein = self.macro_primitives_exec[self.primitives.index('addl')] 
							
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'cmpl ':
						metadata = line.split('cmpl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						ldet = operands[0].split(" ")
						rdet = operands[1].split(" ")
						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						if len(ldet) > 1:
							if ldet[1] == '':
								ldet = [ldet[0]]
							elif ldet[0] == '':
								ldet = [ldet[1]]
						if len(rdet) > 1:
							if rdet[0] == '':
								rdet = [rdet[1]]
							elif rdet[1] == '':	
							    rdet = [rdet[0]]				
						if len(ldet) > 1:
							operands = [ldet[0], ldet[1], operands[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('cmpl_leftmost')]
						elif len(rdet) > 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('cmpl_rightmost')] 
						else:
							operands_len = 2
							primitivein = self.macro_primitives_exec[self.primitives.index('cmpl')] 
						#print("Operands", ldet, rdet, len(ldet), len(rdet))	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'leal ':
						metadata = line.split('leal ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						operands_len = len(operands)
						#print(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						#ldet = operands[0].split(" ")
						#rdet = operands[1].split(" ")
						#for i in range(len(ldet)):
						#	ldet[i].replace(" ", "")
						#for i in range(len(rdet)):
						#	rdet[i].replace(" ", "")
						#if len(ldet) > 1:
						#	if ldet[1] == '':
						#		ldet = [ldet[0]]
						#	elif ldet[0] == '':
						#		ldet = [ldet[1]]
						#if len(rdet) > 1:
						#	if rdet[0] == '':
						#		rdet = [rdet[1]]
						#	elif rdet[1] == '':	
						#	    rdet = [rdet[0]]

						if operands_len != 4:
							ldet = operands[0].split(" ")
							rdet = operands[1].split(" ")
						elif (operands_len == 4) and (len(tmp1.split(" ")) == 2):
							ldet = [operands[0]]
							rdet = operands[1].split(" ")
							rdet.append(operands[2])
							rdet.append(operands[3])
						elif (operands_len == 4) and (len(tmp.split(" ")) == 2):
							ldet = operands[0].split(" ")
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]
						elif (operands_len == 4) and (len(tmp.split(" ")) == 1):
							ldet = ['0', operands[0]]
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]	
						#print("LDET, RDET", ldet, rdet, line)			
						if len(ldet) == 2 and len(rdet) == 1:
							operands = [ldet[0], ldet[1], rdet[0]]
							operands_len = 3
							primitivein = self.macro_primitives_exec[self.primitives.index('leal_leftmost')]
						elif len(rdet) == 2 and len(ldet) == 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							sys.stdout.write('Rightmost operands leal not implemented.')
							raise Exception
						elif len(ldet) == 4 and len(rdet) == 1:
							operands = [ldet[0], ldet[1], ldet[2], ldet[3], rdet[0]]
							#print("Quadruple:", operands)
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('leal_leftmost_quadruple')]
						elif len(ldet) == 1 and len(rdet) == 1:
							operands_len = 2
							operands = [ldet[0], rdet[0]]
							#if leal_no_addr == False:
							#	operands[0] = "%ma-" + operands[0]
							primitivein = self.macro_primitives_exec[self.primitives.index('leal')] 
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception							
						#print("Operands", ldet, rdet, len(ldet), len(rdet))	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'movb ':
						#print("MOVL line", line)
						metadata = line.split('movb ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						#if len(operands) >= 3:
						#	print("OPERANDS MOVL ---------->", operands)
						#	print("MOVL line", line)
						operands_len = len(operands)

						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						tmp = operands[0]
						tmp1 = operands[1]
						if operands_len != 4:
							ldet = operands[0].split(" ")
							rdet = operands[1].split(" ")
						elif (operands_len == 4) and (len(tmp1.split(" ")) == 2):
							ldet = [operands[0]]
							rdet = operands[1].split(" ")
							rdet.append(operands[2])
							rdet.append(operands[3])
						elif (operands_len == 4) and (len(tmp.split(" ")) == 2):
							ldet = operands[0].split(" ")
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]
						elif (operands_len == 4) and (len(tmp.split(" ")) == 1):
							ldet = ['0', operands[0]]
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]

						#for i in range(len(ldet)):
						#	ldet[i].replace(" ", "")
						#for i in range(len(rdet)):
						#	rdet[i].replace(" ", "")
						#if len(ldet) > 1:
						#	if ldet[1] == '':
						#		ldet = [ldet[0]]
						#	elif ldet[0] == '':
						#		ldet = [ldet[1]]
						#if len(rdet) > 1:
						#	if rdet[0] == '':
						#		rdet = [rdet[1]]
						#	elif rdet[1] == '':	
						#	    rdet = [rdet[0]]
						#print(line)
						#print("LDET, RDET: ", ldet, rdet)				
						if len(ldet) == 2 and len(rdet) == 1:
							operands = [ldet[0], ldet[1], operands[1]]
							#print("leftmost: ", operands)
							operands_len = 3
							#print('leftmost')
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost')]
						elif len(rdet) == 2 and len(ldet) == 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							#print('rightmost')
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_rightmost')] 
						elif len(ldet) == 4 and len(rdet) == 1:
							operands =[ldet[0], ldet[1], ldet[2], ldet[3], operands[3]]
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost_triple')] 
						elif (len(ldet) == 1) and (len(rdet) == 1):
							operands_len = 2
							primitivein = self.macro_primitives_exec[self.primitives.index('movl')] 
							#print('center')
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Not implemented movl assembler line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception							
						#print("Operands", ldet, len(ldet), rdet, len(rdet))	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'movl ':
						#print("MOVL line", line)
						#print(line)
						metadata = line.split('movl ')
						metadata[1] = re.sub(r"^\s+|\s+$", "", metadata[1])
						operands = metadata[1].split(",")
						for i in range(len(operands)):
							if '$non_lazy_ptr' in operands[i]:
								operands[i] = '%ma-'  + operands[i][1:-13]
								operands[i] = operands[i].replace('$','')
						#print("MOVL line", operands)
						#if len(operands) >= 3:
						#	print("OPERANDS MOVL ---------->", operands)
						#	print("MOVL line", line)
						operands_len = len(operands)

						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						tmp = operands[0]
						tmp1 = operands[1]
						#print("operands, tmp:", operands, tmp)
						if operands_len != 4:
							ldet = operands[0].split(" ")
							rdet = operands[1].split(" ")
						elif (operands_len == 4) and (len(tmp1.split(" ")) == 2):
							ldet = [operands[0]]
							rdet = operands[1].split(" ")
							rdet.append(operands[2])
							rdet.append(operands[3])
						elif (operands_len == 4) and (len(tmp.split(" ")) == 2):
							ldet = operands[0].split(" ")
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]
						elif (operands_len == 4) and (len(tmp.split(" ")) == 1):
							ldet = ['0', operands[0]]
							ldet.append(operands[1])
							ldet.append(operands[2])
							rdet = [operands[3]]

						#print("LDET, RDET", ldet, rdet)
						#print("lens", len(ldet), len(rdet))

						for i in range(len(ldet)):
							ldet[i].replace(" ", "")
						for i in range(len(rdet)):
							rdet[i].replace(" ", "")
						#if len(ldet) > 1:
						#	if ldet[1] == '':
						#		ldet = [ldet[0]]
						#	elif ldet[0] == '':
						#		ldet = [ldet[1]]
						#if len(rdet) > 1:
						#	if rdet[0] == '':
						#		rdet = [rdet[1]]
						#	elif rdet[1] == '':	
						#	    rdet = [rdet[0]]	
						#print("LDET, RDET, proc:", ldet, rdet)			
						if len(ldet) == 2 and len(rdet) == 1:
							operands = [ldet[0], ldet[1], operands[1]]
							operands_len = 3
							#print('leftmost')
							if int(ldet[0]) == 0:
								primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost_zero')]
							else:
								primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost')]
						elif len(ldet) == 1 and len(rdet) == 4 and rdet[1] != "":
							operands =[operands[0], rdet[0], rdet[1], rdet[2], rdet[3]]
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_rightmost_triple')] 
						elif len(ldet) == 1 and len(rdet) == 4 and rdet[1] == "":
							#print(ldet, rdet)
							operands =[ldet[0], "%ma-"+rdet[0], '0', rdet[2], rdet[3]]
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_rightmost_vector_zero')]
						elif len(rdet) == 2 and len(ldet) == 1:
							operands = [operands[0], rdet[0], rdet[1]]
							operands_len = 3
							#print('rightmost')
							if int(rdet[0]) == 0:
								primitivein = self.macro_primitives_exec[self.primitives.index('movl_rightmost_zero')]
							else:
								primitivein = self.macro_primitives_exec[self.primitives.index('movl_rightmost')] 
						elif len(ldet) == 4 and len(rdet) == 1 and ldet[1] != '':
							operands =[ldet[0], ldet[1], ldet[2], ldet[3], operands[3]]
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost_triple')] 
						elif len(ldet) == 4 and len(rdet) == 1 and ldet[1] == '':
							operands =["%ma-"+ldet[0], '0', ldet[2], ldet[3], operands[3]]
							operands_len = 5
							primitivein = self.macro_primitives_exec[self.primitives.index('movl_leftmost_vector_zero')] 
						elif (len(ldet) == 1) and (len(rdet) == 1):
							operands_len = 2
							primitivein = self.macro_primitives_exec[self.primitives.index('movl')] 
						else:
							sys.stdout.write(bcolors.FAIL +'Error: Not implemented movl assembler line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception							
						#print("Operands", ldet, len(ldet), rdet, len(rdet))	
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'jmp ':
						metadata = line.split('jmp ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jmp')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'je ':
						metadata = line.split('je ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('je')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'jg ':
						metadata = line.split('jg ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jg')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'jl ':
						metadata = line.split('jl ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jl')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'jne ':
						metadata = line.split('jne ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jne')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'jge ':
						metadata = line.split('jge ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jge')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'jle ':
						metadata = line.split('jle ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jle')]
						
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___getior') or (line[0:8] == '__getior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetIOR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetIOR = True
						newLabel = False
					elif (line[0:9] == '___getisr') or (line[0:8] == '__getisr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetISR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetISR = True
						newLabel = False
					elif (line[0:9] == '___setcsr') or (line[0:8] == '__setcsr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setcsr')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___seticr') or (line[0:8] == '__seticr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__seticr')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setior') or (line[0:8] == '__setior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setior')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif (line[0:9] == '___setidr')  or (line[0:8] == '__setidr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setidr')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setiwr')  or (line[0:8] == '__setiwr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setiwr')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:9] == '___setchr')  or (line[0:8] == '__setchr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:9] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setchr')]
						drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False	
					elif (':' in line):						
						line = line.replace(" ","")
						#print('label!', line)
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
								sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the X86 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception
						#if (line[0:3] != '$__'):
						#if (line[0:1] != '$'):
						if (line == 'main:'):					
							redirect_main = True
							primitivein = self.macro_primitives_exec[self.primitives.index('main_redirect')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)
						else:
							primitivein = self.macro_primitives_exec[self.primitives.index('label')]
							drisc_asm = self.update_links_x86(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)
						bytenum = 0
						newLabel = True
						noLong = False
						if metadata[0] in self.DATARAM_LBL:
						    index_tbr = self.DATARAM_LBL.index(metadata[0])
						    self.DATARAM_LBL.remove(metadata[0])
						    self.DATARAM_VALUE.pop(index_tbr)
						self.current_label = metadata[0]
					else:
						sys.stdout.write(bcolors.FAIL +'Unsupported operator on line ' + str(lineidx) + ", " + line + ".\n" + bcolors.ENDC)
						raise Exception
					addr += 1
				if line[0:5] == '.comm':
					tmp = line.split('.comm')
					metadata = tmp[1].split(',') 
					metadata[2] = metadata[2].split('@')[0]
					metadata[2] = metadata[2].replace(' ', '')
					metadata[2] = metadata[2].replace('\t','')
					metadata[1] = metadata[1].replace(' ', '')
					metadata[1] = metadata[1].replace('\t','')
					metadata[0] = metadata[0].replace(' ', '')
					metadata[0] = metadata[0].replace('\t','')	
					#print(metadata)		
					for i in range(0, int(int(metadata[1])*int(metadata[2]))):
						if i == 0:
				 			self.DATARAM_LBL.append(metadata[0])
				 			self.DATARAM_VALUE.append('0')	
						else:
				 			self.DATARAM_LBL.append(metadata[0]+"."+str(i))
				 			self.DATARAM_VALUE.append('0')	
				if line[0:16] == '.indirect_symbol':
				  		if newLabel == True:
				  			self.asm_writer.pop()
				#  		line = line.replace('\t',' ')
				#  		metadata = line.split(" ")
				#  		if metadata[0][:-13] in self.DATARAM_LBL:
				# 		    index_tbr = self.DATARAM_LBL.index(metadata[0])
				# 		    self.DATARAM_LBL.remove(metadata[0])
				# 		    self.DATARAM_VALUE.pop(index_tbr)
				#  		self.DATARAM_LBL.append("%ma-"+self.current_label[:-13])
				#  		#self.DATARAM_LBL.append(self.current_label)
				#  		self.DATARAM_VALUE.append(metadata[1][1:])
				#  		print(self.DATARAM_LBL, self.DATARAM_VALUE)
				  		noLong = True
				if line[0:5] == '.long':
						if noLong == False:
					 		if newLabel == True:
					 			self.asm_writer.pop()
					 		line = line.replace('\t',' ')
					 		metadata = line.split(" ")
					 	#skip = False
					 	#if self.isGlobl:
					 	#	if self.current_label[1:] in self.BOOTSTRAP:
					 	#		skip = True
					 	#if skip == False:
					 	#print('long!!!', newLabel)
					 		#if self.current_label in self.DATARAM_LBL:
					 		#	idx_label_tbr = self.DATARAM_LBL.index(self.current_label)
					 		#	self.DATARAM_LBL.remove(self.current_label)
					 		#	self.DATARAM_VALUE.pop(idx_label_tbr)
						 	if bytenum == 0:
						 		#self.asm_writer.append([self.current_label+":\t\t" + metadata[1]])
						 		self.DATARAM_LBL.append(self.current_label)
						 		#if self.isGlobl:
						 		#	self.DATARAM_VALUE.append(metadataGlobl)
						 		#else:
						 		try:
					 				idata = int(metadata[1])
					 				if idata > 0x7FFF:
					 					metadata[1] = str(int(metadata[1]) - 2**32)
					 					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Long bigger than 0x7FFF, " + self.current_label + ". Making negative. \n")
					 			except:
					 				pass
						 		self.DATARAM_VALUE.append(metadata[1])
						 	else:
						 		self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
						 		try:
					 				idata = int(metadata[1])
					 				if idata > 0x7FFF:
					 					metadata[1] = str(int(metadata[1]) - 2**32)
					 					sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Long bigger than 0x7FFF, " + self.current_label + ". Making negative. \n")
					 			except:
					 				pass
						 		self.DATARAM_VALUE.append(metadata[1])
						 		#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + metadata[1]])
						 	bytenum += 1
						 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
						 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
						 	self.DATARAM_VALUE.append('0')				 	
						 	bytenum += 1
						 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
						 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
						 	self.DATARAM_VALUE.append('0')
						 	bytenum += 1
						 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
						 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
						 	self.DATARAM_VALUE.append('0')
						 	bytenum += 1
						 	newLabel = False
					 	#if self.isGlobl:
					 	#	self.DATARAM_LBL.append(metadataGlobl)
					 	#	self.DATARAM_VALUE.append(metadata[1])				 		
					 		self.isGlobl = False
				if line[0:6] == ".globl":
					self.isGlobl = True
				if line[0:9] == '.zerofill':
					line = line.replace('\t',' ')
					metadata = line.split(",")
					self.DATARAM_LBL.append(metadata[2])
					self.DATARAM_VALUE.append('0')					

		except Exception as e:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "cannot virtualize target.\n")
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.exit(1)
		clen = 0
		for i in range(len(self.asm_writer)):
				for j in range(len(self.asm_writer[i])):
					clen += 1

		try:

			fo = open(fileout,'w')
			vaddr = 0
			self.remap_list = []
			self.remap_addr = []
			for i in range(len(self.BOOTSTRAP)):
					fo.write(self.BOOTSTRAP[i] + ":\t\t" + self.BOOTSTRAP_DMEM[i]+ "\n")
					vaddr += 1
			for i in range(len(self.asm_writer)):
					for j in range(len(self.asm_writer[i])):
						fo.write(self.asm_writer[i][j]+"\n")
						vaddr += 3
			vblock = vaddr
			for i in range(len(self.DATARAM_LBL)):
					#if self.DATARAM_LBL[i][0:4] == "l___" and "_p_" not in self.DATARAM_LBL[i]:
					#		self.remap_list.append(self.DATARAM_LBL[i])
					#		self.remap_addr.append(vaddr)		
					self.remap_list.append(self.DATARAM_LBL[i])
					self.remap_addr.append(vaddr)		
					vaddr += 1
			vaddr = vblock
			for i in range(len(self.DATARAM_LBL)):	
				if self.linker == True:
					if self.DATARAM_LBL[i][0:4] == "%ma-":
						#	print('remap', self.DATARAM_LBL[i], self.DATARAM_LBL[i][4:])
							if (self.DATARAM_LBL[i] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_LBL[i][4:])
							#	print(idxremap)
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								lastaddr = self.remap_addr[idxremap]
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive .long at address " + str(vaddr)+" remapped to " + str(self.DATARAM_LBL[i]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " replaced with " + str(self.DATARAM_LBL[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								#sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for .long directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					elif self.DATARAM_LBL[i][0:8] == "%ma-l___":
						#	print('remap', self.DATARAM_LBL[i], self.DATARAM_LBL[i][4:])
							if (self.DATARAM_LBL[i] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_LBL[i][4:])
							#	print(idxremap)
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								lastaddr = self.remap_addr[idxremap]
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive .long at address " + str(vaddr)+" remapped to " + str(self.DATARAM_LBL[i]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " replaced with " + str(self.DATARAM_LBL[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								#sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for .long directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					elif self.DATARAM_LBL[i][0:6] == "%ma-.L":
						#	print('remap', self.DATARAM_LBL[i], self.DATARAM_LBL[i][4:])
							if (self.DATARAM_LBL[i] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_LBL[i][4:])
							#	print(idxremap)
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								lastaddr = self.remap_addr[idxremap]
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive .long at address " + str(vaddr)+" remapped to " + str(self.DATARAM_LBL[i]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " replaced with " + str(self.DATARAM_LBL[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								#sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for .long directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				else:
					if self.DATARAM_LBL[i][0:6] == "%ma-.L":
						self.DATARAM_VALUE[i] = self.DATARAM_LBL[i][4:]
					elif self.DATARAM_LBL[i][0:8] == "%ma-l___":
						self.DATARAM_VALUE[i] = self.DATARAM_LBL[i][4:]
					elif self.DATARAM_LBL[i][0:4] == "%ma-":
						self.DATARAM_VALUE[i] = self.DATARAM_LBL[i][4:]
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				vaddr += 1
			if redirect_main == True:
				sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"main: has been redirected to _main: .\n")

			fo.close()



		except Exception as e:
			sys.stdout.write("A Python " + str(e.__class__) + " error occurred.\n")
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)


	def compile_mips(self, filename="t0.mips", fileout="t0.asm"):
		fp = open(filename,'r')
		addr = 0
		lineidx = 0
		bytenum = 0
		newLabel = False
		self.push_initial_vars()
		self.asm_writer = []
		self.inGetIOR = False
		self.inGetISR = False
		try:
			operands = ['null']
			operands_len = len(operands)
			primitivein = self.macro_primitives_exec[self.primitives.index('main')]
			drisc_asm = self.update_links(primitivein, operands, operands_len)
			self.asm_writer.append(drisc_asm)
			while True:
				line = fp.readline()
				if line == '':
					break
				else:
					line = line.replace('\n','').replace('\r','')
				line = re.sub(r"^\s+|\s+$", "", line)
				linetmp = ''
				for g in range(len(line)):
					if line[g] != '#':
						linetmp += line[g]
					else:
						break
				line = linetmp
				if line == '':
					line = '#'
				lineidx += 1
				if (line[0] != '#') and (line[0] != '.'):
					line = line.replace(")(", " ")
					line = line.replace("(", " ")
					line = line.replace(")", " ")
					line = line.replace('\t',' ')
					line = line.replace(",","")
					if '%lo ' in line:
							line = line.replace('%lo ', '%lo-')
					if '%hi ' in line:
							line = line.replace('%hi ', '%hi-')
					line = re.sub(r"^\s+|\s+$", "", line)
					isref = False
					if line[0:4] == 'sub ':
						metadata = line.split('sub ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sub')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'subu ':
						metadata = line.split('subu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sub')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'sll ':
						metadata = line.split('sll ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sll')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'sllv ':
						metadata = line.split('sllv ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sll')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'srlv ':
						metadata = line.split('srlv ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('srl')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'srl ':
						metadata = line.split('srl ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('srl')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'sra ':
						metadata = line.split('sra ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sra')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'add ':
						metadata = line.split('add ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'slti ':
						metadata = line.split('slti ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
# WARNING, "u" instruction
					elif line[0:5] == 'sltu ':
						metadata = line.split('sltu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
# WARNING, "u" instruction
					elif line[0:6] == 'sltiu ':
						metadata = line.split('sltiu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'slt ':
						metadata = line.split('slt ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'or ':
						metadata = line.split('or ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('or')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'lui ':
					 	metadata = line.split('lui ')
					 	operands = metadata[1].split(" ")
					 	operands_len = len(operands)
					 	if operands_len < 2:
					 		sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
					 		raise Exception
					 	primitivein = self.macro_primitives_exec[self.primitives.index('lui')]
					 	drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
					 	self.asm_writer.append(drisc_asm)
					 	newLabel = False
					elif line[0:4] == 'and ':
						metadata = line.split('and ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('and')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'not ':
						metadata = line.split('not ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('not')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'andi ':
						metadata = line.split('andi ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('and')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'xor ':
						metadata = line.split('xor ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('xor')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'xori ':
						metadata = line.split('xori ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('xor')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'addi ':
						metadata = line.split('addi ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:6] == 'addiu ':
						metadata = line.split('addiu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'ori ':
						metadata = line.split('ori ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('or')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'addu ':
						metadata = line.split('addu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'lw ':
						metadata = line.split('lw ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('lw')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
# WARNING, "u" instruction
					elif line[0:4] == 'lbu ':
						metadata = line.split('lbu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('lw')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'sw ':
						metadata = line.split('sw ')
						operands = metadata[1].split(" ")
						#print(operands)
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sw')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'sb ':
						metadata = line.split('sb ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sw')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bne ':
						metadata = line.split('bne ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('bne')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'beq ':
						metadata = line.split('beq ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('beq')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'bgez ':
						metadata = line.split('bgez ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('bgez')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'movz ':
						metadata = line.split('movz ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('movz')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'move ':
						metadata = line.split('move ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len == 3:
							if operands[0] == '':
								operands = operands[1:3]
								operands_len = 2
						
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('move')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'negu ':
						metadata = line.split('negu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('negu')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'li ':
						metadata = line.split('li ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('move')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'beqz ':
						metadata = line.split('beqz ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('beqz')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'bnez ':
						metadata = line.split('bnez ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bnez')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif line[0:5] == 'bgtz ':
						metadata = line.split('bgtz ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bgtz')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:2] == 'j ':
						metadata = line.split('j ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('j')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'jal ':
						metadata = line.split('jal ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('jal')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'jr ':
						
						if self.inGetIOR == True:
							self.inGetIOR = False
							metadata = line.split('jr ')
							operands = [metadata[1]]
							operands_len = len(operands)
							if (operands_len != 1):
								sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception
							primitivein = self.macro_primitives_exec[self.primitives.index('__getior')]
							drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)							
							newLabel = False
						elif self.inGetISR == True: 
							self.inGetISR = False
							metadata = line.split('jr ')
							operands = [metadata[1]]
							operands_len = len(operands)
							if (operands_len != 1):
								sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception
							primitivein = self.macro_primitives_exec[self.primitives.index('__getisr')]
							drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)		
							newLabel = False
						else:
							metadata = line.split('jr ')
							operands = [metadata[1]]
							operands_len = len(operands)
							if (operands_len != 1):
								sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
								raise Exception
							primitivein = self.macro_primitives_exec[self.primitives.index('jr')]
							drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)
							newLabel = False
					elif (line[0:8] == '__getior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetIOR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetIOR = True
						newLabel = False
					elif (line[0:8] == '__getisr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetISR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetISR = True
						newLabel = False
					elif (line[0:8] == '__setcsr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setcsr')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__seticr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__seticr')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setior')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif (line[0:8] == '__setidr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setidr')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setiwr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setiwr')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setchr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setchr')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False						
					elif (':' in line):
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the MIPS assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						#if (line[0:3] != '$__'):
						#if (line[0:1] != '$'):
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						bytenum = 0
						newLabel = True
						self.current_label = metadata[0]
					elif line[0:3] == 'nop':
						operands = ['null']
						operands_len = len(operands)
						primitivein = self.macro_primitives_exec[self.primitives.index('nop')]
						drisc_asm = self.update_links(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					else:
						sys.stdout.write(bcolors.FAIL +'Unsupported operator on line ' + str(lineidx) + ", " + line + ".\n" + bcolors.ENDC)
						raise Exception
					#print(line)
					#for primitive in primitivein:
					#		print("Metadata --> ", primitivein)
					addr += 1
				if line[0:5] == '.comm':
					tmp = line.split('.comm')
					metadata = tmp[1].split(',') 
					metadata[2] = metadata[2].split('@')[0]
					metadata[2] = metadata[2].replace(' ', '')
					metadata[2] = metadata[2].replace('\t','')
					metadata[1] = metadata[1].replace(' ', '')
					metadata[1] = metadata[1].replace('\t','')
					metadata[0] = metadata[0].replace(' ', '')
					metadata[0] = metadata[0].replace('\t','')	
					#print(metadata)		
					for i in range(0, int(int(metadata[1])*int(metadata[2])/4)):
						if i == 0:
				 			self.DATARAM_LBL.append(metadata[0])
				 			self.DATARAM_VALUE.append('0')	
						else:
				 			self.DATARAM_LBL.append(metadata[0]+"."+str(i))
				 			self.DATARAM_VALUE.append('0')	
				if line[0:6] == '.4byte':
				 	if newLabel == True:
				 		self.asm_writer.pop()
				 	line = line.replace('\t',' ')
				 	metadata = line.split(" ")
				 	try:
				 		idata = int(metadata[1])
				 		if idata > 0x7FFF:
				 			metadata[1] = str(idata-2**32)
				 			sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "4Byte bigger than 0x7FFF, " + self.current_label + ". Making negative. \n")
				 	except:
				 		pass
				 	if bytenum == 0:
				 		#self.asm_writer.append([self.current_label+":\t\t" + metadata[1]])
				 		self.DATARAM_LBL.append(self.current_label)
				 		self.DATARAM_VALUE.append(metadata[1])
				 	else:
				 		self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 		self.DATARAM_VALUE.append(metadata[1])
				 		#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + metadata[1]])
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')				 	
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	#self.asm_writer.append([self.current_label+"."+str(bytenum)+":\t\t" + '0'])
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	newLabel = False

		except:
			sys.stdout.write('Error.\n')
			sys.exit(1)

		clen = 0
		for i in range(len(self.asm_writer)):
				for j in range(len(self.asm_writer[i])):
					clen += 1


		try:

			fo = open(fileout,'w')
			vaddr = 0
			self.remap_list = []
			self.remap_addr = []
			for i in range(len(self.BOOTSTRAP)):
					fo.write(self.BOOTSTRAP[i] + ":\t\t" + self.BOOTSTRAP_DMEM[i]+ "\n")
					vaddr += 1
			for i in range(len(self.asm_writer)):
					for j in range(len(self.asm_writer[i])):
						fo.write(self.asm_writer[i][j]+"\n")
						vaddr += 3
			vblock = vaddr
			for i in range(len(self.DATARAM_LBL)):
					#if self.DATARAM_LBL[i][0:1] == "$":
					#		self.remap_list.append(self.DATARAM_LBL[i])
					#		self.remap_addr.append(vaddr)		
					self.remap_list.append(self.DATARAM_LBL[i])
					self.remap_addr.append(vaddr)		
					vaddr += 1
			vaddr = vblock
			for i in range(len(self.DATARAM_LBL)):	
				if self.linker == True:
					if self.DATARAM_LBL[i][0:4] == "%lo-":
							if (self.DATARAM_LBL[i][4:] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_LBL[i][4:])
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive %lo at address " + str(vaddr)+" to " + str(self.DATARAM_LBL[i][4:]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " replaced with " + str(self.DATARAM_LBL[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for %lo directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				else:
					if self.DATARAM_LBL[i][0:4] == "%lo-":
						self.DATARAM_VALUE[i] = self.DATARAM_LBL[i][4:]
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				vaddr += 1

			fo.close()



		except:
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)


	def compile_riscv32(self, filename="t0.riscv32", fileout="t0.asm"):
		fp = open(filename,'r')
		addr = 0
		lineidx = 0
		bytenum = 0
		newLabel = False
		self.push_initial_vars_riscv32()
		self.asm_writer = []
		self.inGetIOR = False
		self.inGetISR = False
		try:
			operands = ['null']
			operands_len = len(operands)
			primitivein = self.macro_primitives_exec[self.primitives.index('main')]
			drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len)
			self.asm_writer.append(drisc_asm)
			while True:
				line = fp.readline()
				if line == '':
					break
				else:
					line = line.replace('\n','').replace('\r','')
				line = re.sub(r"^\s+|\s+$", "", line)
				linetmp = ''
				for g in range(len(line)):
					if line[g] != '#':
						linetmp += line[g]
					else:
						break
				line = linetmp
				if line == '':
					line = '#'
				lineidx += 1
				if ((line[0] != '#') and (line[0] != '.')) or (line[0:2] == '.L'):
					line = line.replace(")(", " ")
					line = line.replace("(", " ")
					line = line.replace(")", " ")
					line = line.replace('\t',' ')
					line = line.replace(",","")
					if '%lo ' in line:
							line = line.replace('%lo ', '%lo-')
					if '%hi ' in line:
							line = line.replace('%hi ', '%hi-')
					line = re.sub(r"^\s+|\s+$", "", line)
					isref = False
					#print(line[0:4], line[0:4] == 'sub ')
					if line[0:4] == 'sub ':
						metadata = line.split('sub ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sub')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'sll ':
						metadata = line.split('sll ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sll')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'slli ':
						metadata = line.split('slli ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sll')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'srli ':
						metadata = line.split('srli ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('srl')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'srl ':
						metadata = line.split('srl ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('srl')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'sra ':
						metadata = line.split('sra ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sra')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'srai ':
						metadata = line.split('srai ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sra')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'add ':
						metadata = line.split('add ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'slti ':
						metadata = line.split('slti ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'slt ':
						metadata = line.split('slt ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('slti')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'or ':
						metadata = line.split('or ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('or')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'lui ':
					 	metadata = line.split('lui ')
					 	operands = metadata[1].split(" ")
					 	operands_len = len(operands)
					 	if operands_len < 2:
					 		sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
					 		raise Exception
					 	primitivein = self.macro_primitives_exec[self.primitives.index('lui')]
					 	drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
					 	self.asm_writer.append(drisc_asm)
					 	newLabel = False
					elif line[0:4] == 'and ':
						metadata = line.split('and ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('and')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'not ':
						metadata = line.split('not ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('not')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'andi ':
						metadata = line.split('andi ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('and')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'xor ':
						metadata = line.split('xor ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('xor')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'xori ':
						metadata = line.split('xori ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('xor')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'addi ':
						metadata = line.split('addi ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('add')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'ori ':
						metadata = line.split('ori ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('or')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'lw ':
						metadata = line.split('lw ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('lw')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
# WARNING, "u" instruction
					elif line[0:4] == 'lbu ':
						metadata = line.split('lbu ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('lw')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'lb ':
						metadata = line.split('lb ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('lw')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'sw ':
						metadata = line.split('sw ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sw')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'sb ':
						metadata = line.split('sb ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('sw')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bne ':
						metadata = line.split('bne ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('bne')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'beq ':
						metadata = line.split('beq ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('beq')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'blt ':
						metadata = line.split('blt ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('blt')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:4] == 'bge ':
						metadata = line.split('bge ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('bge')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'bgez ':
						metadata = line.split('bgez ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len < 2:
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						if operands_len == 2:
							operands.append('zero')
						primitivein = self.macro_primitives_exec[self.primitives.index('bgez')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'mv ':
						metadata = line.split('mv ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if operands_len == 3:
							if operands[0] == '':
								operands = operands[1:3]
								operands_len = 2
						
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('mv')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'beqz ':
						metadata = line.split('beqz ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('beqz')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'bnez ':
						metadata = line.split('bnez ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bnez')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif line[0:5] == 'bgtz ':
						metadata = line.split('bgtz ')
						operands = metadata[1].split(" ")
						operands_len = len(operands)
						if (operands_len != 2):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('bgtz')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:2] == 'j ':
						metadata = line.split('j ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('j')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:5] == 'call ':
						metadata = line.split('call ')
						operands = [metadata[1]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('call')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif line[0:3] == 'ret':
						
						if self.inGetIOR == True:
							self.inGetIOR = False
							operands = ['ra']
							operands_len = len(operands)
							primitivein = self.macro_primitives_exec[self.primitives.index('__getior')]
							drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)							
							newLabel = False
						elif self.inGetISR == True: 
							self.inGetISR = False
							operands = ['ra']
							operands_len = len(operands)
							primitivein = self.macro_primitives_exec[self.primitives.index('__getisr')]
							drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)		
							newLabel = False
						else:
							operands = ['ra']
							operands_len = len(operands)
							primitivein = self.macro_primitives_exec[self.primitives.index('jr')]
							drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
							self.asm_writer.append(drisc_asm)
							newLabel = False
					elif (line[0:8] == '__getior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetIOR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetIOR = True
						newLabel = False
					elif (line[0:8] == '__getisr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						self.inGetISR = True
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						self.inGetISR = True
						newLabel = False
					elif (line[0:8] == '__setcsr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setcsr')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__seticr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__seticr')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setior'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setior')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
					elif (line[0:8] == '__setidr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setidr')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setiwr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setiwr')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					elif (line[0:8] == '__setchr'):
						sys.stdout.write(bcolors.OKGREEN + 'Info: Overriding procedure ' + line[0:8] + " entry point on line " + str(lineidx) + ' with macro.\n' + bcolors.ENDC)
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('__setchr')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						newLabel = False						
					elif (':' in line):
						line = line.replace(" ","")
						metadata = line.split(':')
						operands = [metadata[0]]
						operands_len = len(operands)
						if (operands_len != 1):
							sys.stdout.write(bcolors.FAIL +'Error: Something is wrong with the RISCV32 assembler on line ' + str(lineidx) + '.\n' + bcolors.ENDC)
							raise Exception
						primitivein = self.macro_primitives_exec[self.primitives.index('label')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=True)
						self.asm_writer.append(drisc_asm)
						bytenum = 0
						newLabel = True
						self.current_label = metadata[0]
					elif line[0:3] == 'nop':
						operands = ['null']
						operands_len = len(operands)
						primitivein = self.macro_primitives_exec[self.primitives.index('nop')]
						drisc_asm = self.update_links_riscv32(primitivein, operands, operands_len, isref=isref)
						self.asm_writer.append(drisc_asm)
						newLabel = False
					else:
						sys.stdout.write(bcolors.FAIL +'Unsupported operator on line ' + str(lineidx) + ", " + line + ".\n" + bcolors.ENDC)
						raise Exception
					addr += 1
				if line[0:5] == '.comm':
					tmp = line.split('.comm')
					metadata = tmp[1].split(',') 
					metadata[2] = metadata[2].split('@')[0]
					metadata[2] = metadata[2].replace(' ', '')
					metadata[2] = metadata[2].replace('\t','')
					metadata[1] = metadata[1].replace(' ', '')
					metadata[1] = metadata[1].replace('\t','')
					metadata[0] = metadata[0].replace(' ', '')
					metadata[0] = metadata[0].replace('\t','')	
					#print(metadata)		
					for i in range(0, int(int(metadata[1])*int(metadata[2])/4)):
						if i == 0:
				 			self.DATARAM_LBL.append(metadata[0])
				 			self.DATARAM_VALUE.append('0')	
						else:
				 			self.DATARAM_LBL.append(metadata[0]+"."+str(i))
				 			self.DATARAM_VALUE.append('0')	
				if line[0:5] == '.word':
				 	if newLabel == True:
				 		self.asm_writer.pop()
				 	line = line.replace('\t',' ')
				 	metadata = line.split(" ")
				 	try:
				 		idata = int(metadata[1])
				 		if idata > 0x7FFF:
				 			metadata[1] = str(idata-2**32)
				 			sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Word bigger than 0x7FFF, " + self.current_label + ". Making negative. \n")
				 	except:
				 		pass
				 	if bytenum == 0:
				 		self.DATARAM_LBL.append(self.current_label)
				 		self.DATARAM_VALUE.append(metadata[1])
				 	else:
				 		self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 		self.DATARAM_VALUE.append(metadata[1])
				 	bytenum += 1
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')				 	
				 	bytenum += 1
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	self.DATARAM_LBL.append(self.current_label+"."+str(bytenum))
				 	self.DATARAM_VALUE.append('0')
				 	bytenum += 1
				 	newLabel = False

		except:
			sys.stdout.write('Error.\n')
			sys.exit(1)

		clen = 0
		for i in range(len(self.asm_writer)):
				for j in range(len(self.asm_writer[i])):
					clen += 1


		try:

			fo = open(fileout,'w')
			vaddr = 0
			self.remap_list = []
			self.remap_addr = []
			for i in range(len(self.BOOTSTRAP)):
					fo.write(self.BOOTSTRAP[i] + ":\t\t" + self.BOOTSTRAP_DMEM[i]+ "\n")
					vaddr += 1
			for i in range(len(self.asm_writer)):
					for j in range(len(self.asm_writer[i])):
						fo.write(self.asm_writer[i][j]+"\n")
						vaddr += 3
			vblock = vaddr
			for i in range(len(self.DATARAM_LBL)):		
					self.remap_list.append(self.DATARAM_LBL[i])
					self.remap_addr.append(vaddr)		
					vaddr += 1
			vaddr = vblock
			for i in range(len(self.DATARAM_LBL)):	
				if self.linker == True:
					if self.DATARAM_LBL[i][0:4] == "%lo-":
							if (self.DATARAM_LBL[i][4:] in self.remap_list) == True:
								idxremap = self.remap_list.index(self.DATARAM_LBL[i][4:])
								self.DATARAM_VALUE[i] = str(self.remap_addr[idxremap])
								sys.stdout.write(bcolors.OKGREEN +"Info: "+ bcolors.ENDC +"ASM directive %lo at address " + str(vaddr)+" to " + str(self.DATARAM_LBL[i][4:]) + ".\n")
								sys.stdout.write(str(self.DATARAM_LBL[i]) + " replaced with " + str(self.DATARAM_LBL[i][4:]) + " address (" + str(self.remap_addr[idxremap]) + ").\n" )
								sys.stdout.write("%hi-"+str(self.DATARAM_LBL[i][4:]) + " unchanged.\n")	
							else:
								sys.stdout.write(bcolors.FAIL +"Error: " + bcolors.ENDC +"Not corresponding memory location for %lo directive " + str(self.DATARAM_LBL[i]) +".\n")
								raise Exception	
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				else:
					if self.DATARAM_LBL[i][0:4] == "%lo-":
						self.DATARAM_VALUE[i] = self.DATARAM_LBL[i][4:]
					fo.write(self.DATARAM_LBL[i] + ":\t\t" + self.DATARAM_VALUE[i]+ "\n")
				vaddr += 1

			fo.close()



		except:
			sys.stdout.write(bcolors.FAIL +'Cannot write output file.\n'+bcolors.ENDC)
			sys.exit(1)

	def removespace(self, line):
		line = re.sub(r"^\s+|\s+$", "", line)
		return line

	def load_asm(self, filename):
		self.LABEL_NAME = []
		self.LABEL_VALUE = []
		self.UMEM = []
		try:
			self.f = open(filename)
		except:
			sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "can't read input assembly file.\n")
			sys.exit(1)

		line = 0
		line_MCR_update = 0
		isLabel = False
		addr = 0

		self.ALL_SET = []
		dataram = True
		self.xref = []
		self.xref_new = []
		self.xlabel = []
		self.ARMlabel = False

		while True:
			if dataram == True:
				addr += 1
			else:
				addr += 3
			asmline = self.f.readline()
			if asmline == "":
					break
			asmline = asmline.replace("\t"," ")
			asmline = asmline.replace("\n","")
			asmline = asmline.replace("\r","")
			asmline = re.sub(r"^\s+|\s+$", "", asmline)

			if (":" in asmline) and ("exec " not in asmline):
				#asmline = asmline.replace(" ","")
				meta = asmline.split(self._MEMID)
				meta[0] = meta[0].replace('\t', "")
				meta[1] = meta[1].replace('\t', "")
				meta[1] = self.removespace(meta[1])
				meta[0] = self.removespace(meta[0])
				umem0 = meta[0]
				umem1 = meta[1]
				umem2 = ""
				umem3 = ""
				umem4 = ""
				umem5 = ""
				dataram = True
			elif (":" in asmline) and (self._INSTR_ID+" " in asmline):
				#asmline = asmline.replace(" ","")
				memlbl = asmline.split(self._MEMID)
				memlbl[1] = self.removespace(memlbl[1])
				memlbl[0] = self.removespace(memlbl[0])
				instr = memlbl[1].split(self._INSTR_ID+" ")
				umem0 = memlbl[0]
				umem1 = instr[0]
				meta = instr[1].split(",")
				meta[0] = meta[0].replace('\t', "")
				meta[1] = meta[1].replace('\t', "")
				meta[0] = self.removespace(meta[0])
				meta[1] = self.removespace(meta[1])
				if "->" in meta[1]:
					jmp = meta[1].split("->")
					jmp[0] = self.removespace(jmp[0])
					meta[1] = jmp[0]
					jmp[1] = self.removespace(jmp[1])
				else:
					jmp = ["",""]
				if meta[1] == 'MCR':
					umem2 = meta[0]
					umem3 = ""
					umem4 = ""
					umem5 = ""
				else:
					umem2 = ""
					umem3 = meta[0]
					umem4 = meta[1]
					umem5 = jmp[1]
				dataram = False
			elif (self._INSTR_ID+" " in asmline):
				instr = asmline.split(self._INSTR_ID+" ")
				meta = instr[1]
				meta = meta.split(",")
				meta[0] = meta[0].replace('\t', "")
				meta[1] = meta[1].replace('\t', "")
				meta[0] = self.removespace(meta[0])
				meta[1] = self.removespace(meta[1])
				umem0 = ""
				umem1 = ""
				if "->" in meta[1]:
					jmp = meta[1].split("->")
					jmp[0] = self.removespace(jmp[0])
					meta[1] = jmp[0]
					jmp[1] = self.removespace(jmp[1])
				else:
					jmp = ["",""]
				if meta[1] == 'MCR':
					umem2 = meta[0]
					umem3 = ""
					umem4 = ""
					umem5 = ""
				else:
					umem2 = ""
					umem3 = meta[0]
					umem4 = meta[1]
					umem5 = jmp[1]
				dataram = False

			if line < 7:
				dataram = True
			self.UMEM.append([umem0, umem1, umem2, umem3, umem4, umem5])
			line += 1

		self.f.close()
		self.UMEM_NEW = self.UMEM
		#for i in range(len(self.UMEM)):
		#	print(self.UMEM[i])

	def f_writer(self, fileout):
		opcode = "exec"
		f = open(fileout,'w')
		for i in range(len(self.f_code_linked)):
			f.write(self.f_code_linked[i] + '\n')
		f.close()
			

	def f_translate(self):
		opcode = "exec"
		self.f_code = []
		label_p = ""
		for i in range(len(self.UMEM_NEW)):
			f = ""
			if self.UMEM_NEW[i][0] != "":
					f += self.UMEM_NEW[i][0] + ": "
			if self.UMEM_NEW[i][2] != "":
				opcode = self.OPCODE[self.MCRsSYM.index(self.UMEM_NEW[i][2])] 
				if self.UMEM_NEW[i][0] != "":
					label_p = self.UMEM_NEW[i][0] + ": "
				else:
					label_p = ""
			else:
				if self.UMEM_NEW[i][1] != "":
					if i == 0:
						f += "0" 
					else:
						f += self.UMEM_NEW[i][1] 
					self.f_code.append(f)
				if self.UMEM_NEW[i][1] == "":
					#f.write('\t')
					if self.UMEM_NEW[i][3] != "" and self.UMEM_NEW[i][4] != "":
						f += label_p + ("\t" + opcode + " " + self.UMEM_NEW[i][3] + ", " + self.UMEM_NEW[i][4])
						if self.UMEM_NEW[i][5] != "":
							f += (" -> " + self.UMEM_NEW[i][5])
						self.f_code.append(f)
						label_p = ""
		#for i in range(len(self.f_code)):
		#	print(self.f_code[i])

	def linker_f(self):
		addr = 8
		self.remap_list = []
		self.remap_addr = []
		self.remap_data = []
		self.f_code_linked = []
		for i in range(8):
			self.f_code_linked.append(self.f_code[i])
		for i in range(8, len(self.f_code)): # 8 + 4*i
			asmline = self.f_code[i]
			asmline.replace("\n","")
			if ":" in asmline:
				metadata = asmline.split(":")
				rightmost = metadata[1].replace(" ", "").replace("\t", "").replace("\n","")
				leftmost = metadata[0].replace(" ", "").replace("\t", "").replace("\n","")
				if self.PCMCR_RESCALE in leftmost:
					rightmost = str(int(int(rightmost)/3*2))
				found_opcode = False
				for j in range(len(self.OPCODE)):
					if self.OPCODE[j]+" " in asmline:
						found_opcode = True
						break
				if found_opcode:
					self.f_code_linked.append(self.f_code[i])
					addr += 4
				else:
					self.remap_list.append(leftmost)
					self.remap_data.append(rightmost)
					self.remap_addr.append(addr)
					addr += 1
			else:
					self.f_code_linked.append(self.f_code[i])
					addr += 4				
		maxlen = 0
		for i in range(len(self.remap_list)):
			if len(self.remap_list[i]) > maxlen:
				maxlen = len(self.remap_list[i])

		for i in range(len(self.remap_list)): # 8 + 4*i
				if [k in self.NUMSET for k in self.remap_data[i]] != [True] * len(self.remap_data[i]):
					self.remap_data[i] = str(self.remap_addr[self.remap_list.index(self.remap_data[i])])
				self.f_code_linked.append(self.remap_list[i] + ":"+"\t" + self.remap_data[i])
		#for i in range(len(self.f_code_linked)):
		#	print(self.f_code_linked[i])


def ui_init():
	parser = argparse.ArgumentParser(description = "dRISC816/mOISC cross-compiler/translator and linker (LLVM-based) - Copyright (C) 2020-2021 Marco Crepaldi - Electronic Design Laboratory - Istituto Italiano di Tecnologia. \n Note: not all commercial processors/llvm ir instructions have been ported. This program requires llvm >= 9.0.")
	parser.add_argument('-in', metavar = 'filein', dest='filein', help="Input C file to be compiled. By default .c extension will be enforced. Example: test_program (reads: test_program.c)")
	parser.add_argument('-out', metavar = 'fileout', dest='fileout', help="Output dRISC assembler file. By default .asm extension will be enforced. Example: test_program (writes: test_program.asm)")
	parser.add_argument('-arch', metavar = 'intermediate', dest='intermediate', help="LLVM translation from the specified architecture. If commas are used first, arch, second target CPU. Example: mipsel,mips32r2. The ported architectures are x86, arm, riscv, mipsel and ll (llvm ir, with no target CPU). In particular, this small static compiler from clang ir output has two possible calling conventions (see llcc option). With the \'ll\' argument, the LLVM static compiler is not invoked.")
	parser.add_argument('-spo', metavar = 'sp', dest='sp', help="Stack pointer offset in the memory at startup. It must be less than the maximum addressable memory. If not specified, 31500 will be used")
	parser.add_argument('-llcc', metavar = 'llvm_cc', dest='llvm_cc', help="Calling convention used with ll compilation. The argument can be \'fast\' (direct register passing, not suitable for recursive calls), and \'std\' in which function arguments are pushed in the stack.")	
	parser.add_argument('-f', action="store_true", help="Generates assembler in fast processor mode (express MCR, CISC mode). The assembler filename has extension .fasm. An unlinked code with extension .uasm in oisc mode is also generated")
	args = parser.parse_args()
	return args

def main():
	arguments = ui_init()
	if arguments.filein is None:
		sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Input file is missing. Use \'-h\' for help. \n')
		sys.exit(1)
	if arguments.fileout is None:
		sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Output file is missing. Use \'-h\' for help. \n')
		sys.exit(1)	
	if arguments.intermediate is None:
		sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Intermediate architecture is missing. Use \'-h\' for help. \n')
		sys.exit(1)
	arch = arguments.intermediate
	if "," in arch:
		arch = arch.split(",")
	else:
		arch = [arch, '']

	if arch[0].upper() == "MIPSEL":
		if arch[1] != '':
			march = [arch[0], arch[1]]
		else:
			march = [arch[0], 'misp32r2']
	
	elif arch[0].upper() == "X86":
		if arch[1] != '':
			march = [arch[0], arch[1]]
		else:
			march = [arch[0], 'i486']
	elif arch[0].upper() == "ARM":	
		if arch[1] != '':
			march = [arch[0], arch[1]]
		else:
			march = [arch[0], 'arm9']		
	elif arch[0].upper() == "RISCV32":	
		if arch[1] != '':
			march = [arch[0], arch[1]]
		else:
			march = [arch[0], 'generic-rv32']	
	elif arch[0].upper() == "LL":	
		if arch[1] != '':
			march = [arch[0], arch[1]]
		else:
			march = [arch[0], '']
	else:
		sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Unknown architecture. Use \'-h\' for help. \n')
		sys.exit(1)		

	if arguments.llvm_cc is not None and arch[0].upper() != "LL":
		sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Cannot enforce calling convention for this specific target. Use \'-h\' for help. \n')
		sys.exit(1)

	if arguments.llvm_cc is None:
		llvm_cc = 'std'
	else:
		llvm_cc = arguments.llvm_cc

	p_codein = Path(arguments.filein)
	p_codeout = Path(arguments.fileout)	
	codeinlow = str(p_codein.with_suffix(''))
	codeoutlow = str(p_codeout.with_suffix(''))
	
	
	if march[0].upper() == 'RISCV32':
		if os.system('clang -emit-llvm ' + codeinlow + '.c -c -fno-stack-protector -fno-builtin --include=' + 'lib/inc/mOISC.c -I lib/inc -o '+ codeinlow+'.bc') != 0:
			sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM clang exception. \n')
			sys.exit(1)	
	elif march[0].upper() == 'X86':
		if os.system('clang -emit-llvm ' + codeinlow + '.c -c -fno-stack-protector -fno-builtin -mno-sse --include=' + 'lib/inc/mOISC.c -I lib/inc -o '+ codeinlow+'.bc') != 0:
			sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM clang exception. \n')
			sys.exit(1)	
	elif march[0].upper() == 'LL':
		if march[1] == '':
			if os.system('clang -emit-llvm ' + codeinlow + '.c -c -fno-stack-protector -fno-sanitize-cfi-cross-dso -fno-builtin -O0 --include=' + 'lib/inc/mOISC.c -I lib/inc -S -o '+ codeinlow+'.ll') != 0:
				sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM clang exception. \n')
				sys.exit(1)			
		else:
			if os.system('clang -emit-llvm ' + codeinlow + '.c -c -fno-stack-protector -fno-sanitize-cfi-cross-dso -fno-builtin -target ' + march[1] + ' -O0 --include=' + 'lib/inc/mOISC.c -I lib/inc -S -o '+ codeinlow+'.ll') != 0:
				sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM clang exception. \n')
				sys.exit(1)			
	else:
		if os.system('clang -emit-llvm ' + codeinlow + '.c -c -fno-stack-protector -fno-builtin --include=' + 'lib/inc/mOISC.c -I lib/inc -o '+ codeinlow+'.bc') != 0:
			sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM clang exception. \n')
			sys.exit(1)			

	if march[0].upper() == 'X86':
		if os.system('llc '+codeinlow+'.bc -march=' + march[0] + ' -mcpu=' + march[1] + ' -O0 -o '+codeoutlow+"."+march[0]) != 0: 
			sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM llc (static compiler) exception. \n')
			sys.exit(1)	
	elif march[0].upper() != 'LL':

		if os.system('llc '+codeinlow+'.bc -march=' + march[0] + ' -mcpu=' + march[1] + ' -relocation-model=static -O0 -o '+codeoutlow+"."+march[0]) != 0: 
			sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'LLVM llc (static compiler) exception. \n')
			sys.exit(1)		

	if march[0].upper() != 'LL':
		sys.stdout.write(bcolors.OKGREEN +"Info: " + 'Emulating ' + march[0] + ' architecture, ' + march[1] + ' CPU.\n' + bcolors.ENDC)
	else:
		if march[1] == '':
			localarch = 'this CPU'
		else:
			localarch = march[1]
		sys.stdout.write(bcolors.OKGREEN +"Info: " + 'Using clang target triple architecture (intermediate representation), ' + march[0] + ', ' + localarch + '.\n' + bcolors.ENDC)
	if arguments.f == False:
		linker = True
	else:
		linker = False
		sys.stdout.write(bcolors.OKGREEN +"Info: " + 'Making fast code (express MCR) and overriding bootstrap MCR to 0.\n' + bcolors.ENDC)
	compiler = arch_to_drisc(march[0], linker)


	if arguments.sp is not None:
		compiler.set_stack_offset(arguments.sp)
	if march[0].upper() != 'LL':
		compiler.load_primitives()
	if arguments.f == False:
		compiler.translate(filename=codeinlow+'.'+march[0], fileout=codeoutlow+'.asm', llvm_cc=llvm_cc)
	else:
		compiler.translate(filename=codeinlow+'.'+march[0], fileout=codeoutlow+'.uasm', llvm_cc=llvm_cc)
	if arguments.f == True:
		compiler.load_asm(codeoutlow+'.uasm')
		compiler.f_translate()
		compiler.linker_f()		
		compiler.f_writer(codeoutlow+'.fasm')
main()

