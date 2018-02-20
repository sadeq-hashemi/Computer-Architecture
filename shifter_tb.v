module shifter_tb;

reg signed [15:0] shift_in;
reg signed [3:0] shift_val;
reg mode; 
wire signed [15:0] shift_out;

reg signed [15:0] SLL_out;
reg signed [15:0] SRA_out;



shifter DUT (shift_in[15:0], shift_val[15:0], mode, shift_out[15:0]);

initial begin
	shift_in= 16'b0;
	shift_val = 4'b0;
	mode = 1'b0;
	repeat(200) begin
		#20
		 shift_in = $random;
		 shift_val = $random; 
		 mode = $random;  
		 SLL_out = shift_in << shift_val;
		 SRA_out = shift_in >>> shift_val;

		 #40
		
				if(mode && shift_out == SLL_out)
					$display("passed");
				else if (!mode && shift_out == SRA_out)
					$display("passed");
				else if(mode && shift_out != SLL_out)
					$display("failed on shifting left;  shift_val: %b (%d) shift_in: %b (%d) shift_out: %b (%d) "
					, shift_val[3:0], shift_val[3:0], shift_in[15:0], shift_in[15:0], shift_out[15:0], shift_out[15:0]);

				else 
					$display("failed on shifting right arithmetic;  shift_val: %b (%d) shift_in: %b (%d) shift_out: %b (%d) "
					, shift_val[3:0], shift_val[3:0], shift_in[15:0], shift_in[15:0], shift_out[15:0], shift_out[15:0]);	
	end
	#10;
end

//initial $monitor("val:%b sum:%b CO:%b",val, sum, carry_out );

endmodule