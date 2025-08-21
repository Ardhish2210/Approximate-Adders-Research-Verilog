`timescale 1ns/1ps
`include "cla.v"

module tb_cla_4bit;

    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    // Instantiate DUT (Device Under Test)
    cla_4bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Test procedure
    initial begin
        $dumpfile("cla_4bit_tb.vcd"); // For waveform view (GTKWave)
        $dumpvars(0, tb_cla_4bit);

        // Monitor values
        $monitor("Time=%0t | a=%d b=%d cin=%d || sum=%d cout=%d", 
                  $time, a, b, cin, sum, cout);

        // Apply test vectors
        cin = 0; a = 4'b0000; b = 4'b0000; #10;
        cin = 1; a = 4'b0000; b = 4'b0000; #10;
        cin = 0; a = 4'b1010; b = 4'b0101; #10;
        cin = 1; a = 4'b1010; b = 4'b0101; #10;
        cin = 0; a = 4'b1111; b = 4'b0001; #10;
        cin = 1; a = 4'b1111; b = 4'b0001; #10;
        cin = 0; a = 4'b1111; b = 4'b1111; #10;
        cin = 1; a = 4'b1111; b = 4'b1111; #10;

        // Random test cases
        repeat(10) begin
            a   = $random % 16;   // 4-bit random
            b   = $random % 16;
            cin = $random % 2;
            #10;
        end

        $finish;
    end
endmodule
