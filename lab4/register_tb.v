/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #4 ***                                         ***
*** Experiment #4 8-bit Register Lab                                    ***
*** ***********************************************************************
*** Filename: register_tb.v Created by Justin Fursov, Feb 27  2023      ***
*** ---   Revised from lab 3 ---	      	                              ***
***************************************************************************/

/* This is the testbench to check if the register module works correctly */

`define MONITOR_STR_2 "%d: ena = %b, clk = %b, rst = %b, data = %b, out = %b"

module register_tb();

  reg ENA, CLK, RST;
  reg [7:0] DATA;
  wire [8:0] OUT;

  register reg1(
    .ena (ENA),
    .clk (CLK),
    .rst (RST),
    .data (DATA),
    .r_out (OUT)
  );

  initial begin
    $monitor(`MONITOR_STR_2, $time, ENA, CLK, RST, DATA, OUT);
  end

  always #50 CLK = ~CLK;

  initial begin
    $vcdpluson;
    $display("\t***Starting testbench for register***");
    #100 DATA = 0; RST = 0;
    #100 RST = 1;
    #100 DATA = 1; ENA = 1;
    #100 if (DATA === OUT)
      $display("Test 1 passed!");
    else $display("Test 1 failed!");
    #100 DATA = 255;
    #100 if (DATA === OUT)
      $display("Test 2 passed!");
    else $display("Test 2 failed!");
    #100 RST = 0;
    #100 if (8'b0 === OUT)
      $display("Test 3 passed!");
    else $display("Test 3 failed!");
    $finish
  end
endmodule
    



