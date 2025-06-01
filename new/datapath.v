`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 25.05.2025 23:00:51
// Design Name:
// Module Name: datapath
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
module datapath(input clk, reset,
                input PCSrc,
                input [1:0] ResultSrc,
                input MemWrite,
                input [2:0] ALUControl,
                input ALUSrc,
                input [1:0] ImmSrc,
                input RegWrite,
                input [31:0] ReadData,
                input [31:0] Instr,
                output [2:0] Flag,
                output [31:0] PC,
                output [31:0] ALUResult,WriteData);
                wire [31:0] PCNext, PCPlus4, PCTarget;
    wire [31:0] ImmExt;
    wire [31:0] SrcA, SrcB;
    wire [31:0] Result;
    // next PC logic
    PC PC1(PCNext,clk,reset,PC);
    adder pcadd4(PC, 32'd4, PCPlus4);
    adder pcaddbranch(PC, ImmExt, PCTarget);
    mux_2x1 pcmux(PCPlus4, PCTarget, PCSrc, PCNext);
    // register file logic
    Register_file rf(clk,reset, RegWrite, Instr[19:15], Instr[24:20],
                        Instr[11:7], Result, SrcA, WriteData);
    extend ext(Instr[31:7], ImmSrc, ImmExt);
    // ALU logic
    mux_2x1 srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
    ALU alu(SrcA, SrcB, ALUControl,1'b0, ALUResult, Flag);
    mux_3x1 resultmux( ALUResult, ReadData, PCPlus4,ResultSrc, Result);
endmodule