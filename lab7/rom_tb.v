/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: rom_tb.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the testbench for the rom module */
`timescale 1ns / 1ps

module tb_rom();
    parameter Width = 8;
    parameter Depth = 5;
    reg oe;
    reg cs_n;
    reg [Depth-1:0] address;
    wire [Width-1:0] data;
    reg [7:0] expected_values [5'h0:5'h1F];
    reg [7:0] temp_data;

    // Instantiate the ROM module
    rom #(.Width(Width), .Depth(Depth)) rom_inst (
        .oe_i(oe),
        .cs_ni(cs_n),
        .address_i(address),
        .data_o(data)
    );

    initial begin
        $vcdpluson;
        // Initialize the memory with hex values
        $readmemh("rom_data.hex", rom_inst.memory);

        // Test the memory initialization
        test_memory_initialization();

        // Test unspecified locations
        test_unspecified_locations();

        // Scramble bytes and write back
        scramble_and_write_bytes();

        // Test memory scrambling
        test_memory_scrambling();

        // Print the contents of all memory locations
        print_memory_contents();

        // Finish the test
        $finish;
    end

    task test_memory_initialization;
        begin
            integer i;
            // Initialize expected_values for the specified addresses
            expected_values[5'h00] = 8'h00;
            expected_values[5'h01] = 8'h00;
            expected_values[5'h02] = 8'h00;
            expected_values[5'h03] = 8'h00;
            expected_values[5'h04] = 8'h58;
            expected_values[5'h05] = 8'hED;
            expected_values[5'h06] = 8'hB7;
            expected_values[5'h07] = 8'h34;
            expected_values[5'h08] = 8'hC9;
            expected_values[5'h09] = 8'h8F;
            expected_values[5'h0A] = 8'hA0;
            expected_values[5'h0B] = 8'h9B;
            expected_values[5'h0C] = 8'h65;
            expected_values[5'h0D] = 8'h11;
            expected_values[5'h0E] = 8'h03;
            expected_values[5'h0F] = 8'h4C;
            expected_values[5'h10] = 8'hDA;
            expected_values[5'h11] = 8'h7E;
            expected_values[5'h12] = 8'hF2;
            expected_values[5'h13] = 8'h26;
            expected_values[5'h14] = 8'h86;
            expected_values[5'h15] = 8'h95;
            expected_values[5'h16] = 8'hFD;
            expected_values[5'h17] = 8'hB1;
            expected_values[5'h18] = 8'h00;
            expected_values[5'h19] = 8'h00;
            expected_values[5'h1A] = 8'h00;
            expected_values[5'h1B] = 8'h00;
            expected_values[5'h1C] = 8'h12;
            expected_values[5'h1D] = 8'hAF;
            expected_values[5'h1E] = 8'h33;
            expected_values[5'h1F] = 8'h00;
            for (i = 0; i < 32; i = i + 1) begin
                oe = 1'b1;
                cs_n = 1'b0;
                address = i;
                #10;
                if (data !== expected_values[i]) begin
                    $display("Memory Initialization Test: FAILED at address %0h, expected: %0h, got: %0h", i, expected_values[i], data);
                end else begin
                    $display("Memory Initialization Test: PASSED at address %0h, expected: %0h, got: %0h", i, expected_values[i], data);
                end
            end
        end
    endtask

    task test_unspecified_locations;
        begin
            integer i;
            expected_values[5'h18] = 8'hX;
            expected_values[5'h19] = 8'hX;
            expected_values[5'h1A] = 8'hX;
            expected_values[5'h1B] = 8'hX;
            for (i = 0; i < 4; i = i + 1) begin
                address = 5'h18 + i;
                oe = 1'b1;
                cs_n = 1'b0;
                #10;
                if (data !== expected_values[address]) begin
                    $display("Unspecified Locations Test: FAILED at address %0h, expected: %0h, got: %0h", 5'h18 + i, expected_values[i], data);
                end else begin
                    $display("Unspecified Locations Test: PASSED at address %0h, expected: %0h, got: %0h", 5'h18 + i, expected_values[i], data);
                end
            end
        end
    endtask

    task scramble_and_write_bytes;
        begin
            integer i;
            for (i = 0; i < 8; i = i + 1) begin
                address = 5'h10 + i;
                oe = 1'b1;
                cs_n = 1'b0;
                #10;
                temp_data = {data[0], data[7], data[1], data[6], data[2], data[5], data[3], data[4]};
                oe = 1'b0;
                #10;
                rom_inst.memory[address] = temp_data;
            end
        end
    endtask

    task test_memory_scrambling;
        begin
            integer i;

            // Initialize the scrambled values for addresses 5'h10 to 5'h17
            expected_values[5'h10] = 8'h73;
            expected_values[5'h11] = 8'hDF;
            expected_values[5'h12] = 8'h4F;
            expected_values[5'h13] = 8'h64;
            expected_values[5'h14] = 8'h61;
            expected_values[5'h15] = 8'hA9;
            expected_values[5'h16] = 8'hBF;
            expected_values[5'h17] = 8'h8D;
            for (i = 0; i < 8; i = i + 1) begin
                address = 5'h10 + i;
                oe = 1'b1;
                cs_n = 1'b0;
                #10;
                if (data !== expected_values[address]) begin
                    $display("Memory Scrambling Test: FAILED at address %0h, expected: %0h, got: %0h", 5'h10 + i, expected_values[i], data);
                end else begin
                    $display("Memory Scrambling Test: PASSED at address %0h, expected: %0h, got: %0h", 5'h10 + i, expected_values[i], data);
                end
            end
        end
    endtask

    task print_memory_contents;
        begin
            integer i;
            for (i = 0; i < 32; i = i + 1) begin
                address = i;
                oe = 1'b1;
                cs_n = 1'b0;
                #10;
                $display("Memory Contents at address %0h: %0h", i, data);
            end
        end
    endtask

endmodule
