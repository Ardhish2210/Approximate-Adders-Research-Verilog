`timescale 1ns/1ns
`include "ripple_carry_adder.v"

module ripple_carry_adder_tb;

reg [7:0] a, b;
wire [8:0] sum;

ripple_carry_adder uut (.a(a), .b(b), .sum(sum));

initial begin
  $dumpfile("ripple_carry_adder.vcd");
  $dumpvars(0, ripple_carry_adder_tb);

  $monitor("a=%d || b=%d || sum=%d", a, b, sum);

  a = 8'd0; b = 8'd0;
  #10 a = 8'd5; b = 8'd10;
  #10 a = 8'd50; b = 8'd25;
  #10 a = 8'd100; b = 8'd200;
  #10 a = 8'd255; b = 8'd1;
  #10 a = 8'd128; b = 8'd128;
  #10 $finish;
end

endmodule
