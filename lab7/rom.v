/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #7                                                    ***
*** Experiment #7 Variable Size Multiplexer Lab                         ***
*** ***********************************************************************
*** Filename: register.v Created by Justin Fursov, Apr 5 2023           ***
***                                                                     ***
***************************************************************************/

/* This is the module for the variable size register file */
module rom
    #(parameter Width = 8,
    parameter Depth = 5)(
    input oe_i,
    input cs_ni,
    input [Depth-1:0] address_i,
    output reg [Width-1:0] data_o
);

// Declare ROM memory
reg [Width-1:0] memory [0:2**Depth-1];

// Read operation
always @(*) begin
    if (!cs_ni && oe_i) begin
        data_o <= memory[address_i];
    end else begin
        data_o <= 'bz; // Drive high-impedance ('bz) if not enabled
    end
end

endmodule
