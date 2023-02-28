/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #3 ***                                         ***
*** Experiment #3 SR Latch and D-Flip-Flop   Lab     ***                ***
*** ***********************************************************************
*** Filename: DFF_tb.v Created by Justin Fursov, Feb 27 2023 ***        ***
*** ---   Initial Release  ---	      	                                ***
***************************************************************************/

  /* This module is a D Flip Flop Test Bench *
   * Instantiated using port mapping */

`timescale 1ns/100ps

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
    always #50 clock = ~clock;
    initial begin
        $vcdpluson;
        $display("\tStarting testbench for finding longest delay.");
        #100 data = 1'b0; 
            clear = 1'b0; 
        #100 data = 1'b0; 
            clear = 1'b1; 
        #100 $strobe("\tData has been set to %b at this simulation time according to strobe.", data);
            $write("\tAccording to write, data is still set to %b, because it is called before the assignment\n", data);
            data = 1'b1; 
            clear = 1'b1; 
        #100 data = 1'b1; 
            clear = 1'b1; 
        #100 data = 1'b0; 
            clear = 1'b1; 
        #100 data = 1'b1; 
            clear = 1'b1; 
        #100 $monitoroff;
        // Reset the flip-flop
        $display("\tResetting flip-flop. Running test vectors.");
             clear = 0;
        // Test case 0: Clear = 0 -> Q = 0, Qbar = 1
        #100;
        if (q === 0 && qbar === 1)
            $display("Test 0 passed!");
        else $display("Test 0 failed!");
        #100 clear = 1;
             
        // Test case 1: D = 0 -> Q = 0, Qbar = 1
        data = 0;
        #100;
        if (q === 0 && qbar === 1)
            $display("Test 1 passed!");
        else $display("Test 1 failed!");
        
        // Test case 2: D = 1 -> Q = 1, Qbar = 0
        data = 1;
        #100;
        if (q === 1 && qbar === 0)
            $display("Test 2 passed!");
        else $display("Test 2 failed!");
        
        // Test case 3: D = X -> Q = Q (1), Qbar = Qbar (0) (not Pos edge)
        #40 data = 0;
        if (q === 1 && qbar === 0)
            $display("Test 3 passed!");
        else $display("Test 3 failed!");

        

        $finish;
    end

endmodule
