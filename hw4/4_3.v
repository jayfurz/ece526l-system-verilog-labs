
`timescale 1ns / 1ps
primitive mux_2_1(out, i0, i1, s);
    output out;
    input i0, i1, s;

    table
    //  i0 i1 s : out
        0 ? 0 : 0;
        1 ? 0 : 1;
        ? 0 1 : 0;
        ? 1 1 : 1;
        0 0 x : 0;
        1 1 x : 1;
    endtable
endprimitive


module tb_mux_2_1();
    reg i0, i1, s;
    wire out;

    // Instantiate the 2_1_mux primitive
    mux_2_1 mux_instance(out, i0, i1, s);

    // Testbench stimulus
    initial begin
        // Test Case 1
        i0 = 0; i1 = 0; s = 0;
        #10;

        // Test Case 2
        i0 = 0; i1 = 0; s = 1;
        #10;

        // Test Case 3
        i0 = 0; i1 = 1; s = 0;
        #10;

        // Test Case 4
        i0 = 0; i1 = 1; s = 1;
        #10;

        // Test Case 5
        i0 = 1; i1 = 0; s = 0;
        #10;

        // Test Case 6
        i0 = 1; i1 = 0; s = 1;
        #10;

        // Test Case 7
        i0 = 1; i1 = 1; s = 0;
        #10;

        // Test Case 8
        i0 = 1; i1 = 1; s = 1;
        #10;

        // Test Case 9
        i0 = 1; i1 = 1; s = 1'bX;
        #10;

        // Test Case 10
        i0 = 1'bX; i1 = 1'bX; s = 1'bX;
        #10;

        // Finish the simulation
        $finish;
    end

    // Monitor the input and output values
    initial begin
        $monitor("i0 = %b, i1 = %b, s = %b, out = %b", i0, i1, s, out);
    end

endmodule

