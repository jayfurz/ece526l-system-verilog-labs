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
    reg [7:0] correct_answer;
    reg [55:0] opcode_str;

    // Instantiate the ALU module
    alu uut (
        .CLK(clk), .EN(en), .OE(oe), .OPCODE(opcode),
        .A(a), .B(b),
        .ALU_OUT(alu_out), .CF(cf), .OF(of), .SF(sf), .ZF(zf)
    );

    // Opcode name function
    function [55:0] opcode_name;
        input [3:0] opcode;
        begin
            case (opcode)
                4'b0010: opcode_name = "ADD    ";
                4'b0011: opcode_name = "SUB    ";
                4'b0100: opcode_name = "AND    ";
                4'b0101: opcode_name = "OR     ";
                4'b0110: opcode_name = "XOR    ";
                4'b0111: opcode_name = "NOT A  ";
                default: opcode_name = "UNKNOWN";
            endcase
        end
    endfunction

    function automatic void check_result;
        input [55:0] opname;
        input [7:0] alu_out, expected_alu_out;
        begin
            if (alu_out === expected_alu_out) begin
                $display("%0s test passed. Expected: %d, Got: %d", opname, expected_alu_out, alu_out);
            end else begin
                $display("%0s test failed. Expected: %d, Got: %d", opnmae, expected_alu_out, alu_out);
            end
        end
    endfunction


    // Clock generation
    always begin
        #5 clk = ~clk;
    end


    // Testbench stimulus
    initial begin
        // Monitor statements
        $monitor("opcode: %0s, a: %d, b: %d, ALU_OUT: %d, correct answer: %d, CF: %b, OF: %b, SF: %b, ZF: %b", opcode_name(opcode), a, b, alu_out, correct_answer, cf, of, sf, zf);

        // Initialize signals
        clk = 0;
        en = 1;
        oe = 1;
        opcode = 4'b0000;
        a = 8'b0000_0000;
        b = 8'b0000_0000;

        // Basic functionality tests
        opcode = 4'b0010; a = 8'b0101_0101; b = 8'b0011_1100; correct_answer = a + b; #10;  // Test ADD 
        opcode = 4'b0011; a = 8'b1001_0011; b = 8'b0101_1010; correct_answer = a - b; #10;  // Test SUB
        opcode = 4'b0100; a = 8'b1100_1100; b = 8'b1010_1010; correct_answer = a & b; #10;  // Test AND
        opcode = 4'b0101; a = 8'b1111_0000; b = 8'b0000_1111; correct_answer = a | b; #10;  // Test OR
        opcode = 4'b0110; a = 8'b1010_1010; b = 8'b0101_0101; correct_answer = a ^ b; #10;  // Test XOR
        opcode = 4'b0111; a = 8'b1111_0000; b = 8'b0000_0000; correct_answer = ~a; #10;  // Test NOT_A

        $endmonitor;
        // Additional test cases for corner cases discussed earlier.

        // Test    // Test NOT A corner case: ~0
        opcode = 4'b0111;
        a = 8'b0000_0000;
        b = 8'b0000_0000;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b1111_1111);

        // Test ADD edge case: Maximum unsigned addition (255 + 255)
        opcode = 4'b0010;
        a = 8'b1111_1111;
        b = 8'b1111_1111;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b1111_1110); // 254, with CF = 1

        // Test SUB edge case: Maximum positive difference (255 - 0)
        opcode = 4'b0011;
        a = 8'b1111_1111;
        b = 8'b0000_0000;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b1111_1111);

        // Test SUB edge case: Maximum negative difference (0 - 255)
        opcode = 4'b0011;
        a = 8'b0000_0000;
        b = 8'b1111_1111;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b0000_0001); // 1, with CF = 1

        // Test AND edge case: AND with all 1s
        opcode = 4'b0100;
        a = 8'b1111_1111;
        b = 8'b1111_1111;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b1111_1111);

        // Test OR edge case: OR with all 0s
        opcode = 4'b0101;
        a = 8'b0000_0000;
        b = 8'b0000_0000;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b0000_0000);

        // Test XOR edge case: XOR with inverse values
        opcode = 4'b0110;
        a = 8'b1010_1010;
        b = 8'b0101_0101;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b1111_1111);

        // Test XOR edge case: XOR with the same values
        opcode = 4'b0110;
        a = 8'b1010_1010;
        b = 8'b1010_1010;
        #10; opcode_str = opcode_name(opcode);
        check_result(opcode_str, alu_out, 8'b0000_0000);

        // Finish the simulation
        $finish;
    end
endmodule
