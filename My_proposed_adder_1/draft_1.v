`include "brent_kung_adder.v"

module draft_1 (a, b, sum);

input [7:0] a, b;
output [8:0] sum;

// IDEOLOGY: 0 to 3rd bit (approximate part) will be computed using basic OR gates, 
// 4th to 8th bit will be computed using BRENT_KUNG_ADDER (Accurate part)
// The carry will be propagated from LSP to MSP using the 2nd and 3rd bit from LSP
// The carry will be pre_calculated

wire G_3, G_2, P_3; // G: Carry_generated, P: Carry_propagated 
wire cmsp; //cmsp: Carry to the Most Significant Part

assign G_3 = a[3]&b[3];
assign G_2 = a[2]&b[2];
assign P_3 = a[3]^b[3];

assign cmsp = G_3 | (G_2&P_3);

// Approximate part
assign sum[0] = a[0] | b[0];
assign sum[1] = a[1] | b[1];
assign sum[2] = a[2] | b[2];
assign sum[3] = a[3] ^ b[3];

// Accurate part
brent_kung_adder_4bit b1 (.a(a[7:4]), .b(b[7:4]), .cin(cmsp), .sum(sum[7:4]), .carry_out(sum[8]));

endmodule