`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE 526L
// Engineer: Justin Fursov
// 
// Create Date: 05/13/2023 04:54:06 PM
// Design Name: Synchronous FIFO
// Module Name: tb_sync_fifo
// Project Name: LAB 10
// Target Devices: Simulation only
// File Name: tb_sync_fifo.sv  
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module tb_sync_fifo;
    // Parameters
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 32;
    parameter ALMOST_COUNT = 2;

    // Signals
    reg clk;
    reg reset;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] wr_data;
    reg [DATA_WIDTH-1:0] rd_data;
    wire empty;
    wire full;
    wire almost_empty;
    wire almost_full;
    wire valid;
    wire overflow;
    wire underflow;
    wire [DEPTH:0] count;

    // Instantiate the FIFO
    sync_fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH), .ALMOST_COUNT(ALMOST_COUNT)) fifo (
        .clk(clk), .reset(reset), .wr_en(wr_en), .rd_en(rd_en), .wr_data(wr_data),
        .rd_data(rd_data), .empty(empty), .full(full), .almost_empty(almost_empty),
        .almost_full(almost_full), .valid(valid), .overflow(overflow), .underflow(underflow),
        .count(count)
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

        // Fill the FIFO
        wr_en = 1;
        for(wr_data = 0; wr_data < DEPTH; wr_data = wr_data + 1) begin
            #10;
        end wr_en = 0;

        // Check full flag
        assert(full);
        
        // Check overflow. Low when wr_en is low
        #10;
        assert(!overflow);
        // High when wr_en high and data is full
        wr_en = 1;
        #10;
        assert(overflow);
        
        // Read and write simultaneously
        wr_data = 32;
        wr_en = 1;
        rd_en = 1;
        #10;
        wr_en = 0;
        #10;
        assert(wr_data != rd_data);



        // Check valid flag
        assert(valid);

        // Empty the FIFO
        rd_en = 1;
        while (count != 0) begin
        #10;
        end


        // Check empty flag
        assert(empty);

        // Check underflow
        rd_en = 1;
        #10;
        assert(underflow);
        #10;
        rd_en = 0;
        // End of the test
        $finish;
    end
endmodule
