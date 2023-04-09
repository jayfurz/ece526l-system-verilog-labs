/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #6                                                    ***
*** Experiment #6 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: mux_tb.v Created by Justin Fursov, Mar 29 2023              ***
***                                                                     ***
***************************************************************************/

/* This is the testbench for the variable size mux */

`timescale 1ns/100ps

module mux_tb();
reg a, b, sel;
wire out;
mux mux1(out, a, b, sel);

initial begin
    $vcdpluson;
    $display("This is the test of the one wide multiplexer");
    //$monitor("%d: The output is: %b, the sel: %b, a: %b, b: %b", $time, out, sel, a, b);
    $display("%d: The output is: %b, the sel: %b, a: %b, b: %b", $time, out, sel, a, b);
    a = 1; b = 0;
    sel = 0;
    #1;
    $display("%d: The output is: %b, the sel: %b, a: %b, b: %b", $time, out, sel, a, b);
    #10 sel = 1;
    #1;
    $display("%d: The output is: %b, the sel: %b, a: %b, b: %b", $time, out, sel, a, b);
    #10 sel = 0;
    #1;
    $display("%d: The output is: %b, the sel: %b, a: %b, b: %b", $time, out, sel, a, b);
    $finish;
end
endmodule
