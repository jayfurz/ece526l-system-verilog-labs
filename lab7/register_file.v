/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: register.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size register file */
`timescale 1ns/1ps
module register_file
    #(parameter Width = 8,
    parameter Depth = 5)(
    input oe_i,
    input cs_ni,
    input ws_i,
    input [Depth-1:0] address_i,
    inout [Width-1:0] data_io
);

reg [Width-1:0] memory [0:2**Depth-1];
reg [Width-1:0] data_reg;

// Write to memory
always @ (posedge ws_i) begin
    if (!cs_ni && !oe_i) begin
        memory[address_i] <= data_io;
    end
end
wire read_enable;
assign read_enable = (!cs_ni && oe_i);
genvar i;
generate
    for (i= 0; i < Width; i = i+1) begin : tristate_buf
        bufif1 buffer (data_io[i], memory[address_i][i], read_enable);
    end
endgenerate

// Tri-state buffer for read operation
//bufif1 [Width-1:0] tri_buffer(data_io, memory[address_i], read_enable);

endmodule
