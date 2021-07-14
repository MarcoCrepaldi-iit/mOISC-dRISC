# coding=utf-8
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Dynamic Reduced Instruction Set Computer (d'RISC) [a.k.a. multi-OISC (mOISC)] VHDL Code autogen
# Copyright (C) August 18, 2020, Marco Crepaldi, Istituto Italiano di Tecnologia (IIT)
# Electronic Design Laboratory (EDL)
# Via Melen 83, 16152, Genova, Italy
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# taken from GNU Blender: https://svn.blender.org/svnroot/bf-blender/trunk/blender/build_files/scons/tools/bcolors.py
class bcolors:
    HEADER = '\033[95m'
    OKGREEN = '\033[94m'
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
import argparse
from shutil import copyfile
from pathlib import Path

class autogen:
	_MIPSEL = 'mipsel'
	_X86 = 'x86'
	_ARM = 'arm'
	_RISCV32 = 'riscv32'

	def __init__(self):
            #self.DICTIONARY = ['SURLEQ', 'ADDLEQ', 'XORLEQ', 'XNORLEQ', 'ANDLEQ', 'ORLEQ', 'SHLLEQ', 'SHRLEQ']
            self.DICTIONARY = ['ADDLEQ', 'XORLEQ', 'XNORLEQ', 'ANDLEQ', 'ORLEQ', 'SHLLEQ', 'SHRLEQ']
            self.PINDICTIONARY = ['IOR[0]', 'IOR[1]', 'IOR[2]', 'IOR[3]', 'IOR[4]', 'IOR[5]', 'IOR[6]', 'IOR[7]']
            #self.CODEDICT = ['_SURMCR:', '_ADDMCR:', '_XORMCR:', '_XNORMCR:', '_ANDMCR:', '_ORMCR:', '_SHLMCR:', '_SHRMCR:']
            self.CODEDICT = ['_ADDMCR:', '_XORMCR:', '_XNORMCR:', '_ANDMCR:', '_ORMCR:', '_SHLMCR:', '_SHRMCR:']
            self.outdir = "quartusrtl.out"
            self.outdirfull = "quartusrtl.out.full"
            self.folder = './lib'
            self.autodir = 'autogen'
            self.rulesdir = 'rules'
            self.staticdir = 'static'
            self.fpgamif = 'fpga.mif'
            self.VHDLwriter = []
            self.PINwriter = []
            self.PATCHES = []
            self.PINPATCHES = []
            self.PATCHFILE = []
            self.PATCHLEVEL = []
            self.mnemonic = 'exec'

	def load_rules(self):
		try:
                    self.RULESFILES = os.listdir(self.folder + "/" + self.autodir + "/" + self.rulesdir)
                    for rf in self.RULESFILES:
                                if rf.split(".")[1].lower() == 'vhd':
                                        self.META = [[], [], [], [], [], [], []]
                                        self.LEVEL = []
                                        self.LEVELIDX = []
                                        self.inRule = False
                                        prev_rulenumber = 0
                                        fp = open(self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf,'r')
                                        sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Loading rules in " + self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf +".\n")
                                        while True:
                                                line = fp.readline()
                                                tmpline = (line.replace('\t','').replace('\n','').replace('\r','').replace(' ','')).lower()
                                                if tmpline != "":
                                                        if self.inRule == False and (tmpline[0:18] == '--autogen:specific'): 
                                                                        rulenumber = int(tmpline[19])
                                                                        dictdata = tmpline[21:].upper()
                                                                        self.inRule = True
                                                                        if prev_rulenumber != rulenumber:
                                                                                self.LEVEL.append(self.META)
                                                                                self.LEVELIDX.append(rulenumber)
                                                                                self.META = [[], [], [], [], [], [], []]
                                                        elif self.inRule == True and (tmpline[0:21] == '--autogen:endspecific'):
                                                                        self.inRule = False
                                                                        prev_rulenumber = rulenumber
                                                        elif self.inRule == True and (tmpline[0:21] != '--autogen:endspecific'):
                                                                self.META[self.DICTIONARY.index(dictdata)].append(line)
                                                        elif self.inRule == False and (tmpline[0:18] != '--autogen:specific'):
                                                                self.VHDLwriter.append(line)
                                                elif line == '':
                                                        break
                                        if rulenumber == prev_rulenumber:
                                                        self.LEVEL.append(self.META)
                                                        self.LEVELIDX.append(rulenumber)

                                        fp.close()
                                        self.PATCHES.append(self.LEVEL)
                                        self.PATCHLEVEL.append(self.LEVELIDX)
                                        self.PATCHFILE.append(rf)
				
                                if rf.split(".")[1].lower() == 'qsf':
                                        self.METAPIN = [[], [], [], [], [], [], [], []]
                                        self.PIN = []
                                        self.FPGAPIN = [[], [], [], [], [], [], [], []]
                                        self.inRule = False
                                        prev_rulenumber = 0
                                        fp = open(self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf,'r')
                                        sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Loading rules in " + self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf +".\n")
                                        while True:
                                                line = fp.readline()
                                                tmpline = (line.replace('\t','').replace('\n','').replace('\r','').replace(' ','')).lower()
                                                if tmpline != "":
                                                        if self.inRule == False and (tmpline[0:18] == '#autogen:pinconfig'): 
                                                                        rulenumber = int(tmpline[19])
                                                                        pindata = tmpline[21:].upper()
                                                                        self.inRule = True
                                                                        if prev_rulenumber != rulenumber:
                                                                                self.PIN.append(self.METAPIN)
                                                                                self.METAPIN = [[], [], [], [], [], [], [], []]
                                                        elif self.inRule == True and (tmpline[0:21] == '#autogen:endpinconfig'):
                                                                        self.inRule = False
                                                                        prev_rulenumber = rulenumber
                                                        elif self.inRule == True and (tmpline[0:21] != '#autogen:endpinconfig'):
                                                                self.METAPIN[self.PINDICTIONARY.index(pindata)].append(line)
                                                                extracted = line.split('-to ')[1].upper().replace('\n','').replace('\r','')
                                                                fpgapin = line.split("set_location_assignment")[1].split(' -to ')[0].replace(' ','')
                                                                sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Got an " + extracted + " pin assignment statement to FPGA " + fpgapin + ".\n")
                                                                self.FPGAPIN[self.PINDICTIONARY.index(pindata)].append(fpgapin)
                                                        elif self.inRule == False and (tmpline[0:18] != '#autogen:pinconfig'):
                                                                self.PINwriter.append(line)                                                                                                                               
                                                elif line == '':
                                                        break
                                        if rulenumber == prev_rulenumber:
                                                        self.PIN.append(self.METAPIN)

                                        fp.close()
                                        self.PINPATCHES.append(self.PIN)
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot load " + self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf + " rules.\n")
				sys.exit(1)


	def make_vhdl_full(self, filename='rfm95.asm', pinreconfig=None):
		self.codeinlow = filename
		if pinreconfig is not None:
                    autopin = pinreconfig.upper().split(',')
                    if len(autopin) != len(self.FPGAPIN):
                        sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Not all pins have been specified.\n")
                        sys.exit(1)
		else:
                    autopin = None
                    
		if os.path.exists(self.outdirfull):
			sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "The directory " + self.outdirfull + " exists.\n")
		else:
			sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Creating directory " + self.outdirfull + ".\n")
			os.mkdir(self.outdirfull)
		try:
                    staticfiles = os.listdir(self.folder + "/" + self.autodir + "/" + self.staticdir)
                    for i in range(len(staticfiles)):
                        copyfile(self.folder + "/" + self.autodir + "/" + self.staticdir + "/" + staticfiles[i], "./" + self.outdirfull+"/"+staticfiles[i])

                    rulesfiles = os.listdir(self.folder + "/" + self.autodir + "/" + self.rulesdir)
                    for i in range(len(rulesfiles)):
                                        rf = rulesfiles[i]
                                        if rf.split(".")[1].lower() == 'qsf':
                                                sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Writing file " + rf + ".\n")
                                                fw = open("./" + self.outdirfull + "/" + rf,'w')
                                                fp = open(self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf,'r')
                                                replaced = False
                                                lineno = 1
                                                while True:
                                                        line = fp.readline()
                                                        tmpline = (line.replace('\t','').replace('\n','').replace('\r','').replace(' ','')).lower()
                                                        if tmpline != "" and line != "":
                                                                if self.inRule == False and (tmpline[0:18] == '#autogen:pinconfig'): 
                                                                                rulenumber = int(tmpline[19])
                                                                                dictdata = self.PINDICTIONARY.index(tmpline[21:].upper())
                                                                                self.inRule = True
                                                                                replaced = False
                                                                elif self.inRule == True and (tmpline[0:21] == '#autogen:endpinconfig'):
                                                                                self.inRule = False
                                                                elif self.inRule == True and (tmpline[0:21] != '#autogen:endpinconfig') and replaced == False:
                                                                                        sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Adding pin configuration " + self.PINDICTIONARY[dictdata] + " on line " + str(lineno) + ".\n")
                                                                                        if self.FPGAPIN[dictdata] != []:
                                                                                                        for i in range(len(self.PINPATCHES[0][rulenumber][dictdata])):
                                                                                                            if autopin is not None:
                                                                                                                    sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Overriding " + self.FPGAPIN[dictdata][0] + " with " + autopin[dictdata] + ".\n")
                                                                                                                    fw.write(self.PINPATCHES[0][rulenumber][dictdata][i].replace(self.FPGAPIN[dictdata][0], autopin[dictdata]))
                                                                                                            else:
                                                                                                                    fw.write(self.PINPATCHES[0][rulenumber][dictdata][i])
                                                                                        replaced = True						
                                                                elif self.inRule == False and (tmpline[0:18] != '#autogen:pinconfig'):
                                                                        fw.write(line)
                                                        elif line == '':
                                                                break
                                                        else:
                                                                fw.write(line)
                                                        
                                                        lineno += 1
                                                fw.close()
                                                fp.close()                                             
                                            
                                        else:
                                            copyfile(self.folder + "/" + self.autodir + "/" + self.rulesdir + "/" + rulesfiles[i], "./" + self.outdirfull+"/"+rulesfiles[i])
			
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot write the rules/static VHDL and Quartus project files in " + self.outdirfull + ".\n")
				sys.exit(1)
		try:
			miffile = self.codeinlow.split(".")[0]
			copyfile(miffile+".mif", "./" + self.outdirfull+"/"+ self.fpgamif)
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot write the MIF file associated to the .asm (that should be " + miffile+".mif" + " ). Did you make sure you compile your design from scratch?\n")
				sys.exit(1)

	def make_vhdl(self, pinreconfig=None):
		if pinreconfig is not None:
                    autopin = pinreconfig.upper().split(',')
                    if len(autopin) != len(self.FPGAPIN):
                        sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Not all pins have been specified.\n")
                        sys.exit(1)
		else:
                    autopin = None
                        
		if os.path.exists(self.outdir):
			sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "The directory " + self.outdir + " exists.\n")
		else:
			sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Creating directory " + self.outdir + ".\n")
			os.mkdir(self.outdir)

		try:
		  for rf in self.RULESFILES:
                                if rf.split(".")[1].lower() == 'vhd':
                                        sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Writing file " + rf + ".\n")
                                        fw = open("./" + self.outdir + "/" + rf,'w')
                                        fp = open(self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf,'r')
                                        replaced = False
                                        lineno = 1
                                        while True:
                                                line = fp.readline()
                                                tmpline = (line.replace('\t','').replace('\n','').replace('\r','').replace(' ','')).lower()
                                                if tmpline != "" and line != "":
                                                        if self.inRule == False and (tmpline[0:18] == '--autogen:specific'): 
                                                                        rulenumber = int(tmpline[19])
                                                                        dictdata = self.DICTIONARY.index(tmpline[21:].upper())
                                                                        self.inRule = True
                                                                        replaced = False
                                                        elif self.inRule == True and (tmpline[0:21] == '--autogen:endspecific'):
                                                                        self.inRule = False
                                                        elif self.inRule == True and (tmpline[0:21] != '--autogen:endspecific') and replaced == False:
                                                                        idx = self.PATCHFILE.index(rf)
                                                                        if self.ISA[dictdata] == True:
                                                                                sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Adding opcode hardware for " + self.DICTIONARY[dictdata] + " on line " + str(lineno) + ".\n")
                                                                                if self.PATCHES[idx][rulenumber][dictdata] != []:
                                                                                        for i in range(len(self.PATCHES[idx][rulenumber][dictdata])):
                                                                                                fw.write(self.PATCHES[idx][rulenumber][dictdata][i])
                                                                                replaced = True						
                                                        elif self.inRule == False and (tmpline[0:18] != '--autogen:specific'):
                                                                fw.write(line)
                                                elif line == '':
                                                        break
                                                else:
                                                        fw.write(line)
                                                
                                                lineno += 1
                                        fw.close()
                                        fp.close()
                                if rf.split(".")[1].lower() == 'qsf':
                                        sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Writing file " + rf + ".\n")
                                        fw = open("./" + self.outdir + "/" + rf,'w')
                                        fp = open(self.folder + "/" + self.autodir + '/' + self.rulesdir + "/" + rf,'r')
                                        replaced = False
                                        lineno = 1
                                        while True:
                                                line = fp.readline()
                                                tmpline = (line.replace('\t','').replace('\n','').replace('\r','').replace(' ','')).lower()
                                                if tmpline != "" and line != "":
                                                        if self.inRule == False and (tmpline[0:18] == '#autogen:pinconfig'): 
                                                                        rulenumber = int(tmpline[19])
                                                                        dictdata = self.PINDICTIONARY.index(tmpline[21:].upper())
                                                                        self.inRule = True
                                                                        replaced = False
                                                        elif self.inRule == True and (tmpline[0:21] == '#autogen:endpinconfig'):
                                                                        self.inRule = False
                                                        elif self.inRule == True and (tmpline[0:21] != '#autogen:endpinconfig') and replaced == False:
                                                                                sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Adding pin configuration " + self.PINDICTIONARY[dictdata] + " on line " + str(lineno) + ".\n")
                                                                                if self.FPGAPIN[dictdata] != []:
                                                                                                for i in range(len(self.PINPATCHES[0][rulenumber][dictdata])):
                                                                                                    if autopin is not None:
                                                                                                            sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Overriding " + self.FPGAPIN[dictdata][0] + " with " + autopin[dictdata] + ".\n")
                                                                                                            fw.write(self.PINPATCHES[0][rulenumber][dictdata][i].replace(self.FPGAPIN[dictdata][0], autopin[dictdata]))
                                                                                                    else:
                                                                                                            fw.write(self.PINPATCHES[0][rulenumber][dictdata][i])
                                                                                replaced = True						
                                                        elif self.inRule == False and (tmpline[0:18] != '#autogen:pinconfig'):
                                                                fw.write(line)
                                                elif line == '':
                                                        break
                                                else:
                                                        fw.write(line)
                                                
                                                lineno += 1
                                        fw.close()
                                        fp.close()                                    
                                    

                                        
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot write the rules VHDL files.\n")
				sys.exit(1)
		try:
			staticfiles = os.listdir(self.folder + "/" + self.autodir + "/" + self.staticdir)
			for i in range(len(staticfiles)):
					copyfile(self.folder + "/" + self.autodir + "/" + self.staticdir + "/" + staticfiles[i], "./" + self.outdir+"/"+staticfiles[i])
			
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot write the static VHDL and Quartus project files.\n")
				sys.exit(1)
		try:
			miffile = self.codeinlow.split(".")[0]
			copyfile(miffile+".mif", "./" + self.outdir+"/"+ self.fpgamif)
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot write the MIF file associated to the .asm (that should be " + miffile+".mif" + " ). Did you make sure you compile your design from scratch?\n")
				sys.exit(1)




	def read_asm(self, filename='rfm95.asm'):
		self.ISA = [False, False, False, False, False, False, False, False]
		self.ACTIVE = [False, False, False, False, False, False, False, False]
		self.codeinlow = filename
		try:
			af = open(filename,'r')
			sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Reading ASM file " + filename + ".\n")
			while True:
				line = af.readline()
				if line != "":
					for i in range(len(self.CODEDICT)):
						if self.CODEDICT[i] in line:
							self.ISA[i] = True
							sys.stdout.write(bcolors.OKGREEN + "Info: " + bcolors.ENDC + "Found opcode " + self.DICTIONARY[i] + ".\n")
						if self.CODEDICT[i][:-1] in line and self.mnemonic in line:
							self.ACTIVE[i] = True
				elif line == "":
					break
		except:
				sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot read assembler file.\n")
				sys.exit(1)	
		for i in range(len(self.ACTIVE)):
			if self.ACTIVE[i] == False and self.ISA[i] == True:
				sys.stdout.write(bcolors.WARNING + "Warning: " + bcolors.ENDC + "Opcode " + self.DICTIONARY[i] + " is declared in data memory but it seems to be never used. Skipping. \n")	
				self.ISA[i] = False

