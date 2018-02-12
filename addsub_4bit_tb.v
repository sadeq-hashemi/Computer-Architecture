
module addsub_4bit_tb;

reg signed [3:0] A;
reg signed [3:0] B;
reg sub;
wire signed [3:0] sum;
reg signed [3:0] correctSum;
reg signed [3:0] correctDiff;
wire carry_out, ovfl;


addsub_4bit DUT (sum[3:0], ovfl, A[3:0], A[3:0], sub);

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
		 #20
if(sub)
$display("(%d) - (%d) = %d",$signed(A[3:0]), $signed(B[3:0]),$signed( correctDiff));
else
$display("(%d) + (%d) = %d",$signed(A[3:0]), $signed(B[3:0]), $signed(correctSum));
		//if(sum !== val[3:0] - val[7:4]) $display("failed for %d + %d = %d",val[3:0], val[7:4], sum);
		//else $display("passed");
		
	end
	#10;
end

//initial $monitor("val:%b sum:%b CO:%b",val, sum, carry_out );

endmodule