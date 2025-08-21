`timescale 1ns/1ps
`include "eta.v"

//===================================================
// Testbench for ETA Adder (8-bit)
//===================================================
module tb_eta_adder_8bit;

    reg  [7:0] a, b;
    wire [8:0] approx_sum;   // ETA output
    integer exact_sum;       // Golden reference

    integer i, j;
    integer error_dist;
    real error_percent;

    integer total_error;
    real total_error_percent;
    integer total_cases;
    integer error_cases;

    // DUT: ETA Adder
    eta_adder_8bit uut (
        .a(a),
        .b(b),
        .sum(approx_sum)
    );

    initial begin
        total_error = 0;
        total_error_percent = 0.0;
        total_cases = 0;
        error_cases = 0;

        // Sweep all possible input combinations
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i;
                b = j;

                #1; // wait for signals to settle

                // Reference exact sum (no module, just operator)
                exact_sum = i + j;

                // Error distance
                error_dist = exact_sum - approx_sum;
                if (error_dist < 0) error_dist = -error_dist;

                // Error percentage
                if (exact_sum != 0)
                    error_percent = (error_dist * 100.0) / exact_sum;
                else
                    error_percent = 0.0;

                // Accumulate totals
                total_error = total_error + error_dist;
                total_error_percent = total_error_percent + error_percent;
                total_cases = total_cases + 1;

                if (error_dist != 0)
                    error_cases = error_cases + 1;
            end
        end

        // Report results
        $display("=======================================");
        $display("ETA Adder (8-bit) Evaluation Results");
        $display(" Total Cases           : %0d", total_cases);
        $display(" Total Error Distance  : %0d", total_error);
        $display(" Error Rate (ER)       : %0f%%", 
                 (error_cases * 100.0) / total_cases);
        $display(" MED (Mean Error Dist) : %0f", 
                 total_error / (1.0 * total_cases));
        $display(" MEP (Mean Error %% )  : %0f%%", 
                 total_error_percent / (1.0 * total_cases));
        $display("=======================================");

        $finish;
    end

endmodule
