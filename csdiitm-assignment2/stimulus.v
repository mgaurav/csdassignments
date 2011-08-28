module stimulus;
   reg [15:0] A, B;
   reg 	     as;
   
   wire [15:0] sum;
   wire       cout;
   reg       clk;
   
   adder16 ADDER_16(sum, cout, A, B, as, clk);
   
   initial
     begin
	$monitor($time, "A = %b, B = %b, as = %b, ---> cout = %b, sum = %b %d\n", A, B, as, cout, sum, sum);
     end

   initial
     begin
	clk = 0;
	
	A = 16'd0;
	B = 16'd0;
	as = 0;
	
	#5 A = 16'd16;
	B = 16'd3;

	#10 A = 16'd32768;
	B = 16'd32768;
	as = 1;
	
	#10 A = 16'd33000;
	B = 16'd18000;

	#10 A = 16'd60000;
	B = 16'd33000;

	#10 A = 16'd1200;
	B = 16'd03;
	
	#10 A = 16'd99;
	B = 16'd99;
	as = 0;

	#10 A = 16'd100;
	B = 16'd1;
	as = 1;

	#10 A = 16'd1;
	B = 1;
	as = 0;
	
     end // initial begin

   always
     begin
	#5 clk = ~clk;
     end
   
endmodule // stimulus