module fulladder1bit(s,c,x,y,z);

   output s;
   output c;
   input  x;
   input  y;
   input  z;

   wire   temp1, temp2, temp3;
   
   xor g1(s,x,y,z);
   and a1(temp1, x, y);
   and a2(temp2, x, z);
   and a3(temp3, y, z);
   or (c, temp1, temp2, temp3);
   
endmodule // fulladder1bit
	  
module csa32bit(s, c, x, y, z);

   output [31:0] s;
   output [31:0] c;
   input [31:0]  x;
   input [31:0]  y;
   input [31:0]  z;

   buf b1(c[0], 1'b 0);
   wire 	 temp;
   
   
   
   fulladder1bit f1(s[0], c[1], x[0], y[0], z[0]);
   fulladder1bit f2(s[1], c[2], x[1], y[1], z[1]);
   fulladder1bit f3(s[2], c[3], x[2], y[2], z[2]);
   fulladder1bit f4(s[3], c[4], x[3], y[3], z[3]);
   fulladder1bit f5(s[4], c[5], x[4], y[4], z[4]);
   fulladder1bit f6(s[5], c[6], x[5], y[5], z[5]);
   fulladder1bit f7(s[6], c[7], x[6], y[6], z[6]);
   fulladder1bit f8(s[7], c[8], x[7], y[7], z[7]);
   fulladder1bit f9(s[8], c[9], x[8], y[8], z[8]);
   fulladder1bit f10(s[9], c[10], x[9], y[9], z[9]);
   fulladder1bit f11(s[10], c[11], x[10], y[10], z[10]);
   fulladder1bit f12(s[11], c[12], x[11], y[11], z[11]);
   fulladder1bit f13(s[12], c[13], x[12], y[12], z[12]);
   fulladder1bit f14(s[13], c[14], x[13], y[13], z[13]);
   fulladder1bit f15(s[14], c[15], x[14], y[14], z[14]);
   fulladder1bit f16(s[15], c[16], x[15], y[15], z[15]);
   fulladder1bit f17(s[16], c[17], x[16], y[16], z[16]);
   fulladder1bit f18(s[17], c[18], x[17], y[17], z[17]);
   fulladder1bit f19(s[18], c[19], x[18], y[18], z[18]);
   fulladder1bit f20(s[19], c[20], x[19], y[19], z[19]);
   fulladder1bit f21(s[20], c[21], x[20], y[20], z[20]);
   fulladder1bit f22(s[21], c[22], x[21], y[21], z[21]);
   fulladder1bit f23(s[22], c[23], x[22], y[22], z[22]);
   fulladder1bit f24(s[23], c[24], x[23], y[23], z[23]);
   fulladder1bit f25(s[24], c[25], x[24], y[24], z[24]);
   fulladder1bit f26(s[25], c[26], x[25], y[25], z[25]);
   fulladder1bit f27(s[26], c[27], x[26], y[26], z[26]);
   fulladder1bit f28(s[27], c[28], x[27], y[27], z[27]);
   fulladder1bit f29(s[28], c[29], x[28], y[28], z[28]);   
   fulladder1bit f30(s[29], c[30], x[29], y[29], z[29]);
   fulladder1bit f31(s[30], c[31], x[30], y[30], z[30]);
   fulladder1bit f32(s[31], temp,  x[31], y[31], z[31]);
endmodule // csa32bit
		    
