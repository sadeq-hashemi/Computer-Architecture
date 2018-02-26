
module register_16bit_tb;

reg clk, rst;

reg cellin; 
reg cellout_1;
reg cellout_2;

reg [15:0] currIn;
reg [15:0] currOut_1;
reg [15:0] currOut_2;
reg [15:0] regArray [15:0]; //an array that holds expected values

reg [3:0] regID_1;
reg [3:0] regID_2;
reg [3:0] writeReg;
reg writeEnable;
reg readEnable1;
reg readEnable2; 

wire [15:0] oneHot_1; 
wire [15:0] oneHot_2;
wire [15:0] oneHot_wr




readDecoder_4_16(.regID(regID_1),.wordline(oneHot_1));

writeDecoder_4_16(.regID(writeReg), .wordline(oneHot));

bitCell( .clk(clk),  .rst(rst), .D(cellin), .writeEnable(writeEnable), .readEnable1(readEnable1),
				 .readEnable2(readEnable2), .bitline_1(cellout_1), .bitline_2(cellout_2));

register( .clk(clk),  .rst(rst), .D(currIn), .writeReg(writeEnable), .readEnable1(readEnable1),
				 .readEnable2(readEnable2), .bitline_1(currOut_1), .bitline_2(currOut_2));

RegisterFile(.clk(clk), .rst(rst), .srcReg_1(regID_1), .srcReg_2(regID_2), .dstReg(writeReg),
			 .writeReg(writeEnable), .dstData(currIn), .srcData_1(currOut_1), .srcData_2(currOut_2));

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