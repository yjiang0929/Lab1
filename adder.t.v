// Adder testbench
`timescale 1 ns / 1 ps
`include "adder.v"
`define DELAY 5000

module testFullAdder();
    reg[31:0] a;
    reg[31:0] b;
    wire[31:0] sum;
    wire overflow, carryout;

    FullAdderbit adder(sum, carryout, overflow, a, b);
// We can add -8 through +7
initial begin
  $display("Four Bit Full Adder positive + positive Tests");
  $display(" A   |  B   | Sum  | Carryout | Overflow | Sum Exp | Carryout Exp | Overflow Exp");            // Prints header for truth table
  a = 32'b00000000000000000000000000000000; b = 32'b00000000000000000000000000000000; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  0000   | 0            | 0", a, b, sum, carryout, overflow);
  a = 32'b11111111111111111111111111111111; b = 32'b00000000000000000000000000000000; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  0001   | 0            | 0", a, b, sum, carryout, overflow);

end
//For hte 16 test cases, we want:
// two positive numbers added with and w/out overflow
// two negative numbers added with and w/out overflow
// A positive number added with and w/out overflow and Carryout
// There will always be overflow with positive and negative?



endmodule
