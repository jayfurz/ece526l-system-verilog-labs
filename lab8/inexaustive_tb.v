/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: inexhaustive_tb.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the inexhaustive testbench */

`timescale 1ns/1ps

module tb_sum_of_products();

parameter DATA_WIDTH = 4;
reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in, coef11, coef12, coef21, coef22;
wire [2*DATA_WIDTH+1:0] final_sum;

// Instantiate the sum_of_products module
sum_of_products #(
    .DATA_WIDTH(DATA_WIDTH)
) sum_of_products_inst (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .coef11(coef11),
    .coef12(coef12),
    .coef21(coef21),
    .coef22(coef22),
    .final_sum(final_sum)
);

// Clock generator
always
    #5 clk = ~clk;

// Testbench stimulus
initial begin
    // Initialize inputs
    $vcdpluson;
    clk = 0;
    rst = 0;
    data_in = 0;
    coef11 = 0;
    coef12 = 0;
    coef21 = 0;
    coef22 = 0;

    // Apply reset
    rst = 1;
    #10 rst = 0;

    // Monitor the inputs and output
    $monitor("At time %t: data_in=%b coef11=%b coef12=%b coef21=%b coef22=%b final_sum=%b", $time, data_in, coef11, coef12, coef21, coef22, final_sum);

    // Test with all zeros
    #10 data_in = 4'b0000; coef11 = 4'b0000; coef12 = 4'b0000; coef21 = 4'b0000; coef22 = 4'b0000;

    // Test with all ones
    #40 data_in = 4'b1111; coef11 = 4'b1111; coef12 = 4'b1111; coef21 = 4'b1111; coef22 = 4'b1111;

    // Test with alternating bit patterns
    #40 data_in = 4'b0101; coef11 = 4'b1010; coef12 = 4'b0101; coef21 = 4'b1010; coef22 = 4'b0101;

    // Test with a mix of different bit patterns
    #40 data_in = 4'b1001; coef11 = 4'b0011; coef12 = 4'b1100; coef21 = 4'b1010; coef22 = 4'b0110;
    
    // Finish simulation
    #10 $finish;
end

endmodule
