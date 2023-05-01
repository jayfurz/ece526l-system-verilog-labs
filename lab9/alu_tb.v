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
`define SIGNED_OPERANDS
module tb_alu;

    reg clk;
    reg en;
    reg oe;
    reg [3:0] opcode;

    `ifdef SIGNED_OPERANDS
        reg signed [7:0] a, b;
        wire signed [7:0] alu_out;
        reg signed [7:0] correct_answer;
    `else
        reg [7:0] a, b;
        wire [7:0] alu_out;
        reg [7:0] correct_answer;
    `endif

    wire cf, of, sf, zf;
    reg [55:0] opcode_str;


    // Instantiate the ALU module
    alu uut (
        .CLK(clk), .EN(en), .OE(oe), .OPCODE(opcode),
        .A(a), .B(b),
        .ALU_OUT(alu_out), .CF(cf), .OF(of), .SF(sf), .ZF(zf)
    );

    // Opcode name function
    function [7*8-1:0] opcode_name;
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

    task test;
        input [3:0] test_opcode;
        `ifdef SIGNED_OPERANDS
            input signed [7:0] test_a;
            input signed [7:0] test_b;
            input signed [7:0] expected_alu_out;
        `else
            input [7:0] test_a;
            input [7:0] test_b;
            input [7:0] expected_alu_out;
        `endif
        input       expected_cf;
        input       expected_of;
        input       expected_sf;
        input       expected_zf;
        reg [7*8-1:0] opcode_string;

        begin
            opcode <= test_opcode;
            a <= test_a;
            b <= test_b;
            #10;

            opcode_string = opcode_name(test_opcode);
            $display("Testing %0s with a = %d, b = %d, output: %d, expected: %d", opcode_string, a, b, alu_out, expected_alu_out);

            if (alu_out !== expected_alu_out) begin
                $display("Mismatch in alu_out for %s: Expected = %h, Actual = %h", opcode_string, expected_alu_out, alu_out);
            end
            `ifdef SIGNED_OPERANDS
                if (of !== expected_of) begin
                    $display("Mismatch in OF for %s: Expected = %b, Actual = %b", opcode_string, expected_of, of);
                end
            `else
                if (cf !== expected_cf) begin
                    $display("Mismatch in CF for %s: Expected = %b, Actual = %b", opcode_string, expected_cf, cf);
                end
            `endif

            if (sf !== expected_sf) begin
                $display("Mismatch in SF for %s: Expected = %b, Actual = %b", opcode_string, expected_sf, sf);
            end

            if (zf !== expected_zf) begin
                $display("Mismatch in ZF for %s: Expected = %b, Actual = %b", opcode_string, expected_zf, zf);
            end
        end
    endtask

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    `ifdef SIGNED_OPERANDS
      initial $display("Signed run");
    `else
      initial $display("Unsigned run");
    `endif


    // Testbench stimulus
    initial begin
        // Monitor statements
        $monitor("opcode: %0s, a: %d, b: %d, alu_out: %d, correct answer: %d, cf: %b, of: %b, sf: %b, zf: %b", opcode_name(opcode), a, b, alu_out, correct_answer, cf, of, sf, zf);
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

        $monitoroff;
        // Additional test cases for corner cases discussed earlier.
        $display("\nNow testing corner cases");

        // Corner cases for ADD
        `ifdef SIGNED_OPERANDS
            // Signed mode (opcode, a, b, out, cf, of, sf, zf
            test(4'b0010, 8'sh7F, 8'sh7F, 8'shFE, 0, 1, 1, 0); // Maximum positive value + Maximum positive value
            test(4'b0010, 8'sh80, 8'sh80, 8'sh00, 0, 1, 0, 1); // Maximum negative value + Maximum negative value
        `else
            // Unsigned mode
            test(4'b0010, 8'h00, 8'h00, 8'h00, 0, 0, 0, 1); // A = 0, B = 0
            test(4'b0010, 8'hFF, 8'h00, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = 0
            test(4'b0010, 8'h00, 8'hFF, 8'hFF, 0, 0, 1, 0); // A = 0, B = maximum value
            test(4'b0010, 8'hFF, 8'hFF, 8'hFE, 1, 1, 1, 0); // A = maximum value, B = maximum value
        `endif

        // Corner cases for SUB
        `ifdef SIGNED_OPERANDS
            // Signed mode
            test(4'b0011, 8'sh7F, 8'sh80, 8'shFF, 0, 1, 1, 0); // Maximum positive value - Maximum negative value
            test(4'b0011, 8'sh80, 8'sh7F, 8'sh01, 1, 1, 0, 0); // Maximum negative value - Maximum positive value
        `else
            // Unsigned mode
            test(4'b0011, 8'h00, 8'h00, 8'h00, 0, 0, 0, 1); // A = 0, B = 0
            test(4'b0011, 8'hFF, 8'h00, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = 0
            test(4'b0011, 8'h00, 8'hFF, 8'h01, 1, 0, 0, 0); // A = 0, B = maximum value
            test(4'b0011, 8'hFF, 8'hFF, 8'h00, 0, 0, 0, 1); // A = maximum value, B = maximum value
        `endif

        // Corner cases for AND, OR, XOR
        `ifdef SIGNED_OPERANDS
            // Signed mode
            test(4'b0100, 8'sh7F, 8'sh80, 8'sh00, 0, 0, 0, 1); // Maximum positive value AND Maximum negative value
            test(4'b0101, 8'sh7F, 8'sh80, 8'shFF, 0, 0, 1, 0); // Maximum positive value OR Maximum negative value
            test(4'b0110, 8'sh7F, 8'sh80, 8'shFF, 0, 0, 1, 0); // Maximum positive value XOR Maximum negative value
        `else
            // Unsigned mode
            test(4'b0100, 8'h00, 8'h00, 8'h00, 0, 0, 0, 1); // A = 0, B = 0 (AND)>>
            test(4'b0100, 8'hFF, 8'h00, 8'h00, 0, 0, 0, 1); // A = maximum value, B = 0 (AND)
            test(4'b0100, 8'h00, 8'hFF, 8'h00, 0, 0, 0, 1); // A = 0, B = maximum value (AND)
            test(4'b0100, 8'hFF, 8'hFF, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = maximum value (AND)

            test(4'b0101, 8'h00, 8'h00, 8'h00, 0, 0, 0, 1); // A = 0, B = 0 (OR)
            test(4'b0101, 8'hFF, 8'h00, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = 0 (OR)
            test(4'b0101, 8'h00, 8'hFF, 8'hFF, 0, 0, 1, 0); // A = 0, B = maximum value (OR)
            test(4'b0101, 8'hFF, 8'hFF, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = maximum value (OR)

            test(4'b0110, 8'h00, 8'h00, 8'h00, 0, 0, 0, 1); // A = 0, B = 0 (XOR)
            test(4'b0110, 8'hFF, 8'h00, 8'hFF, 0, 0, 1, 0); // A = maximum value, B = 0 (XOR)
            test(4'b0110, 8'h00, 8'hFF, 8'hFF, 0, 0, 1, 0); // A = 0, B = maximum value (XOR)
            test(4'b0110, 8'hFF, 8'hFF, 8'h00, 0, 0, 0, 1); // A = maximum value, B = maximum value (XOR)
        `endif

        // Corner cases for NOT_A
        `ifdef SIGNED_OPERANDS
            // Signed mode
            test(4'b0111, 8'sh00, 8'sh00, 8'shFF, 0, 0, 1, 0); // A = 0
            test(4'b0111, 8'sh7F, 8'sh00, 8'sh80, 0, 0, 1, 0); // A = maximum positive value
            test(4'b0111, 8'sh80, 8'sh00, 8'sh7F, 0, 0, 0, 0); // A = maximum negative value
        `else
            // Unsigned mode
            test(4'b0111, 8'h00, 8'h00, 8'hFF, 0, 0, 1, 0); // A = 0
            test(4'b0111, 8'hFF, 8'h00, 8'h00, 0, 0, 0, 1); // A = maximum value
        `endif

        // Test with EN = 0 (should maintain the previous state)
        $display("\nNow testing EN");
        en = 0;
        // choose operation ADD
        opcode = 4'b0010;
        a = 8'h3A;
        b = 8'h22;
        // Wait for a few clock cycles
        repeat(5) @(posedge clk);
        // Enable the ALU
        en = 1;
        repeat(5) @(posedge clk);
        // The ALU output should remain the same as before
        test(opcode, a, b, 8'h3A + 8'h22, 0, 0, 0, 0);
        en = 0;
        // Perform another operation (subtract)
        opcode = 4'b0011;
        a = 8'h3A;
        b = 8'h22;
        // Wait for a few clock cycles
        repeat(5) @(posedge clk);
        // the ALU output should remain the same as before (still showing the
        // result of the addition)
        test(4'b0010, a, b, 8'h3A + 8'h22, 0, 0, 0, 0);

        // Test with OE = 0 (should set ALU_OUT to high impedance)
        $display("\nNow testing OE");
        oe = 0;
        en = 1;
        // Choose an operation, e.g., ADD
        opcode = 4'b0010;
        a = 8'h3A;
        b = 8'h22;
        // Wait for a few clock cycles
        repeat(5) @(posedge clk);
        // The ALU_OUT should be high impedance (floating) so we cannot directly check its value
        // However, we can check if the ALU_OUT is not driven
        if (alu_out !== {8{1'bz}}) begin
            $display("ERROR: ALU_OUT is not high impedance when OE = 0, alu_out = %b", alu_out);
        end
        // Enable the output
        oe = 1;
        repeat(5) @(posedge clk);
        // The ALU output should now show the result of the operation
        test(4'b0010, a, b, 8'h3A + 8'h22, 0, 0, 0, 0);
        // Finish the simulation
        $finish;
    end
endmodule
