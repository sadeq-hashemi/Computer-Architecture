module PC_control(input [2:0]c, input [8:0] i, input [2:0] f, input [15:0] PC_in, output [15:0]PC_out);


wire [15:0]not_taken;
wire [15:0] taken;
wire err; 
wire [15:0] shifted_PC;
wire [9:0] shifted_i; 
wire N, V, Z; 

//f[2] = N f[1]=  V f[0] = Z
assign N = f[2];
assign V = f[1];
assign Z = f[0];
shifter PC_shift(.shift_in(PC_in), .shift_val(1'h1), .mode(1'b1), .shift_out(shifted_PC));
shifter i_shift(.shift_in({{6{i[8]}},i[8:0]}), .shift_val(1'h1), .mode(1'b1), .shift_out(shifted_i));
//not_taken = PC_in;   

assign not_taken = shifted_PC; //not_taken = PC + 2

PSA_16bit add(.A(shifted_PC), .B(shifted_i), .sum(taken), .error(err)); //taken = (PC << 1) + (I << 1)

assign PC_out = c[2] ? 
		  c[1] ?
		     c[0] ?
		       taken : //C = 111 (unconditional)
		       V ? taken : not_taken : //c = 110 (overflow)
		     c[0] ? 
	 	       N | Z ? taken : not_taken : //c = 101 (less than or equal to)
		       Z | (~Z & ~N) ? taken : not_taken : //c = 100 (greater than or equal to)
		  c[1] ?
		    c[0] ? 
		      N ? taken : not_taken : //c = 011 (less than)
		      (~Z & ~N) ? taken : not_taken : //c = 010  (greater than)
		    c[0] ?
		      Z ? taken : not_taken : //c = 001 (equal)
		      ~Z ? taken : not_taken; //c = 000 (not equal)


endmodule