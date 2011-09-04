
module cla4bit(out, cout, in1, in2, c0);
   output [3:0] out;
   output 	cout;
   input [3:0] in1, in2;
   input c0;

   wire g0, g1, g2, g3;
   wire p0, p1, p2, p3;
   wire c1, c2, c3;

   and #(1) (g0, in1[0], in2[0]);
   and #(1) (g1, in1[1], in2[1]);
   and #(1) (g2, in1[2], in2[2]);
   and #(1) (g3, in1[3], in2[3]);

   xor #(1) (p0, in1[0], in2[0]);
   xor #(1) (p1, in1[1], in2[1]);
   xor #(1) (p2, in1[2], in2[2]);
   xor #(1) (p3, in1[3], in2[3]);

   wire p01, p02, p03, p12, p13, p23;
   wire cp0, cp01, cp02, cp03;

   and #(1) (cp0, c0, p0);
   and #(1) (cp01, c0, p0, p1);
   and #(1) (cp02, c0, p0, p1, p2);
   and #(1) (cp03, c0, p0, p1, p2, p3);

   or #(1) (c1, g0, cp0);
   wire g0p1, g1p2, g0p12, g2p3, g1p23, g0p13;

   and #(1) (g0p1, g0, p1);
   and #(1) (g1p2, g1, p2);
   and #(1) (g0p12, g0, p1, p2);
   and #(1) (g2p3, g2, p3);
   and #(1) (g1p23, g1, p2, p3);
   and #(1) (g0p13, g0, p1, p2, p3);

   or #(1) (c2, g1, g0p1, cp01);
   or #(1) (c3, g2, g1p2, g0p12, cp02);
   or #(1) (cout, g3, g2p3, g1p23, g0p13, cp03);

   xor #(1) (out[0], p0, c0);
   xor #(1) (out[1], p1, c1);
   xor #(1) (out[2], p2, c2);
   xor #(1) (out[3], p3, c3);
   
endmodule // cla4

module adder32bit(out, cout, in1, in2, as, clk);
   output [31:0] out;
   output 	 cout;
   input [31:0]  in1, in2;
   input 	 as;
   input 	 clk;
   

   wire 	 c4, c8, c12, c16, c20, c24, c28, c32;
   wire [31:0] 	 in2m;

   xor #(1) (in2m[0], in2[0], as);
   xor #(1) (in2m[1], in2[1], as);
   xor #(1) (in2m[2], in2[2], as);
   xor #(1) (in2m[3], in2[3], as);
   xor #(1) (in2m[4], in2[4], as);
   xor #(1) (in2m[5], in2[5], as);
   xor #(1) (in2m[6], in2[6], as);
   xor #(1) (in2m[7], in2[7], as);
   xor #(1) (in2m[8], in2[8], as);
   xor #(1) (in2m[9], in2[9], as);
   xor #(1) (in2m[10], in2[10], as);
   xor #(1) (in2m[11], in2[11], as);
   xor #(1) (in2m[12], in2[12], as);
   xor #(1) (in2m[13], in2[13], as);
   xor #(1) (in2m[14], in2[14], as);
   xor #(1) (in2m[15], in2[15], as);

   xor #(1) (in2m[16], in2[16], as);
   xor #(1) (in2m[17], in2[17], as);
   xor #(1) (in2m[18], in2[18], as);
   xor #(1) (in2m[19], in2[19], as);
   xor #(1) (in2m[20], in2[20], as);
   xor #(1) (in2m[21], in2[21], as);
   xor #(1) (in2m[22], in2[22], as);
   xor #(1) (in2m[23], in2[23], as);
   xor #(1) (in2m[24], in2[24], as);
   xor #(1) (in2m[25], in2[25], as);
   xor #(1) (in2m[26], in2[26], as);
   xor #(1) (in2m[27], in2[27], as);
   xor #(1) (in2m[28], in2[28], as);
   xor #(1) (in2m[29], in2[29], as);
   xor #(1) (in2m[30], in2[30], as);
   xor #(1) (in2m[31], in2[31], as);
   
   cla4bit CLA0(out[3:0], c4, in1[3:0], in2m[3:0], as);
   cla4bit CLA1(out[7:4], c8, in1[7:4], in2m[7:4], c4);
   cla4bit CLA2(out[11:8], c12, in1[11:8], in2m[11:8], c8);
   cla4bit CLA3(out[15:12], c16, in1[15:12], in2m[15:12], c12);
   cla4bit CLA4(out[19:16], c20, in1[19:16], in2m[19:16], c16);
   cla4bit CLA5(out[23:20], c24, in1[23:20], in2m[23:20], c20);
   cla4bit CLA6(out[27:24], c28, in1[27:24], in2m[27:24], c24);
   cla4bit CLA7(out[31:28], cout, in1[31:28], in2m[31:28], c28);
   
endmodule // adder16
