# Single_Cycle_RISCV
A fully functional single-cycle RISC-V processor implementing the **RV32I** base integer instruction set.
Written in Verilog, this project is built for clarity, modularity — ideal for exploring CPU microarchitecture and digital design fundamentals.

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
## 🧪 Test Program

<details>
<summary><b>Click to view sample RISC-V test program 🔽</b></summary>

<br>

### 🧠 Assembly

# multiply-accumulate test
addi x5, x0, 5
addi x6, x0, 1
addi x11, x0, 0x180

# main_loop:
beq  x5, x0, store_final_result
addi x8, x6, 0
addi x9, x5, 0
addi x10, x0, 0

# multiply_loop:
beq  x9, x0, multiply_done
add  x10, x10, x8
addi x9, x9, -1
jal  x0, multiply_loop

# multiply_done:
addi x6, x10, 0
addi x5, x5, -1
jal  x0, main_loop

# store_final_result:
sw   x6, 0(x11)
jal  x0, 0
</details> ```


##  Supported Instructions
Currently supports the RV32I subset, including:

Arithmetic: ADD, SUB, AND, OR, XOR, SRL, SLL, SAR.

Immediate: ADDI, ANDI, ORI, XORI, SLLI , SRLI, SRAI.

Load/Store: LW, SW

Control flow: BEQ, BNE, BLT, BGE ,JAL

---

## Architecture
It is heavily inspired from the one mentioned in Computer Organization and **Design – Patterson & Hennessy** with slight modifications in control signal by using a Flag register in ALU to implement BLT,BGE etc and each component is written in verilog with a modular design Philosophy making it easy to test each component indepently.

---

## 🛠️ TODO
-Add support for ECALL, LUI, AUIPC

-Add pipelined version

-Implement forwarding and hazard detection

-Write assembler or loader


