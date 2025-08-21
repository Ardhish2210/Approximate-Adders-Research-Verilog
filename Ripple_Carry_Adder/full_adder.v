module full_adder (a, b, sum, cin, cout);

input a, b, cin;
output sum, cout;

assign sum = a ^ b ^ cin;
assign cout = (a&b) | (b&cin) | (cin&a);

endmodule