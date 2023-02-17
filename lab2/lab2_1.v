`timescale 1 ns / 100 ps

`define PRIMARY_OUT     0       // ns (primary outputs)
`define FAN_OUT_1       0       // ns (one output fanout)
`define FAN_OUT_2       0       // ns (two output fanout)
`define TIME_DELAY_1    0       // ns (one input gates)
`define TIME_DELAY_2    0       // ns (two input gates)
`define TIME_DELAY_3    0       // ns (three input gates)

module Lab2_1 (in1, in2, out1);
    input in1, in2;
    output out1;
    
    wire NT,A1,A2;

    not #(`TIME_DELAY_1 + `FAN_OUT_2) NOT1(NT,in1);
    and #(`TIME_DELAY_2 + `FAN_OUT_1) AND1(A1,in2,in1);
    and #(`TIME_DELAY_2 + `FAN_OUT_1) AND2(A2,in1,NT);
    nand #(`TIME_DELAY_3 + `PRIMARY_OUT)  NAND1(out1,NT,A1,A2);

endmodule
