/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #6                                                    ***
*** Experiment #6 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: mux.v Created by Justin Fursov, Mar 29 2023              ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size mux */

`timescale 1ns/100ps

module mux(out, a, b, sel);

parameter Width = 1;
input [Width-1:0] a, b;
input sel;
output [Width-1:0] out;

assign    out = (sel? b: a); //  two bits are not the same and sel is x
endmodule
