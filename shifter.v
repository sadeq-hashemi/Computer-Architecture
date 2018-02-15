module Shifter (shift_in, shift_val, mode, shift_out);

input [15:0] shift_in; //This is the number to perform shift operation on
input [3:0] shift_val; //Shift amount (used to shift the ?shift_in?)
input  mode; // To indicate SLL or SRA 
output [15:0] shift_out; //Shifter value

wire [15:0] SRA1;
wire [15:0] SRA2;
wire [15:0] SRA4;
wire [15:0] SRA8;

wire [15:0] SLL1;
wire [15:0] SLL2;
wire [15:0] SLL4;
wire [15:0] SLL8;

assign SRA1[15:0] = shift_val[0] ? {shift_in[15], shift_in[15:1]} : shift_in[15:0];
assign SRA2[15:0] = shift_val[1] ? {SRA1[15], SRA1[15], SRA1[15:2]} : SRA1[15:0];
assign SRA4[15:0] = shift_val[2] ? {SRA2[15], SRA2[15], SRA2[15], SRA2[15:4]} : SRA2[15:0];
assign SRA8[15:0] = shift_val[3] ? {SRA4[15], SRA4[15], SRA4[15], SRA4[15], SRA4[15], SRA4[15], SRA4[15], SRA4[15], SRA4[15:8]} : SRA4[15:0];

assign SLL1[15:0] = shift_val[0] ? {shift_in[15:1], 1'b0}: shift_in[15:0];
assign SLL2[15:0] = shift_val[1] ? {SLL1[15:2], 1'b0, 1'b0}: SLL1[15:0];
assign SLL4[15:0] = shift_val[2] ? {SLL2[15:4], 1'b0, 1'b0, 1'b0, 1'b0}: SLL2[15:0];
assign SLL8[15:0] = shift_val[3] ? {SLL4[15:8], 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}: SLL4[15:0];


assign shift_out[15:0] = mode ?  SLL8[15:0]: SRA8[15:0]; 

endmodule


