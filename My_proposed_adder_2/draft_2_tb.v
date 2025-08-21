`timescale 1ns/1ps
`include "draft_2.v"

module tb_draft_2;

    reg [7:0] a, b;
    wire [8:0] approx_sum;
    reg [8:0] exact_sum;

    // DUT
    draft_2 uut (
        .a(a),
        .b(b),
        .sum(approx_sum)
    );

    // Metrics
    integer i, j;
    integer ED;           // Error Distance
    integer total_ED;     // Sum of EDs
    integer total_relED;  // For MRED
    integer total_sqED;   // For MEP
    integer error_cases;  // Count of errors
    integer total_cases;  // Total test cases
    integer maxED;

    real MED, MRED, ER, MEP;

    initial begin
        total_ED = 0;
        total_relED = 0;
        total_sqED = 0;
        error_cases = 0;
        maxED = 0;
        total_cases = 0;

        // Exhaustive test (all 8-bit pairs → 65536 cases)
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;
                #1; // wait for outputs

                exact_sum = i + j;
                ED = (exact_sum > approx_sum) ? (exact_sum - approx_sum) : (approx_sum - exact_sum);

                // accumulate metrics
                total_ED = total_ED + ED;
                total_sqED = total_sqED + (ED * ED);
                if (exact_sum != 0)  // avoid div by zero
                    total_relED = total_relED + (100*ED)/exact_sum;

                if (ED != 0) error_cases = error_cases + 1;
                if (ED > maxED) maxED = ED;

                total_cases = total_cases + 1;
            end
        end

        // Compute averages
        MED  = total_ED / (1.0 * total_cases);
        MRED = total_relED / (1.0 * total_cases); // percentage
        ER   = (100.0 * error_cases) / total_cases;
        MEP  = total_sqED / (1.0 * total_cases);

        // Display Results
        $display("============================================");
        $display(" Approximate Adder Evaluation (8-bit) ");
        $display("============================================");
        $display("Total Cases     : %0d", total_cases);
        $display("Error Rate (ER) : %0.2f %%", ER);
        $display("Mean Error Dist : %0.2f", MED);
        $display("Mean Rel. ED    : %0.2f %%", MRED);
        $display("Max Error Dist  : %0d", maxED);
        $display("Mean Error Power: %0.2f", MEP);
        $display("============================================");

        $finish;
    end

endmodule