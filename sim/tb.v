`timescale 1ns/1ps 

module tb_topmodule; // Your testbench module name

    // Parameters
    parameter CLOCK_PERIOD = 10; // ns (e.g., for a 100 MHz clock -> 10ns period)

    // Inputs to the topmodule (UUT)
    reg clk;
    reg reset;

    // Outputs from the topmodule (UUT) to monitor
    // These names should match the wires connected to the UUT instance below
    wire [31:0] WriteData_mon;
    wire [31:0] DataAdr_mon;
    wire        MemWrite_mon;

    // Instantiate the Unit Under Test (UUT)
    // Ensure 'topmodule' is the name of your top Verilog module
    // and the port names (.clk, .reset, .WriteData_out, etc.)
    // exactly match the ports defined in your topmodule.v file.
    topmodule uut (
        .clk(clk),
        .reset(reset),
        // Connect to UUT's output ports
        .WriteData_out(WriteData_mon),
        .DataAdr_out(DataAdr_mon),
        .MemWrite_out(MemWrite_mon)
    );

    // Clock Generation
    initial begin
        clk = 0; // Start clock low
        forever #((CLOCK_PERIOD)/2) clk = ~clk; // Toggle every half period
    end

    // Test Sequence
    initial begin
        // 1. Initialize signals and apply reset
        $display("[%0t ns] Testbench: Starting simulation. Asserting reset.", $time);
        reset = 1; // Assert reset (active high)

        // Wait for a couple of clock cycles while reset is active
        // This ensures all synchronous elements see the reset.
        repeat(2) @(posedge clk);
        // Or, wait for a fixed duration: #(2 * CLOCK_PERIOD);

        // 2. De-assert reset
        $display("[%0t ns] Testbench: De-asserting reset. Processor should start fetching.", $time);
        reset = 0; // De-assert reset

        // 3. Let processor run for a number of cycles
        // Adjust the number of cycles based on your test program length
        // For Program 1 (3 ADDI instructions + JAL), 10 cycles should be enough to see the loop.
        $display("[%0t ns] Testbench: Letting processor run...", $time);
        #(109 * CLOCK_PERIOD); // Run for 15 clock cycles after reset

        // 4. Add specific checks here (optional, but good practice for automated testing)
        // Example:
        // if (uut.rvsingle.dp.rf.RAM[1] == 32'd5) begin // Check x1 after first ADDI
        //     $display("[%0t ns] Testbench: SUCCESS - x1 is 5.", $time);
        // end else begin
        //     $display("[%0t ns] Testbench: FAILURE - x1 is %h, expected 5.", $time, uut.rvsingle.dp.rf.RAM[1]);
        // end
        // Note: Hierarchical access uut.rvsingle.dp.rf.RAM[1] depends on simulator capabilities
        // and correct instance names.

        // 5. Finish simulation
        $display("[%0t ns] Testbench: Finishing simulation.", $time);
        $finish;
    end

    // Waveform Dumping (for Vivado XSIM and other simulators)
    initial begin
        // The .wdb file is Vivado's native database.
        // .vcd is a standard format viewable by GTKWave, etc.
        // XSIM will generate a .wdb regardless; $dumpfile might create an additional .vcd.
        $dumpfile("waveform.vcd");
        // Ensure 'tb_topmodule' here matches YOUR testbench module name above.
        $dumpvars(0, tb_topmodule); // Dump all signals in this testbench and all modules below it.
    end

endmodule