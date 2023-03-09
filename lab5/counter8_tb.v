`timescale 1ns/100ps

module counter8_tb();
    
    reg en_i, clk_i, rst_i, load_i;
    reg [7:0] data_i;
    wire [7:0] cnt_o;

    counter8 u_counter (
        .clk_i,
        .rst_ni,
        .load_i,
        .en_i,
        .data_i,
        .cnt_o
    );

    initial begin
        clk = 0;
    end

    always begin
        clk = ~clk;
    end

    $monitor("%d: The value of counter is %d.", $time, cnt_o);



endmodule
