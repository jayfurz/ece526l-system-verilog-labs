/**************************************************************************
***   	                                                                ***
*** ECE 526 L Lab #9                                                    ***
*** Experiment #9 ALU                                                   ***
*** ***********************************************************************
*** Filename: alu.v Created by Justin Fursov, Apr 18 2023             ***
***                                                                     ***
***************************************************************************/

/* This is the module for the ALU                */

`timescale 1ns/100ps

module alu #(
    parameter WIDTH = 8) (
    input CLK, EN, OE,
    input [3:0] OPCODE,
    // this is where the compilation is conditional--whether or not it is going
    // to be signed.
//`define SIGNED_OPERANDS

`ifdef SIGNED_OPERANDS
    input signed [WIDTH-1:0] A, B,
    output reg signed [WIDTH-1:0] ALU_OUT,
`else
    input [WIDTH-1:0] A, B,
    output reg [WIDTH-1:0] ALU_OUT,
`endif

    // CF is carry flag, OF- Overflow, SF-Signflag, ZF-Zeroflag
    output reg CF, OF, SF, ZF
);

    // Localparams for opcodes
    localparam ADD_OP  = 4'b0010;
    localparam SUB_OP  = 4'b0011;
    localparam AND_OP  = 4'b0100;
    localparam OR_OP   = 4'b0101;
    localparam XOR_OP  = 4'b0110;
    localparam NOTA_OP = 4'b0111;
    
`ifdef SIGNED_OPERANDS
    reg signed [WIDTH-1:0] result;
    reg signed [WIDTH:0] add_result;
`else
    reg [WIDTH-1:0] result;
    reg [WIDTH:0] add_result;
`endif

    always @(posedge CLK) begin
        if (EN) begin
            case (OPCODE)
                ADD_OP: begin
                    add_result = A + B;
                    result = add_result[WIDTH-1:0];
                    CF = add_result[WIDTH];
                    OF = (A[WIDTH-1] == B[WIDTH-1]) && (A[WIDTH-1] != result[WIDTH-1]);
                end
                
                SUB_OP: begin
                    add_result = A + (~B + 1);
                    result = add_result[WIDTH-1:0];
                    CF = (A < B) ? 1 : 0;
                    OF = (A[WIDTH-1] != B[WIDTH-1]) && (A[WIDTH-1] != result[WIDTH-1]);
                end
                
                AND_OP: result = A & B;
                OR_OP: result = A | B;
                XOR_OP: result = A ^ B;
                NOTA_OP: result = ~A;
                default: ; // Ignore other opcodes
            endcase
            
            SF = result[WIDTH-1];
            ZF = (result == 0) ? 1 : 0;
        end
    end
    
    always @(posedge CLK) begin
        if (OE) begin
            ALU_OUT = result;
        end
        else begin
            ALU_OUT = {WIDTH{1'bz}};
        end
    end

endmodule
