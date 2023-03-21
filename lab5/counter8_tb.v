/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #5                                                    ***
*** Experiment #5 8-bit Counter Lab                                     ***
*** ***********************************************************************
*** Filename: counter8_tb.v Created by Justin Fursov, Feb 27  2023      ***
***                                                                     ***
***************************************************************************/

/* This is the testbench to check if the counter module works correctly */


`timescale 1ns/100ps

module counter8_tb();

    // Inputs
    reg en_i, clk_i, rst_ni, load_i;
    reg [7:0] data_i;

    // Outputs
    wire [7:0] cnt_o;

    // Instantiate the top-level design
    counter_8_bit u_counter (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .load_i(load_i),
        .en_i(en_i),
        .data_i(data_i),
        .cnt_o(cnt_o)
    );

    // Initial block for initializing signals
    initial begin
        $vcdpluson;
        clk_i = 0;
    end

    // Clock generator with a 20 ns period
    always begin
        #10 clk_i = ~clk_i;
    end

    // Test sequence
    initial begin
        $monitor("%d: The value of counter is %d. rst_ni: %d", $time, cnt_o, rst_ni);

        // Asynchronous reset
        #20 rst_ni = 0;
        #20 rst_ni = 1;

        // Enable the counter
        #20 en_i = 1;

        // Increment the counter
        #180;

        // Parallel load 240 decimal
        #20 load_i = 1; data_i = 240;
        #20 load_i = 0;

        // Count from 240 until roll over
        #400;

        // Reset overrides both load and increment
        #20 rst_ni = 0;
        #20 rst_ni = 1;

        // Correct functioning of enable
        #20 en_i = 0;
        #80 en_i = 1;

        // Finish the simulation
        #200;
        $finish;
    end

endmodule

