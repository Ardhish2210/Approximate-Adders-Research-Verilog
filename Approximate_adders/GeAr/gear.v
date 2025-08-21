// GeAr Approximate Adder (8-bit)
// Lower 4 bits: Approximate (OR/XOR-based, no carry propagation)
// Upper 4 bits: Accurate (Ripple Carry Adder)

module gear_adder_8bit (
    input  [7:0] a, b,
    output [8:0] sum
);
    wire [3:0] approx_sum;
    wire [3:0] acc_sum;
    wire       carry_out;

    // --- Approximate Part (Lower 4 bits) ---
    // Method: Sum = a XOR b, ignore carry propagation
    assign approx_sum = a[3:0] ^ b[3:0];

    // --- Accurate Part (Upper 4 bits) ---
    // Normal Ripple Carry Adder
    wire [4:0] acc;
    assign acc = a[7:4] + b[7:4];  
    assign acc_sum = acc[3:0];
    assign carry_out = acc[4];

    // --- Final Sum Concatenation ---
    assign sum = {carry_out, acc_sum, approx_sum};

endmodule
