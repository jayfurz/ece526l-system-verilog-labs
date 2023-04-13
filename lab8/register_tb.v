/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Register File Lab                       ***
*** ***********************************************************************
*** Filename: register_tb.v Created by Justin Fursov, Apr 5 2023        ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size registe file */

module register_file_tb();
reg oe_i, cs_ni, ws_i;
reg [5:0] address_i;
reg [7:0] data_io;

register_file rf_1(
    .data_io(data_io),
    .address_i(address_i),
    .oe_i(oe_i),
    .cs_ni(cs_ni),
    .ws_i(ws_i)
);

initial begin
    $monitor();
    
end


endmodule

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
