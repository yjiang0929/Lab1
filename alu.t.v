// ALU testbench
`timescale 1 ns / 1 ps
`include "alu.v"
`define DELAY 5000

module testALU();
    reg[31:0] a;
    reg[31:0] b;
    wire[31:0] r;
    wire[3:0] control;
    wire zero, co, ofl;

    ALU32bit alu(r, control, zero, co, ofl, a, b);

initial begin
  $dumpfile("alu.vcd");
  $dumpvars();
  $display("32 Bit ADD tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd0; a = 32'h0000000; b = 32'h00000000; #`DELAY //0+0
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'h01234567; b = 32'h0FFFFFFF; #`DELAY //test pos+pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'h7FFFFFFF; b = 32'h7FFFFFFF; #`DELAY //test pos+pos overflow
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   1    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY //test neg+neg carryout
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   1    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'h90000000; b = 32'h80000000; #`DELAY //test neg+neg carryout+overflow
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   1    |   1    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'h812345678; b = 32'h12345678; #`DELAY //test pos+neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");
  control=3'd0; a = 32'hE12345678; b = 32'h72345678; #`DELAY //test pos+neg carryout
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a+b)
      $display("R Error");

  $display("32 Bit SUB tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd1; a = 32'h12345678; b = 32'h12345678; #`DELAY //a-b=0
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'h7FFFFFFF; b = 32'h71234567; #`DELAY //pos-pos=pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'h71234567; b = 32'h7FFFFFFF; #`DELAY //pos-pos=neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'hFFFFFFFF; b = 32'hF1234567; #`DELAY //neg-neg=pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'hF1234567; b = 32'hFFFFFFFF; #`DELAY //neg-neg=neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'h71234567; b = 32'hF1234567; #`DELAY //pos-neg=pos overflow
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   1    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'h37654321; b = 32'hE1234567; #`DELAY //pos-neg=pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'hE7654321; b = 32'h31234567; #`DELAY //neg-pos=neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");
  control=3'd1; a = 32'hA7654321; b = 32'h71234567; #`DELAY //neg-pos=neg overflow
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   1    |   0", control, a, b, r, co, ofl, zero);
  if (r != a-b)
      $display("R Error");

  $display("32 Bit XOR tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd2; a = 32'h87654321; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");
  control=3'd2; a = 32'hFFFFFFFF; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");
  control=3'd2; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");
  control=3'd2; a = 32'h00000000; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");
  control=3'd2; a = 32'h00000000; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");
  control=3'd2; a = 32'hFFFFFFFF; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a^b)
      $display("R Error");

  $display("32 Bit SLT tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd3; a = 32'h00000000; b = 32'h00000000; #`DELAY //0=0
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000000)
      $display("R Error");
  control=3'd3; a = 32'h7FFFFFFF; b = 32'h12345678; #`DELAY //pos>pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000000)
      $display("R Error");
  control=3'd3; a = 32'h12345678; b = 32'h7FFFFFFF; #`DELAY //pos<pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000001)
      $display("R Error");
  control=3'd3; a = 32'hFFFFFFFF; b = 32'h81234567; #`DELAY //neg>neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000000)
      $display("R Error");
  control=3'd3; a = 32'h81234567; b = 32'hFFFFFFFF; #`DELAY //neg<neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000001)
      $display("R Error");
  control=3'd3; a = 32'h7FFFFFFF; b = 32'hFFFFFFFF; #`DELAY //pos>neg
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000000)
      $display("R Error");
  control=3'd3; a = 32'hFFFFFFFF; b = 32'h7FFFFFFF; #`DELAY //neg<pos
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != 32'h00000001)
      $display("R Error");

  $display("32 Bit AND tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd4; a = 32'h87654321; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");
  control=3'd4; a = 32'hFFFFFFFF; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");
  control=3'd4; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");
  control=3'd4; a = 32'h00000000; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");
  control=3'd4; a = 32'h00000000; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");
  control=3'd4; a = 32'hFFFFFFFF; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a&b)
      $display("R Error");

  $display("32 Bit NAND tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd5; a = 32'h87654321; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");
  control=3'd5; a = 32'hFFFFFFFF; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");
  control=3'd5; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");
  control=3'd5; a = 32'h00000000; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");
  control=3'd5; a = 32'h00000000; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");
  control=3'd5; a = 32'hFFFFFFFF; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~&b)
      $display("R Error");

  $display("32 Bit NOR tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd6; a = 32'h87654321; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");
  control=3'd6; a = 32'hFFFFFFFF; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");
  control=3'd6; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");
  control=3'd6; a = 32'h00000000; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");
  control=3'd6; a = 32'h00000000; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");
  control=3'd6; a = 32'hFFFFFFFF; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a~|b)
      $display("R Error");

  $display("32 Bit OR tests");
  $display("Control |                A                 |                B                 |                R                   |COut | OFL |ZERO |Cout Exp| OFL Exp|ZERP Exp");
  control=3'd7; a = 32'h87654321; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
  control=3'd7; a = 32'hFFFFFFFF; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
  control=3'd7; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
  control=3'd7; a = 32'h00000000; b = 32'h12345678; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
  control=3'd7; a = 32'h00000000; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   1", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
  control=3'd7; a = 32'hFFFFFFFF; b = 32'h00000000; #`DELAY
  $display("%b  | %b | %b |  %b  |  %b  |  %b  |  %b  |   0    |   0    |   0", control, a, b, r, co, ofl, zero);
  if (r != a|b)
      $display("R Error");
end

endmodule