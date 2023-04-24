/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: adder.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size adder*/

`timescale 1ns/1ps

module scalable_adder #(
    parameter DATA_WIDTH = 4
) (
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    output wire [DATA_WIDTH:0] S
);

assign S = A + B;

endmodule
