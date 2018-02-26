
module bitCell( input clk,  input rst, input D, input writeEnable, input readEnable1, input readEnable2, inout bitline_1, inout bitline_2);
	//Bit Cell consists of a D Flip Flip  that has 2 branches at its output.
	//Each branch has its own tristate and connects to a bitline
	wire FFout;
	dff FF (.q(FFout), .d(D), .wen(writeEnable), .clk(clk), .rst(rst));
	assign bitline_1 = readEnable1 ? FFout : 1'bz;
	assign bitline_2 = readEnable2 ? FFout : 1'bz; 
endmodule

module register( input clk,  input rst, input [15:0] D, input writeReg, input readEnable1, input readEnable2, inout [15:0] bitline_1, inout [15:0] bitline_2);
	//A register holds 16 bit cells
	bitCell cell_0 (.clk(clk), .rst(rst), .D(D[0]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[0]), .bitline_2(bitline_2[0])); 

	bitCell cell_1 (.clk(clk), .rst(rst), .D(D[1]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[1]), .bitline_2(bitline_2[1])); 

	bitCell cell_2 (.clk(clk), .rst(rst), .D(D[2]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[2]), .bitline_2(bitline_2[2])); 

	bitCell cell_3 (.clk(clk), .rst(rst), .D(D[3]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[3]), .bitline_2(bitline_2[3])); 

	bitCell cell_4 (.clk(clk), .rst(rst), .D(D[4]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[4]), .bitline_2(bitline_2[4])); 

	bitCell cell_5 (.clk(clk), .rst(rst), .D(D[5]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[5]), .bitline_2(bitline_2[5])); 

	bitCell cell_6 (.clk(clk), .rst(rst), .D(D[6]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[6]), .bitline_2(bitline_2[6])); 

	bitCell cell_7 (.clk(clk), .rst(rst), .D(D[7]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[7]), .bitline_2(bitline_2[7])); 

	bitCell cell_8 (.clk(clk), .rst(rst), .D(D[8]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[8]), .bitline_2(bitline_2[8])); 

	bitCell cell_9 (.clk(clk), .rst(rst), .D(D[9]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[9]), .bitline_2(bitline_2[9])); 

	bitCell cell_10 (.clk(clk), .rst(rst), .D(D[10]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[10]), .bitline_2(bitline_2[10])); 

	bitCell cell_11 (.clk(clk), .rst(rst), .D(D[11]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[11]), .bitline_2(bitline_2[11])); 

	bitCell cell_12 (.clk(clk), .rst(rst), .D(D[12]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[12]), .bitline_2(bitline_2[12]));

	bitCell cell_13 (.clk(clk), .rst(rst), .D(D[13]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[13]), .bitline_2(bitline_2[13]));

	bitCell cell_14 (.clk(clk), .rst(rst), .D(D[14]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[14]), .bitline_2(bitline_2[14]));

	bitCell cell_15 (.clk(clk), .rst(rst), .D(D[15]), .writeEnable(writeReg), .readEnable1(readEnable1),
		 .readEnable2(readEnable2), .bitline_1(bitline_1[15]), .bitline_2(bitline_2[15]));
    
endmodule

module RegisterFile(input clk, input rst, input [3:0] srcReg_1, input [3:0] srcReg_2, input [3:0] dstReg, input writeReg, input [15:0] dstData, inout [15:0] srcData_1, inout [15:0] srcData_2);
	wire [15:0] oneHot_1;
	wire [15:0] oneHot_2;
	wire [15:0] oneHot_wr; 
	//A Read decoder takes srcReg_1 and srcReg_2 and
	//outputs a one hot 16 bit output that corresponds to 
	//each of the 16 registers
		readDecoder_4_16 read_1 (.regID(srcReg_1), .wordline(oneHot_1));
		readDecoder_4_16 read_2(.regID(srcReg_2), .wordline(oneHot_2));
		writeDecoder_4_16 write (.regID(), .writeReg(), .wordline());	

	//A Register File has 16 registers
	register reg0 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[0]),
		 .readEnable1(oneHot_1[0]), .readEnable2(oneHot_2[0]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg1 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[1]),
		 .readEnable1(oneHot_1[1]), .readEnable2(oneHot_2[1]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg2 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[2]),
		 .readEnable1(oneHot_1[2]), .readEnable2(oneHot_2[2]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg3 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[3]),
		 .readEnable1(oneHot_1[3]), .readEnable2(oneHot_2[3]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg4 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[4]),
		 .readEnable1(oneHot_1[4]), .readEnable2(oneHot_2[4]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg5 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[5]),
		 .readEnable1(oneHot_1[5]), .readEnable2(oneHot_2[5]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg6 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[6]),
		 .readEnable1(oneHot_1[6]), .readEnable2(oneHot_2[6]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg7 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[7]),
		 .readEnable1(oneHot_1[7]), .readEnable2(oneHot_2[7]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg8 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[8]),
		 .readEnable1(oneHot_1[8]), .readEnable2(oneHot_2[8]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg9 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[9]),
		 .readEnable1(oneHot_1[9]), .readEnable2(oneHot_2[9]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg10 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[10]),
		 .readEnable1(oneHot_1[10]), .readEnable2(oneHot_2[10]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg11 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[11]),
		 .readEnable1(oneHot_1[11]), .readEnable2(oneHot_2[11]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg12 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[12]),
		 .readEnable1(oneHot_1[12]), .readEnable2(oneHot_2[12]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg13 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[13]),
		 .readEnable1(oneHot_1[13]), .readEnable2(oneHot_2[13]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg14 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[14]),
		 .readEnable1(oneHot_1[14]), .readEnable2(oneHot_2[14]), .bitline_1(srcData_1), .bitline_2(srcData_2));

	register reg15 (.clk(clk),  .rst(rst), .D(dstData), .writeReg(oneHot_wr[15]),
		 .readEnable1(oneHot_1[15]), .readEnable2(oneHot_2[15]), .bitline_1(srcData_1), .bitline_2(srcData_2));


	

endmodule