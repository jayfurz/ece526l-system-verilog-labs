`timescale 1ns/100ps

module aasd_reset (
    input           rst_ni,
    input           clk_i,
    output reg      aasd_rst_o
);
    reg q;
    always @ (posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            aasd_rst_o <= 0;
            q <= 0;
        end else begin
            q <= rst_ni;
            aasd_rst_o <= q;
        end
    end
endmodule

