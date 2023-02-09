`timescale 1 ns/ 1 ns

`define MONITOR_STR_1 "%d: in1 = %b, in2 = %b, | out = %b || A1 = %b, A2 = %b, NT = %b"

module Lab2_1_tb();
    reg in1, in2;
    wire out;
    Lab2_1 UUT(.in1 (in1),
        .in2 (in2),
        .out1 (out));

    initial begin
        $monitor(`MONITOR_STR_1, $time, in1, in2, out, UUT.A1, UUT.A2, UUT.NT);
    end

    initial begin
        $vcdpluson;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 in1 = 1'b0;
            in2 = 1'b1;
        #15 in1 = 1'b1;
            in2 = 1'b1;
        #15 in1 = 1'b1;
            in2 = 1'b0;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 in1 = 1'b1;
            in2 = 1'b0;
        #15 in1 = 1'b1;
            in2 = 1'b1;
        #15 in1 = 1'b0;
            in2 = 1'b1;
        #15 in1 = 1'b0;
            in2 = 1'b0;
        #15 $finish;
    end
endmodule
