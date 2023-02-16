`timescale 1ns/1ns

`define MONITOR_STR_1 "%d: q = %b, qbar = %b, clock = %b, data = %b, clear = %b"

module Lab3_3_tb();
    reg clock, data, clear;
    wire q, qbar;

    dff DFF1(.q (q),
        .qbar (qbar),
        .clock (clock),
        .data (data),
        .clear (clear));

    initial begin 
        $monitor(`MONITOR_STR_1, $time, q, qbar, clock, data, clear);
        clock = 0;
    end
    always #20 clock = ~clock;
    initial begin
        $vcdpluson;
        #40 data = 1'b0; 
            clear = 1'b0; 
        #40 data = 1'b0; 
            clear = 1'b1; 
        #40 data = 1'b1; 
            clear = 1'b1; 
        #40 data = 1'b1; 
            clear = 1'b1; 
        #40 data = 1'b0; 
            clear = 1'b1; 
        #40 data = 1'b1; 
            clear = 1'b1; 
        #40 $monitoroff;
        $finish;
    end

endmodule
