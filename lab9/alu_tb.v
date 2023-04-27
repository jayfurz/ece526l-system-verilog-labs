/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #9                                                    ***
*** Experiment #9 ALU                                                   ***
*** ***********************************************************************
*** Filename: alu_tb.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the testbench module for the ALU                */

`timescale 1ns/100ps

module tb_alu;

    reg clk;
    reg en;
    reg oe;
    reg [3:0] opcode;
    reg [7:0] a, b;
    wire [7:0] alu_out;
    wire cf, of, sf, zf;

    // Instantiate the ALU module
    alu uut (
        .CLK(clk), .EN(en), .OE(oe), .OPCODE(opcode),
        .A(a), .B(b),
        .ALU_OUT(alu_out), .CF(cf), .OF(of), .SF(sf), .ZF(zf)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end


    // Testbench stimulus
    initial begin
        // Monitor statements
        $monitor("opcode: %b, a: %d, b: %d, ALU_OUT: %d, CF: %b, OF: %b, SF: %b, ZF: %b", opcode, a, b, alu_out, cf, of, sf, zf);

        // Initialize signals
        clk = 0;
        en = 1;
        oe = 1;
        opcode = 4'b0000;
        a = 8'b0000_0000;
        b = 8'b0000_0000;

        // Basic functionality tests
        opcode = 4'b0010; a = 8'b0101_0101; b = 8'b0011_1100; #10;  // Test ADD
        opcode = 4'b0011; a = 8'b1001_0011; b = 8'b0101_1010; #10;  // Test SUB
        opcode = 4'b0100; a = 8'b1100_1100; b = 8'b1010_1010; #10;  // Test AND
        opcode = 4'b0101; a = 8'b1111_0000; b = 8'b0000_1111; #10;  // Test OR
        opcode = 4'b0110; a = 8'b1010_1010; b = 8'b0101_0101; #10;  // Test XOR
        opcode = 4'b0111; a = 8'b1111_0000; b = 8'b0000_0000; #10;  // Test NOT_A

        // Additional test cases can be added here, following the test scenarios and corner cases discussed earlier.

        // Finish the simulation
        $finish;
    end
endmodule
