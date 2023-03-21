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
    // Testbench signals
    reg en_i, clk_i, rst_ni, load_i; // Control signals
    reg [7:0] data_i;                // Data input signal
    wire [7:0] cnt_o;                // Counter output signal
    wire aasd_rst;                   // Unused reset signal

    // Instantiating the 8-bit counter module
    counter_8_bit u_counter (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .load_i(load_i),
        .en_i(en_i),
        .data_i(data_i),
        .cnt_o(cnt_o)
    );

    // Clock generation
    initial begin
        $vcdpluson; // Turn on VCD+ output
        clk_i = 0;  // Initialize clock signal to low
    end

    always begin
        #50 clk_i = ~clk_i; // Toggle clock signal every 50 time units
    end

    // Testbench stimulus
    initial begin
        // Monitor output and reset signal during simulation
        $monitor("%d: The value of counter is %d. rst_ni: %d", $time, cnt_o, rst_ni);
        
        // Reset and enable signals sequence
        #100 rst_ni = 0;    // Assert reset
        #100 rst_ni = 1;    // Deassert reset
        #100 en_i = 1;      // Enable counter
        
        // Load data into the counter
        #900 load_i = 1; data_i = 240; // Load 240 into the counter
        #100 load_i = 0;               // Deassert load signal

        // Reset counter again
        #2000 rst_ni = 0; // Assert reset
        #100 rst_ni = 1;  // Deassert reset

        #400; // Wait for 400 time units

        $finish; // End the simulation
    end
endmodule
