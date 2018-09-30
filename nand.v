`define NAND nand #20 

module structuralNand
(
    output[31:0] out,
    input[31:0] A,
    input[31:0] B
);


`NAND and0(out[0],A[0],B[0]);
`NAND and1(out[1],A[1],B[1]);
`NAND and2(out[2],A[2],B[2]);
`NAND and3(out[3],A[3],B[3]);
`NAND and4(out[4],A[4],B[4]);
`NAND and5(out[5],A[5],B[5]);
`NAND and6(out[6],A[6],B[6]);
`NAND and7(out[7],A[7],B[7]);
`NAND and8(out[8],A[8],B[8]);
`NAND and9(out[9],A[9],B[9]);
`NAND and10(out[10],A[10],B[10]);
`NAND and11(out[11],A[11],B[11]);
`NAND and12(out[12],A[12],B[12]);
`NAND and13(out[13],A[13],B[13]);
`NAND and14(out[14],A[14],B[14]);
`NAND and15(out[15],A[15],B[15]);
`NAND and16(out[16],A[16],B[16]);
`NAND and17(out[17],A[17],B[17]);
`NAND and18(out[18],A[18],B[18]);
`NAND and19(out[19],A[19],B[19]);
`NAND and20(out[20],A[20],B[20]);
`NAND and21(out[21],A[21],B[21]);
`NAND and22(out[22],A[22],B[22]);
`NAND and23(out[23],A[23],B[23]);
`NAND and24(out[24],A[24],B[24]);
`NAND and25(out[25],A[25],B[25]);
`NAND and26(out[26],A[26],B[26]);
`NAND and27(out[27],A[27],B[27]);
`NAND and28(out[28],A[28],B[28]);
`NAND and29(out[29],A[29],B[29]);
`NAND and30(out[30],A[30],B[30]);
`NAND and31(out[31],A[31],B[31]);


endmodule
