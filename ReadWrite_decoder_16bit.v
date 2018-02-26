module readDecoder_4_16(input [3:0] regID, output [15:0] wordline);

	//Reades the 4 bit input and outputs a one hot 16 bit output
	assign wordline = (regID == 0) ? 16'h0001 : 
			(regID == 1) ? 16'h0002 : 
			(regID == 2) ? 16'h0004 :
			(regID == 3) ? 16'h0008 :
			(regID == 4) ? 16'h0010 :
			(regID == 5) ? 16'h0020 :
			(regID == 6) ? 16'h0040 :
			(regID == 7) ? 16'h0080 :
			(regID == 8) ? 16'h0100 :
			(regID == 9) ? 16'h0200 :
			(regID == 10) ? 16'h0400 :
			(regID == 11) ? 16'h0800 :
			(regID == 12) ? 16'h1000 :
			(regID == 13) ? 16'h2000 :
			(regID == 14) ? 16'h4000 :
			16'h8000;



endmodule
module writeDecoder_4_16(input [3:0] regID, input writeReg, output [15:0] wordline);

	wire [15:0] oneHot; 
	assign oneHot =  (regID == 0) ? 16'h0001 : 
			(regID == 1) ? 16'h0002 : 
			(regID == 2) ? 16'h0004 :
			(regID == 3) ? 16'h0008 :
			(regID == 4) ? 16'h0010 :
			(regID == 5) ? 16'h0020 :
			(regID == 6) ? 16'h0040 :
			(regID == 7) ? 16'h0080 :
			(regID == 8) ? 16'h0100 :
			(regID == 9) ? 16'h0200 :
			(regID == 10) ? 16'h0400 :
			(regID == 11) ? 16'h0800 :
			(regID == 12) ? 16'h1000 :
			(regID == 13) ? 16'h2000 :
			(regID == 14) ? 16'h4000 :
			16'h8000;
	assign wordline = writeReg ? oneHot : 16'h0000; 


endmodule