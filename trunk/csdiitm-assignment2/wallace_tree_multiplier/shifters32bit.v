
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
  
endmodule // twobitleftshifter32

module fourbitleftshifter(out, in);
   
   output [31:0] out;
   input [31:0]  in;
   
   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], in[0]);
   buf b6(out[5], in[1]);
   buf b7(out[6], in[2]);
   buf b8(out[7], in[3]);
   buf b9(out[8], in[4]);
   buf b10(out[9], in[5]);
   buf b11(out[10], in[6]);
   buf b12(out[11], in[7]);
   buf b13(out[12], in[8]);
   buf b14(out[13], in[9]);
   buf b15(out[14], in[10]);
   buf b16(out[15], in[11]);
   buf b17(out[16], in[12]);
   buf b18(out[17], in[13]);
   buf b19(out[18], in[14]);
   buf b20(out[19], in[15]);
   buf b21(out[20], in[16]);
   buf b22(out[21], in[17]);
   buf b23(out[22], in[18]);
   buf b24(out[23], in[19]);
   buf b25(out[24], in[20]);
   buf b26(out[25], in[21]);
   buf b27(out[26], in[22]);
   buf b28(out[27], in[23]);
   buf b29(out[28], in[24]);
   buf b30(out[29], in[25]);
   buf b31(out[30], in[26]);
   buf b32(out[31], in[27]);
  
endmodule // fourbitleftshifter



module sixbitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], 1'b 0);
   buf b6(out[5], 1'b 0);
   buf b7(out[6], in[0]);
   buf b8(out[7], in[1]);
   buf b9(out[8], in[2]);
   buf b10(out[9], in[3]);
   buf b11(out[10], in[4]);
   buf b12(out[11], in[5]);
   buf b13(out[12], in[6]);
   buf b14(out[13], in[7]);
   buf b15(out[14], in[8]);
   buf b16(out[15], in[9]);
   buf b17(out[16], in[10]);
   buf b18(out[17], in[11]);
   buf b19(out[18], in[12]);
   buf b20(out[19], in[13]);
   buf b21(out[20], in[14]);
   buf b22(out[21], in[15]);
   buf b23(out[22], in[16]);
   buf b24(out[23], in[17]);
   buf b25(out[24], in[18]);
   buf b26(out[25], in[19]);
   buf b27(out[26], in[20]);
   buf b28(out[27], in[21]);
   buf b29(out[28], in[22]);
   buf b30(out[29], in[23]);
   buf b31(out[30], in[24]);
   buf b32(out[31], in[25]);
   
endmodule // sixbitleftshifter



module eightbitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], 1'b 0);
   buf b6(out[5], 1'b 0);
   buf b7(out[6], 1'b 0);
   buf b8(out[7], 1'b 0);
   buf b9(out[8], in[0]);
   buf b10(out[9], in[1]);
   buf b11(out[10], in[2]);
   buf b12(out[11], in[3]);
   buf b13(out[12], in[4]);
   buf b14(out[13], in[5]);
   buf b15(out[14], in[6]);
   buf b16(out[15], in[7]);
   buf b17(out[16], in[8]);
   buf b18(out[17], in[9]);
   buf b19(out[18], in[10]);
   buf b20(out[19], in[11]);
   buf b21(out[20], in[12]);
   buf b22(out[21], in[13]);
   buf b23(out[22], in[14]);
   buf b24(out[23], in[15]);
   buf b25(out[24], in[16]);
   buf b26(out[25], in[17]);
   buf b27(out[26], in[18]);
   buf b28(out[27], in[19]);
   buf b29(out[28], in[20]);
   buf b30(out[29], in[21]);
   buf b31(out[30], in[22]);
   buf b32(out[31], in[23]);
  
endmodule // eightbitleftshifter

	  

module tenbitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], 1'b 0);
   buf b6(out[5], 1'b 0);
   buf b7(out[6], 1'b 0);
   buf b8(out[7], 1'b 0);
   buf b9(out[8], 1'b 0);
   buf b10(out[9], 1'b 0);
   buf b11(out[10], in[0]);
   buf b12(out[11], in[1]);
   buf b13(out[12], in[2]);
   buf b14(out[13], in[3]);
   buf b15(out[14], in[4]);
   buf b16(out[15], in[5]);
   buf b17(out[16], in[6]);
   buf b18(out[17], in[7]);
   buf b19(out[18], in[8]);
   buf b20(out[19], in[9]);
   buf b21(out[20], in[10]);
   buf b22(out[21], in[11]);
   buf b23(out[22], in[12]);
   buf b24(out[23], in[13]);
   buf b25(out[24], in[14]);
   buf b26(out[25], in[15]);
   buf b27(out[26], in[16]);
   buf b28(out[27], in[17]);
   buf b29(out[28], in[18]);
   buf b30(out[29], in[19]);
   buf b31(out[30], in[20]);
   buf b32(out[31], in[21]);
   
endmodule // tenbitleftshifter


module twelvebitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], 1'b 0);
   buf b6(out[5], 1'b 0);
   buf b7(out[6], 1'b 0);
   buf b8(out[7], 1'b 0);
   buf b9(out[8], 1'b 0);
   buf b10(out[9], 1'b 0);
   buf b11(out[10], 1'b 0);
   buf b12(out[11], 1'b 0);
   buf b13(out[12], in[0]);
   buf b14(out[13], in[1]);
   buf b15(out[14], in[2]);
   buf b16(out[15], in[3]);
   buf b17(out[16], in[4]);
   buf b18(out[17], in[5]);
   buf b19(out[18], in[6]);
   buf b20(out[19], in[7]);
   buf b21(out[20], in[8]);
   buf b22(out[21], in[9]);
   buf b23(out[22], in[10]);
   buf b24(out[23], in[11]);
   buf b25(out[24], in[12]);
   buf b26(out[25], in[13]);
   buf b27(out[26], in[14]);
   buf b28(out[27], in[15]);
   buf b29(out[28], in[16]);
   buf b30(out[29], in[17]);
   buf b31(out[30], in[18]);
   buf b32(out[31], in[19]);
  
endmodule // tenbitleftshifter


module fourteenbitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;

   buf b1(out[0], 1'b 0);
   buf b2(out[1], 1'b 0);
   buf b3(out[2], 1'b 0);
   buf b4(out[3], 1'b 0);
   buf b5(out[4], 1'b 0);
   buf b6(out[5], 1'b 0);
   buf b7(out[6], 1'b 0);
   buf b8(out[7], 1'b 0);
   buf b9(out[8], 1'b 0);
   buf b10(out[9], 1'b 0);
   buf b11(out[10], 1'b 0);
   buf b12(out[11], 1'b 0);
   buf b13(out[12], 1'b 0);
   buf b14(out[13], 1'b 0);
   buf b15(out[14], in[0]);
   buf b16(out[15], in[1]);
   buf b17(out[16], in[2]);
   buf b18(out[17], in[3]);
   buf b19(out[18], in[4]);
   buf b20(out[19], in[5]);
   buf b21(out[20], in[6]);
   buf b22(out[21], in[7]);
   buf b23(out[22], in[8]);
   buf b24(out[23], in[9]);
   buf b25(out[24], in[10]);
   buf b26(out[25], in[11]);
   buf b27(out[26], in[12]);
   buf b28(out[27], in[13]);
   buf b29(out[28], in[14]);
   buf b30(out[29], in[15]);
   buf b31(out[30], in[16]);
   buf b32(out[31], in[17]);
  
endmodule
	  
