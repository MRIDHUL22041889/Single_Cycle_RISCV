`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2025 17:10:45
// Design Name: 
// Module Name: topmodule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
/*
module topmodule(input clk, reset,
                  output [31:0] WriteData, DataAdr,
                  output MemWrite);
    wire [31:0] PC, Instr, ReadData;
    // instantiate processor and memories
     riscvcore rvsingle( clk, reset, PC, Instr, MemWrite, 
DataAdr,  WriteData, ReadData);

    imem imem(PC, Instr);
    
    Data_Memory dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
 endmodule*/


// Inside topmodule.v

module topmodule(input clk, reset,
                  output [31:0] WriteData_out, DataAdr_out, // Renamed to avoid confusion
                  output MemWrite_out);

    wire [31:0] PC_sig, Instr_sig, ReadData_sig; // Internal signals
    wire [31:0] ALUResult_sig; // To connect riscvcore's ALUResult to Data_Memory's address
    wire        MemWrite_sig;  // To connect riscvcore's MemWrite to Data_Memory's we

    // Instantiate processor and memories
     riscvcore rvsingle(
        .clk(clk),
        .reset(reset),
        // Core Outputs
        .PC(PC_sig),
        .MemWrite(MemWrite_sig),    // Output from core
        .ALUResult(ALUResult_sig),  // Output from core (this is the data memory address)
        .WriteData(WriteData_out),  // Output from core (this is data to be written to memory)
                                    // and also an output of topmodule
        // Core Inputs
        .Instr(Instr_sig),
        .ReadData(ReadData_sig)
     );

    imem imem_inst(
        .addr(PC_sig),
        .instruction_out(Instr_sig)
    );

    // Corrected Data_Memory instantiation
    Data_Memory dmem_inst(
        .clk(clk),
        .we(MemWrite_sig),      // Connect to the MemWrite signal from riscvcore
        .a(ALUResult_sig),      // Connect to ALUResult from riscvcore (this is DataAdr)
        .wd(WriteData_out),     // Connect to WriteData from riscvcore
        .rd(ReadData_sig)       // Connect ReadData from dmem back to riscvcore
    );

    // Assign top-level outputs
    // If DataAdr_out is meant to be the address sent to Data Memory:
    assign DataAdr_out = ALUResult_sig;
    // If MemWrite_out is meant to be the MemWrite signal from the core:
    assign MemWrite_out = MemWrite_sig;
    // WriteData_out is already connected directly from riscvcore

 endmodule
