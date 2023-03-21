/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #5                                                    ***
*** Experiment #5 8-bit Counter Lab                                     ***
*** ***********************************************************************
*** Filename: top_counter.v Created by Justin Fursov, Mar 17 2023       ***
***                                                                     ***
***************************************************************************/

// This is the top module that includes the AASD reset module and the variable
// width counter submodule

`timescale 1ns / 100ps

// Top-level module for an 8-bit counter with AASD reset functionality
module counter_8_bit (
input clk_i, // Clock input
input rst_ni, // Active low reset input
input en_i, // Enable input
input load_i, // Load input
input [7:0] data_i, // Data input
output [7:0] cnt_o // Counter output
);

// Instantiating counter module with aasd_rst signal
counter counter1(
    .clk_i(clk_i),
    .rst_ni(aasd_rst),
    .en_i(en_i),
    .load_i(load_i),
    .data_i(data_i),
    .cnt_o(cnt_o)
);

// Asynchronous Active Low Set Dominant (AASD) reset signal
wire aasd_rst;

// Instantiating AASD reset module
aasd_reset aasd1(
    .rst_ni(rst_ni),
    .clk_i(clk_i),
    .aasd_rst_o(aasd_rst)
);

endmodule
