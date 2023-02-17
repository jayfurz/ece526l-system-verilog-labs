/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #1 ***                                         ***
*** Experiment #1 Familiarization with Linux and VCS ***                ***
*** ***********************************************************************
*** Filename: mux4_1.v Created by Justin Fursov, Feb 09 2023 ***        ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/
`timescale 1 ns/ 1 ns
module mux4_1(out, a, b, c, d, s0, s1);
// port dedications
output out;
input a, b, c, d, s0, s1;
wire s0_n, s1_n, T1, T2, T3, T4;

not (s0_n, s0), (s1_n, s1);
and (T1, a ,s0_n, s1_n), (T2, b, s0_n, s1), (T3, c, s0, s1_n), (T4, d, s0, s1);
or(out, T1, T2, T3, T4);

endmodule
