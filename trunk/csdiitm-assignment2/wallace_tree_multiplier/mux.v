
module fourto1mux1bit(out, in3, in2, in1, in0, select);
   output out;
   input  in0;
   input  in1;
   input  in2;
   input  in3;
   input [1:0] select;

   wire        n1,n0;
   wire        m0,m1,m2,m3;

   not #(1) (n0, select[0]);
   not #(1) (n1, select[1]);

   and #(1) (m0, n0, n1, in0);
   and #(1) (m1, select[0], n1, in1);
   and #(1) (m2, n0, select[1],  in2);
   and #(1) (m3, select[1], select[0], in3);

   or #(1) (out, m0, m1, m2, m3);

endmodule // fourto1mux1bit

module eightto1mux1bit(out, in7, in6, in5, in4, in3, in2, in1, in0, select);
   output  out;
   input   in7, in6, in5, in4, in3, in2, in1, in0;
   input [2:0] select;

   wire        temp1, temp0, n, temp2, temp3;

   wire  [1:0]      select1;
   
   buf b1(select1[1], select[1]);
   buf b2(select1[0], select[0]);
 
   fourto1mux1bit m1(temp0, in3, in2, in1, in0, select1);
   fourto1mux1bit m2(temp1, in7, in6, in5, in4, select1);

   not #(1) (n, select[2]);

   and #(1) (temp2, temp0, n);
   and #(1) (temp3, temp1, select[2]);

   or #(1) (out, temp2, temp3);
endmodule // eightto1mux1bit
   

module eightto1mux16bit(out, in7, in6, in5, in4, in3, in2, in1, in0, select);
   output [15:0] out;
   input [15:0]  in3;
   input [15:0]  in2;
   input [15:0]  in1;
   input [15:0]  in0;
   input [15:0]  in4;

   input [15:0]  in5;
   input [15:0]  in6;
   input [15:0]  in7;
   input [2:0] 	 select;
   

   eightto1mux1bit m1(out[0], in7[0], in6[0], in5[0], in4[0], in3[0], in2[0], in1[0], in0[0], select);
   eightto1mux1bit m2(out[1], in7[1], in6[1], in5[1], in4[1], in3[1], in2[1], in1[1], in0[1], select);
   eightto1mux1bit m3(out[2], in7[2], in6[2], in5[2], in4[2], in3[2], in2[2], in1[2], in0[2], select);
   eightto1mux1bit m4(out[3], in7[3], in6[3], in5[3], in4[3], in3[3], in2[3], in1[3], in0[3], select);
   eightto1mux1bit m5(out[4], in7[4], in6[4], in5[4], in4[4], in3[4], in2[4], in1[4], in0[4], select);
   eightto1mux1bit m6(out[5], in7[5], in6[5], in5[5], in4[5], in3[5], in2[5], in1[5], in0[5], select);
   eightto1mux1bit m7(out[6], in7[6], in6[6], in5[6], in4[6], in3[6], in2[6], in1[6], in0[6], select);
   eightto1mux1bit m8(out[7], in7[7], in6[7], in5[7], in5[7], in3[7], in2[7], in1[7], in0[7], select);
   eightto1mux1bit m9(out[8], in7[8], in6[8], in5[8], in4[8], in3[8], in2[8], in1[8], in0[8], select);
   eightto1mux1bit m10(out[9], in7[9], in6[9], in5[9], in4[9], in3[9], in2[9], in1[9], in0[9], select);
   eightto1mux1bit m11(out[10], in7[10], in6[10], in5[10], in4[10], in3[10], in2[10], in1[10], in0[10], select);
   eightto1mux1bit m12(out[11], in7[11], in6[11], in5[11], in4[11], in3[11], in2[11], in1[11], in0[11], select);
   eightto1mux1bit m13(out[12], in7[12], in6[12], in5[12], in4[12], in3[12], in2[12], in1[12], in0[12], select);
   eightto1mux1bit m14(out[13], in7[13], in6[12], in5[12], in4[12], in3[13], in2[13], in1[13], in0[13], select);
   eightto1mux1bit m15(out[14], in7[14], in6[14], in5[14], in4[14], in3[14], in2[14], in1[14], in0[14], select);
   eightto1mux1bit m16(out[15], in7[15], in6[15], in5[15], in4[15], in3[15], in2[15], in1[15], in0[15], select);

endmodule // fourto1mux16bit