def ui_init():
	parser = argparse.ArgumentParser(description = "Hardware auto-generator for mOISC.\n\r It generates dRISC/mOISC VHDL and Quartus project files for a Cyclone 10LP device from a template, based on the opcodes find in an assembler file, with output in a subfolder ./quartusrtl.out. \nCopyright (C) 2020 Marco Crepaldi - Electronic Design Laboratory - Istituto Italiano di Tecnologia.")
	parser.add_argument('-in', metavar = 'filein', dest='filein', help="Input ASM file to be read to extract opcodes. Example: test_program (reads: test_program.asm). The extracted RTL will be placed in ./quartusrtl.out")
	parser.add_argument('-pincfg', metavar = 'pincfg', dest='pincfg', help="FPGA pins to map IOR[0]-IOR[7], comma separated, and ordered from 0 to 7. Example: PIN\_L14,PIN\_K15,PIN\_J14,PIN\_J13,PIN\_C11,PIN\_F14,PIN\_B1,PIN\_C2 (special characters must be entered with an escape character \). If no -pincfg is provided the default rules will be used")                                                                                                                     
	parser.add_argument('-mkfull', action="store_true", help="Makes an all-opcodes processor RTL code in a subfolder ./quartusrtl.out.full")
	args = parser.parse_args()
	return args

