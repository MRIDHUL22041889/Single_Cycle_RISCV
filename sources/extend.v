`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2025 21:28:10
// Design Name: 
// Module Name: extend
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


module extend(
    input [31:7] a,
    input [1:0] imsrc,
    output reg [31:0]b
    );
    //wire signed [31:0]t;  // Removed, not used
    //b=h'00000000;  // Removed, this is wrong
    always @(*) begin // Changed to combinatorial always block.
        b = 32'b0;  // Set a default value. Important to avoid latches.

        case(imsrc)
            2'b00:begin             //I TYPE {{20{Instr[31]}}, Instr[31:20]}
              b = { {20{a[31]}}, a[31:20] }; // I-type.  Assume a[31] is the sign bit for extension
            end
            2'b01:begin             //S TYPE{{20{Instr[31]}}, Instr[31:25], Instr[11:7]}
                b = { {20{a[31]}}, a[31:25], a[11:7] }; // S-type. Assume a[31] is the sign bit
            end
            //B TYPE{{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}
            2'b10:begin  
                 b = { {20{a[31]}}, a[7], a[30:25], a[11:8], 1'b0 }; // B-type instruction extension
            end
            2'b11:begin //J TYPE
                b = {{12{a[31]}}, a[19:12], a[20], a[30:21], 1'b0 };
            end
            default: b = 32'b0; //Handles case when imsrc isn't handled.
        endcase
    end
endmodule