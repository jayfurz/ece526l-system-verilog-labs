/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #7 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: multiplier.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size multiplier*/
`timescale 1ns/1ps

module scalable_multiplier #(
    parameter DATA_WIDTH = 4
) (
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    output wire [(2*DATA_WIDTH)-1:0] Y
);

assign Y = A * B;

endmodule
