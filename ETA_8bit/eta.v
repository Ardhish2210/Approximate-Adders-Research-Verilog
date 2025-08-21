module eta_adder_8bit (
    input  [7:0] a,
    input  [7:0] b,
    output [8:0] sum
);

    wire [3:0] a_low, b_low, a_high, b_high;
    wire [3:0] sum_low;
    wire [4:0] sum_high;
    wire carry_high;

    assign a_low  = a[3:0];
    assign b_low  = b[3:0];
    assign a_high = a[7:4];
    assign b_high = b[7:4];

    assign sum_low[0] = a_low[0] ^ b_low[0];   // bit0
    assign sum_low[1] = a_low[1] | b_low[1];   // bit1
    assign sum_low[2] = a_low[2] | b_low[2];   // bit2
    assign sum_low[3] = a_low[3] | b_low[3];   // bit3

    assign carry_high = a_low[3] & b_low[3];

    ripple_carry_adder #(4) rca_high (
        .a(a_high),
        .b(b_high),
        .cin(carry_high),
        .sum(sum_high)
    );

    assign sum = {sum_high, sum_low};

endmodule

module ripple_carry_adder #(parameter N=4) (
    input  [N-1:0] a, b,
    input          cin,
    output [N:0]   sum
);
    wire [N:0] c;
    assign c[0] = cin;

    genvar i;
    generate
        for (i=0; i<N; i=i+1) begin : RCA
            full_adder fa (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate

    assign sum[N] = c[N];
endmodule

module full_adder (
    input a, b, cin,
    output sum, cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
