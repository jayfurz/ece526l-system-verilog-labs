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
        integer i;
        reg [7:0] expected_values [5'h0:5'h1F] = '{
            8'h00, 8'h00, 8'h00, 8'h00, 8'h58,
            8'hED, 8'hB7, 8'h34, 8'hC9, 8'h8F,
            8'hA0, 8'h9B, 8'h65, 8'h11, 8'h03,
            8'h4C, 8'hDA, 8'h7E, 8'hF2, 8'h26,
            8'h86, 8'h95, 8'hFD, 8'hB1, 8'h00,
            8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
            8'h00, 8'h00
        };
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
    endtask

    task test_unspecified_locations;
        integer i;
        reg [7:0] expected_values [5'h18:5'h1B] = '{8'hX, 8'hX, 8'hX, 8'hX};
        for (i = 0; i < 4; i = i + 1) begin
            address = 5'h18 + i;
            oe = 1'b1;
            cs_n = 1'b0;
            #10;
            if (data !== expected_values[i]) begin
                $display("Unspecified Locations Test: FAILED at address %0h, expected: %0h, got: %0h", 5'h18 + i, expected_values[i], data);
            end else begin
                $display("Unspecified Locations Test: PASSED at address %0h, expected: %0h, got: %0h", 5'h18 + i, expected_values[i], data);
            end
        end
    endtask

    task scramble_and_write_bytes;
        integer i;
        reg [7:0] temp_data;
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
    endtask

    task test_memory_scrambling;
        integer i;
        reg [7:0] expected_values [5'h10:5'h17] = '{8'h73, 8'hDF, 8'h4F, 8'h64, 8'h61, 8'hA9, 8'hBF, 8'h8D};
        for (i = 0; i < 8; i = i + 1) begin
            address = 5'h10 + i;
            oe = 1'b1;
            cs_n = 1'b0;
            #10;
            if (data !== expected_values[i]) begin
                $display("Memory Scrambling Test: FAILED at address %0h, expected: %0h, got: %0h", 5'h10 + i, expected_values[i], data);
            end else begin
                $display("Memory Scrambling Test: PASSED at address %0h, expected: %0h, got: %0h", 5'h10 + i, expected_values[i], data);
            end
        end
    endtask

    task print_memory_contents;
        integer i;
        for (i = 0; i < 32; i = i + 1) begin
            address = i;
            oe = 1'b1;
            cs_n = 1'b0;
            #10;
            $display("Memory Contents at address %0h: %0h", i, data);
        end
    endtask

endmodule

