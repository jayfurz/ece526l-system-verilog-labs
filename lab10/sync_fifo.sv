`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: ECE 526L
// Engineer: Justin Fursov
// 
// Create Date: 05/13/2023 04:54:06 PM
// Design Name: Synchronous FIFO
// Module Name: sync_fifo
// Project Name: LAB 10
// Target Devices: Simulation only
// File Name: sync_fifo.sv 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sync_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 32,
    parameter ALMOST_COUNT = 2
) (
    input wire clk,
    input wire reset,
    input wire wr_en,
    input wire rd_en,
    input wire [DATA_WIDTH-1:0] wr_data,
    output reg [DATA_WIDTH-1:0] rd_data,
    output wire empty,
    output wire full,
    output wire almost_empty,
    output wire almost_full,
    output wire valid,
    output wire overflow,
    output wire underflow,
    output wire [DEPTH:0] count
);

// Write and read pointers
reg [DEPTH:0] wr_ptr = 0;
reg [DEPTH:0] rd_ptr = 0;

// Memory
reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

`ifdef FIFO_FWFT
    // FWFT read data register
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            rd_data <= 0;
        end else begin
            if(wr_en && !full) begin
                memory[wr_ptr] <= wr_data;
                wr_ptr <= wr_ptr + 1;
                if (empty) begin
                    rd_data <= wr_data;
                end
            end
            if(rd_en && !empty) begin
                rd_data <= memory[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end
        end
    end

`else
    // Normal logic
    always @(posedge clk or posedge reset) begin
    if(reset) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end else begin
        if(wr_en && !full) begin
            memory[wr_ptr] <= wr_data;
            wr_ptr <= wr_ptr + 1;
        end
        if(rd_en && !empty) begin
            rd_data <= memory[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end
end
`endif

assign empty = (wr_ptr == rd_ptr);
assign full = (wr_ptr == rd_ptr + 32);
assign almost_empty = (wr_ptr - rd_ptr <= ALMOST_COUNT && rd_ptr != wr_ptr);
assign almost_full = (rd_ptr - wr_ptr <= ALMOST_COUNT && rd_ptr != wr_ptr);
assign valid = (rd_en && !empty);
assign overflow = (wr_en && full);
assign underflow = (rd_en && empty);
assign count = wr_ptr - rd_ptr;

endmodule

