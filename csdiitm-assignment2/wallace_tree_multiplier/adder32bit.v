`include "hierarchialcla16.v"

/**
 * 32 Bit Adder, using 2 16 bit hierarchial adder in ripple.
 * Only a adder, subtraction should be performed using this.
 */
module adder32bit(out, cout, in1, in2, c0);
   output [31:0] out;
   output 	 cout;
   input [31:0]  in1, in2;
   input 	 c0;

   wire 	 c16;

   hierarchial_cla (out[15:0], c16, in1[15:0], in2[15:0], c0);
   hierarchial_cla (out[31:16], cout, in1[31:16], in2[31:16], c16);
   
endmodule // adder16
