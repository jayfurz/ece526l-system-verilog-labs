`timescale 1ns/1ns

`define MONITOR_STR_1 "%d: s0 = %b, s1 = %b, r0 = %b, r1 = %b, Q = %b, Qnot = %b"

module Lab3_2_tb();
    reg s0, s1, r0, r1;
    wire Q, Qnot;

    SR_Latch2 sr1(.s0 (s0),
        .s1 (s1),
        .r0 (r0),
        .r1 (r1),
        .Q (Q),
        .Qnot (Qnot));

    initial begin 
        $monitor(`MONITOR_STR_1, $time, s0, s1, r0, r1, Q, Qnot);
    end

    initial begin
        $vcdpluson;
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b0; 
            r1 = 1'b0; 
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b0; 
            r1 = 1'b1; 
        #15 s0 = 1'b1;
            s1 = 1'b0; 
            r0 = 1'b0; 
            r1 = 1'b0; 
        #15 s0 = 1'b1;
            s1 = 1'b0; 
            r0 = 1'b1; 
            r1 = 1'b0; 
        #15 s0 = 1'b1;
            s1 = 1'b0; 
            r0 = 1'b1; 
            r1 = 1'b1; 
        #15 s0 = 1'b1;
            s1 = 1'b0; 
            r0 = 1'b0; 
            r1 = 1'b1; 
        #15 s0 = 1'b1;
            s1 = 1'b1; 
            r0 = 1'b0; 
            r1 = 1'b0; 
        #15 s0 = 1'b1;
            s1 = 1'b1; 
            r0 = 1'b0; 
            r1 = 1'b1; 
        #15 s0 = 1'b1;
            s1 = 1'b1; 
            r0 = 1'b1; 
            r1 = 1'b0; 
        #15 s0 = 1'b1;
            s1 = 1'b1; 
            r0 = 1'b1; 
            r1 = 1'b1; 
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b1; 
            r1 = 1'b0; 
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b1; 
            r1 = 1'b1; 
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b1; 
            r1 = 1'b0; 
        #15 s0 = 1'b0;
            s1 = 1'b0; 
            r0 = 1'b0; 
            r1 = 1'b0; 
    end

endmodule
