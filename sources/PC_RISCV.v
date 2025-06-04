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
    input [31:0] a,     
    input  clk,
    input reset,
    output reg [31:0] b 
);
    always @(posedge clk or posedge reset) begin
        if(reset)
            b <= 32'h00000000; // Correct reset to 0
        else
            b <= a;            
    end
endmodule
