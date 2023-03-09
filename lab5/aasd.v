`timescale 1ns/100ps

module aasd_reset (
    input           rst_ni,
    input           clk_i,
    output          aasd_rst_o
);
    reg q;
    always @ (posedge clk or negedge rst_ni) begin
        if !rst_ni begin
            aasd_rst_o <= 1;
        end else begin
            q <= rst_ni;
            aasd_rst_o <= q;
        end
    end
endmodule

