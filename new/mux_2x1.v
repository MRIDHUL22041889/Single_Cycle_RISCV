`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2025 19:32:04
// Design Name: 
// Module Name: mux_2x1
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

module mux_2x1(
    input [31:0] d0,     // Selected when s=0
    input [31:0] d1,     // Selected when s=1
    input  s,
    output [31:0] out
    );
    assign out = s ? d1 : d0; // Standard ternary operator for a mux
endmodule