# Single_Cycle_RISCV
This project is an implementation of a **single cycle RISC V core** that supports **RV32I base integer instruction set**, it is written in Verilog and is designed for simplicity making it ideal for educational purposes.

---

## 🔧 Features

- Single-cycle CPU architecture
- Supports RV32I instruction set
- Instruction fetch, decode, execute, memory, and write-back handled in one clock cycle
- Modular Verilog design (ALU, control unit, register file, etc.)
- Testbench included for simulation and validation

---
## 📁 Directory Structure

riscv-core/  

├── sources/ # Verilog source files  

├── sim/ # Testbench and sample programs  

├── docs/ # Architecture diagrams and documentation  

├── README.md  



---

📜 Supported Instructions
Currently supports the RV32I subset, including:

Arithmetic: ADD, SUB, AND, OR, XOR, SRL, SLL, SAR.

Immediate: ADDI, ANDI, ORI, XORI, SLLI , SRLI, SRAI.

Load/Store: LW, SW

Control flow: BEQ, BNE, BLT, BGE ,JAL

---

Architecture
It is heavily inspired from the one mentioned in Computer Organization and **Design – Patterson & Hennessy** with slight modifications in control signal by using a Flag register in ALU to implement BLT,BGE etc and each component is written in verilog with a modular design Philosophy making it easy to test each component indepently.

---

🛠️ TODO
-Add support for ECALL, LUI, AUIPC

-Add pipelined version

-Implement forwarding and hazard detection

-Write assembler or loader


