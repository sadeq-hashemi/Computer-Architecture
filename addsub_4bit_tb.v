
module addsub_4bit_tb;

reg [7:0] val;
reg sub;
wire [3:0] sum;
wire carry_out, ovfl;


addsub_4bit DUT (sum[3:0], ovfl, val[3:0], val[7:4], sub);

initial begin
	val = 8'b0;
	sub = 1'b1;
	repeat(100) begin
		#20 val = $random; #20
		if(sum !== val[3:0] - val[7:4]) $display("failed for %d + %d = %d",val[3:0], val[7:4], sum);
		else $display("passed");
		
	end
	#10;
end

//initial $monitor("val:%b sum:%b CO:%b",val, sum, carry_out );

endmodule