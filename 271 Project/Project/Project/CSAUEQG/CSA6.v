`timescale 1ns/10ps

//6bit CSA
module CSA6(s6,co6,a6,b6,in6);
output [5:0]s6;
output co6;
input [5:0]a6,b6;
input in6;
wire [5:0]s6;
wire c1;

CSA3 E1(.sum_3(s6[2:0]),.cout_3(c1),.op1_3(a6[2:0]),.op2_3(b6[2:0]),.cin_3(in6));
CSA3 E2(.sum_3(s6[5:3]),.cout_3(co6),.op1_3(a6[5:3]),.op2_3(b6[5:3]),.cin_3(c1));
endmodule

