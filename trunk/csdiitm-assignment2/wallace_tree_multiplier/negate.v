`include "hierarchialclas.v"

module twoscomplement16bit(out, in);
   output [15:0] out;
   input [15:0]  in;
   
   wire [15:0] 	 one;
   wire [15:0] 	 temp;
   wire 	 as;
   wire 	 cout;
   
   assign one = 16'b1;
   assign as = 0;
   
   
   not #(1) n1(temp[0], in[0]);
   not #(1) n2(temp[1], in[1]);
   not #(1) n3(temp[2], in[2]);
   not #(1) n4(temp[3], in[3]);
   not #(1) n5(temp[4], in[4]);
   not #(1) n6(temp[5], in[5]);
   not #(1) n7(temp[6], in[6]);
   not #(1) n8(temp[7], in[7]);
   not #(1) n9(temp[8], in[8]);
   not #(1) n10(temp[9], in[9]);
   not #(1) n11(temp[10], in[10]);
   not #(1) n12(temp[11], in[11]);
   not #(1) n13(temp[12], in[12]);
   not #(1) n14(temp[13], in[13]);
   not #(1) n15(temp[14], in[14]);
   not #(1) n16(temp[15], in[15]);

   hierarchial_cla_16 adder(out, cout, one, temp, as);
   
endmodule // twoscomplement16bit
