// Adder circuit
// delay was removed when synthesized on FPGA
`define AND and #30
`define OR or #30
`define NOT not #10
`define XOR xor #30

module structuralFullAdder
(
    output sum,
    output carryout,
    input A,
    input B,
    input carryin
);
    wire AxorB;
    wire AxorBandC;
    wire AandB;

    `XOR AxorBgate(AxorB, A, B);
    `XOR AxorBxorCgate(sum, AxorB, carryin);
    `AND AandBgate(AandB,A,B);
    `AND AxorBandCgate(AxorBandC, AxorB, carryin);
    `OR  orgate(carryout, AxorBandC, AandB);

endmodule

module FullAdderbit
(
  output[31:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[31:0] a,     // First operand in 2's complement format
  input[31:0] b      // Second operand in 2's complement format
);
    wire carryin[30:0]; // Connect carry outs to carry ins
    wire carryoutXor;
    wire msbXor;
    wire nmsbXor;

    structuralFullAdder adder0(sum[0],carryin[0],a[0],b[0],1'b0);
    structuralFullAdder adder1(sum[1],carryin[1],a[1],b[1],carryin[0]);
    structuralFullAdder adder2(sum[2],carryin[2],a[2],b[2],carryin[1]);
    structuralFullAdder adder3(sum[3],carryin[3],a[3],b[3],carryin[2]);
    structuralFullAdder adder4(sum[4],carryin[4],a[4],b[4],carryin[3]);
    structuralFullAdder adder5(sum[5],carryin[5],a[5],b[5],carryin[4]);
    structuralFullAdder adder6(sum[6],carryin[6],a[6],b[6],carryin[5]);
    structuralFullAdder adder7(sum[7],carryin[7],a[7],b[7],carryin[6]);
    structuralFullAdder adder8(sum[8],carryin[8],a[8],b[8],carryin[7]);
    structuralFullAdder adder9(sum[9],carryin[9],a[9],b[9],carryin[8]);
    structuralFullAdder adder10(sum[10],carryin[10],a[10],b[10],carryin[9]);
    structuralFullAdder adder11(sum[11],carryin[11],a[11],b[11],carryin[10]);
    structuralFullAdder adder12(sum[12],carryin[12],a[12],b[12],carryin[11]);
    structuralFullAdder adder13(sum[13],carryin[13],a[13],b[13],carryin[12]);
    structuralFullAdder adder14(sum[14],carryin[14],a[14],b[14],carryin[13]);
    structuralFullAdder adder15(sum[15],carryin[15],a[15],b[15],carryin[14]);
    structuralFullAdder adder16(sum[16],carryin[16],a[16],b[16],carryin[15]);
    structuralFullAdder adder17(sum[17],carryin[17],a[17],b[17],carryin[16]);
    structuralFullAdder adder18(sum[18],carryin[18],a[18],b[18],carryin[17]);
    structuralFullAdder adder19(sum[19],carryin[19],a[19],b[19],carryin[18]);
    structuralFullAdder adder20(sum[20],carryin[20],a[20],b[20],carryin[19]);
    structuralFullAdder adder21(sum[21],carryin[21],a[21],b[21],carryin[20]);
    structuralFullAdder adder22(sum[22],carryin[22],a[22],b[22],carryin[21]);
    structuralFullAdder adder23(sum[23],carryin[23],a[23],b[23],carryin[22]);
    structuralFullAdder adder24(sum[24],carryin[24],a[24],b[24],carryin[23]);
    structuralFullAdder adder25(sum[25],carryin[25],a[25],b[25],carryin[24]);
    structuralFullAdder adder26(sum[26],carryin[26],a[26],b[26],carryin[25]);
    structuralFullAdder adder27(sum[27],carryin[27],a[27],b[27],carryin[26]);
    structuralFullAdder adder28(sum[28],carryin[28],a[28],b[28],carryin[27]);
    structuralFullAdder adder29(sum[29],carryin[29],a[29],b[29],carryin[28]);
    structuralFullAdder adder30(sum[30],carryin[30],a[30],b[30],carryin[29]);
    structuralFullAdder adder31(sum[31],carryout,a[31],b[31],carryin[30]);

    // An overflow has occured if the final carryout and the sum's
    // most significant bit are not the same, if you're not adding
    // a negative and positive number
    `XOR carryoutXorGate(carryoutXor,carryout,sum[31]);
    `XOR msbXorGate(msbXor, a[31], b[31]);
    `NOT nmsbXorGate(nmsbXor, msbXor);
    `AND overflowAndGate(overflow,nmsbXor,carryoutXor);
endmodule
