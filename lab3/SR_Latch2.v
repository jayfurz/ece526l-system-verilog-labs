/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #3 ***                                         ***
*** Experiment #3 SR Latch and D-Flip-Flop   Lab     ***                ***
*** ***********************************************************************
*** Filename: SR_Latch2.v Created by Justin Fursov, Feb 27  2023 **     ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

  /* This module is a SR-Latch *
  * the input and output delays are set as parameters. *
  * There are four inputs, s0, s1, r0, r1.  *
  * There are two outputs, q and qbar. */

`timescale 1ns/100ps

`define TIME_DELAY_1    3
`define TIME_DELAY_2    4
`define TIME_DELAY_3    5
`define FAN_OUT_1       0.5
`define FAN_OUT_2       0.8
`define FAN_OUT_3       1.0
`define PRIMARY_OUT     2.0


// This is a Switch-Reset Latch
// Inputs are the switch bits:
// s0, s1
// And the reset bits:
// r0, r1



module SR_Latch2 (  Q,
                    Qnot,
                    s0,
                    s1,
                    r0,
                    r1);

    output Q, Qnot;
    input s0, s1, r0, r1;

    // Declare parameters for delay.
    // Default to 3 inputs and primary outs for both NANDs
    parameter INPUT_DELAY_S = `TIME_DELAY_3,
              INPUT_DELAY_R = `TIME_DELAY_3,
              OUTPUT_DELAY_Q = `PRIMARY_OUT,
              OUTPUT_DELAY_QNOT = `PRIMARY_OUT;
              

    nand #(INPUT_DELAY_S + OUTPUT_DELAY_Q) NAND1(Q, s0, s1, Qnot);
    nand #(INPUT_DELAY_R + OUTPUT_DELAY_QNOT) NAND2(Qnot, r0, r1, Q);

endmodule
