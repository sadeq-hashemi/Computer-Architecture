module ALU (ALU_in1, ALU_in2, opcode, ALU_out, error );

input [3:0] ALU_in1, ALU_in2;
input [1:0] opcode; //ADD:00 SUB:01 NAND:10 XOR:11
output [3:0] ALU_out;
output error; // Just to show overflow
wire [3:0] sumdiff; //holds sum or difference
wire ovfl; 

addsub_4bit addsub(ALU_in1[3:0], ALU_in2[3:0], opcode[0], sumdiff[3:0], ovfl); //ADD/SUB opcode[0] can act as substract signal

assign {error, ALU_out} = opcode[1] ? 
			//NAND or XOR
			opcode[0] ? 
			{1'b0, ALU_in1 ^ ALU_in2} : {1'b0, ALU_in1 &~ ALU_in2} : 
			//ADD/SUB
			{sumdiff,ovfl};
			
endmodule