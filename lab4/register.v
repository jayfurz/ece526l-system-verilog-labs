`timescale 1ns/100ps

module register(
    ena,
    clk,
    rst,
    data,
    reg_out
);

  // Instantiate inputs and outputs with default width
  parameter Width = 8;
  input ena, clk, rst;
  input [Width-1:0] data;
  output [Width-1:0] reg_out;
  wire [Width-1:0] rnot_out;  
  // Instantiate wire for the output of mux into dff
  wire [Width-1:0] mux_out;
  mux2_1 MUX [Width-1:0](
    .out(mux_out),
    .a(reg_out),
    .b(data),
    .sel(ena)
  );

  // Instantiate an array of dff instances
  dff DFF [Width-1:0](
    .q(reg_out),
    .qbar(rnot_out),
    .clock(clk),
    .data(mux_out),
    .clear(rst)
  );

endmodule





