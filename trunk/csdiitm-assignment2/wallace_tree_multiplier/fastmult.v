`include "shifters32bit.v"
`include "shiftbuf.v"
`include "negate.v"
`include "mux.v"
`include "csa.v"
`include "adder32bit.v"


module bitpairrecoder16bit(p, m, b2, b1, b0, clk);

   output [31:0] p;
   input [15:0]  m;
   input 	 clk;
   
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
   twoscomplement16bit c1 (t4, temp1, clk);
   twoscomplement16bit c2 (t5, m, clk);
   twoscomplement16bit c3 (t6, m, clk);
   
   eightto1mux16bit m1 (temp2, t7, t6, t5, t4, t3, t2, t1, t0, select);

   extend16bitto32bit e1 (p, temp2);
   
endmodule // boothrecoder16bit


   
module fastmultiplier16bit(out, m, multiplier, clk);
   output [31:0] out;
   input [15:0]  m;
   input [15:0]  multiplier;
   input 	 clk;

   //generate the partial products to be added using the bt pair recoding technique 
   
   
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
   
   always@(multiplier, m)
     begin
	$display ("input1 = %b\n input2 = %b\n",multiplier, m);
     end
  
   bitpairrecoder16bit b1(p0, m, multiplier[1], multiplier[0], 0,clk);
   bitpairrecoder16bit b2(p1, m, multiplier[3], multiplier[2], multiplier[1], clk);
   bitpairrecoder16bit b3(p2, m, multiplier[5], multiplier[4], multiplier[3], clk);
   bitpairrecoder16bit b4(p3, m, multiplier[7], multiplier[6], multiplier[5], clk);
   bitpairrecoder16bit b5(p4, m, multiplier[9], multiplier[8], multiplier[7], clk);
   bitpairrecoder16bit b6(p5, m, multiplier[11], multiplier[10], multiplier[9], clk);
   bitpairrecoder16bit b7(p6, m, multiplier[13], multiplier[12], multiplier[11], clk);
   bitpairrecoder16bit b8(p7, m, multiplier[15], multiplier[14], multiplier[13], clk);

   always@(multiplier, m)
     begin
	#100 $display ("p0 = %b\n p1 = %b\n p2 = %b\n p3=%b\n p4 = %b\n p5 = %b\n p6 = %b\n p7 = %b\n\n",p0,p1,p2,p3,p4,p5,p6,p7);
     end
   
   //shift the partial products appropriately
   //pi is shifted by 2*i bits to its left...0 appended to the less significant bit values.
   twobitleftshifter t1(q1, p1);
   fourbitleftshifter f1(q2, p2);
   sixbitleftshifter s1(q3, p3);
   eightbitleftshifter e1(q4, p4);
   tenbitleftshifter t2(q5, p5);
   twelvebitleftshifter t3(q6, p6);
   fourteenbitleftshifter t4(q7, p7);


   always@(multiplier, m)
     begin
	#400 $display ("q0 = %b\n q1 = %b\n q2 = %b\n q3=%b\n q4 = %b\n q5 = %b\n q6 = %b\n q7 = %b\n\n",p0,q1,q2,q3,q4,q5,q6,q7);
     end
      
   //now we have all the eight 32 bit partial products....we need to add them using the csas over the wallace tree.
   csa32bit c1(s1,c1,p0,q1,q2);
   always@(multiplier,m)
     begin
	#500 $display ("q0  = %b\n q1 = %b\n q2 = %b\n s1 = %b\n 1 = %b\1",p0,q1,q2,s1,c1);
     end
   
   csa32bit c2(s2,c2,q3,q4,q5);
   csa32bit c3(s3,c3,s1,c1,s2);
   csa32bit c4(s4,c4,c2,q6,q7);
   csa32bit c5(s5,c5,s3,c3,s4);
   csa32bit c6(s6,c6,s5,c5,c4);

   adder32bit a1(out, cout, s6, c6, 0, clk);
   
   
	  
endmodule // fastmultiplier16bit
