`include "cla.v"

module draft_3 (a, b, sum);

input [7:0] a, b;
output [8:0] sum;

// IDEOLOGY: 0 to 3rd bit (approximate part) will be computed using basic OR and XOR gates, 
// 4th to 8th bit will be computed using CLA (Accurate part)
// The carry will be propagated from LSP to MSP using the 3rd bit from LSP
// The carry will be pre_calculated

wire cmsp; //cmsp: Carry to the Most Significant Part
assign cmsp = (a[3]&b[3]);

// Approximate part

assign sum[0] = a[0] ^ b[0];
assign sum[1] = a[1] | b[1];
assign sum[2] = a[2] | b[2];
assign sum[3] = a[3] ^ b[3];

// Accurate part
cla_4bit r1 (.a(a[7:4]), .b(b[7:4]), .cin(cmsp), .sum(sum[7:4]), .cout(sum[8]));

endmodule







