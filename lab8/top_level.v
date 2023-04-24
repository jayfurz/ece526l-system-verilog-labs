/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: top_level.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size top_level instantiation */

`timescale 1ns/1ps

module sum_of_products #(
    parameter DATA_WIDTH = 4
) (
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire [DATA_WIDTH-1:0] coef11,
    input wire [DATA_WIDTH-1:0] coef12,
    input wire [DATA_WIDTH-1:0] coef21,
    input wire [DATA_WIDTH-1:0] coef22,
    output wire [2*DATA_WIDTH+1:0] final_sum
);
wire [2*DATA_WIDTH:0] prod_sum1, prod_sum2;
wire [DATA_WIDTH-1:0] reg_2;
wire [DATA_WIDTH-1:0] reg_out;

// Instance of level_two (1)

level_two #(.DATA_WIDTH(DATA_WIDTH)) level_two_inst1 (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .coef1(coef11),
    .coef2(coef12),
    .reg2_out(reg_2),
    .prod_sum(prod_sum1)
);

// Instance of level_two (2)
level_two #(.DATA_WIDTH(DATA_WIDTH)) level_two_inst2 (
    .clk(clk),
    .rst(rst),
    .data_in(reg_2),
    .coef1(coef21),
    .coef2(coef22),
    .reg2_out(reg_out),
    .prod_sum(prod_sum2)
);

// Instance of final adder
scalable_adder #(.DATA_WIDTH(2*DATA_WIDTH+1)) final_adder (
    .A(prod_sum1),
    .B(prod_sum2),
    .S(final_sum)
);


endmodule
