// hoeraa_8bit.v
module hoeraa_8bit (
    input  [7:0] a, b,
    output [8:0] sum
);

    wire carry_in;

    // Approximate part
    assign sum[0] = 1'b1;        // Force bit0 to 1
    assign sum[1] = 1'b1;        // Force bit1 to 1
    assign sum[2] = a[2] | b[2]; // OR logic
    assign sum[3] = a[3] | b[3]; // OR logic

    // Carry-in to accurate part = AND of MSB approx bit
    assign carry_in = a[3] & b[3];

    // Accurate part (upper 4 bits with carry-in)
    assign {sum[8], sum[7:4]} = a[7:4] + b[7:4] + carry_in;

endmodule
