`timescale 1ns/1ps
`include "brent_kung_adder.v"

module tb_brent_kung_adder_4bit;
    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       carry_out;

    // Instantiate DUT
    brent_kung_adder_4bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry_out(carry_out)
    );

    initial begin
        $dumpfile("brent_kung_4bit.vcd");
        $dumpvars(0, tb_brent_kung_adder_4bit);

        $monitor("t=%0t | a=%b(%0d) b=%b(%0d) cin=%b | sum=%b(%0d) cout=%b",
                 $time, a, a, b, b, cin, sum, sum, carry_out);

        // Test all combinations
        for (integer i = 0; i < 16; i = i + 1) begin
            for (integer j = 0; j < 16; j = j + 1) begin
                for (integer k = 0; k < 2; k = k + 1) begin
                    a   = i;
                    b   = j;
                    cin = k;
                    #5;
                end
            end
        end
        $finish;
    end
endmodule
