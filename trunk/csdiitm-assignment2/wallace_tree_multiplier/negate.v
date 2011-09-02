`include "claadder.v"

module twoscomplement16bit(out, in, clk);
   output [15:0] out;
   input [15:0]  in;
   input 	 clk;
   
   wire [15:0] 	 one;
   wire [15:0] 	 temp;
   wire 	 as;
   
   assign one = 16'b1;
   assign as = 0;
   
   
   not n1(temp[0], in[0]);
   not n2(temp[1], in[1]);
   not n3(temp[2], in[2]);
   not n4(temp[3], in[3]);
   not n5(temp[4], in[4]);
   not n6(temp[5], in[5]);
   not n7(temp[6], in[6]);
   not n8(temp[7], in[7]);
   not n9(temp[8], in[8]);
   not n10(temp[9], in[9]);
   not n11(temp[10], in[10]);
   not n12(temp[11], in[11]);
   not n13(temp[12], in[12]);
   not n14(temp[13], in[13]);
   not n15(temp[14], in[14]);
   not n16(temp[15], in[15]);

   adder16 adder0(out, cout, one, temp, as, clk);
   
endmodule // twoscomplement16bit
