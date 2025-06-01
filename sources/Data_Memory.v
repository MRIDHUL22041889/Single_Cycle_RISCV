`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2025 19:43:11
// Design Name: 
// Module Name: Data_Memory
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

module Data_Memory(
    input clk,
    input we,                   // Write Enable
    input [31:0] a,             // Byte Address from ALU
    input [31:0] wd,            // Write Data
    output [31:0] rd            // Read Data (combinational output)
    );

  parameter DATA_WIDTH = 32;
  // Choose a practical size for simulation/synthesis
  // For example, 10 bits for 1024 words (4KB)
  parameter NUM_ADDRESS_BITS_FOR_MEM_ARRAY = 10; // e.g., for a 2^10 = 1024 word memory
  parameter MEM_WORD_COUNT = (2**NUM_ADDRESS_BITS_FOR_MEM_ARRAY);

  // Memory array: Address is word-based
  reg [DATA_WIDTH-1:0] memory_array [0:MEM_WORD_COUNT-1];

  // wire [NUM_ADDRESS_BITS_FOR_MEM_ARRAY-1:0] word_address;
  // Convert byte address 'a' to word_address for the memory_array
  // word_address = a[NUM_ADDRESS_BITS_FOR_MEM_ARRAY + 1 : 2]; // e.g., if NUM_ADDRESS_BITS_FOR_MEM_ARRAY is 10, use a[11:2]

  // Synchronous Write
  always @(posedge clk) begin
    if (we) begin
      // memory_array[word_address] <= wd;
      memory_array[a[NUM_ADDRESS_BITS_FOR_MEM_ARRAY + 1 : 2]] <= wd;
    end
  end

  // Combinational Read (needed for single-cycle LW)
  // assign rd = memory_array[word_address];
  assign rd = memory_array[a[NUM_ADDRESS_BITS_FOR_MEM_ARRAY + 1 : 2]];

  // Optional: Initialize memory (e.g., to zero or from a file)
  // This is often done for simulation. For synthesis, memory initialization
  // might be handled differently (e.g., BRAM initialization files).
  integer i;
  initial begin
    for (i = 0; i < MEM_WORD_COUNT; i = i + 1) begin
      memory_array[i] = 32'h00000000;
    end
    // Or load from file:
    // $readmemh("data_memory_init.mem", memory_array);
    $display("Data_Memory: Initialized %0d words to zero.", MEM_WORD_COUNT);
  end

endmodule