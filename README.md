# 16-bit RISC-V Inspired Microprocessor  
Implementation in **Verilog** with **Vivado Simulation**

## Overview
This project implements a **16-bit microprocessor with 8 general-purpose registers** and a simplified instruction set.  
It was developed as part of my educational hardware design course in uni, focusing on **clarity, functionality, and testability** rather than raw efficiency.  

The design demonstrates a full **instruction execution pipeline** (fetch, decode, execute, write-back) and integrates key processor components:
- Program Counter (PC)  
- Register File (8 registers, 16-bit each)  
- Arithmetic Logic Unit (ALU with full adder)  
- Instruction Decoder  
- Memory (ROM/RAM with synchronous read/write support)

> 🔹 This repository is intended to showcase hardware design skills in **digital logic, Verilog HDL, simulation/debugging, and processor architecture**. If you are interested in the details of the learning journey and testing details, please read report.pdf 

---

## Features
- **16-bit architecture**  
- **8 general-purpose registers** (X0 hardwired to zero, others configurable)  
- **Instruction Set Architecture (ISA)** including:  
  - `ADD`, `ADDI`, `SUBI`  
  - `BEQ` (branch if equal), `JALR` (jump and link)  
  - `LUI` (load upper immediate)  
  - Optional memory operations: `SW` (store word), `LW` (load word)  
- **Word-addressable memory** (synchronous, avoids propagation delay issues)  
- **ALU with full adder**, supporting signed operations and immediate handling  
- **Test programs included**, e.g. multiplication via loops  
- Designed and tested using **Vivado** with waveform verification, please check img folder for screenshots of the testing

---

## Architecture
### Processor Components
- **Top Module**: Integrates PC, registers, memory, decoder, and ALU.  
- **Memory**: Supports both instruction fetch and data read/write with synchronization on clock edges.  
- **Decoder**: Uses internal multiplexers to extract operands and immediates from instructions.  
- **ALU**: Performs addition, subtraction, branching logic, and memory address calculation.  
- **Full Adder**: Built from cascaded half-adders to support 16-bit addition.  

**Simplified Data Flow**  
```
PC → Memory → Decoder → ALU → Registers/Memory → PC (update)
```

---

## Example Assembly Program
Example: Multiplying `123 × 6`, storing result in memory, then reading it back.

Feel free to read the whole program that tests each instruction in the instruction set
saved as Finalbi assembly.txt

```assembly
LUI   r2, 2       // r2 = 128
SUBI  r2, r2, 5   // r2 = 123
ADDI  r3, r0, 6   // r3 = 6
ADDI  r5, r0, 10  // store subroutine address in r5
JALR  r6, r5      // jump to subroutine, save return addr in r6

SW    r1, r0, 63  // store result at mem[63]
LW    r7, r0, 63  // load result back into r7
```

---

## Testing and Debugging
- Each module (Memory, Decoder, ALU) was tested **individually** before system integration.  
- A bug with asynchronous memory writes (causing unintended overwrites) was resolved by synchronizing writes to the clock edge.  
- Waveforms were analyzed to confirm correct signal propagation across all modules.  
- Testbenches include:
  - Arithmetic and branching programs  
  - Memory read/write stress tests  
  - End-to-end execution of assembly routines  

---

## Results
- Successfully executes arithmetic, branching, and memory operations.  
- Verified with multiple assembly programs.  
- Educational value: provides clear insight into **how processors execute instructions** at the hardware level.  

---

## Lessons Learned
- Practical understanding of **instruction decoding and ALU design**  
- Importance of **synchronization** in memory read/write cycles  
- Experience debugging propagation delay issues in Verilog  
- Bridging theoretical knowledge (assembly & digital logic) with real implementation  

---

## Future Improvements
- Add support for more RISC-V instructions (e.g., NAND, MUL).  
- Implement pipelining for higher efficiency.  
- Explore FPGA synthesis and performance analysis (timing, utilization).  
- Optimize memory design for scalability.  

