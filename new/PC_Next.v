`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 15:10:23
// Design Name: 
// Module Name: PC_Next
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


module PC_Next(
    input [31:0] pc,
    output reg [31:0] pc_next
    );
    always @(*) begin
        pc_next=pc+4;
    end
endmodule
