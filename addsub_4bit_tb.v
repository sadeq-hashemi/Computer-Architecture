
module addsub_4bit_tb;

reg signed [3:0] A;
reg signed [3:0] B;
reg sub;
wire signed [3:0] sum;
reg signed [3:0] correctSum;
reg signed [3:0] correctDiff;
wire carry_out, ovfl;



addsub_4bit DUT (A[3:0], B[3:0], sub, sum[3:0], ovfl);

initial begin
	A = 4'b0;
	B = 4'b0;
	sub = 1'b0;
	repeat(100) begin
		#20
		 A = $random;
		 B = $random; 
		 sub = $random; 
		 correctSum = A[3:0] + B[3:0];
		correctDiff = A[3:0] + ~B[3:0] + 1;		 
		 #40
		if (sub) 
			begin
				if(correctDiff == sum)
					$display("passed");
				else if (ovfl)
					$display("passed");
				else
					$display("failed on A - B with  A: %b (%d) B: %b (%d) SUM: %b (%d) OVFL: %b"
					, A[3:0], A[3:0], B[3:0], B[3:0], sum[3:0], sum[3:0], ovfl);
			end
		else 
			begin
				if(correctSum == sum)
					$display("passed");
				else if (ovfl)
					$display("passed");
				else
					$display("failed on A + B with  A: %b (%d) B: %b (%d) SUM: %b (%d) OVFL: %b"
					, A[3:0], A[3:0], B[3:0], B[3:0], sum[3:0], sum[3:0], ovfl);
			end

	
	end
	#10;
end

//initial $monitor("val:%b sum:%b CO:%b",val, sum, carry_out );

endmodule