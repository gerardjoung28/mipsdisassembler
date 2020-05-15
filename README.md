# mipsdisassembler
This program convert bianry files created form mips program to the corresponding mips assembler instructions.

## Running the program

To run this program, it is necessary to add the command -std=c++11 in compiler configuration of the ide. This is necessary for the program to run so that it can access that library. After the program is ran it will ask the user for name of the binary file that the user want to disassemble; note that such binary file needs to be in the same folder as the program executable. After the user has input the name of the binary file, the program should then generate the corresponding MIPS instruction for such binaries.

## Updated version
disassembler.cpp file is an updated version which fixed older version out-of-range errors
