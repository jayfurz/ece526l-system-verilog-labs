`timescale 1ns/100ps

module counter #(
    parameter Width = 8
) (
    input               clk_i,
    input               rst_i,
    input               en_i,
    input               load_i,
    input  [Width-1:0]  data_i,
    output [Width-1:0]  cnt_o
);
    
    always @(posedge clk_i || !(rst_i)) begin
        if (!rst_i) begin
            assign cnt_0 = 0;
        end else begin
            deassign cnt_0;
            if (en_i) begin
                if (load_i) begin
                    cnt_0 <= data_i;
                end else begin
                    cnt_o <= cnt_o + 1;
                end
            end
        end
    end
endmodule
                
