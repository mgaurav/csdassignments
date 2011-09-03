
module sixteenbitbuffer(out, in);
   output [15:0] out;
   input [15:0]  in;

   buf b1(out[0], in[0]);
   buf b2(out[1], in[1]);
   buf b3(out[2], in[2]);
   buf b4(out[3], in[3]);
   buf b5(out[4], in[4]);
   buf b6(out[5], in[5]);
   buf b7(out[6], in[6]);
   buf b8(out[7], in[7]);
   buf b9(out[8], in[8]);
   buf b10(out[9], in[9]);
   buf b11(out[10], in[10]);
   buf b12(out[11], in[11]);
   buf b13(out[12], in[12]);
   buf b14(out[13], in[13]);
   buf b15(out[14], in[14]);
   buf b16(out[15], in[15]);

endmodule // sixteenbitbuffer


module sixteenbitleftshifter(out, in);
   output [15:0] out;
   input [15:0]  in;

   buf b1(out[0], 0);
   buf b2(out[1], in[0]);
   buf b3(out[2], in[1]);
   buf b4(out[3], in[2]);
   buf b5(out[4], in[3]);
   buf b6(out[5], in[4]);
   buf b7(out[6], in[5]);
   buf b8(out[7], in[6]);
   buf b9(out[8], in[7]);
   buf b10(out[9], in[8]);
   buf b11(out[10], in[9]);
   buf b12(out[11], in[10]);
   buf b13(out[12], in[11]);
   buf b14(out[13], in[12]);
   buf b15(out[14], in[13]);
   buf b16(out[15], in[14]);

endmodule // sixteenbitrightshifter

module onebitleftshifter(out, in);
   output [31:0] out;
   input [31:0]  in;


   buf b1(out[0], 0);
   buf b2(out[1], in[0]);
   buf b3(out[2], in[1]);
   buf b4(out[3], in[2]);
   buf b5(out[4], in[3]);
   buf b6(out[5], in[4]);
   buf b7(out[6], in[5]);
   buf b8(out[7], in[6]);
   buf b9(out[8], in[7]);
   buf b10(out[9], in[8]);
   buf b11(out[10], in[9]);
   buf b12(out[11], in[10]);
   buf b13(out[12], in[11]);
   buf b14(out[13], in[12]);
   buf b15(out[14], in[13]);
   buf b16(out[15], in[14]);

   buf b17(out[16], in[15]);
   buf b18(out[17], in[16]);
   buf b19(out[18], in[17]);
   buf b20(out[19], in[18]);
   buf b21(out[20], in[19]);
   buf b22(out[21], in[20]);
   buf b23(out[22], in[21]);
   buf b24(out[23], in[22]);
   buf b25(out[24], in[23]);
   buf b26(out[25], in[24]);
   buf b27(out[26], in[25]);
   buf b28(out[27], in[26]);
   buf b29(out[28], in[27]);
   buf b30(out[29], in[28]);
   buf b31(out[30], in[29]);
   buf b32(out[31], in[30]);

endmodule // 32bitrightshifter
   

module extend16bitto32bit(out , in);

   output [31:0] out;
   input [15:0]  in;
    
   
   buf b1(out[0], in[0]);
   buf b2(out[1], in[1]);
   buf b3(out[2], in[2]);
   buf b4(out[3], in[3]);
   buf b5(out[4], in[4]);
   buf b6(out[5], in[5]);
   buf b7(out[6], in[6]);
   buf b8(out[7], in[7]);
   buf b9(out[8], in[8]);
   buf b10 (out[9], in[9]);
   buf b11(out[10], in[10]);
   buf b12(out[11], in[11]);
   buf b13(out[12], in[12]);
   buf b14(out[13], in[13]);
   buf b15(out[14], in[14]);
   buf b16(out[15], in[15]);
   buf b17(out[16], in[15]);
   buf b18(out[17], in[15]);
   buf b19(out[18], in[15]);
   buf b21(out[19], in[15]);
   buf b22(out[20], in[15]);
   buf b23(out[21], in[15]);
   buf b24(out[22], in[15]);
   buf b25(out[23], in[15]);
   buf b26(out[24], in[15]);
   buf b27(out[25], in[15]);
   buf b28(out[26], in[15]);
   buf b29(out[27], in[15]);
   buf b30(out[28], in[15]);
   buf b31(out[29], in[15]);
   buf b32(out[30], in[15]);
   buf b33(out[31], in[15]);

endmodule // exend16bitto32bit
