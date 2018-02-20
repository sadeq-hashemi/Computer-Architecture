module PSA_16bit_tb;

reg signed [15:0] A;
reg signed [15:0] B;
wire signed [15:0] sum;
reg signed [15:0] correctSum;

wire ovfl;



PSA_16bit DUT (A[15:0], B[15:0], sum[15:0], ovfl);

initial begin
	A = 16'b0;
	B = 16'b0;
	repeat(200) begin
		#20
		 A = $random;
		 B = $random;  
		 correctSum[3:0] = A[3:0] + B[3:0];	 
		 correctSum[7:4]= A[7:4] + B[7:4];
		 correctSum[11:8] = A[11:8] + B[11:8];
		 correctSum[15:12] = A[15:12] + B[15:12];
		 #40
		
				if(correctSum == sum)
					$display("passed");
				else if (ovfl)
					$display("passed");
				else
					$display("failed on A + B with  A: %b (%d) B: %b (%d) SUM: %b (%d) OVFL: %b"
					, A[15:0], A[15:0], B[15:0], B[15:0], sum[15:0], sum[15:0], ovfl);

	
	end
	#10;
end

//initial $monitor("val:%b sum:%b CO:%b",val, sum, carry_out );

endmodule
