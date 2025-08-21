module loa_8bit (
    input  [7:0] a, b,
    output [8:0] sum
);

    assign sum[3:0] = a[3:0] | b[3:0];
    assign {sum[8:4]} = a[7:4] + b[7:4];

endmodule
