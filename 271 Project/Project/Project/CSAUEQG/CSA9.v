`timescale 1ns/10ps

//9 bit CSA
module CSA9(s9,co9,a9,b9,in9);
output [8:0]s9;
output co9;
input [8:0]a9,b9;
input in9;
wire [8:0]s9;
wire c1,c2;

CSA3 V1(.sum_3(s9[2:0]),.cout_3(c1),.op1_3(a9[2:0]),.op2_3(b9[2:0]),.cin_3(in9));
CSA3 V2(.sum_3(s9[5:3]),.cout_3(c2),.op1_3(a9[5:3]),.op2_3(b9[5:3]),.cin_3(c1));
CSA3 V3(.sum_3(s9[8:6]),.cout_3(co9),.op1_3(a9[8:6]),.op2_3(b9[8:6]),.cin_3(c2));
endmodule

