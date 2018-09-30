// Adder testbench
`timescale 1 ns / 1 ps
`include "nand.v"
`define DELAY 5000

module testAnd();
    reg[31:0] a;
    reg[31:0] b;
    wire[31:0] sum;
    wire overflow, carryout;

    structuralNand nandBrick(sum, a, b);
// We can add -8 through +7
initial begin
  // $dumpfile("adder.vcd");
  // $dumpvars();
  $display("Temp Tests");
  $display(" A   |  B   | Sum  | Carryout | Overflow | Sum Exp | Carryout Exp | Overflow Exp");            // Prints header for truth table
  a = 32'b00000000000000000000000000000000; b = 32'b00000000000000000000000000000000; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  0000   | 0            | 0", a, b, sum, carryout, overflow);
  a = 32'b11111111111111111111111111111111; b = 32'b11111111111111111111111111111111; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  0001   | 0            | 0", a, b, sum, carryout, overflow);
  a = 32'b11111111111111111111111111111111; b = 32'b00000000000000000000000000000000; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  0001   | 0            | 0", a, b, sum, carryout, overflow);
  a = 32'b11111111111111111000011111111111; b = 32'b11000011111111111111111111111111; #`DELAY                                 // Set A and B, wait for update (#1)
  $display("%b | %b | %b |   %b      |    %b     |  1000   | 0            | 1", a, b, sum, carryout, overflow);

end
endmodule
