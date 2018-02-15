module PSA_16bit (A, B, sum, error);

input [15:0] A, B; //Input values
output [15:0] sum; //sum output
output error; //To indicate overflows
wire [3:0] ovfl;

addsub_4bit add1 (A[3:0], B[3:0], 1'b0, sum[3:0], ovfl[0]);
addsub_4bit add2 (A[7:4], B[7:4], 1'b0, sum[7:4], ovfl[1]);
addsub_4bit add3 (A[11:8], B[11:9], 1'b0, sum[11:9], ovfl[2]);
addsub_4bit add4 (A[15:12], B[15:12], 1'b0, sum[15:12], ovfl[3]);

assign error = ovfl[0] | ovfl[1] | ovfl[2] | ovfl[3];

endmodule

