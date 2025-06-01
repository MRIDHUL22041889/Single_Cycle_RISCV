`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 17:27:01
// Design Name: 
// Module Name: PC_RISCV
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


module PC(
    input [31:0] a,     // This is PCNext from datapath
    input  clk,
    input reset,
    output reg [31:0] b  // This is PC (output)
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            b <= 32'h00000000; // Correct reset to 0
        else
            b <= a;            // CORRECTED: Simply store the input 'a'
    end
endmodule