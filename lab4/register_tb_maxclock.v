/**************************************************************************
***   	                                                                ***
*** ECE 526 L Experiment #4 ***                                         ***
*** Experiment #4 8-bit Register Lab                                    ***
*** ***********************************************************************
*** Filename: register_tb.v Created by Justin Fursov, Feb 27  2023      ***
*** ---   Revised from lab 3 ---	      	                              ***
***************************************************************************/

/* This is the testbench to check if the register module works correctly */
`timescale 1ns/10ps
`define MONITOR_STR_2 "%d: ena = %b, clk = %b, rst = %b, data = %b, out = %b"

module register_tb();

  reg ENA, CLK, RST;
  reg [7:0] DATA;
  wire [7:0] OUT;

  register reg1(
    .ena (ENA),
    .clk (CLK),
    .rst (RST),
    .data (DATA),
    .reg_out (OUT)
  );

  // Initialize previous_reg to test the ENA low
  reg [7:0] previous_reg; 
  initial begin
    $monitor(`MONITOR_STR_2, $time, ENA, CLK, RST, DATA, OUT);
  end

  always #(19.3) CLK = ~CLK;

  initial begin
    $vcdpluson;
    $display("\t***Starting testbench for register***");
    $display("\n\tChecking if data gets written to the register with RST high and ENA high.");
    CLK = 1;
    #(19.3*2) DATA = 0; RST = 0;
    #(19.3*2) RST = 1;
    #(19.3*2) DATA = 8'b01010101; ENA = 1;
    #(19.3*4) if (DATA === OUT)
      $display("\tTest 1 passed!");
    else $display("\tTest 1 failed!");

    $display("\n\tChecking the output if DATA has all bits HIGH");
    #(19.3*2) DATA = 255;
    #(19.3*4) if (DATA === OUT)
      $display("\tTest 2 passed!");
    else $display("\tTest 2 failed!");

    $display("\n\tChecking if the output of register becomes 0 with RST low.");
    #(19.3*2) RST = 0;
    #(19.3*2) if (8'b0 === OUT)
      $display("\tTest 3 passed!");
    else $display("\tTest 3 failed!");

    $display("\n\tChecking to make sure data is not written if ENA is low.");
    #(19.3*2) ENA = 0; DATA = 8'b01010101; RST = 1;
    #(19.3*2) if (DATA  !== OUT)
      $display("\tTest 4 passed!");
    else $display("\tTest 4 failed!");

    $display("\n\tChecking that by changing ENA to high, the data is written to the register.");
    #(19.3*2) ENA = 1;
    #(19.3*4) if (DATA  === OUT)
      $display("\tTest 5 passed!");
    else $display("\tTest 5 failed!");

    $display("\n\tChecking that the previous register is preserved when ENA is low.");
    #(19.3*2) ENA = 0; DATA = 8'b10101010; previous_reg = OUT;
    #(19.3*2) if (previous_reg  === OUT)
      $display("\tTest 6 passed!");
    else $display("\tTest 6 failed!");
    $finish;
  end

endmodule
    



