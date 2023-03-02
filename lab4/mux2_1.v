`timescale 1 ns / 100 ps
module mux2_1(out, a, b, sel);

  // Port declarations
  output out;
  input a, b, sel;

  // Internal variable declarations
  wire a1, b1, sel_n;

  // The netlist
  not (sel_n, sel);
  and(a1, a, sel_n);
  and (b1, b, sel);
  or (out, a1, b1);
endmodule
