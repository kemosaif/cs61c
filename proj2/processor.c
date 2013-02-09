#include <stdio.h>
#include <stdlib.h>

#include "processor.h"
#include "disassemble.h"

int32_t signExtension(int32_t instr) {
  int16_t value = (int16_t)instr;
  return (int32_t)value;
}

uint32_t zeroExtension(int32_t instr) {
  uint16_t value = (uint16_t)instr;
  return (uint32_t)value;
}

void execute_one_inst(processor_t* p, int prompt, int print_regs)
{
  inst_t inst;

  /* fetch an instruction */
  inst.bits = load_mem(p->pc, SIZE_WORD);

  /* interactive-mode prompt */
  if(prompt)
  {
    if (prompt == 1) {
      printf("simulator paused, enter to continue...");
      while(getchar() != '\n')
        ;
    }
    printf("%08x: ",p->pc);
    disassemble(inst);
  }

  switch (inst.rtype.opcode) /* could also use e.g. inst.itype.opcode */
  {
  case 0x0:     // opcode == 0x0 (SPECIAL)

    switch (inst.rtype.funct)
    {
    case 0x0:   // sll rd,rt,shamt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rt] << inst.rtype.shamt;
      p->pc += 4;
      break;
    case 0x2:   // srl rd,rt,shamt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rt] >> inst.rtype.shamt;
      p->pc += 4;
      break;
    case 0x3:   // sra rd,rt,shamt
      p->R[inst.rtype.rd] = ((int32_t)p->R[inst.rtype.rt]) >> inst.rtype.shamt;
      p->pc += 4;
      break;
    case 0x8:   // jr rs
      p->pc = p->R[inst.rtype.rs];
      break;
    case 0x9:   // jalr rd,rs
      p->R[inst.rtype.rd] = p->pc + 4;
      p->pc = p->R[inst.rtype.rs];
      break;
    case 0xc:   // syscall
      handle_syscall(p);
      p->pc += 4;
      break;
    case 0x21:  // addu rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] + p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x23:  // subu rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] - p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x24:  // and rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] & p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x25:  // or rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] | p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x26:  // xor rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] ^ p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x27:  // nor rd,rs,rt
      p->R[inst.rtype.rd] = ~(p->R[inst.rtype.rs] | p->R[inst.rtype.rt]);
      p->pc += 4;
      break;
    case 0x2a:  // slt rd,rs,rt
      p->R[inst.rtype.rd] = (int32_t)p->R[inst.rtype.rs] < (int32_t)p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    case 0x2b:  // sltu rd,rs,rt
      p->R[inst.rtype.rd] = p->R[inst.rtype.rs] < p->R[inst.rtype.rt];
      p->pc += 4;
      break;
    default:    // undefined funct
      fprintf(stderr, "%s: pc=%08x, illegal instruction=%08x\n", __FUNCTION__, p->pc, inst.bits);
      exit(-1);
      break;
    }
    break;

  case 0x2:     // j address
    p->pc = ((p->pc+4) & 0xf0000000) | (inst.jtype.addr << 2);
    break;
  case 0x3:     // jal address
    p->R[31] = p->pc+4;
    p->pc = ((p->pc+4) & 0xf0000000) | (inst.jtype.addr << 2);
    break;
  case 0x4:     // beq rs,rt,offset
    if (p->R[inst.itype.rs] == p->R[inst.itype.rt]) {
      p->pc += 4 + (signExtension(inst.itype.imm) << 2);
    } else {
        p->pc += 4;
    }
    break;
  case 0x5:     // bne rs,rt,offset
    if (p->R[inst.itype.rs] != p->R[inst.itype.rt]) {
      p->pc += 4 + (signExtension(inst.itype.imm) << 2);
    } else {
        p->pc += 4;
    }
    break;
  case 0x9:     // addiu rt,rs,imm
    p->R[inst.itype.rt] = p->R[inst.itype.rs] + signExtension(inst.itype.imm);
    p->pc += 4;
    break;
  case 0xa:     // slti rt,rs,imm
    p->R[inst.itype.rt] = (int32_t)p->R[inst.itype.rs] < signExtension(inst.itype.imm);
    p->pc += 4;
    break;
  case 0xb:     // sltiu rt,rs,imm
    p->R[inst.itype.rt] = p->R[inst.itype.rs] < inst.itype.imm;
    p->pc += 4;
    break;
  case 0xc:     // andi rt,rs,imm
    p->R[inst.itype.rt] = p->R[inst.itype.rs] & inst.itype.imm;
    p->pc += 4;
    break;
  case 0xd:     // ori rt,rs,imm
    p->R[inst.itype.rt] = p->R[inst.itype.rs] | inst.itype.imm;
    p->pc += 4;
    break;
  case 0xe:     // xori rt,rs,imm
    p->R[inst.itype.rt] = p->R[inst.itype.rs] ^ inst.itype.imm;
    p->pc += 4;
    break;
  case 0xf:     // lui rt,imm
    p->R[inst.itype.rt] = inst.itype.imm << 16;
    p->pc += 4;
    break;
  case 0x20:    // lb rt,offset(rs)
    p->R[inst.itype.rt] = signExtension(load_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_BYTE));
    p->pc += 4;
    break;
  case 0x21:    // lh rt,offset(rs)
    p->R[inst.itype.rt] = signExtension(load_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_HALF_WORD));
    p->pc += 4;
    break;
  case 0x23:    // lw rt,offset(rs)
    p->R[inst.itype.rt] = load_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_WORD);
    p->pc += 4;
    break;
  case 0x24:    // lbu rt,offset(rs)
    p->R[inst.itype.rt] = zeroExtension(load_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_BYTE));
    p->pc += 4;
    break;
  case 0x25:    // lhu rt,offset(rs)
    p->R[inst.itype.rt] = zeroExtension(load_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_HALF_WORD));
    p->pc += 4;
    break;
  case 0x28:    // sb rt,offset(rs)
    store_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_BYTE, p->R[inst.itype.rt]);
    p->pc += 4;
    break;
  case 0x29:    // sh rt,offset(rs)
    store_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_HALF_WORD, p->R[inst.itype.rt]);
    p->pc += 4;
    break;
  case 0x2b:    // sw rt,offset(rs)
    store_mem(p->R[inst.itype.rs] + signExtension(inst.itype.imm), SIZE_WORD, p->R[inst.itype.rt]);
    p->pc += 4;
    break;
  default:      // undefined opcode
    fprintf(stderr, "%s: pc=%08x, illegal instruction: %08x\n", __FUNCTION__, p->pc, inst.bits);
    exit(-1);
    break;
  }

  // enforce $0 being hard-wired to 0
  p->R[0] = 0;

  if(print_regs)
    print_registers(p);
}

void init_processor(processor_t* p)
{
  int i;

  /* initialize pc to 0x1000 */
  p->pc = 0x1000;

  /* zero out all registers */
  for (i=0; i<32; i++)
  {
    p->R[i] = 0;
  }
}

void print_registers(processor_t* p)
{
  int i,j;
  for (i=0; i<8; i++)
  {
    for (j=0; j<4; j++)
      printf("r%2d=%08x ",i*4+j,p->R[i*4+j]);
    puts("");
  }
}

void handle_syscall(processor_t* p)
{
  reg_t i;

  switch (p->R[2]) // syscall number is given by $v0 ($2)
  {
  case 1: // print an integer
    printf("%d", p->R[4]);
    break;

  case 4: // print a string
    for(i = p->R[4]; i < MEM_SIZE && load_mem(i, SIZE_BYTE); i++)
      printf("%c", load_mem(i, SIZE_BYTE));
    break;

  case 10: // exit
    printf("exiting the simulator\n");
    exit(0);
    break;

  case 11: // print a character
    printf("%c", p->R[4]);
    break;

  default: // undefined syscall
    fprintf(stderr, "%s: illegal syscall number %d\n", __FUNCTION__, p->R[2]);
    exit(-1);
    break;
  }
}
