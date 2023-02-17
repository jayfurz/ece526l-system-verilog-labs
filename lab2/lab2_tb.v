/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #2 ***                                         ***
*** Experiment #2 Delays and Primitive Gates Lab     ***                ***
*** ***********************************************************************
*** Filename: lab2_tb.v Created by Justin Fursov, Feb 16 2023 ***       ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

/* This module is a testbench module to test all the different combinations *
* of inputs. *
* the reg in1 and in2 are set to all the possible combinations, which is 2^2 *
* The module from lab2.v is initialized as UUT using port mapping *
* I have more test cases because I wanted to do all the test cases in reverse
* in case there is any change due to delays */


`timescale 1 ns/ 1 ns

`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | out = %b || A1 = %b, A2 = %b, NT = %b"

module Lab2_1_tb();
    reg in1, in2;
    wire out;
    Lab2_1 UUT(.in1 (in1),
        .in2 (in2),
        .out1 (out));

    initial begin
        $monitor(`MONITOR_STR_1, $time, in1, in2, out, UUT.A1, UUT.A2, UUT.NT);
    end

    // Run all the test cases
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
        #15 in1 = 1'b1;
            in2 = 1'b0;
        #15 in1 = 1'b1;
            in2 = 1'b1;
        #15 in1 = 1'b0;
            in2 = 1'b1;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 $finish;
    end
endmodule
