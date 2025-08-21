module brent_kung_adder_4bit (
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       carry_out
);
    // Step 1: Propagate & Generate
    wire [3:0] p, g;
    assign p = a ^ b;  // Propagate
    assign g = a & b;  // Generate

    // Step 2: Prefix computation
    wire g1_0, g2_0, g3_0, g3_2;
    wire p1_0, p2_0, p3_0, p3_2;

    // Level 1
    assign g1_0 = g[1] | (p[1] & g[0]);
    assign p1_0 = p[1] & p[0];
    assign g3_2 = g[3] | (p[3] & g[2]);
    assign p3_2 = p[3] & p[2];

    // Level 2
    assign g2_0 = g[2] | (p[2] & g1_0);
    assign p2_0 = p[2] & p1_0;

    // Level 3
    assign g3_0 = g3_2 | (p3_2 & g2_0);
    assign p3_0 = p3_2 & p2_0;

    // Step 3: Carry computation (cin included)
    wire [4:0] carry;
    assign carry[0] = cin;
    assign carry[1] = g[0] | (p[0] & carry[0]);
    assign carry[2] = g1_0 | (p1_0 & carry[0]);
    assign carry[3] = g2_0 | (p2_0 & carry[0]);
    assign carry[4] = g3_0 | (p3_0 & carry[0]);

    // Step 4: Sum & Cout
    assign sum       = p ^ carry[3:0];
    assign carry_out = carry[4];
endmodule
