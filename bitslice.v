`define AND and #30
`define NAND nand #20
`define OR or #30
`define NOR nor #20
`define NOT not #10
`define XOR xor #30

`define FOURAND and #50
`define EIGHTOR or #90

// Use the structural full adder created in earlier homeworks/labs.
module structuralFullAdder
(
    output sum, //Sum value
    output carryout, //Carryout value
    input A, //Input one
    input B, //Input two
    input carryin //Carryin
);
    //Wire definitions
    wire AxorB;
    wire AxorBandC;
    wire AandB;

    //Handle sum logic
    `XOR AxorBgate(AxorB, A, B);
    `XOR AxorBxorCgate(sum, AxorB, carryin);

    //Handle the carryout logic
    `AND AandBgate(AandB,A,B);
    `AND AxorBandCgate(AxorBandC, AxorB, carryin);
    `OR  orgate(carryout, AxorBandC, AandB);

endmodule


//Module for handling bitslicing.
module bitSlice
(
    output c_out, //Output we're looking for
    output carry_out, //Carryout flag
    input A, //Input one
    input B, //Input two
    input carry_in, //Carryin flag for addition
    input subtract, //Flag used to convert adder to subtractor
    input[2:0] mux_in //Bitstring indicating mux values
);
    //Wire declaration
    wire sub_xor_out;
    wire adder_out;
    wire nor_out;
    wire and_out;
    wire nand_out;
    wire nor_out;
    wire or_out;
    wire mux0_not;
    wire mux1_not;
    wire mux2_not;
    wire mux_in0;
    wire mux_in1;
    wire mux_in2;
    wire mux_in3;
    wire mux_in4;
    wire mux_in5;
    wire mux_in6;
    wire mux_in7;

    `XOR xor0(sub_xor_out, subtract, B); //Xor causes the adder to allow for logic for SLR, ADD, and SUB
    structuralFullAdder adder0(adder_out,carry_out,A,sub_xor_out,carry_in); //Adder

    //Basic gates our ALU needs to handle
    `XOR xor1(xor_out, A, B);
    `AND and0(and_out, A, B);
    `NAND nand0(nand_out, A, B);
    `NOR nor0(nor_out, A, B);
    `OR or0(or_out, A, B);

    //Opposite of mux inputs
    `NOT not0(mux0_not, mux_in[0]);
    `NOT not1(mux1_not, mux_in[1]);
    `NOT not2(mux2_not, mux_in[2]);

    //Mux implementation, with each mux_in defining a different possible input to the mux. Only 1 of the 8 options can be 1.
    `FOURAND fourand0(mux_in0, mux0_not, mux1_not, mux2_not, adder_out);
    `FOURAND fourand1(mux_in1, mux0_not, mux1_not, mux_in[0], adder_out);
    `FOURAND fourand2(mux_in2, mux0_not, mux_in[1], mux2_not, xor_out);
    `FOURAND fourand3(mux_in3, mux0_not, mux_in[1], mux_in[0], adder_out);
    `FOURAND fourand4(mux_in4, mux_in[2], mux1_not, mux2_not, and_out);
    `FOURAND fourand5(mux_in5, mux_in[2], mux1_not, mux_in[0], nand_out);
    `FOURAND fourand6(mux_in6, mux_in[2], mux_in[1], mux2_not, nor_out);
    `FOURAND fourand7(mux_in7, mux_in[2], mux_in[1], mux_in[0], or_out);

    //The mux allows only one of the 8 different mux_ins to be 1, and therefore we can take the OR of all of them
    `EIGHTOR eightor0(c_out, mux_in0, mux_in1, mux_in2, mux_in3, mux_in4, mux_in5, mux_in6, mux_in7);


endmodule
