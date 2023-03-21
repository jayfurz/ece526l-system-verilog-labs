`timescale 1ns / 100ps

module counter_8_bit (
    input           clk_i,
    input           rst_ni,
    input           en_i,
    input           load_i,
    input [7:0]     data_i,
    output [7:0]    cnt_o
);

counter counter1(
    .clk_i(clk_i),
    .rst_ni(aasd_rst),
    .en_i(en_i),
    .load_i(load_i),
    .data_i(data_i),
    .cnt_o(cnt_o)
);

aasd_reset aasd1(
    .rst_ni(rst_ni),
    .clk_i(clk_i),
    .aasd_rst_o(aasd_rst)
);

endmodule
