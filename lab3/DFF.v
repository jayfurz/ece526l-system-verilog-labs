/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #3 ***                                         ***
*** Experiment #3 SR Latch and D-Flip-Flop   Lab     ***                ***
*** ***********************************************************************
*** Filename: DFF.v Created by Justin Fursov, Feb 27  2023 ***          ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

  /* This module is a D Flip Flop *
  * the input and output delays are set as parameters. *
  * There are three inputs: clock, data, clear *.
  * There are two outputs, q and qbar. */

`timescale 1ns/100ps

`define TIME_DELAY_1    3
`define TIME_DELAY_2    4
`define TIME_DELAY_3    5
`define FAN_OUT_1       0.5
`define FAN_OUT_2       0.8
`define FAN_OUT_3       1.0
`define PRIMARY_OUT     2.0



module dff(q, qbar, clock, data, clear);
        
    output q, qbar;

    input clock, data, clear;
    wire cbar, clkbar, dbar, clk, d, clr, s, sbar, r, rbar;
    not #(`TIME_DELAY_1 + `FAN_OUT_1) NOT1a(cbar, clear);
    not #(`TIME_DELAY_1 + `FAN_OUT_3) NOT1b(clr, cbar);
    not #(`TIME_DELAY_1 + `FAN_OUT_1) NOT2a(clkbar, clock);
    not #(`TIME_DELAY_1 + `FAN_OUT_2) NOT2b(clk, clkbar);
    not #(`TIME_DELAY_1 + `FAN_OUT_1) NOT3a(dbar, data);
    not #(`TIME_DELAY_1 + `FAN_OUT_1) NOT3b(d, dbar);
    
    // Top SR latch    
    SR_Latch2 
     #(.INPUT_DELAY_S(`TIME_DELAY_1),
       .INPUT_DELAY_R(`TIME_DELAY_3),
       .OUTPUT_DELAY_Q(`FAN_OUT_1),
       .OUTPUT_DELAY_QNOT(`FAN_OUT_3))
    SR1
    (.Q (sbar),
        .Qnot (s),
        .s0 (rbar),
        .s1 (1'b1),
        .r0 (clr),
        .r1 (clk));

    // Bottom SR Latch
    SR_Latch2 
     #(.INPUT_DELAY_S(`TIME_DELAY_3),
       .INPUT_DELAY_R(`TIME_DELAY_3),
       .OUTPUT_DELAY_Q(`FAN_OUT_2),
       .OUTPUT_DELAY_QNOT(`FAN_OUT_2))
    SR2
    (.Q (r),
        .Qnot (rbar),
        .s0 (s),
        .s1 (clk),
        .r0 (clr),
        .r1 (d));

    // Out SR Latch
    SR_Latch2 
     #(.INPUT_DELAY_S(`TIME_DELAY_2),
       .INPUT_DELAY_R(`TIME_DELAY_3),
       .OUTPUT_DELAY_Q(`PRIMARY_OUT),
       .OUTPUT_DELAY_QNOT(`PRIMARY_OUT))
    SR3
    (.Q (q),
        .Qnot (qbar),
        .s0 (s),
        .s1 (1'b1),
        .r0 (clr),
        .r1 (r));

endmodule
