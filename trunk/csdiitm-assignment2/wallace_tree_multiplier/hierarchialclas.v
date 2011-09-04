/**
 * 4 Bit Carry Look Ahead Adder.
 * Also outputs Higher Level generator and propogators.
 * 
 * Latency = 3 tau for "g, p"
 *           3 tau for "out"
 *           3 tau for "cout"
 */
module cla4(out, cout, g, p, in1, in2, c0);
   output [3:0] out;
   output 	cout, g, p;
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

   and #(1) (p, p3, p2, p1, p0);
   or #(1) (g, g3, g2p3, g1p23, g0p13);
endmodule // cla4

/**
 * 16 bit adder using 2 Level CLA Logic, It is only
 * a Adder, Subtraction should not be performed.
 * 
 * Latency = 8 tau for "out",
 *           5 tau for "cout"
 */
module hierarchial_cla_16 (out, cout, in1, in2, c0);
   output [15:0] out;
   output 	cout;
   input [15:0] in1, in2;
   input c0;

   wire  c4, c8, c12;
   wire  cout0, cout1, cout2;
   wire  g0, p0, g1, p1, g2, p2, g3, p3;
   wire  p01, p02, p03, p12, p13, p23;
   wire cp0, cp01, cp02, cp03;
   wire g0p1, g1p2, g0p12, g2p3, g1p23, g0p13;
   
   cla4 CLA1(out[3:0], cout0, g0, p0, in1[3:0], in2[3:0], c0);
   and #(1) (cp0, c0, p0);
   or #(1) (c4, g0, cp0);
   cla4 CLA2(out[7:4], cout1, g1, p1, in1[7:4], in2[7:4], c4);
   and #(1) (g0p1, g0, p1);
   and #(1) (cp01, c0, p0, p1);
   or #(1) (c8, g1, g0p1, cp01);
   cla4 CLA3(out[11:8], cout2, g2, p2, in1[11:8], in2[11:8], c8);
   and #(1) (cp02, c0, p0, p1, p2);
   and #(1) (g1p2, g1, p2);
   and #(1) (g0p12, g0, p1, p2);
   or #(1) (c12, g2, g1p2, g0p12, cp02);
   cla4 CLA4(out[15:12], cout3, g3, p3, in1[15:12], in2[15:12], c12);
   and #(1) (cp03, c0, p0, p1, p2, p3);
   and #(1) (g2p3, g2, p3);
   and #(1) (g1p23, g1, p2, p3);
   and #(1) (g0p13, g0, p1, p2, p3);
   or #(1) (cout, g3, g2p3, g1p23, g0p13, cp03);
   
endmodule // hierarchial_cla


/**
 * 32 Bit Adder, using 2 16 bit hierarchial adder in ripple.
 * Only a adder, subtraction should be performed using this.
 * 
 * Latency = 10 tau
 */
module adder32bit(out, cout, in1, in2, c0);
   output [31:0] out;
   output 	 cout;
   input [31:0]  in1, in2;
   input 	 c0;

   wire 	 c16;

   hierarchial_cla_16 HierarchialCla1 (out[15:0], c16, in1[15:0], in2[15:0], c0);
   hierarchial_cla_16 HierarchialCla2 (out[31:16], cout, in1[31:16], in2[31:16], c16);
   
endmodule // adder16

/**
 * Stimulus Module for testing Adder 32 bit
 */
/*
module stimulus;
     reg [31:0] A, B;
     reg 	c0;

     wire [31:0] sum;
     wire 	 cout;

     adder32bit Adder32 (sum, cout, A, B, c0);

     initial
       begin
	  $monitor($time, "A = %d, B = %d, c0 = %b, -> %b, sum = %d %b\n", A, B, c0, cout, sum, sum);
       end

   initial
     begin
	A = 32'b10101010_10101010_10101010_10101010;
	B = 32'b01010101_01010101_01010101_01010101;
	c0 = 0;

	#10 A = 32'd1;
	B = 32'd1;

	#10 A = 32'd1000;
	B = 32'd9999;
	c0 = 1;

	#10 A = 32'd86;
	B = 32'd186;

	#10 A = 32'd1203;
	B = 32'd2543;
	c0 = 0;
     end // initial begin

endmodule // stimulus
*/