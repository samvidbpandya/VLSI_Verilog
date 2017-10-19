`timescale 1ns/10ps

//7bit CSA
module CSA7(s7,co7,a7,b7,in7);
output [6:0]s7;
output co7;
input [6:0]a7,b7;
input in7;
wire [6:0]s6;
wire c1;

CSA3 J1(.sum_3(s7[2:0]),.cout_3(c1),.op1_3(a7[2:0]),.op2_3(b7[2:0]),.cin_3(in7));
CSA4 J2(.sum_4(s7[6:3]),.cout_4(co7),.op1_4(a7[6:3]),.op2_4(b7[6:3]),.cin_4(c1));
endmodule

