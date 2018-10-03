`timescale 1 ns / 1 ps
`include "alu.v"
`define DELAY 5000

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module testALULUT();
	reg[2:0] command;
	wire[2:0] alu_code;
	wire set_flags;
	wire slt_enable;
	wire subtract;

	ALUcontrolLUT ALU(alu_code, set_flags, slt_enable, subtract, command);

initial begin
	$dumpfile("lut.vcd");
	$dumpvars();
	$display("Command | ALU Code | Flags | SLT | Subtract");
	$monitor("   %h    |    %h     |   %h   |  %h  |    %h", command, alu_code, set_flags, slt_enable, subtract);
	command = `ADD; #`DELAY; // Flags = 1
	command = `SUB; #`DELAY; // Flags = 1, Subtract = 1
	command = `XOR; #`DELAY;
	command = `SLT; #`DELAY; // SLT = 1, Subtract = 1
	command = `AND; #`DELAY;
	command = `NAND; #`DELAY;
	command = `NOR; #`DELAY;
	command = `OR; #`DELAY;

end // inital
endmodule // testALULUT