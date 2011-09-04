`include "shifters32bit.v"
`include "shiftbuf.v"
`include "negate.v"
`include "mux.v"
`include "csa.v"

module bitpairrecoder16bit(p, m, b2, b1, b0);
   
   output [31:0] p;
   input [15:0]  m;
   
   input 	 b2, b1, b0;
   
   wire [15:0] 	 t7;
   wire [15:0] 	 t6;
   wire [15:0] 	 t5;
   wire [15:0] 	 t4;
   wire [15:0] 	 t3;
   wire [15:0] 	 t2;
   wire [15:0] 	 t1;
   wire [15:0] 	 t0;
   wire [15:0] 	 out;
   wire [2:0] 	 select;

   wire [15:0] 	 temp1;
   wire [15:0] 	 temp2;
   
   buf (select[0], b0);
   buf (select[1], b1);
   buf (select[2], b2);

   sixteenbitbuffer SBB0 (t0, 16'b 0);
   sixteenbitbuffer SBB1 (t7, 16'b 0);
   sixteenbitbuffer SBB2 (t1, m);
   sixteenbitbuffer SBB3 (t2, m);
   sixteenbitleftshifter SBLS1 (t3, m);
   sixteenbitleftshifter SBLS2 (temp1, m);
   twoscomplement16bit TC1 (t4, temp1);
   twoscomplement16bit TC2 (t5, m);
   twoscomplement16bit TC3 (t6, m);
   
   eightto1mux16bit m1 (temp2, t7, t6, t5, t4, t3, t2, t1, t0, select);

   extend16bitto32bit e1 (p, temp2);
   
endmodule // boothrecoder16bit


/***
 * Following is the structure of ISB registers :
 * m = multiplicand
 *       31_______15________________0  
 * ISB1 | 16 b m | 16 b multiplier  | 32 bits
 *      |________|__________________|
 * 
 * pi's are partial products after bit pair multiplication
 *      255______223______191______159______127______95_______63_______31_______0 
 * ISB2 | 32b p7 | 32b p6 | 32b p5 | 32b p4 | 32b p3 | 32b p2 | 32b p1 | 32b p0 | 256 bits
 *      |________|________|________|________|________|________|________|________|
 * 
 *       63_______31_______0  
 * ISB3 | 32 b c6| 32 b s6 | 64 bits
 *      |________|_________|
 * 
*/
module fastmultiplier16bit(out, m, multiplier, clk);
   output [31:0] out;
   input [15:0]  m;
   input [15:0]  multiplier;
   input 	 clk;

   //generate the partial products to be added using the bt pair recoding technique 
   reg [31:0] 	 ISB1;
   reg [255:0] 	 ISB2;
   reg [63:0] 	 ISB3;
   
   
   wire [31:0] 	 p0;
   wire [31:0] 	 p1;
   wire [31:0] 	 p2;
   wire [31:0] 	 p3;
   wire [31:0] 	 p4;
   wire [31:0] 	 p5;
   wire [31:0] 	 p6;
   wire [31:0] 	 p7;

   wire [31:0] 	 q0;
   wire [31:0] 	 q1;
   wire [31:0] 	 q2;
   wire [31:0] 	 q3;
   wire [31:0] 	 q4;
   wire [31:0] 	 q5;
   wire [31:0] 	 q6;
   wire [31:0] 	 q7;

   wire [31:0] 	 s1;
   wire [31:0] 	 s2;
   wire [31:0] 	 s3;
   wire [31:0] 	 s4;
   wire [31:0] 	 s5;
   wire [31:0] 	 s6;

   wire [31:0] 	 c1;
   wire [31:0] 	 c2;
   wire [31:0] 	 c3;
   wire [31:0] 	 c4;
   wire [31:0] 	 c5;
   wire [31:0] 	 c6;

   wire 	 cout;
   
   bitpairrecoder16bit BP1(p0, ISB1[31:16], ISB1[1], ISB1[0], 0);
   bitpairrecoder16bit BP2(p1, ISB1[31:16], ISB1[3], ISB1[2], ISB1[1]);
   bitpairrecoder16bit BP3(p2, ISB1[31:16], ISB1[5], ISB1[4], ISB1[3]);
   bitpairrecoder16bit BP4(p3, ISB1[31:16], ISB1[7], ISB1[6], ISB1[5]);
   bitpairrecoder16bit BP5(p4, ISB1[31:16], ISB1[9], ISB1[8], ISB1[7]);
   bitpairrecoder16bit BP6(p5, ISB1[31:16], ISB1[11], ISB1[10], ISB1[9]);
   bitpairrecoder16bit BP7(p6, ISB1[31:16], ISB1[13], ISB1[12], ISB1[11]);
   bitpairrecoder16bit BP8(p7, ISB1[31:16], ISB1[15], ISB1[14], ISB1[13]);

   //level 2 of pipelining starts
   
   //shift the partial products appropriately
   //pi is shifted by 2*i bits to its left...0 appended to the less significant bit values.
   twobitleftshifter t1(q1, ISB2[63:32]);
   fourbitleftshifter f1(q2, ISB2[95:64]);
   sixbitleftshifter SBLS1(q3, ISB2[127:96]);
   eightbitleftshifter e1(q4, ISB2[159:128]);
   tenbitleftshifter t2(q5, ISB2[191:160]);
   twelvebitleftshifter t3(q6, ISB2[223:192]);
   fourteenbitleftshifter t4(q7, ISB2[255:224]);

   //now we have all the eight 32 bit partial products....we need to add them using the csas over the wallace tree.
   csa32bit CSA1(s1,c1,ISB2[31:0],q1,q2);
   csa32bit CSA2(s2,c2,q3,q4,q5);
   
   csa32bit CSA3(s3,c3,s1,c1,s2);
   csa32bit CSA4(s4,c4,c2,q6,q7);

   csa32bit CSA5(s5,c5,s3,c3,s4);
   
   csa32bit CSA6(s6,c6,s5,c5,c4);

   //level 3 of pipelining starts
   adder32bit Adder1(out, cout, ISB3[31:0], ISB3[63:32], 0);

   always @(posedge clk)
     begin
	ISB3[63:32] = c6;
	ISB3[31:0] = s6;
		
	ISB2[255:224] = p7;
	ISB2[223:192] = p6;
	ISB2[191:160] = p5;
	ISB2[159:128] = p4;
	ISB2[127:96] = p3;
	ISB2[95:64] = p2;
	ISB2[63:32] = p1;
	ISB2[31:0] = p0;
	
	ISB1[31:16] = m;
	ISB1[15:0] = multiplier;
     end
	  
endmodule // fastmultiplier16bit
