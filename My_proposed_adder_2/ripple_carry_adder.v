`include "full_adder.v"

module ripple_carry_adder (a, b, sum, cin, cout);

input cin;
input [3:0] a, b;
output [3:0] sum;
output cout;

wire c0, c1, c2;

full_adder f0 (.a(a[0]), .b(b[0]), .sum(sum[0]), .cin(1'b0), .cout(c0));
full_adder f1 (.a(a[1]), .b(b[1]), .sum(sum[1]), .cin(c0), .cout(c1));
full_adder f2 (.a(a[2]), .b(b[2]), .sum(sum[2]), .cin(c1), .cout(c2));
full_adder f3 (.a(a[3]), .b(b[3]), .sum(sum[3]), .cin(c2), .cout(cout));
// full_adder f4 (.a(a[4]), .b(b[4]), .sum(sum[4]), .cin(c3), .cout(c4));
// full_adder f5 (.a(a[5]), .b(b[5]), .sum(sum[5]), .cin(c4), .cout(c5));
// full_adder f6 (.a(a[6]), .b(b[6]), .sum(sum[6]), .cin(c5), .cout(c6));
// full_adder f7 (.a(a[7]), .b(b[7]), .sum(sum[7]), .cin(c6), .cout(sum[8]));

endmodule