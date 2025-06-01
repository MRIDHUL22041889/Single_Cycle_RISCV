`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 15:06:58
// Design Name: 
// Module Name: PC_Target
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


module adder(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] c
    );
    always @(*)begin
        c=a+b;
    end
endmodule
