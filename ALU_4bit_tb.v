module ALU_4bit_tb; 

reg signed [3:0] in_1;
reg signed [3:0] in_2;
reg signed [1:0] op;
wire signed [3:0] out;
wire err;
reg signed [3:0] ANS;

ALU iDUT (in_1, in_2, op, out, err); 
initial begin
	in_1 = 4'b0; 
	in_2 = 4'b0; 
	op = 2'b0;
	ANS = 4'b0;

	repeat(500) begin
		#20
		in_1 = $random; 
		in_2 = $random; 
		op = $random; 
		#40 
		case(op)
			2'b00: begin
				assign ANS = in_1 + in_2; #20
				if(out != ANS && err != 1'b1) $display ("ERROR: adding %d and %d, expected:%d got:%d",
					 $signed(in_1), $signed(in_2), $signed(ANS), $signed(out));
			end
			2'b01: begin
				assign ANS = in_1 - in_2; #20
				if(out != ANS && err != 1'b1) $display ("ERROR: substracting %d and %d, expected:%d got:%d",
					 $signed(in_1), $signed(in_2), $signed(ANS), $signed(out));
			end
			2'b10: begin
				assign ANS = in_1 &~ in_2; #20
				if(out != ANS) $display ("ERROR: %d nand %d, expected:%d got:%d",
					 $signed(in_1), $signed(in_2), $signed(ANS), $signed(out));
			end
			2'b11: begin
				assign ANS = in_1 ^ in_2; #20
				if(out != ANS) $display ("ERROR: %d xor %d, expected:%d got:%d",
					 $signed(in_1), $signed(in_2), $signed(ANS), $signed(out));
			end
			default: $display("unexpected error");
		endcase
	$display("passed!");
	end 

end

endmodule
