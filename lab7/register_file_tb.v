/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Register File Lab                       ***
*** ***********************************************************************
*** Filename: register_tb.v Created by Justin Fursov, Apr 5 2023        ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size registe file */
`timescale 1ns/1ps

module register_file_tb(data_io);

    // Parameters
    localparam Width = 8;
    localparam Depth = 5;

    // Signals
    reg oe;
    reg cs_n;
    reg ws;
    reg [Depth-1:0] address;
    inout [Width-1:0] data_io;
    reg [Width-1:0] data_reg;
    reg [31:0] i;

    // Instantiate the register file module
    register_file #(Width, Depth) register_file_inst(
        .oe_i(oe),
        .cs_ni(cs_n),
        .ws_i(ws),
        .address_i(address),
        .data_io(data_io)
    );
    reg [511:0] monitor_string;
    reg passed;
    // Drive data_io with data_reg when writing
    assign data_io = data_reg;

    // Test bench stimulus
    initial begin
        
        $vcdpluson;
        // Passed variable stays at 1 unless fail
        passed = 1;

        // Reset
        oe = 1'b0;
        cs_n = 1'b1;
        ws = 1'b0;
        address = 0;
        data_reg = 'bz;

        // Test A: Write to and read from every memory location 
        // Test B covers this test.
        i = 0;
        for (i = 0; i < 32; i=i+1) begin
            // Write data
            #10 cs_n = 1'b0;
            #10 ws = 1'b0;
            #10 address = i;
            #10 data_reg = i;
            #10 ws = 1'b1;
            #10 cs_n = 1'b1;
        end

        // Test B: Block read
        #10 cs_n = 1'b0;
        #10 data_reg = 'bz;
        for (i = 0; i < 32; i=i+1) begin
            // Read data
            #10 oe = 1'b1;
            #10 address = i;
            #10;
            if (data_io !== i) begin
                $sformat(monitor_string, "Test B: FAILED, expected: %0d, got: %0d", i, data_io);
                $display("%s", monitor_string);
                passed = 0;
            end
        end
        if (data_io !== 31) begin
            $sformat(monitor_string, "Test B: FAILED, expected: %0d, got: %0d", i, data_io);
            $display("%s", monitor_string);
            passed = 0;
        end else if (passed) begin
            $display("Test A: PASSED\nTest B: PASSED");
        end
        #10 cs_n = 1'b1;


        // Test C: Enabled and disabled states
        #10 cs_n = 1'b0; // Enabled state
        #10 cs_n = 1'b1; // Disabled state
        #10 address = 3;
        #10;

        if (data_io == 3) begin
            $sformat(monitor_string, "Test C: FAILED, expected: 31, got: %0d", data_io);
            $display("%s", monitor_string);
            passed = 0;
        end else begin
            $display("Test C: PASSED");
        end

        // Test D: High impedance state
        #10 cs_n = 1'b1;
        #10 oe = 1'b0;
        #10;

        if (data_io != 'bz) begin
            $sformat(monitor_string, "Test D: FAILED, expected: 'bz, got: %0d", data_io);
            $display("%s", monitor_string);
            passed = 0;
        end else begin
            $display("Test D: PASSED");
        end

        // Test E: Demonstrate 32 locations in the memory
        // Same as Test A
        if (passed)
            $display("Test E: PASSED");

        // Test F: Walking ones
        for (i = 0; i < Width; i=i+1) begin
            // Write data
            #10 cs_n = 1'b0;
            #10 ws = 1'b0;
            #10 address = i;
            #10 data_reg = 1 << i;
            #10 ws = 1'b1;

            // Read data
            #10 data_reg = 'bz;
            #10 oe = 1'b1;
            #10;
            if (data_io !== (1 << i)) begin
                $sformat(monitor_string, "Test F: FAILED at address %0d, expected: %0b, got: %0b", i, (1 << i), data_io);
                $display("%s", monitor_string);
                passed = 0;
            end 
        end
        if (passed)
            $display("Test F: PASSED");


        // Finish the simulation
        #10 $finish;
    end

endmodule
