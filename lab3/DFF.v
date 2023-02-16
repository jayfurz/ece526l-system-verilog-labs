`timescale 1ns/1ns

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
    
    SR_Latch2 SR1(.Q (sbar),
        .Qnot (s),
        .s0 (rbar),
        .s1 (1'b1),
        .r0 (clr),
        .r1 (clk));
    SR_Latch2 SR2(.Q (r),
        .Qnot (rbar),
        .s0 (s),
        .s1 (clk),
        .r0 (clr),
        .r1 (d));
    SR_Latch2 SR3(.Q (q),
        .Qnot (qbar),
        .s0 (s),
        .s1 (1'b1),
        .r0 (clr),
        .r1 (r));

endmodule