def main():
    if sys.version_info.major < 3:
            sys.stdout.write(bcolors.FAIL + "Error: " + bcolors.ENDC + "Cannot run this program with Python 2.\n")
            sys.exit(1)
    arguments = ui_init()
    if arguments.filein is None and arguments.mkfull is False:
        sys.stdout.write(bcolors.FAIL +'Error: '+bcolors.ENDC +'Input file is missing. Use \'-h\' for help. \n')
        sys.exit(1)

    if arguments.filein is not None:
        p_codein = Path(arguments.filein)
        codeinlow = str(p_codein.with_suffix(''))
		#codeinv = arguments.filein.split(".")
		#if len(codeinv) == 1:
		#	codeinlow = codeinv[0]
		#else:
		#	codein = arguments.filein.split(".")
		#	codeinlow = codein[0]
            
            

    auto = autogen()

    if arguments.pincfg is not None:
        pincfg = arguments.pincfg
    else:
        pincfg = None
    if arguments.filein is not None and arguments.mkfull is False:
        auto.read_asm(filename=codeinlow+".asm")
        auto.load_rules()
        auto.make_vhdl(pinreconfig=pincfg)
    if arguments.mkfull is True and arguments.filein is not None:
        auto.load_rules()
        auto.make_vhdl_full(filename=codeinlow+".asm", pinreconfig=pincfg)

main()
