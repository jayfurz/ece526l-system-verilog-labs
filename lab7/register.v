/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: register.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size registe file */

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
always @ (posedge ws_i) begin
    if (!cs_ni && !oe_i) begin
        memory[address_i] <= data_io;
    end
end

assign data_io = (!cs_ni && oe_i)? memory[address_i]: 'bz;

endmodule
