`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 12:33:21
// Design Name: 
// Module Name: mux 3x1
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


module mux_3x1(
    input [31:0] s1,s2,s3,
    input [1:0] c,
    output reg [31:0] s4
    );
    always @(*)begin
        case(c)
        2'b00: s4<=s1;
        2'b01: s4<=s2;
        2'b10: s4<=s3;
        endcase            
    end
endmodule
