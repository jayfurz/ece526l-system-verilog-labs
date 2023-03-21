`timescale 1ns/100ps

module counter #(
    parameter Width = 8
) (
    input               clk_i,
    input               rst_ni,
    input               en_i,
    input               load_i,
    input  [Width-1:0]  data_i,
    output reg [Width-1:0]  cnt_o
);
    
    always @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) cnt_o <= 0;
        else begin
            if (en_i) begin
                if (load_i) begin
                    cnt_o <= data_i;
                end else begin
                    cnt_o <= cnt_o + 1;
                end
            end
        end
    end
endmodule
                
