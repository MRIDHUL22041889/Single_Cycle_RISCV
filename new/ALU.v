`timescale 1ns / 1ps

/*Operation	RISC-V Mnemonics	ALU Type	Description
    ADD     add, addi	          Arithmetic	A + B
    SUB	    sub	                   Arithmetic	A - B
    AND	    and, andi	           Logical	   A & B
    OR	     or, ori	            Logical	    `A
    XOR	    xor, xori	          Logical	    A ^ B
    SLL	    sll, slli	          Shift	      Shift Left Logical
    SRL	    srl, srli	          Shift	      Shift Right Logical
    SRA	    sra, srai	          Shift	      Shift Right Arithmetic
    */

module ALU (
    input signed [31:0] a,
    input signed [31:0] b,
    input [2:0] opcode,
    input cin,
    output reg signed [31:0] out,
    output reg [2:0] status_reg=3'b000  // [ZF,SIGN_FLAG,CARRY_FLAG]
);
    always @(*) begin
        case (opcode)
            3'b000: begin  // ADD
                out = a + b + cin;
                status_reg[0] = (out == 0);         // Zero Flag
                status_reg[1] = out[31];            // Sign Flag
                status_reg[2] = (a[31] == b[31]) && (out[31] != a[31]); // Carry/Overflow Flag
            end
            3'b001: begin  // SUB
                out = a - b - cin;
                status_reg[0] = (out == 0);
                status_reg[1] = out[31];
                status_reg[2] = (a[31] != b[31]) && (out[31] != a[31]);
            end
            3'b010: begin  // AND
                out = a & b;
                status_reg[0] = (out == 0);
                status_reg[1] = out[31];
            end
            3'b011: begin  // OR
                out = a | b;
                status_reg[0] = (out == 0);
                status_reg[1] = out[31];
            end
            3'b100: begin  // XOR
                out = a ^ b;
                status_reg[0] = (out == 0);
                status_reg[1] = out[31];
            end
            3'b101: begin  // SHIFT LOGICAL RIGHT 
                out = a << b;
                status_reg[0] = (out == 0);
                status_reg[1] = out[31];
            end
            3'b110: begin      // SHIFT LOGICAL LEFT
                    out = a >> b;
                    status_reg[0] = (out == 0);
                    status_reg[1] = out[31];
            end
            3'b111: begin            // ARITHHMETIC RIGHT SHIFT
                    out = a <<< b;
                    status_reg[0] = (out == 0);
                    status_reg[1] = out[31];
            end
            default: begin
               out = 8'b0; // Default value to avoid latching (and potentially X)
               status_reg = 3'b000; // and ensure status is initialized
            end
        endcase
    
    end
endmodule
