// 4-bit Carry Lookahead Adder
module cla_4bit (
    input  [3:0] a, b,     // 4-bit inputs
    input        cin,      // Carry in
    output [3:0] sum,      // 4-bit sum
    output       cout      // Carry out
);

    wire [3:0] p, g;   // propagate and generate
    wire [4:1] c;      // internal carries

    // Propagate and Generate
    assign p = a ^ b;      // propagate = a XOR b
    assign g = a & b;      // generate  = a AND b

    // Carry Lookahead Logic
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

    // Sum calculation
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c[1];
    assign sum[2] = p[2] ^ c[2];
    assign sum[3] = p[3] ^ c[3];

endmodule
