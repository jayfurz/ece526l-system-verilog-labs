`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE 526L
// Engineer: Justin Fursov
// 
// Create Date: 05/13/2023 04:54:06 PM
// Design Name: Synchronous FIFO
// Module Name: tb_fwft_fifo
// Project Name: LAB 10
// Target Devices: Simulation only
// File Name: tb_fwft_fifo.sv  
// Description: This module checks the FWFT functionality
// 
// Dependencies: sync_fifo.sv
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define FIFO_FWFT 1 // Turn on the `ifdef for FWFT

module tb_fwft_fifo;
    // Parameters
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 32;

    // Signals
    reg clk;
    reg reset;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] wr_data;
    wire [DATA_WIDTH-1:0] rd_data;
    wire empty;
    wire full;

    // Instantiate the FIFO
    sync_fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) fifo (
        .clk(clk), .reset(reset), .wr_en(wr_en), .rd_en(rd_en), .wr_data(wr_data),
        .rd_data(rd_data), .empty(empty), .full(full)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Testbench
    initial begin
        // Reset
        reset = 1;
        #10;
        reset = 0;
        #10;

        // Check that FIFO is empty
        assert(empty);

        // Write a word to the FIFO
        wr_data = 42;
        wr_en = 1;
        #10;
        wr_en = 0;
        #10;

        // Check that the written word appears on the output
        assert(rd_data == 42);
        assert(!empty);

        // Read the word from the FIFO
        rd_en = 1;
        #10;
        rd_en = 0;
        #10;

        // Check that the FIFO is empty
        assert(empty);

        // Fill the FIFO
        wr_en = 1;
        for(wr_data = 0; wr_data < DEPTH; wr_data = wr_data + 1) begin
            #10;
        end wr_en = 0;

        // Check full flag
        assert(full);
        

        // Read and write simultaneously
        wr_data = 0;
        wr_en = 1;
        rd_en = 1;
        #10;
        wr_en = 0;
        #10;

        // Check that FIFO is first in first out and not the opposite
        wr_data = 42;
        wr_en = 1;
        #10;
        assert(rd_data != 42);
        wr_en = 0;
        #10;

        // Empty the FIFO
        rd_en = 1;
        while(!empty) begin
        #10;
        end

        // Check empty flag
        assert(empty);

        // End of the test
        $finish;
    end
endmodule
