`include "stimulus.v"

module cla4(out, cout, in1, in2, c0);
   output [3:0] out;
   output 	cout;
   input [3:0] in1, in2;
   input c0;

   wire g0, g1, g2, g3;
   wire p0, p1, p2, p3;
   wire c1, c2, c3;

   and(g0, in1[0], in2[0]);
   and(g1, in1[1], in2[1]);
   and(g2, in1[2], in2[2]);
   and(g3, in1[3], in2[3]);

   xor(p0, in1[0], in2[0]);
   xor(p1, in1[1], in2[1]);
   xor(p2, in1[2], in2[2]);
   xor(p3, in1[3], in2[3]);

   wire p01, p02, p03, p12, p13, p23;
   wire cp0, cp01, cp02, cp03;

   and(cp0, c0, p0);
   and(cp01, c0, p0, p1);
   and(cp02, c0, p0, p1, p2);
   and(cp03, c0, p0, p1, p2, p3);

   or(c1, g0, cp0);
   wire g0p1, g1p2, g0p12, g2p3, g1p23, g0p13;

   and(g0p1, g0, p1);
   and(g1p2, g1, p2);
   and(g0p12, g0, p1, p2);
   and(g2p3, g2, p3);
   and(g1p23, g1, p2, p3);
   and(g0p13, g0, p1, p2, p3);

   or(c2, g1, g0p1, cp01);
   or(c3, g2, g1p2, g0p12, cp02);
   or(cout, g3, g2p3, g1p23, g0p13, cp03);

   xor(out[0], p0, c0);
   xor(out[1], p1, c1);
   xor(out[2], p2, c2);
   xor(out[3], p3, c3);
   
endmodule // cla4

/**           ___           ___           ___           ___ 
 *      _    |   |    _    |   |    _    |   |    _    |   |
 *     | |   | C |   | |   | C |   | |   | C |   | |   | C |
 * --->| |-->| L |-->| |-->| L |-->| |-->| L |-->| |-->| L |-->
 *     |_|   | A |   |_|   | A |   |_|   | A |   |_|   | A |
 *     ISB   |___|   ISB   |___|   ISB   |___|   ISB   |___|
 */
module adder16(out, cout, in1, in2, as, clk);
   output [15:0] out;
   output 	 cout;
   input [15:0]  in1, in2;
   input 	 as;
   input 	 clk;
   
   wire 	 c4, c8, c12;
   wire [15:0] 	 in2m;
   wire 	 cout0, cout1, cout2;
   wire [3:0] 	 out0, out1, out2;
   
   // Inter State Buffers
   reg [32:0] 	 ISB1;
   reg [28:0] 	 ISB2;
   reg [24:0] 	 ISB3;
   reg [20:0] 	 ISB4;
   
   xor(in2m[0], in2[0], as);
   xor(in2m[1], in2[1], as);
   xor(in2m[2], in2[2], as);
   xor(in2m[3], in2[3], as);
   xor(in2m[4], in2[4], as);
   xor(in2m[5], in2[5], as);
   xor(in2m[6], in2[6], as);
   xor(in2m[7], in2[7], as);
   xor(in2m[8], in2[8], as);
   xor(in2m[9], in2[9], as);
   xor(in2m[10], in2[10], as);
   xor(in2m[11], in2[11], as);
   xor(in2m[12], in2[12], as);
   xor(in2m[13], in2[13], as);
   xor(in2m[14], in2[14], as);
   xor(in2m[15], in2[15], as);
   
   cla4 CLA0(out0, cout0, ISB1[3:0], ISB1[19:16], ISB1[32]);
   cla4 CLA1(out1, cout1, ISB2[3:0], ISB2[15:12], ISB2[28]);
   cla4 CLA2(out2, cout2, ISB3[3:0], ISB3[11:8], ISB3[24]);
   cla4 CLA3(out[15:12], cout, ISB4[3:0], ISB4[7:4], ISB4[20]);
   assign out[11:0] = ISB4[19:8];
   
   always @(posedge clk)
     begin
	ISB4[3:0] = ISB3[7:4];
	ISB4[7:4] = ISB3[15:12];
	ISB4[15:8] = ISB3[23:16];
	ISB4[19:16] = out2;
	ISB4[20] = cout2;
	
	ISB3[7:0] = ISB2[11:4];
	ISB3[15:8] = ISB2[23:16];
	ISB3[19:16] = ISB2[27:24];
	ISB3[23:20] = out1;
	ISB3[24] = cout1;
	
	ISB2[11:0] = ISB1[15:4];
	ISB2[23:12] = ISB1[31:20];
	ISB2[27:24] = out0;
	ISB2[28] = cout0;
	
	ISB1[15:0] = in1;
	ISB1[31:16] = in2m;
	ISB1[32] = as;
     end
   
endmodule // adder16
