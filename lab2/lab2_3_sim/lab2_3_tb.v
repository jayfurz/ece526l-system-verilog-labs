/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #2 ***                                         ***
*** Experiment #2 Delays and Primitive Gates Lab     ***                ***
*** ***********************************************************************
*** Filename: lab2_complete_tb.v Created by Justin Fursov, Feb 16 2023  *** 
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

/* This testbench checks the full suite of test cases from lab2_complete.v *
* This one initializes from the module named Lab2_1 *
* This test bench was done with the delays set and without delays *
* to compare. */

`timescale 1 ns/ 100 ps


`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | out = %b || A1 = %b, A2 = %b, NT = %b, O1 = %b"

module Lab2_2_tb();
    reg in1, in2;
    wire out;
    Lab2_2 UUT(.in1 (in1),
        .in2 (in2),
        .out1 (out));

    initial begin
        $monitor(`MONITOR_STR_1, $time, in1, in2, out, UUT.A1, UUT.A2, UUT.NT, UUT.O1);
    end

    initial begin
        $vcdpluson;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 in1 = 1'b0;
            in2 = 1'b1;
        #15 in1 = 1'b1;
            in2 = 1'b1;
        #15 in1 = 1'b1;
            in2 = 1'b0;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 $finish;
    end
endmodule
