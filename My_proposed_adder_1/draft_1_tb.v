`timescale 1ns/1ps
`include "draft_1.v"
//`include "brent_kung_adder.v"

module tb_draft_1;

    reg [7:0] a, b;
    wire [8:0] sum;

    draft_1 uut (
        .a(a),
        .b(b),
        .sum(sum)
    );

    integer i, j;
    integer exact_sum;
    integer approx_sum;
    integer error_dist;
    real error_percent;
    integer total_error;
    real total_error_percent;
    integer total_cases;
    integer error_cases;  // count cases where error ≠ 0

    initial begin
        total_error = 0;
        total_error_percent = 0.0;
        total_cases = 0;
        error_cases = 0;

        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;

                #1;

                exact_sum  = i + j;
                approx_sum = sum;

                error_dist = exact_sum - approx_sum;
                if (error_dist < 0) error_dist = -error_dist;

                if (exact_sum != 0) 
                    error_percent = (error_dist * 100.0) / exact_sum;
                else 
                    error_percent = 0.0;

                total_error = total_error + error_dist;
                total_error_percent = total_error_percent + error_percent;
                total_cases = total_cases + 1;

                // Count error cases
                if (error_dist != 0)
                    error_cases = error_cases + 1;
            end
        end

        $display("=======================================");
        $display(" Total Cases            : %0d", total_cases);
        $display(" Total Error Distance   : %0d", total_error);
        $display(" Error Rate (ER)        : %0f%%", 
                 (error_cases * 100.0) / total_cases);
        $display(" MED (Mean Error Dist)  = %0f", 
                 total_error / (1.0 * total_cases));
        $display(" MEP (Mean Error %%)    = %0f%%", 
                 total_error_percent / (1.0 * total_cases));
        $display("=======================================");

        $finish;
    end

endmodule
