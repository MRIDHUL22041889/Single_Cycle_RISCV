`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 18:50:10
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7,
    input [2:0] Flag,
    input clk, reset,
     output reg PCSrc,
     output reg [1:0] ResultSrc,
     output reg MemWrite,
     output reg [2:0] ALUControl,
     output reg ALUSrc,
     output reg [1:0] ImmSrc,
     output reg RegWrite
    );
    wire rtype;
    wire itype;
    wire load;
    wire store;
    wire branch;
    wire jal;
    wire jalr;
    reg is_less;
    reg is_great;
    reg is_equal;
    
    assign rtype  = (opcode == 7'b0110011);
    assign itype  = (opcode == 7'b0010011); // I-type (ALU Immediate, Load)
    assign load   = (opcode == 7'b0000011);
    assign store  = (opcode == 7'b0100011);
    assign branch = (opcode == 7'b1100011);
    assign jal    = (opcode == 7'b1101111);
    assign jalr   = (opcode == 7'b1100111);

    always @(*) begin
        RegWrite    = 1'b0;
        ImmSrc      = 2'b00; // Default: Sign extend immediate
        ALUSrc      = 1'b0;  // Default: Operand B from register
        MemWrite    = 1'b0;
        ResultSrc   = 2'b00; // Default: ALU result
        PCSrc       = 1'b0;
        ALUControl  = 3'b000; // Default: ADD
        is_equal = 0;
        is_great = 0;
         is_less  = 0;

        if(rtype)begin      //R TYPE
            RegWrite=1'b1;
            case (funct3)
                3'h00: begin  // ADD, SUB
                    if (funct7 ==1'b0) begin  // AND funct7 for ADD and SUB
                        ALUControl = 3'b000;  // ADD
                    end 
                    else begin
                        ALUControl = 3'b001;  // SUB
                    end
                end
                3'h07: ALUControl=3'b010;        //AND
                3'h06: ALUControl=3'b011;        //OR
                3'h04: ALUControl=3'b100;        //XOR
                3'h05: begin  // SLR, SAR
                    if (funct7 == 1'b0) begin  // SLR funct7 for SAR and SLR
                        ALUControl = 3'b110;  // SLR
                    end 
                    else begin
                        ALUControl = 3'b111;  // SAR
                    end
                end
                3'h01: ALUControl=3'b101;        //SLL
            endcase
        end
        
        else if(itype)begin      //I TYPE
            RegWrite=1'b1;
            ImmSrc=2'b00;
            ALUSrc=1'b1;
            
            case (funct3)
                3'h00: ALUControl = 3'b000;  // ADD
                3'h07: ALUControl=3'b010;        //AND
                3'h06: ALUControl=3'b011;        //OR
                3'h04: ALUControl=3'b100;        //XOR
                3'h05:begin 
                    if(funct7==0) ALUControl = 3'b110;     // SLR
                    else ALUControl = 3'b111;     // SAR
                end
                3'h01: ALUControl=3'b101;        //SLL
            endcase
        end
        else if(load)begin      //L TYPE
            RegWrite=1'b1;
            ImmSrc=2'b00;
            ALUSrc=1'b1;
            ALUControl = 3'b000;
            ResultSrc=2'b01;
        end
        else if(branch)begin                                 //NOT COMPLETED
            ImmSrc=2'b10;
            ALUControl = 3'b001;
            is_equal = (Flag[0] == 1'b1);
            is_less = (Flag[1] == 1'b1);
            is_great = (Flag[1] == 1'b0);
            case (funct3)
                3'h0: if(is_equal)PCSrc=1'b1;
                3'h1: if(!is_equal)PCSrc=1'b1;
                3'h4: if(is_less)PCSrc=1'b1;
                3'h5: if(is_equal & is_great)PCSrc=1'b1;
            endcase
        end 
        else if(store)begin
            ImmSrc=2'b01;
            ALUSrc=1'b1;
            MemWrite=1'b1;
            
        end
        else if(jal)begin
            RegWrite=1'b1;
            ImmSrc=2'b11;
            ResultSrc=2'b10;
            PCSrc=1'b1;
        end
    end
   
endmodule
