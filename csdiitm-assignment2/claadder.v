`include "stimulus.v"

/**
 * Logic circuit for computing level-1 and level-2
 * generator and propogator
 * 
 * Latency = 3 tau
 */
module generatorNpropogator (g, p, G, P, x, y);
   output [15:0] g, p;
   output [3:0]  G, P;
   input [15:0]	 x, y;

   and #(1) (g[0 ], x[0 ], y[0 ]);
   and #(1) (g[1 ], x[1 ], y[1 ]);
   and #(1) (g[2 ], x[2 ], y[2 ]);
   and #(1) (g[3 ], x[3 ], y[3 ]);
   and #(1) (g[4 ], x[4 ], y[4 ]);
   and #(1) (g[5 ], x[5 ], y[5 ]);
   and #(1) (g[6 ], x[6 ], y[6 ]);
   and #(1) (g[7 ], x[7 ], y[7 ]);
   and #(1) (g[8 ], x[8 ], y[8 ]);
   and #(1) (g[9 ], x[9 ], y[9 ]);
   and #(1) (g[10], x[10], y[10]);
   and #(1) (g[11], x[11], y[11]);
   and #(1) (g[12], x[12], y[12]);
   and #(1) (g[13], x[13], y[13]);
   and #(1) (g[14], x[14], y[14]);
   and #(1) (g[15], x[15], y[15]);

   xor #(1) (p[0 ], x[0 ], y[0 ]);
   xor #(1) (p[1 ], x[1 ], y[1 ]);
   xor #(1) (p[2 ], x[2 ], y[2 ]);
   xor #(1) (p[3 ], x[3 ], y[3 ]);
   xor #(1) (p[4 ], x[4 ], y[4 ]);
   xor #(1) (p[5 ], x[5 ], y[5 ]);
   xor #(1) (p[6 ], x[6 ], y[6 ]);
   xor #(1) (p[7 ], x[7 ], y[7 ]);
   xor #(1) (p[8 ], x[8 ], y[8 ]);
   xor #(1) (p[9 ], x[9 ], y[9 ]);
   xor #(1) (p[10], x[10], y[10]);
   xor #(1) (p[11], x[11], y[11]);
   xor #(1) (p[12], x[12], y[12]);
   xor #(1) (p[13], x[13], y[13]);
   xor #(1) (p[14], x[14], y[14]);
   xor #(1) (p[15], x[15], y[15]);

   and #(1) (P[0], p[3], p[2], p[1], p[0]);
   and #(1) (P[1], p[7], p[6], p[5], p[4]);
   and #(1) (P[2], p[11], p[10], p[9], p[8]);
   and #(1) (P[3], p[15], p[14], p[13], p[12]);

   wire [3:0] g2p33, g1p23, g0p13;

   and #(1) (g0p13[0], g[0], p[1], p[2], p[3]);
   and #(1) (g1p23[0], g[1], p[2], p[3]);   
   and #(1) (g2p33[0], g[2], p[3]);

   and #(1) (g0p13[1], g[4], p[5], p[6], p[7]);
   and #(1) (g1p23[1], g[5], p[6], p[7]);   
   and #(1) (g2p33[1], g[6], p[7]);

   and #(1) (g0p13[2], g[8], p[9], p[10], p[11]);
   and #(1) (g1p23[2], g[9], p[10], p[11]);   
   and #(1) (g2p33[2], g[10], p[11]);

   and #(1) (g0p13[3], g[12], p[13], p[14], p[15]);
   and #(1) (g1p23[3], g[13], p[14], p[15]);   
   and #(1) (g2p33[3], g[14], p[15]);

   or #(1) (G[0], g[3], g2p33[0], g1p23[0], g0p13[0]);
   or #(1) (G[1], g[7], g2p33[1], g1p23[1], g0p13[1]);
   or #(1) (G[2], g[11], g2p33[2], g1p23[2], g0p13[2]);
   or #(1) (G[3], g[15], g2p33[3], g1p23[3], g0p13[3]);
endmodule


/**
 * Logic circuit to compute carry from generator and
 * propogator to be used in Carry Look-ahead adder.
 * 
 * Latency = 2 tau
 */
module highLevelCarryGenerator (C, P, G, c0);
   output [3:0] C;
   input [3:0] 	P, G;
   input 	c0;
   
   wire p01, p02, p03, p12, p13, p23;
   wire cp0, cp01, cp02, cp03;

   and #(1) (cp0, c0, P[0]);
   and #(1) (cp01, c0, P[0], P[1]);
   and #(1) (cp02, c0, P[0], P[1], P[2]);
   and #(1) (cp03, c0, P[0], P[1], P[2], P[3]);

   or #(1) (C[0], G[0], cp0);
   wire g0p1, g1p2, g0p12, g2p3, g1p23, g0p13;

   and #(1) (g0p1, G[0], P[1]);
   and #(1) (g1p2, G[1], P[2]);
   and #(1) (g0p12, G[0], P[1], P[2]);
   and #(1) (g2p3, G[2], P[3]);
   and #(1) (g1p23, G[1], P[2], P[3]);
   and #(1) (g0p13, G[0], P[1], P[2], P[3]);

   or #(1) (C[1], G[1], g0p1, cp01);
   or #(1) (C[2], G[2], g1p2, g0p12, cp02);
   or #(1) (C[3], G[3], g2p3, g1p23, g0p13, cp03);

endmodule


/**
 * 4 bit Carry Look Ahead Adder
 * 
 * Latency = 3 tau
 */
module cla4 (sum, p, g, c0);
   output [3:0] sum;
   input [3:0] 	p, g;
   input 	c0;
   
   wire [3:0]	C;

   highLevelCarryGenerator HLCG (C, p, g, c0);
   xor #(1) (sum[0], p[0], c0);
   xor #(1) (sum[1], p[1], C[0]);
   xor #(1) (sum[2], p[2], C[1]);
   xor #(1) (sum[3], p[3], C[2]);
   
endmodule // cla4

/**
 * 16 bit Pipelined Adder using 2 Levels of CLA Logic,
 * 3 Pipeline Stages:
 * Stage 1 : Computes level-1 and level-2 generator and
 *           propogator for input X and (Y xor a/s).
 *           Total Latency = 4 tau
 * Stage 2 : Computes Input Carry to each 4 bit CLA.
 *           Total Latency = 2 tau
 * Stage 3 : Computes bits of the SUM = X +/- Y.
 *           Total Latency = 3 tau
 * 
 * Therefore, Clock Period of the clock driving Inter
 * state buffers = 4 tau.
 * 
 * Following is the structure of ISB registers :
 * 
 *       32_ 31_______15_______0  
 * ISB1 |C0 | 16 b X | 16 b Y  | 33 bits
 *      |___|________|_________|
 * 
 *      40_ 39______35______31_______15_______0 
 * ISB2 |C0|4 b Gi |4 b Pi | 16b gi | 16b pi   | 41 bits
 *      |__|_______|_______|________|__________|
 * 
 *      44_ _43______39______35______31_______15_______0 
 * ISB3 |C16|C12  C0|4 b Gi |4 b Pi | 16b gi | 16b pi   | 45 bits
 * 	|___|_______|_______|_______|________|__________|
 * 
 */
module hierarchial_cla(out, cout, in1, in2, as, clk);
   output [15:0] out;
   output 	cout;
   input [15:0] in1, in2;
   input as, clk;

   reg [32:0] ISB1;
   reg [40:0] ISB2;
   reg [44:0] ISB3;

   wire [15:0] g, p;
   wire [3:0]  G, P, C;
   
   wire  c4, c8, c12;
   wire  cout0, cout1, cout2;
   wire  g0, p0, g1, p1, g2, p2, g3, p3;
   wire  p01, p02, p03, p12, p13, p23;
   wire cp0, cp01, cp02, cp03;
   wire g0p1, g1p2, g0p12, g2p3, g1p23, g0p13;
   wire [15:0] 	 in2m;   

   // Stage 1 of Pipeline Begins here.
   xor #(1) (in2m[0], ISB1[0], as);
   xor #(1) (in2m[1], ISB1[1], as);
   xor #(1) (in2m[2], ISB1[2], as);
   xor #(1) (in2m[3], ISB1[3], as);
   xor #(1) (in2m[4], ISB1[4], as);
   xor #(1) (in2m[5], ISB1[5], as);
   xor #(1) (in2m[6], ISB1[6], as);
   xor #(1) (in2m[7], ISB1[7], as);
   xor #(1) (in2m[8], ISB1[8], as);
   xor #(1) (in2m[9], ISB1[9], as);
   xor #(1) (in2m[10], ISB1[10], as);
   xor #(1) (in2m[11], ISB1[11], as);
   xor #(1) (in2m[12], ISB1[12], as);
   xor #(1) (in2m[13], ISB1[13], as);
   xor #(1) (in2m[14], ISB1[14], as);
   xor #(1) (in2m[15], ISB1[15], as);

   generatorNpropogator GnP (g, p, G, P, in1, in2m);
   // Stage 1 of Pipeline Ends here.

   // Stage 2 of Pipeline Begins here.
   highLevelCarryGenerator HLCG (C, ISB2[35:32], ISB2[39:36], ISB2[40]);
   // Stage 2 of Pipeline Ends here.

   // Stage 3 of Pipeline Begins here.
   cla4 CLA1 (out[3:0], ISB3[3:0], ISB3[19:16], ISB3[40]);
   cla4 CLA2 (out[7:4], ISB3[7:4], ISB3[23:20], ISB3[41]);
   cla4 CLA3 (out[11:8], ISB3[11:8], ISB3[27:24], ISB3[42]);
   cla4 CLA4 (out[15:12], ISB3[15:12], ISB3[31:28], ISB3[43]);
   assign cout = ISB3[44];
   
   // Stage 3 of Pipeline Ends here.
      
   always @(posedge clk)
     begin
	ISB3[40:0] = ISB2[40:0];
	ISB3[44:41] = C[3:0];

	ISB2[15:0] = p;
	ISB2[31:16] = g;
	ISB2[35:32] = P;
	ISB2[39:36] = G;
	ISB2[40] = ISB1[32];

	ISB1[15:0] = in2;
	ISB1[31:16] = in1;
	ISB1[32] = as;
     end
endmodule