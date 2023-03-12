`timescale 1 ns / 100 ps
module mux2_1(out, a, b, sel);

  // Port declarations
  output out;
  input a, b, sel;

  // Internal variable declarations
  wire a1, b1, sel_n;

  // The netlist
  not #(`TIME_DELAY_1 + `FAN_OUT_1) (sel_n, sel);
  and #(`TIME_DELAY_2, `FAN_OUT_1) (a1, a, sel_n);
  and #(`TIME_DELAY_2 + `FAN_OUT_1) (b1, b, sel);
  or #(`TIME_DELAY_2 + `FAN_OUT_1) (out, a1, b1);
endmodule
