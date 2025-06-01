module riscvcore(
    input clk, reset,
    output [31:0] PC,
    input [31:0] Instr,
    output MemWrite,
    output [31:0] ALUResult,
    output [31:0] WriteData,
    input [31:0] ReadData
);

    wire PCSrc;
    wire [1:0] ResultSrc;
    wire [2:0] ALUControl;
    wire ALUSrc;
    wire [1:0] ImmSrc;
    wire RegWrite;
    wire [2:0] Flag;

    // Control Unit instantiation
    control_unit CU (
        .opcode(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7(Instr[30]),
        .Flag(Flag),
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

    // Datapath instantiation
    datapath dp (
        .clk(clk),
        .reset(reset),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .ReadData(ReadData),
        .Instr(Instr),
        .Flag(Flag),
        .PC(PC),
        .ALUResult(ALUResult),
        .WriteData(WriteData)
    );

endmodule
