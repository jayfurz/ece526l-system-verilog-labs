/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #5                                                    ***
*** Experiment #5 8-bit Counter Lab                                     ***
*** ***********************************************************************
*** Filename: aasd.v Created by Justin Fursov, Mar 17 2023              ***
***                                                                     ***
***************************************************************************/

/* This is the Asynchronous Active Low Set Dominant Reset Module */

`timescale 1ns/100ps

// Asynchronous Active Low Set Dominant Reset Module
module aasd_reset (
    input rst_ni, // Active low reset input
    input clk_i, // Clock input
    output reg aasd_rst_o // Asynchronous active low set dominant reset output
);

    reg q; // Intermediate register to store previous reset input value

    // Always block for synchronous logic
    always @ (posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin // If reset is active (low)
            aasd_rst_o <= 0; // Assert output reset signal
            q <= 0; // Reset the intermediate register
        end else begin
            q <= rst_ni; // Store the current reset input value in the intermediate register
            aasd_rst_o <= q; // Assign the intermediate register value to the output reset signal
        end
    end
endmodule

