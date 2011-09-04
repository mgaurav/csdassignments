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
   
   buf b1 (select[0], b0);
   buf b2 (select[1], b1);
   buf b3 (select[2], b2);

   sixteenbitbuffer b0 (t0, 8'b 0);
   sixteenbitbuffer b7 (t7, 8'b 0);
   sixteenbitbuffer b4 (t1, m);
   sixteenbitbuffer b5 (t2, m);
   sixteenbitleftshifter r3 (t3, m);
   sixteenbitleftshifter r4 (temp1, m);
   twoscomplement16bit c1 (t4, temp1);
   twoscomplement16bit c2 (t5, m);
   twoscomplement16bit c3 (t6, m);
   
   eightto1mux16bit m1 (temp2, t7, t6, t5, t4, t3, t2, t1, t0, select);

   extend16bitto32bit e1 (p, temp2);
   
endmodule // boothrecoder16bit


/*	ISB3[159:128] = c3;
	ISB3[127:96] = c2;
	ISB3[95:64] = s3;
	ISB3[63:32] = q7;
	ISB3[31:0] = q6;
*/

/***
 * Following is the structure of ISB registers :
 * m = multiplicand
 *       31_______15________________0  
 * ISB1 | 16 b m | 16 b multiplier  | 32 bits
 *      |________|__________________|
 * 
 * pi's are partial products after bit pair multiplication
 *      127______111______95_______79_______63_______47_______31_______15_______0 
 * ISB2 | 16b p7 | 16b p6 | 16b p5 | 16b p4 | 16b p3 | 16b p2 | 16b p1 | 16b p0 | 128 bits
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
   reg [127:0] 	 ISB2;
   reg [159:0] 	 ISB3;
   
   
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
   
   bitpairrecoder16bit b1(p0, ISB1[31:16], ISB1[1], ISB1[0], 0);
   bitpairrecoder16bit b2(p1, ISB1[31:16], ISB1[3], ISB1[2], ISB1[1]);
   bitpairrecoder16bit b3(p2, ISB1[31:16], ISB1[5], ISB1[4], ISB1[3]);
   bitpairrecoder16bit b4(p3, ISB1[31:16], ISB1[7], ISB1[6], ISB1[5]);
   bitpairrecoder16bit b5(p4, ISB1[31:16], ISB1[9], ISB1[8], ISB1[7]);
   bitpairrecoder16bit b6(p5, ISB1[31:16], ISB1[11], ISB1[10], ISB1[9]);
   bitpairrecoder16bit b7(p6, ISB1[31:16], ISB1[13], ISB1[12], ISB1[11]);
   bitpairrecoder16bit b8(p7, ISB1[31:16], ISB1[15], ISB1[14], ISB1[13]);

   //level 2 of pipelining starts
   
   //shift the partial products appropriately
   //pi is shifted by 2*i bits to its left...0 appended to the less significant bit values.
   twobitleftshifter t1(q1, ISB2[31:16]);
   fourbitleftshifter f1(q2, ISB2[47:32]);
   sixbitleftshifter s1(q3, ISB2[63:48]);
   eightbitleftshifter e1(q4, ISB2[79:64]);
   tenbitleftshifter t2(q5, ISB2[95:80]);
   twelvebitleftshifter t3(q6, ISB2[111:96]);
   fourteenbitleftshifter t4(q7, ISB2[127:112]);


   //now we have all the eight 32 bit partial products....we need to add them using the csas over the wallace tree.
   csa32bit c1(s1,c1,ISB2[15:0],q1,q2);
   csa32bit c2(s2,c2,q3,q4,q5);
   
   csa32bit c3(s3,c3,s1,c1,s2);
   csa32bit c4(s4,c4,c2,q6,q7);

   csa32bit c5(s5,c5,s3,c3,s4);
   
   csa32bit c6(s6,c6,s5,c5,c4);

   //level 3 of pipelining starts
   adder32bit a1(out, cout, ISB3[31:0], ISB3[63:32], 0);

   always @(posedge clk)
     begin
	ISB3[63:32] = c6;
	ISB3[31:0] = s6;
		
	ISB2[127:112] = p7;
	ISB2[111:96] = p6;
	ISB2[95:80] = p5;
	ISB2[79:64] = p4;
	ISB2[63:48] = p3;
	ISB2[47:32] = p2;
	ISB2[31:16] = p1;
	ISB2[15:0] = p0;
	
	ISB1[31:16] = m;
	ISB1[15:0] = multiplier;
     end
	  
endmodule // fastmultiplier16bit
