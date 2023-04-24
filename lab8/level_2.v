/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: level_2.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size level 2 instantiation */

`timescale 1ns/1ps

module level_two #(
    parameter DATA_WIDTH = 4
) (
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire [DATA_WIDTH-1:0] coef1,
    input wire [DATA_WIDTH-1:0] coef2,
    output wire [DATA_WIDTH:0] prod_sum
);

// Instance of register1
scalable_register #(.DATA_WIDTH(DATA_WIDTH)) register1 (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(reg1_out)
);

// Instance of multiplier1
scalable_multiplier #(.DATA_WIDTH(DATA_WIDTH)) multiplier1 (
    .A(coef1),
    .B(reg1_out),
    .Y(mult1_out)
);

// Instance of register2
scalable_register #(.DATA_WIDTH(DATA_WIDTH)) register2 (
    .clk(clk),
    .rst(rst),
    .data_in(reg1_out),
    .data_out(reg2_out)
);

// Instance of multiplier2
scalable_multiplier #(.DATA_WIDTH(DATA_WIDTH)) multiplier2 (
    .A(coef2),
    .B(reg2_out),
    .Y(mult2_out)
);

// Instance of adder
scalable_adder #(.DATA_WIDTH(DATA_WIDTH+1)) adder (
    .A(mult1_out),
    .B(mult2_out),
    .S(prod_sum)
);

wire [DATA_WIDTH-1:0] reg1_out, reg2_out;
wire [(2*DATA_WIDTH)-1:0] mult1_out, mult2_out;

endmodule
