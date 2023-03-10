/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #2 ***                                         ***
*** Experiment #2 Delays and Primitive Gates Lab     ***                ***
*** ***********************************************************************
*** Filename: lab2_3.v Created by Justin Fursov, Feb 16 2023            ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

/* This is another module building on the one from the previous section *
* the Time delays go up to 3 and 4 now because the circuit is more complicated
* There are still 2 inputs and outputs, but the logic is a little more
* complicated. */

`timescale 1 ns / 100 ps

`define PRIMARY_OUT     5       // ns (primary outputs)
`define FAN_OUT_1       0.5       // ns (one output fanout)
`define FAN_OUT_2       1       // ns (two output fanout)
`define FAN_OUT_3       1.5       // ns (three output fanout)
`define TIME_DELAY_1    1       // ns (one input gates)
`define TIME_DELAY_2    2       // ns (two input gates)
`define TIME_DELAY_3    4       // ns (three input gates)
`define TIME_DELAY_4    5       // ns (four input gate)

module Lab2_2 (in1, in2, out1);
    input in1, in2;
    output out1;
    
    wire NT,A1,A2,O1;

    not #(`TIME_DELAY_1 + `FAN_OUT_3) NOT1(NT,in1);
    
    // Here is the added OR gate
    or  #(`TIME_DELAY_2 + `FAN_OUT_1) OR1(O1,A1,NT);
    and #(`TIME_DELAY_2 + `FAN_OUT_1) AND1(A1,in2,in1);
    and #(`TIME_DELAY_2 + `FAN_OUT_2) AND2(A2,in1,NT);
    nand #(`TIME_DELAY_4 + `PRIMARY_OUT)  NAND1(out1,NT,A1,A2,O1);

endmodule
