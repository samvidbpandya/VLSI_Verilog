`timescale 1ns/10ps

//10bit CSA
module CSA10(s10,co10,a10,b10,in10);
output [9:0]s10;
output co10;
input [9:0]a10,b10;
input in10;
wire [9:0]s10;
wire c1,c2;

CSA2 J1(.sum_2(s10[1:0]),.cout_2(c1),.op1_2(a10[1:0]),.op2_2(b10[1:0]),.cin_2(in10));
CSA4 J2(.sum_4(s10[5:2]),.cout_4(c2),.op1_4(a10[5:2]),.op2_4(b10[5:2]),.cin_4(c1));
CSA4 J3(.sum_4(s10[9:6]),.cout_4(co10),.op1_4(a10[9:6]),.op2_4(b10[9:6]),.cin_4(c2));
endmodule

