module oloca_8bit #(parameter APPROX_BITS = 4) (
    input  [7:0] a,
    input  [7:0] b,
    output [8:0] sum
);

    // Split signals
    wire [APPROX_BITS-1:0] a_low, b_low;
    wire [7-APPROX_BITS:0] a_high, b_high;

    assign a_low  = a[APPROX_BITS-1:0];
    assign b_low  = b[APPROX_BITS-1:0];
    assign a_high = a[7:APPROX_BITS];
    assign b_high = b[7:APPROX_BITS];

    // Approximate part (OR-based with optimization)
    wire [APPROX_BITS-1:0] approx_sum;
    assign approx_sum = a_low | b_low;

    // Constant carry assumption (optimization)
    wire const_carry;
    assign const_carry = 1'b0;  // can also try '1' for bias adjustment

    // Accurate part (Adder for MSBs)
    wire [8-APPROX_BITS:0] accurate_sum;
    assign accurate_sum = {1'b0, a_high} + {1'b0, b_high} + const_carry;

    // Combine results
    assign sum = {accurate_sum, approx_sum};

endmodule
