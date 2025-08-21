`timescale 1ns/1ps
`include "gear.v"

module tb_gear_adder_8bit;

    reg  [7:0] a, b;
    wire [8:0] approx_sum;
    reg  [8:0] exact_sum;

    // DUT
    gear_adder_8bit uut (
        .a(a),
        .b(b),
        .sum(approx_sum)
    );

    // Metrics
    integer i, j;
    integer total_cases;
    integer error_count;
    integer error_val;
    integer abs_error;

    real AE, MAE, MSE, RMSE, MEP; 
    real error_sum, abs_error_sum, sq_error_sum;

    initial begin
        error_count   = 0;
        error_sum     = 0;
        abs_error_sum = 0;
        sq_error_sum  = 0;
        total_cases   = 0;

        // Exhaustive test for 8-bit inputs
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 256; j = j + 1) begin
                a = i; b = j;
                #1; // evaluation delay

                exact_sum = a + b;
                error_val = approx_sum - exact_sum;
                abs_error = (error_val < 0) ? -error_val : error_val;

                // Accumulate metrics
                if (error_val != 0)
                    error_count = error_count + 1;

                error_sum     = error_sum + error_val;
                abs_error_sum = abs_error_sum + abs_error;
                sq_error_sum  = sq_error_sum + (error_val * error_val);

                total_cases   = total_cases + 1;
            end
        end

        // Compute error metrics
        AE   = error_sum / total_cases;
        MAE  = abs_error_sum / total_cases; // same as MED
        MSE  = sq_error_sum / total_cases;
        RMSE = $sqrt(MSE);
        MEP  = (MAE / 510.0) * 100.0;  // max exact sum for 8-bit + 8-bit = 510

        $display("============================================");
        $display("GeAr 8-bit Approximate Adder Error Metrics");
        $display("Total Cases             = %0d", total_cases);
        $display("Error Rate (ER)         = %0.4f %%", (error_count*100.0)/total_cases);
        $display("Average Error (AE)      = %0.4f", AE);
        $display("Mean Abs Error (MAE/MED)= %0.4f", MAE);
        $display("Mean Square Error (MSE) = %0.4f", MSE);
        $display("Root MSE (RMSE)         = %0.4f", RMSE);
        $display("Mean Error Percentage   = %0.4f %%", MEP);
        $display("============================================");

        $finish;
    end

endmodule
