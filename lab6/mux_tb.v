/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #6                                                    ***
*** Experiment #6 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: mux_tb.v Created by Justin Fursov, Mar 29 2023               ***
***                                                                     ***
***************************************************************************/

/* This is the testbench for the variable size mux */
`timescale 1ns / 1ps

module testbench;
reg [5:0] a, b;
wire out1;
wire [3:0] out4;
wire [4:0] out5;
wire [5:0] out6;
reg sel;

mux mux1(
    .out(out1),
    .a(a[0:0]),
    .b(b[0:0]),
    .sel(sel));
mux #(4) mux4(
    .out(out4),
    .a(a[3:0]),
    .b(b[3:0]),
    .sel(sel));
mux #(5) mux5(
    .out(out5),
    .a(a[4:0]),
    .b(b[4:0]),
    .sel(sel));
mux #(6) mux6(
    .out(out6),
    .a(a),
    .b(b),
    .sel(sel));

initial begin
    $vcdpluson;
    $display("Testing all instances simultaneously");
    a = 6'b100111; b = 6'b010000;
    sel = 0;

    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);
    #10 sel = 1;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);
    #10 sel = 0;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);

    a = 6'b011101; b = 6'b101010;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);
    #10 sel = 1;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);

    // Test cases for sel = 1'bx
    sel = 1'bx;
         
    // Case 1: A = B
    a = 6'b110011; b = 6'b110011;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);
    
    // Case 2: A != B
    a = 6'b101101; b = 6'b010010;
    #1 $display("Time: %d, sel: %b, a: %b, b: %b, out1: %b, out4: %b, out5: %b, out6: %b", $time, sel, a, b, out1, out4, out5, out6);

    $finish;
end
endmodule
