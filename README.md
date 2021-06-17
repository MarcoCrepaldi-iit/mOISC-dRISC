# mOISC-dRISC

This is an open source implementation of a multi-One Instruction Set Processor (mOISC) based on 14 execution modes
for microcontroller applications. 

This repository comprises a basic compilation and translation toolchain from C source code compiled with LLVM and LLVM assembly to the
mOISC assembler. mOISC can be used for educational purposes or other research activities, for instance devising other architectures.

Copyiright (C) 2020-2021 Marco Crepaldi, Istituto Italiano di Tecnologia (www.iit.it), Electronic Design Laboratory (https://edl.iit.it)

This software is *experimental*, we have not implemented all LLVM-IR commands, and it works for simple programs. This software is only a starting point
to devise more complex projects/architectures.

*A full machine description is available in the first comments of the file `m.py`*.

## Pre-Requisites

The software has been tested under MacOS with Darwin Kernel Version 20.5.0, and under CentOS Linux 7, Kernel 3.10.0-1160.25.1.el7.
To run the program you need the following software:

+ python3 ([download](https://www.python.org/downloads/));
+ gtkWave ([download](http://gtkwave.sourceforge.net));
+ llvm and clang version >= 9.0 ([download](https://llvm.org));
+ python3 module argparse (once python3 is installed run `python3 -m pip install argparse`);
+ other builtin python3 modules (os, sys, re, pathlib, dataclasses, struct, itertools, curses, binascii, time).
 
## Compiling C source code

Compilation from C to binary files is achieved using `mc.py` and `m.py`. For ease of use we have created two scritps that compile
the code by running both programs in sequence.

All the source files can be placed in the `examples/` folder. 

Code can be compiled in OISC mode and in CISC mode. We refer here to a sample code that generates a frequency modulated sine wave on the IOR port, `sine_wave.c`. The mOISC include file required for compilation is in `lib/inc` and its corresponding C code is automatically included by `mc.py` at compilation time.

### Compiling in CISC mode 

#### LLVM-IR compilation

To compile in CISC mode an example code `sine_wave.c` run the following command,
```
./compile-cisc examples/sine_wave ll
```
where `ll` stands for low-level and invokes compilation based on clang LLVM-IR output.
After compilation the following files will be generated: `sine_wave.fasm` (assembly in CISC mode), `sine_wave.uasm` (unlinked assembly in OISC mode),
`sine_wave.sym` (symbol file for simulation), `sine_wave.bin` (binary file for simulation), `sine_wave.mif` (MIF file for FPGA programming),
`sine_wave.ll` (LLVM-IR code generated by `clang` before low-level compilation). 

#### Assembly translation

To translate from known ISA architectures, run the following command,
```
./compile-cisc examples/sine_wave arm
```
where `arm` identifies the ISA, in this example ARM. Supported ISA are `x86`, `riscv`, `arm`, `mipsel`.
After compilation the following files will be generated: `sine_wave.fasm` (assembly in CISC mode), `sine_wave.uasm` (unlinked assembly in OISC mode),
`sine_wave.sym` (symbol file for simulation), `sine_wave.bin` (binary file for simulation), `sine_wave.mif` (MIF file for FPGA programming),
`sine_wave.<arch>` (`<arch>` assembly generated by `clang` and `llc` before translation). 

### Compiling in OISC mode 

#### LLVM-IR compilation

To compile in OISC mode an example code `sine_wave.c` run the following command,
```
./compile examples/sine_wave ll
```
where `ll` stands for low-level and invokes compilation based on clang LLVM-IR output.
After compilation the following files will be generated: `sine_wave.asm` (assembly in OISC mode),
`sine_wave.sym` (symbol file for simulation), `sine_wave.bin` (binary file for simulation), `sine_wave.mif` (MIF file for FPGA programming),
`sine_wave.ll` (LLVM-IR code generated by `clang` before low-level compilation). 

#### Assembly translation

To translate from known ISA architectures, run the following command,
```
./compile examples/sine_wave arm
```
where `arm` identifies the ISA, in this example ARM. Supported ISA are `x86`, `riscv`, `arm`, `mipsel`.
After compilation the following files will be generated: `sine_wave.asm` (assembly in OISC mode),
`sine_wave.sym` (symbol file for simulation), `sine_wave.bin` (binary file for simulation), `sine_wave.mif` (MIF file for FPGA programming),
`sine_wave.<ARCH>` (`<ARCH>` assembly generated by `clang` and `llc` before translation). 

## Simulating the compiled code

To run graphical simulation (internally invoking gtkWave), run the following command:
```
./simulate examples/sine_wave
```
Press ctrl-c to stop simulation execution. The simulation will generate a VCD file that will be opened by the `simulate` script in 
gtkWave. Add to the viewed wave at least the IOR to see the effect of the code on the I/O output port. 

## Generation of the mOISC VHDL code

To generate processor VHDL code and Quartus project files, run the following command:
```
./autogen examples/sine_wave
```
The program will generate a full Quartus project in a subfolder `quartusrtl.out`, including only the 
instructions used in the assembly code. Make sure the code is compiled in OISC mode. The generated processor
will be able to run both CISC and OISC mode code in any case, but `autogen` will process only OISC mode assembler files.

To generate a full featured processor run:
```
./autogen examples/sine_wave -mkfull
```
It will generate a full featured processor in a subfolder `quartusrtl.out.full`. In this case the OISC mode assembly is dummy.

### Note on commands syntax

The mOISC toolchain is based on `m.py`, `mc.py` and `mautogen.py`, that are called in the scripts `compile`, `compile-cisc`, `simulate` and `autogen`.
All these programs refer to the subfolder `\lib` and all its files.

For instance, run the command `python3 m.py -help` to print the options of `m.py`. The same applies for `mc.py` and `mautogen.py`.

## License

The files contained in this repository are licensed under the BSD-3-Clause license, except the following:

+ the files in /lib/autogen dRISC.qsf, dRISC.qpf, dRISC_PLL.cmp, dRISC_PLL.vhd, iobuf.cmp, memory.cmp, memory.vhd, 	
  dRISC_chain.cdf, memory.qip, memory_inst.vhd, dRISC.qsf are generated by the Intel Quartus software, and are licensed under the terms and conditions  
  described in the Intel Program License Subscription Agreement, the Intel Quartus Prime License Agreement, the Intel FPGA IP License Agreement, or other 
  applicable license agreement, including, without limitation, that your use is for the sole purpose of programming logic devices manufactured by Intel 
  and sold by Intel or its authorized distributors. 

  More information at: https://fpgasoftware.intel.com/eula
  
+ the file dRISC.qsf contains additional *commented lines* written by Marco Crepaldi, Istituto Italiano di Tecnologia.

+ all the .c and .h files and the file pysensor.py in the subfolder examples/ are subject to Open Source 
  Licensing GPL V3.
	
+ examples/RH_RF95.h, copyright (C) 2014 Mike McCauley (mikem@airspayce.com), 
  with code commented on line 15 and from line 505 until the end of file by Marco Crepaldi, Istituto Italiano di Tecnologia.

For all the other files, we report the BDS-3-Clause license:

Copyright 2020-2021 Marco Crepaldi, Istituto Italiano di Tecnologia, Via Morego 30, 16163, Genova, Italy.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

+ 	Redistributions of source code must retain the above copyright notice, this list of conditions and the 
	following disclaimer.

+ 	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the 
	following disclaimer in the documentation and/or other materials provided with the distribution.

+ 	Neither the name of the copyright holder nor the names of its contributors may be used to endorse or
	promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
