/**************************************************************************
**   	                                                                ***
*** ECE 526 L Lab #8                                                    ***
*** Experiment #8 Variable Size Multiplier Adder                        ***
*** ***********************************************************************
*** Filename: exhaustive_tb.v Created by Justin Fursov, Apr 18 2023     ***
***                                                                     ***
***************************************************************************/

/* This is the module for the exhaustive testbench */
`timescale 1ns/1ps

module tb_sum_of_products_exhaustive();

parameter DATA_WIDTH = 4;
reg clk;
reg rst;
reg [DATA_WIDTH-1:0] data_in, coef11, coef12, coef21, coef22;
wire [2*DATA_WIDTH+1:0] final_sum;

// Instantiate the sum_of_products module
sum_of_products #(
    .DATA_WIDTH(DATA_WIDTH)
) sum_of_products_inst (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .coef11(coef11),
    .coef12(coef12),
    .coef21(coef21),
    .coef22(coef22),
    .final_sum(final_sum)
);

// Clock generator
always
    #5 clk = ~clk;

// Non-hierarchical sum of products with clocked data_in registers
reg [DATA_WIDTH-1:0] data_in_reg1, data_in_reg2, data_in_reg3;
reg [2*DATA_WIDTH+1:0] non_hierarchical_sum;
reg [4:0] i, j, k, l, m;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_in_reg1 <= 0;
        data_in_reg2 <= 0;
        data_in_reg3 <= 0;
    end else begin
        data_in_reg1 <= data_in;
        data_in_reg2 <= data_in_reg1;
        data_in_reg3 <= data_in_reg2;
    end
end

always @(posedge clk) begin
    non_hierarchical_sum <= (data_in * coef11 + data_in_reg1 * coef12) + (data_in_reg2 * coef21 + data_in_reg3 * coef22);
end

// `define FORCE_ERROR
`ifdef FORCE_ERROR
initial begin
    $display("Forcing error at simulation time 1920");
    #31457000 $monitoron;
    #280 force sum_of_products_inst.final_sum = 1'b1;
    #280 $monitoroff;
    #1940 release sum_of_products_inst.final_sum;

end
`endif

// Testbench stimulus
initial begin
    // Initialize inputs
    clk = 0;
    rst = 0;
    data_in = 0;
    coef11 = 0;
    coef12 = 0;
    coef21 = 0;
    coef22 = 0;

    // Apply reset
    rst = 1;
    #10 rst = 0;

    // Monitor the inputs and output
    $monitor("At time %t: data_in=%d coef11=%d coef12=%d coef21=%d coef22=%d final_sum=%d non_hierarchical_sum=%d", $time, data_in, coef11, coef12, coef21, coef22, final_sum, non_hierarchical_sum);
    $monitoroff;

    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 16; k = k + 1) begin
                for (l = 0; l < 16; l = l + 1) begin
                    for (m = 0; m < 16; m = m + 1) begin
                        data_in <= i;
                        coef11 <= j;
                        coef12 <= k;
                        coef21 <= l;
                        coef22 <= m;

                        // Add some delay to make sure the output is stable
                        #40;
                        
                        if (final_sum !== non_hierarchical_sum) begin
                            $display("Error at time %t: data_in=%d coef11=%d coef12=%d coef21=%d coef22=%d final_sum=%d expected_sum=%d", $time, data_in, coef11, coef12, coef21, coef22, final_sum, non_hierarchical_sum);
                            $finish;
                        end

                        if (i == 15 && j == 15 && k == 15 && l == 15 && m == 15) begin
                            $display("All test vectors passed!");
                            $finish;
                        end
                        
                        // monitor on when it's either the first or last 16
                        // vectors
                        if ((i == 0 && j == 0 && k == 0 && l == 0) || (i == 15 && j == 15 && k == 15 && l == 15)) begin
                            $monitoron;

                        // monitor off after the first 16 vectors.
                        end else if (i == 0 && j == 0 && k == 0 && l == 1 && m == 0) begin
                            $monitoroff;
                        end
                    end
                end
            end
        end
    end
end

endmodule                          
