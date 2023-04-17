/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Register File Lab                       ***
*** ***********************************************************************
*** Filename: register_tb.v Created by Justin Fursov, Apr 5 2023        ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size registe file */
`timescale 1ns/1ps

module register_file_tb;

    // Parameters
    localparam Width = 8;
    localparam Depth = 5;

    // Signals
    reg oe;
    reg cs_n;
    reg ws;
    reg [Depth-1:0] address;
    wire [Width-1:0] data;

    // Instantiate the register file module
    register_file #(Width, Depth) register_file_inst(
        .oe_i(oe),
        .cs_ni(cs_n),
        .ws_i(ws),
        .address_i(address),
        .data_io(data)
    );

    // Test bench stimulus
    initial begin

        // Reset
        oe = 1'b0;
        cs_n = 1'b1;
        ws = 1'b0;
        address = 0;

        // Test case 1: Write data to the register file
        #10 cs_n = 1'b0;
        #10 ws = 1'b1;
        #10 address = 4'b0000;
        #10 data = 8'b0001_0010;
        #10 ws = 1'b0;
        #10 cs_n = 1'b1;

        // Test case 2: Read data from the register file
        #10 oe = 1'b1;
        #10 cs_n = 1'b0;
        #10 address = 4'b0000;
        #10 cs_n = 1'b1;

        // Test case 3: Write data to another address
        #10 cs_n = 1'b0;
        #10 ws = 1'b1;
        #10 address = 4'b0001;
        #10 data = 8'b1100_1100;
        #10 ws = 1'b0;
        #10 cs_n = 1'b1;

        // Test case 4: Read data from another address
        #10 oe = 1'b1;
        #10 cs_n = 1'b0;
        #10 address = 4'b0001;
        #10 cs_n = 1'b1;

        // Test case 5: Read data from the first address again
        #10 address = 4'b0000;
        #10 cs_n = 1'b1;

        // Finish the simulation
        #10 $finish;
    end

endmodule
