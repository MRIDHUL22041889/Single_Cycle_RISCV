`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 17:47:43
// Design Name: 
// Module Name: Register_file
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

module Register_file(
    input clk,reset,we3,        // 1 = write, 0 = read
    input [4:0] a1,
    input [4:0] a2,
    input [4:0] a3,
    input [31:0] wd3,
    output reg [31:0] rd1,
    output reg [31:0] rd2
);
    reg [31:0] registers [0:31];
    integer i;

    // Reset logic: synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end else begin
            // Write on positive edge of clock if write enabled and not writing to x0
            if (we3 && (a3 != 5'd0)) begin
                registers[a3] <= wd3;
            end
        end
    end

    // Read logic: combinational
always @(*) begin
    // Explicitly ensure x0 always reads as 0
    if (a1 == 5'd0) begin
        rd1 = 32'd0;
    end else begin
        rd1 = registers[a1];
    end

    if (a2 == 5'd0) begin
        rd2 = 32'd0;
    end else begin
        rd2 = registers[a2];
    end
end
endmodule
