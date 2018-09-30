`define AND and #30
`define OR or #30
`define NOT not #10

module structuralOr
(
    output[31:0] out,
    input[31:0] A,
    input[31:0] B
);

`OR or0(out[0],A[0],B[0]);
`OR or1(out[1],A[1],B[1]);
`OR or2(out[2],A[2],B[2]);
`OR or3(out[3],A[3],B[3]);
`OR or4(out[4],A[4],B[4]);
`OR or5(out[5],A[5],B[5]);
`OR or6(out[6],A[6],B[6]);
`OR or7(out[7],A[7],B[7]);
`OR or8(out[8],A[8],B[8]);
`OR or9(out[9],A[9],B[9]);
`OR or10(out[10],A[10],B[10]);
`OR or11(out[11],A[11],B[11]);
`OR or12(out[12],A[12],B[12]);
`OR or13(out[13],A[13],B[13]);
`OR or14(out[14],A[14],B[14]);
`OR or15(out[15],A[15],B[15]);
`OR or16(out[16],A[16],B[16]);
`OR or17(out[17],A[17],B[17]);
`OR or18(out[18],A[18],B[18]);
`OR or19(out[19],A[19],B[19]);
`OR or20(out[20],A[20],B[20]);
`OR or21(out[21],A[21],B[21]);
`OR or22(out[22],A[22],B[22]);
`OR or23(out[23],A[23],B[23]);
`OR or24(out[24],A[24],B[24]);
`OR or25(out[25],A[25],B[25]);
`OR or26(out[26],A[26],B[26]);
`OR or27(out[27],A[27],B[27]);
`OR or28(out[28],A[28],B[28]);
`OR or29(out[29],A[29],B[29]);
`OR or30(out[30],A[30],B[30]);
`OR or31(out[31],A[31],B[31]);


endmodule
