
module register_16bit_tb;

integer i;
reg clk, rst;

reg exp, err;
reg [15:0]expWord;
reg prev; 
reg cellin; 
wire cellout_1;
wire cellout_2;

reg [15:0] currIn;
reg [15:0] prevWord;
wire [15:0] currOut_1;
wire[15:0] currOut_2;
reg [15:0] regArray [15:0]; //an array that holds expected values

reg [3:0] regID_1;
reg [3:0] regID_2;
reg [3:0] writeReg;
reg writeEnable;
reg readEnable1;
reg readEnable2; 

wire [15:0] oneHot_1; 
wire [15:0] oneHot_2;
wire [15:0] oneHot_wr;

localparam NONE = 3'b000;
localparam READ1 = 3'b010;
localparam READ2 = 3'b001;
localparam WRITE = 3'b100;
localparam WRITEREAD1 = 3'b110;
localparam WRITEREAD2 = 3'b101;
localparam READ1READ2 = 3'b011;
localparam WRITEREAD1READ2 = 3'b111;


readDecoder_4_16 readDecoder_DUT(.regID(regID_1), .wordline(oneHot_1));

writeDecoder_4_16 writeDecoder_DUT(.regID(writeReg), .writeReg(writeEnable),  .wordline(oneHot_wr));

bitCell bitCell_DUT( .clk(clk),  .rst(rst), .D(cellin), .writeEnable(writeEnable), .readEnable1(readEnable1),
				 .readEnable2(readEnable2), .bitline_1(cellout_1), .bitline_2(cellout_2));

register register_DUT( .clk(clk),  .rst(rst), .D(currIn), .writeReg(writeEnable), .readEnable1(readEnable1),
				 .readEnable2(readEnable2), .bitline_1(currOut_1), .bitline_2(currOut_2));

RegisterFile RegisterFile_DUT(.clk(clk), .rst(rst), .srcReg_1(regID_1), .srcReg_2(regID_2), .dstReg(writeReg),
			 .writeReg(writeEnable), .dstData(currIn), .srcData_1(currOut_1), .srcData_2(currOut_2));
//CLOCK GENERATE 
initial begin 
	clk = 0;
	rst = 0; 
end
always 
	#10 clk = !clk;

initial begin
	#5
	rst = 1;
	err = 0; 
	#20
	rst = 0; 
	#20
//TESTING READ DECODER
	repeat(200) begin
	#20
	regID_1 = $random; 
	expWord = 16'h0001;
	#20
	expWord = expWord << regID_1;
	#40
	if(oneHot_1 != expWord) begin
	  err = 1; 
	  $display("Reader Decoder... readReg: %d  output: %b expected: %b", regID_1, oneHot_1, expWord);
	  end
	end
	//pass statement and err reset
	if(err == 0)
	  $display("read decoder passed... ");
	else 
	  err = 0; 
	rst = 1; 

//TESTING WRITE DECODER
	repeat(200) begin
	writeReg = $random; 
	writeEnable= $random;
	if(writeEnable)
	  expWord = 16'h0001 << writeReg;
	else
	  expWord = 16'h0000;
	#40
	if(oneHot_wr != expWord) begin
	  err = 1; 
	  $display("Writer Decoder... writeReg: %d WriteEnable:%d output: %b expected: %b",
	  writeReg, writeEnable, oneHot_wr, expWord);
	  end
	end
	//pass statement and err reset
	if(err == 0)
	  $display("write decoder passed... ");
	else 
	  err = 0;
	#20 
	rst = 1;
	prev = 0; 
	#20
	rst = 0;  


