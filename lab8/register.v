/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #7 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: register.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size register*/

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
