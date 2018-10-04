`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

`define NAND_GATE nand #20
`define AND_GATE  and #30
`define XOR_GATE  xor #30
`define NOT_GATE  not #10
`define OR_GATE   or #20
`define NOR_32_GATE nor #320
`define AND_32_GATE and #330

`include "bitslice.v"

module ALUcontrolLUT
(
output reg[2:0] alu_code,
output reg      set_flags,
output reg      slt_enable,
output reg      subtract,
input[2:0]      ALUcommand
);

always @(ALUcommand) begin
	case (ALUcommand)
		`ADD:  begin alu_code = 0; set_flags=1; slt_enable = 0; subtract = 0; end    
		`SUB:  begin alu_code = 1; set_flags=1; slt_enable = 0; subtract = 1; end
		`XOR:  begin alu_code = 2; set_flags=0; slt_enable = 0; subtract = 0; end    
		`SLT:  begin alu_code = 3; set_flags=0; slt_enable = 1; subtract = 1; end
		`AND:  begin alu_code = 4; set_flags=0; slt_enable = 0; subtract = 0; end    
		`NAND: begin alu_code = 5; set_flags=0; slt_enable = 0; subtract = 0; end
		`NOR:  begin alu_code = 6; set_flags=0; slt_enable = 0; subtract = 0; end    
		`OR:   begin alu_code = 7; set_flags=0; slt_enable = 0; subtract = 0; end
	endcase
end
endmodule

module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
	wire c[31:0];
	wire zero_nor;
	wire slt_b_and;
	wire slt_a_and;
	wire out[31:0];
	wire alu_code;
	wire set_flags;
	wire slt_enable;
	wire subtract;
	wire overflow_internal;
	wire nb;
	wire nout;
	wire SLT_internal;
	wire nslt_enable;

	//LUT
	ALUcontrolLUT LUT(alu_code,set_flags,slt_enable,subtract,command);

	//Flags
	`XOR_GATE overflow_xor_gate(overflow, c[30], c[31]);
	`AND_GATE overflow_and_gate(overflow,overflow_internal,set_flags);
	`AND_GATE zero_and_gate(zero, zero_nor, set_flags);
	`AND_GATE carryout_and_gate(carryout, c[31], set_flags);
	`NOR_GATE out_nor_gate(zero_nor, out[0], out[1], out[2], out[3], out[4], out[5], out[6], out[7], out[8], out[9], out[10], out[11], out[12], out[13], out[14], out[15], out[16], out[17], out[18], out[19], out[20], out[21], out[22], out[23], out[24], out[25], out[26], out[27], out[28], out[29], out[30], out[31]);

	//SLT
	`NOT_GATE b_not_gate(nb, b[31]);
	`NOT_GATE out_not_gate(nout, out[31]);
	`AND_GATE b_and_gate(slt_b_and, nb, out[31]);
	`AND_GATE out_and_gate(slt_a_and, a[31], nout);
	`OR_GATE  slt_or_gate(SLT_internal, slt_b_and, slt_a_and);
	`NOT_GATE slt_not_gate(nslt_enable, slt_enable);

	//First bitslice
	bitSlice bitslice0( .c_out(out[0]), .carry_out(c[0]), .A(operandA[0]),
		.B(operandB[0]), .carry_in(subtract), .mux_in(alu_code));
		//carry_in subtract on the first bit, to handle the 
		//adding 1 in 2's complement subtraction
	`OR_GATE result_or(result[0],out[0],SLT_internal);

	//Generate remaining bitslices and slt_enable and gates
	genvar i;
	generate
		for(i = 1; i < 32, i = i+1)
		begin:genblock
			bitSlice bitslice( .c_out(out[i]), .carry_out(c[i]), .carry_in(c[i-1])
				.A(operandA[i]), .B(operandB[i]), .mux_in(alu_code));
			`AND_GATE result_and(result[i], out[i], nslt_enable);
		end
	endgenerate

	
endmodule