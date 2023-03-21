/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #5                                                    ***
*** Experiment #5 8-bit Counter Lab                                     ***
*** ***********************************************************************
*** Filename: counter8.v Created by Justin Fursov, Mar 17 2023       ***
***                                                                     ***
***************************************************************************/

/* This is the counter submodule */

`timescale 1ns/100ps

// 8-bit counter module with configurable width
module counter #(
    parameter Width = 8 // Parameter for configurable counter width
) (
    input clk_i, // Clock input
    input rst_ni, // Active low reset input
    input en_i, // Enable input
    input load_i, // Load input
    input [Width-1:0] data_i, // Data input
    output reg [Width-1:0] cnt_o // Counter output
);

   // Always block for synchronous logic and asynchronous reset 
    always @(posedge clk_i or negedge rst_ni) begin
        // Check for active low reset
        if (!rst_ni) cnt_o <= 0;
        else begin
            // Check if enable is active
            if (en_i) begin
                // Check if load is active
                if (load_i) begin
                    // Load the input data into the counter
                    cnt_o <= data_i;
                end else begin
                    // Increment the counter
                    cnt_o <= cnt_o + 1;
                end
            end
        end
    end
endmodule
                
