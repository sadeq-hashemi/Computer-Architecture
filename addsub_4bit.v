module full_adder_1bit(A, B, Cin, S, Cout);

input A, B, Cin;
output S, Cout;

assign S = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule


//----------------------------------------------------------------------------------------------------------------
module addsub_4bit ( A, B, sub, sum, ovfl);
input [3:0] A, B; //Input values
input sub; // add-sub indicatoroutput

wire [3:0] B2; 
wire [3:0]cin;
wire cout;
output [3:0] sum; //sum output
output ovfl; //To indicate overflow

assign B2[0] = sub ^ B[0]; // addition: B XOR 0 = B	substraction B XOR 1 = ~B
assign B2[1] = sub ^ B[1];
assign B2[2] = sub ^ B[2];
assign B2[3] = sub ^ B[3];
assign cin[0] = sub; //1 if substraction



full_adder_1bit FA1 (A[0], B2[0], cin[0], sum[0], cin[1] ); //Example of using the one bit full adder (which you must also design)
full_adder_1bit FA2 (A[1], B2[1], cin[1], sum[1], cin[2]);
full_adder_1bit FA3 (A[2], B2[2], cin[2], sum[2], cin[3]);
full_adder_1bit FA4 (A[3], B2[3], cin[3], sum[3], cout);

// sol1:There has been overflow in the addition of two n-bit two's complement
// numbers when the sign of the two operands are the same and the sign
// of the sum is different.
// sol2: The OVERFLOW flag is the XOR of the carry coming into the sign bit
// (if any) with the carry going out of the sign bit (if any)
/*assign ovfl =  A[3] ^ B[3] ? 1'b0 : 
		 A[3] & B[3] ? ~sum[3] : sum[3];*/
assign ovfl = A[3]!= B2[3]? 0: 
		A[3] == sum[3] ? 0 : 1;

endmodule