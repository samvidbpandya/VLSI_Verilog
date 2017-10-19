`timescale 1ns/10ps

//8bit CSA
module CSA8(s8,co8,a8,b8,in8);
output [7:0]s8;
output co8;
input [7:0]a8,b8;
input in8;
wire [7:0]s8;
wire c1;

CSA4 T1(.sum_4(s8[3:0]),.cout_4(c1),.op1_4(a8[3:0]),.op2_4(b8[3:0]),.cin_4(in8));
CSA4 T2(.sum_4(s8[7:4]),.cout_4(co8),.op1_4(a8[7:4]),.op2_4(b8[7:4]),.cin_4(c1));
endmodule

