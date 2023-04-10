/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #6                                                    ***
*** Experiment #6 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: mux.v Created by Justin Fursov, Mar 29 2023               ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size mux */

`timescale 1ns/100ps

module mux(out, a, b, sel);

parameter Width = 1;
input [Width-1:0] a, b;
input sel;
output reg [Width-1:0] out;
reg [31:0] count;

always @ (a,b,sel) begin
    count = 0;
    while (count < Width) begin
        if (a[count] == b[count]) begin
            out[count] <= a[count];
        end else if (~sel) begin
            out[count] <= a[count];
        end else if (sel) begin
            out[count] <= b[count];
        end else out[count] <= sel;
        count = count + 1;
    end
end

endmodule
