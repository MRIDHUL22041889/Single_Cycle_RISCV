`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 19:24:52
// Design Name: 
// Module Name: Instruction_memory
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




module imem(input [31:0] addr,
            output [31:0] instruction_out);
    reg [31:0] RAM[63:0];
    initial begin
       $readmemh("C:\\Users\\rvmri\\.Xilinx\\project_2\\project_2.srcs\\sources_1\\new\\riscvtest.txt",RAM);
       $display("imem: Loaded instruction from riscvtest.txt, RAM[0] = %h", RAM[0]);
    end
    assign instruction_out = RAM[addr[31:2]]; // word aligned
 endmodule
