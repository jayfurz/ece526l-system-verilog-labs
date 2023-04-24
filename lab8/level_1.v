/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: level_1.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size adder, multiplier and register
*  which is the first level of the triple level heirarchy.                  */

`timescale 1ns/1ps

module scalable_register #(
    parameter DATA_WIDTH = 4
) (
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_out <= 0;
    end else begin
        data_out <= data_in;
    end
end

endmodule

module scalable_multiplier #(
    parameter DATA_WIDTH = 4
) (
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    output wire [(2*DATA_WIDTH)-1:0] Y
);

assign Y = A * B;

endmodule

module scalable_adder #(
    parameter DATA_WIDTH = 4
) (
    input wire [DATA_WIDTH-1:0] A,
    input wire [DATA_WIDTH-1:0] B,
    output wire [DATA_WIDTH:0] S
);

assign S = A + B;

endmodule
