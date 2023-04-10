/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #6                                                    ***
*** Experiment #6 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: mux.v Created by Justin Fursov, Mar 29 2023               ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size mux */

module mux(out, a, b, sel);

    parameter Width = 1;  // Default width of the multiplexer
    input [Width-1:0] a, b;  // Input buses A and B
    input sel;  // Selection signal
    output [Width-1:0] out;  // Output bus

    genvar i;
    generate
    for (i = 0; i < Width; i = i + 1) begin: bit_mux
        assign out[i] = (a[i] == b[i])? a[i] : (a[i] & ~sel) | (b[i] & sel);
    end
    endgenerate

endmodule

