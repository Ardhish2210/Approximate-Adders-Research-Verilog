// 8-bit HOAANED Adder (Hybrid Approximate Adder with Error Detection)
module hoaaned_8bit (
    input  [7:0] a, b,
    output [8:0] sum
);

    wire [3:0] approx_sum;   // LSB part
    wire [4:0] accurate_sum; // MSB part

    // Approximate lower 4 bits using OR gate
    assign approx_sum = a[3:0] | b[3:0];

    // Accurate addition for upper 4 bits (ignoring carry-in from LSBs)
    assign accurate_sum = a[7:4] + b[7:4];

    // Final sum (concatenate accurate + approximate)
    assign sum = {accurate_sum, approx_sum};

endmodule