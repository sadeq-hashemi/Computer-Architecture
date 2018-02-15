module Shifter (shift_in, shift_val, mode, shift_out);

input [15:0] shift_in; //This is the number to perform shift operation on
input [3:0] shift_val; //Shift amount (used to shift the ?shift_in?)
input  mode; // To indicate SLL or SRA 
output [15:0] shift_out; //Shifter value

wire [15:0] SRA1;
wire [15:0] SRA2;
wire [15:0] SRA4;
wire [15:0] SRA8;

//SHIFT RIGHT ARITHMETIC 
//bit 0 
assign SRA1[0] = shift_val[0] ? shift_in[1] : shift_in[0];  
assign SRA1[1] = shift_val[0] ? shift_in[2] : shift_in[1]; 
assign SRA1[2] = shift_val[0] ? shift_in[3] : shift_in[2]; 
assign SRA1[3] = shift_val[0] ? shift_in[4] : shift_in[3]; 
assign SRA1[4] = shift_val[0] ? shift_in[5] : shift_in[4]; 
assign SRA1[5] = shift_val[0] ? shift_in[6] : shift_in[5]; 
assign SRA1[6] = shift_val[0] ? shift_in[7] : shift_in[6]; 
assign SRA1[7] = shift_val[0] ? shift_in[8] : shift_in[7]; 
assign SRA1[8] = shift_val[0] ? shift_in[9] : shift_in[8];  
assign SRA1[9] = shift_val[0] ? shift_in[10] : shift_in[9]; 
assign SRA1[10] = shift_val[0] ? shift_in[11] : shift_in[10]; 
assign SRA1[11] = shift_val[0] ? shift_in[12] : shift_in[11]; 
assign SRA1[12] = shift_val[0] ? shift_in[13] : shift_in[12]; 
assign SRA1[13] = shift_val[0] ? shift_in[14] : shift_in[13]; 
assign SRA1[14] = shift_val[0] ? shift_in[15] : shift_in[14]; 
assign SRA1[15] = shift_val[0] ? shift_in[15] : shift_in[15]; 

//bit 1
assign SRA2[0] = shift_val[1] ? SRA1[2] : SRA1[0];
assign SRA2[1] = shift_val[1] ? SRA1[3] : SRA1[1];
assign SRA2[2] = shift_val[1] ? SRA1[4] : SRA1[2];
assign SRA2[3] = shift_val[1] ? SRA1[5] : SRA1[3];
assign SRA2[4] = shift_val[1] ? SRA1[6] : SRA1[4];
assign SRA2[5] = shift_val[1] ? SRA1[7] : SRA1[5];
assign SRA2[6] = shift_val[1] ? SRA1[8] : SRA1[6];
assign SRA2[7] = shift_val[1] ? SRA1[9] : SRA1[7];
assign SRA2[8] = shift_val[1] ? SRA1[10] : SRA1[8];
assign SRA2[9] = shift_val[1] ? SRA1[11] : SRA1[9];
assign SRA2[10] = shift_val[1] ? SRA1[12] : SRA1[10];
assign SRA2[11] = shift_val[1] ? SRA1[13] : SRA1[11];
assign SRA2[12] = shift_val[1] ? SRA1[14] : SRA1[12];
assign SRA2[13] = shift_val[1] ? SRA1[15] : SRA1[13];
assign SRA2[14] = shift_val[1] ? SRA1[15] : SRA1[14];
assign SRA2[15] = shift_val[1] ? SRA1[15] : SRA1[15];


//bit 2

assign SRA4[1] = shift_val[2] ? SRA2[4] : SRA2[1];
assign SRA4[2] = shift_val[2] ? SRA2[5] : SRA2[2];
assign SRA4[3] = shift_val[2] ? SRA2[6] : SRA2[3];
assign SRA4[4] = shift_val[2] ? SRA2[7] : SRA2[4];
assign SRA4[5] = shift_val[2] ? SRA2[8] : SRA2[5];
assign SRA4[6] = shift_val[2] ? SRA2[9] : SRA2[6];
assign SRA4[7] = shift_val[2] ? SRA2[10] : SRA2[7];
assign SRA4[8] = shift_val[2] ? SRA2[11] : SRA2[8];
assign SRA4[9] = shift_val[2] ? SRA2[12] : SRA2[9];
assign SRA4[10] = shift_val[2] ? SRA2[13] : SRA2[10];
assign SRA4[11] = shift_val[2] ? SRA2[14] : SRA2[11];
assign SRA4[12] = shift_val[2] ? SRA2[15] : SRA2[12];
assign SRA4[13] = shift_val[2] ? SRA2[15] : SRA2[13];
assign SRA4[14] = shift_val[2] ? SRA2[15] : SRA2[14];
assign SRA4[15] = shift_val[2] ? SRA2[15] : SRA2[15];

//bit 3
assign SRA8[0] = shift_val[3] ? SRA4[8] : SRA4[0];
assign SRA8[1] = shift_val[3] ? SRA4[9] : SRA4[1];
assign SRA8[2] = shift_val[3] ? SRA4[10] : SRA4[2];
assign SRA8[3] = shift_val[3] ? SRA4[11] : SRA4[3];
assign SRA8[4] = shift_val[3] ? SRA4[12] : SRA4[4];
assign SRA8[5] = shift_val[3] ? SRA4[13] : SRA4[5];
assign SRA8[6] = shift_val[3] ? SRA4[14] : SRA4[6];
assign SRA8[7] = shift_val[3] ? SRA4[15] : SRA4[7];
assign SRA8[8] = shift_val[3] ? SRA4[15] : SRA4[8];
assign SRA8[9] = shift_val[3] ? SRA4[15] : SRA4[9];
assign SRA8[10] = shift_val[3] ? SRA4[15] : SRA4[10];
assign SRA8[11] = shift_val[3] ? SRA4[15] : SRA4[11];
assign SRA8[12] = shift_val[3] ? SRA4[15] : SRA4[12];
assign SRA8[13] = shift_val[3] ? SRA4[15] : SRA4[13];
assign SRA8[14] = shift_val[3] ? SRA4[15] : SRA4[14];
assign SRA8[15] = shift_val[3] ? SRA4[15] : SRA4[15];

//SHIFT LEFT LOGICAL 
//bit 0

//bit 1
//bit 2
//bit 3

//bit2
endmodule