//TESTING BIT CELL

	repeat(200) begin
	  cellin = $random;
	  writeEnable = $random; 
	  readEnable1 = $random; 
	  readEnable2 = $random; 
	  #20 

	  case({writeEnable, readEnable1, readEnable2})
	    READ1: exp = prev;
	    READ2: exp = prev;
	    WRITE: exp = cellin;
	    READ1READ2: exp = prev;
	    WRITEREAD1: exp = cellin;
	    WRITEREAD2: exp = cellin;
	    WRITEREAD1READ2: exp = cellin;
	    NONE: exp = 1'bx;
	    default: exp = 1'bx;
	  endcase
	  #20
	  case({writeEnable, readEnable1, readEnable2})
	    READ1, WRITEREAD1: if (cellout_1 != exp) begin
	      err = 1;
	      $display(" bitCell error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%d bitline2:%d exp:%d prev: %d",
	         cellin, writeEnable, readEnable1, readEnable2, cellout_1, cellout_2, exp, prev);
	      end
	    READ2, WRITEREAD2: if (cellout_2 != exp)begin
	      err = 1;
	      $display(" bitCell error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%d bitline2:%d exp:%d, prev:%d",
	         cellin, writeEnable, readEnable1, readEnable2, cellout_1, cellout_2, exp, prev);
	      end
	    WRITEREAD1READ2, READ1READ2: if(cellout_1 != exp || cellout_2 != exp) begin
	      err = 1;
	      $display(" bitCell error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%d bitline2:%d exp:%d prev:%d",
	         cellin, writeEnable, readEnable1, readEnable2, cellout_1, cellout_2, exp, prev);
	      end
	    //default: continue;
	  endcase
	  if(writeEnable) prev = cellin;
	end
if(err == 0)
	  $display("bitcell passed... ");
	else 
	  err = 0;
	#20 
	rst = 1;
	prevWord = 16'h0000; 
	#20
	rst = 0;  


//TESTING REGISTER

	repeat(500) begin
	  currIn = $random;
	  writeEnable = $random; 
	  readEnable1 = $random; 
	  readEnable2 = $random; 
	  #20 

	  case({writeEnable, readEnable1, readEnable2})
	    READ1: expWord = prevWord;
	    READ2: expWord = prevWord;
	    WRITE: expWord = currIn;
	    READ1READ2: expWord = prevWord;
	    WRITEREAD1: expWord = currIn;
	    WRITEREAD2: expWord = currIn;
	    WRITEREAD1READ2: expWord = currIn;
	    NONE: expWord = 16'hxxxx;
	    default: exp = 16'hxxxx;
	  endcase
	  #20
	  case({writeEnable, readEnable1, readEnable2})
	    READ1, WRITEREAD1: if (currOut_1 != expWord) begin
	      err = 1;
	      $display(" register error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%d bitline2:%d exp:%d prev: %d",
	         currIn, writeEnable, readEnable1, readEnable2, currOut_1, currOut_2, expWord, prevWord);
	      end
	    READ2, WRITEREAD2: if (currOut_2 != expWord)begin
	      err = 1;
	      $display(" register error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%d bitline2:%d exp:%d, prev:%d",
	         currIn, writeEnable, readEnable1, readEnable2, currOut_1, currOut_2, expWord, prevWord);
	      end
	    WRITEREAD1READ2, READ1READ2: if(currOut_1 != expWord || currOut_2 != expWord) begin
	      err = 1;
	      $display(" register error= D:%d writeEnable:%d readEnable1: %d readEnable2: %d bitline1:%h bitline2:%h exp:%d prev:%d",
	         currIn, writeEnable, readEnable1, readEnable2, currOut_1, currOut_2, expWord, prevWord);
	      end
	    //default: continue;
	  endcase
	  if(writeEnable) prevWord = currIn;
	end
if(err == 0)
	  $display("register passed... ");
	else 
	  err = 0;
	#20 
	rst = 1;
	prev = 0; 
	#20
	rst = 0;  
	for(i = 0; i < 16; i = i+1) begin
	  regArray[i] = 16'h0000;
	end
//TESTING REGISTER FILE
// .clk(clk), .rst(rst), .srcReg_1(regID_1), .srcReg_2(regID_2), .dstReg(writeReg),
	//		 .writeReg(writeEnable), .dstData(currIn), .srcData_1(currOut_1), .srcData_2(currOut_2)
	repeat(500) begin
	  currIn = $random;
	  writeEnable = $random;
	  regID_1 = $random; 
	  regID_2 = $random;
	  writeReg = $random;
	  readEnable1 = $random; 
	  readEnable2 = $random; 
	  #20 

	  regArray[writeReg] = currIn;
	  #20
	  if(currOut_1 != regArray[regID_1])
	    err = 1;
	  if(currOut_2 != regArray[regID_2])
	    err = 1;	  
	end
if(err == 0)
	  $display("register file passed... ");
	else 
	  err = 0;
end
endmodule