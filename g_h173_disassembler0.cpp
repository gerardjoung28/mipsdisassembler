/******************************
 * Authors: Jorge Carrillo jac656
 * Gerardo Hechavarria g_h173
 * CS 3339 - Spring 2020, Texas State University
 * Project Mips Disassembler
 ******************************/
#include <iostream>
#include <string>
#include <fstream>
#include <cstdint>
#include <iomanip>
using namespace std;

const int NREGS = 32;
const string regNames[NREGS] = {"$zero","$at","$v0","$v1","$a0","$a1","$a2","$a3",
                                "$t0","$t1","$t2","$t3","$t4","$t5","$t6","$t7",
                                "$s0","$s1","$s2","$s3","$s4","$s5","$s6","$s7",
                                "$t8","$t9","$k0","$k1","$gp","$sp","$fp","$ra"};

void disassembleInstr(uint32_t pc, uint32_t instr) {
  uint32_t opcode;      // opcode field
  uint32_t rs, rt, rd;  // register specifiers
  uint32_t shamt;       // shift amount (R-type)
  uint32_t funct;       // funct field (R-type)
  uint32_t uimm;        // unsigned version of immediate
  int32_t simm;         // signed version of immediate
  uint32_t addr;        // jump address offset field

  opcode = ( instr >> 26); // shift 26 bit to the right to get the first 6 bit for opcode
  rs = (instr >> 21) & 0x1f; // shift 21 bit to right and and keep the five bits for rs the same and the rest to zero
  rt = (instr >> 16) & 0x1f; // shift 16 and keep in the register the 5 bits for rt
  rd = (instr >> 11) & 0x1f; // shift 11 bit to right and keep in register the rd bits
  shamt = (instr >> 6) & 0x1f; // shift and keep shamt bit in register
  funct = (instr & 0x3f); // shift and keep the bits for function in register
  uimm = (instr & 0x0ffff); // keep the 15 immediate bits
  simm = (((signed)uimm << 16) >> 16); // keep the 15 immediate bits for signed number and add 1 to get the signed version.
  addr = (instr & 0x03ffffff) ; // keep address

  cout << hex << setw(8) << pc << ": ";
  switch(opcode) {
    case 0x00:
      switch(funct) {
        case 0x00: cout << "sll " << regNames[rd] << ", " << regNames[rs] << ", " << dec << shamt; break;
        case 0x03: cout << "sra " << regNames[rd] << ", " << regNames[rs] << ", " << dec << shamt; break;
        case 0x08: cout << "jr " << regNames[rs]; break;
        case 0x10: cout << "mfhi " << regNames[rd]; break;
        case 0x12: cout << "mflo " << regNames[rd]; break;
        case 0x18: cout << "mult " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x1a: cout << "div " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x21: cout << "addu " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x22: cout << "sub " << regNames[rd] << ", " << regNames[rs] << ", " << dec << shamt; break;
        case 0x23: cout << "subu " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x2a: cout << "slt " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x24: cout << "and " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x20: cout << "add " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x27: cout << "nor " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x25: cout << "or " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x2b: cout << "sltu " << regNames[rd] << ", " << regNames[rs] << ", " << regNames[rt]; break;
        case 0x02: cout << "srl " << regNames[rt] << ", " << regNames[rd] << ", " << dec << shamt ; break;
        case 0x1b: cout << "divu " << regNames[rs] << ", " << regNames[rt] ; break;
        case 0x19: cout << "multu " << regNames[rs] << ", " << regNames[rt]; break;
        default: cout << "unimplemented";
      }
      break;
    case 0x02: cout << "j " << hex << (((pc + 4) >> 28) << 28) + addr * 4; break;
    case 0x03: cout << "jal " << hex << ((pc + 4) & 0xf0000000) + addr * 4; break;
    case 0x04: cout << "beq " << regNames[rs] << ", " << regNames[rt] << ", " << hex << (pc + 4) + simm * 4; break;
    case 0x05: cout << "bne " << regNames[rs] << ", " << regNames[rt] << ", " << hex << (pc + 4) + simm * 4; break;
    case 0x09: cout << "addiu " << regNames[rt] << ", " << regNames[rs] << ", " << dec << simm; break;
    case 0x0c: cout << "andi " << regNames[rs] << ", " << regNames[rt] << ", " << dec << uimm; break;
    case 0x0f: cout << "lui " << regNames[rt] << ", " << dec << uimm; break;
    case 0x1a: cout << "trap " << hex << addr; break;
    case 0x23: cout << "lw " << regNames[rt] << ", " << dec << simm <<"(" <<regNames[rs]<<")"; break;
    case 0x2b: cout << "sw " << regNames[rt] << ", " << dec << simm <<"(" << regNames[rs] << ")"; break;
    case 0x24: cout << "lbu " << regNames[rt] << ", " << dec << uimm <<"(" << regNames[rs] << ")"; break;
    case 0x25: cout << "lhu " << regNames[rt] << ", " << dec << uimm <<"(" << regNames[rs] << ")"; break;
    case 0x0d: cout << "ori " << regNames[rt] << ", " << regNames[rs] << ", " << dec << uimm; break;
    case 0x0a: cout << "slti " << regNames[rt] << ", " << regNames[rs] << ", " << dec << simm; break;
    case 0x0b: cout << "sltiu " << regNames[rt] << ", " << regNames[rs] << ", " << dec << simm; break;
    case 0x28: cout << "sb " << regNames[rt] << ", " << dec << simm <<"(" << regNames[rs] << ")"; break;
    case 0x29: cout << "sh " << regNames[rt] << ", " << dec << simm <<"(" << regNames[rs] << ")"; break;
    default: cout << "unimplemented";
  }
  cout << endl;
}


int main(){
   int count = 0;
   ifstream inFile;
   uint8_t bytes[4];
   int32_t test1;
   string unused;
   string line;
   uint32_t *instructions;
   unsigned long long int binary ;
   unsigned long long int start;

   cout << "CS 3339 MIPS Disassembler" << endl << endl;

  // open the binary file;
   inFile.open("test12");

   if(!inFile) {
     cerr << "error: could not open executable file " << endl;
     return -1;}

  // count number of lines in the file.
   while(!inFile.eof())
    {
      getline(inFile,line);
      count++;}

   // clear() and seekg() file to start reading from the beginning;
   inFile.clear();
   inFile.seekg(0, ios::beg);

   // save first line in file corresponding to the starting memory
     inFile >> unused;

    // convert string to int;
     start = stoi(unused,nullptr,2);

   instructions = new uint32_t[count];

   if(!instructions) {
     cerr << "error: out of memory" << endl;
     return -1;}

   inFile >> unused ;

   // read if 32 bit instruction convert it to int and save it in instructions;
   for(int i = 0; i < count; i++) {
     binary = stoi(unused, nullptr, 2);
     instructions[i] = binary;
     inFile >> unused ;
   }

 // disassemble each instruction
   for(int i = 0; i < count; i++) {
    disassembleInstr(start + i * 4, instructions[i]);
  }

   inFile.close();
   return 0;
}
