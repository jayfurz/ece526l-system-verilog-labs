`timescale 1ns/100ps

module counter8_tb();
    
    reg en_i, clk_i, rst_ni, load_i;
    reg [7:0] data_i;
    wire [7:0] cnt_o;
    wire aasd_rst;

    counter_8_bit u_counter (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .load_i(load_i),
        .en_i(en_i),
        .data_i(data_i),
        .cnt_o(cnt_o)
    );


    initial begin
        $vcdpluson;
        clk_i = 0;
    end

    always begin
        #50 clk_i = ~clk_i;
    end

    initial begin
        $monitor("%d: The value of counter is %d. rst_ni: %d", $time, cnt_o, rst_ni);
        #100 rst_ni = 0;
        #100 rst_ni = 1;
        #100 en_i = 1;
        #900 load_i = 1; data_i = 240;
        #100 load_i = 0;
        #2000 rst_ni = 0;
        #100 rst_ni = 1;
        #400;

        $finish;
    end

endmodule
