/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #2 ***                                         ***
*** Experiment #2 Delays and Primitive Gates Lab     ***                ***
*** ***********************************************************************
*** Filename: lab2_2.v Created by Justin Fursov, Feb 16 2023 ***          ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

/*This module has two inputs, in1 and in2 and has one output, out1 *
* The Time Delays are explained as follows: *
* The fan out are the output delays and are either 1 or 2 depending on *
* how many devices are connected to the output of the device *
* Time Delay is the input delays *
* Finally, the primary out is the one for the final output */



`timescale 1 ns / 100 ps

`define PRIMARY_OUT     5       // ns (primary outputs)
`define FAN_OUT_1       0.5       // ns (one output fanout)
`define FAN_OUT_2       1       // ns (two output fanout)
`define TIME_DELAY_1    1       // ns (one input gates)
`define TIME_DELAY_2    2       // ns (two input gates)
`define TIME_DELAY_3    4       // ns (three input gates)

module Lab2_1 (in1, in2, out1);
    input in1, in2;
    output out1;
    
    wire NT,A1,A2;

    not #(`TIME_DELAY_1 + `FAN_OUT_2) NOT1(NT,in1);
    and #(`TIME_DELAY_2 + `FAN_OUT_1) AND1(A1,in2,in1);
    and #(`TIME_DELAY_2 + `FAN_OUT_1) AND2(A2,in1,NT);
    nand #(`TIME_DELAY_3 + `PRIMARY_OUT)  NAND1(out1,NT,A1,A2);

endmodule
