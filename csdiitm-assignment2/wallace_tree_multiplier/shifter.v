
module twobitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   assign out[0] = 0;
   assign out[1] = 0;
   buf b1(out[2], in[0]);
   buf b2(out[3], in[1]);
   buf b3(out[4], in[2]);
   buf b4(out[5], in[3]);
   buf b5(out[6], in[4]);
   buf b6(out[7], in[5]);
   buf b7(out[8], in[6]);
   buf b8(out[9], in[7]);
   buf b9(out[10], in[8]);
   buf b10(out[11], in[9]);
   buf b11(out[12], in[10]);
   buf b12(out[13], in[11]);
   buf b13(out[14], in[12]);
   buf b14(out[15], in[13]);
   buf b15(out[16], in[14]);
   buf b16(out[17], in[15]);
   buf b17(out[18], in[16]);
   buf b18(out[19], in[17]);
   buf b19(out[20], in[18]);
   buf b20(out[21], in[19]);
   buf b21(out[22], in[20]);
   buf b22(out[23], in[21]);
   buf b23(out[24], in[22]);
   buf b24(out[25], in[23]);
   buf b25(out[26], in[24]);
   buf b26(out[27], in[25]);
   buf b27(out[28], in[26]);
   buf b28(out[29], in[27]);
   buf b29(out[30], in[28]);
   buf b30(out[31], in[29]);
  
endmodule // twobitleftshifter

