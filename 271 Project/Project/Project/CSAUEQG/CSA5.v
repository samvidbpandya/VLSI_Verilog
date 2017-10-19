`timescale 1ns/10ps

//5bit CSA
module CSA5(s,co,a,b,in);
output [4:0]s;
output co;
input [4:0]a,b;
input in;
wire [4:0]s;
wire c1;

CSA2 D1(.sum_2(s[1:0]),.cout_2(c1),.op1_2(a[1:0]),.op2_2(b[1:0]),.cin_2(in));
CSA3 D2(.sum_3(s[4:2]),.cout_3(co),.op1_3(a[4:2]),.op2_3(b[4:2]),.cin_3(c1));

endmodule

