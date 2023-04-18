/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: register.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size register file */

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

// Tri-state buffer for read operation
always @ (*) begin
    if (!cs_ni && oe_i) begin
        data_reg = memory[address_i];
    end else begin
        data_reg = 'bz;
    end
end

// Assign the output to inout port
assign data_io = data_reg;

endmodule
