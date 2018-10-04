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
	reg[2:0] test_command;
	wire test_alu_code0;
	wire test_alu_code1;
	wire test_alu_code2;
	wire test_set_flags;
	wire test_slt_enable;
	wire test_subtract;

	ALUcontrolLUT test_ALU(test_alu_code0, test_alu_code1, test_alu_code2, test_set_flags, test_slt_enable, test_subtract, test_command);

initial begin
	$dumpfile("lut.vcd");
	$dumpvars();
	$display("Command | ALU Code | Flags | SLT | Subtract");
	$monitor("   %h    |    %h %h %h     |   %h   |  %h  |    %h", test_command, test_alu_code2,test_alu_code1,test_alu_code0, test_set_flags, test_slt_enable, test_subtract);
	test_command = `ADD; #`DELAY; // Flags = 1
	test_command = `SUB; #`DELAY; // Flags = 1, Subtract = 1
	test_command = `XOR; #`DELAY;
	test_command = `SLT; #`DELAY; // SLT = 1, Subtract = 1
	test_command = `AND; #`DELAY;
	test_command = `NAND; #`DELAY;
	test_command = `NOR; #`DELAY;
	test_command = `OR; #`DELAY;

end // inital
endmodule // testALULUT