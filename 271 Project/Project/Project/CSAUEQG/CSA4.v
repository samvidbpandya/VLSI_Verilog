`timescale 1ns/10ps
//4 bit CSA

module CSA4(sum_4, cout_4, op1_4, op2_4, cin_4);
output [3:0]sum_4;
output cout_4;
input [3:0]op1_4,op2_4;
input cin_4;
wire [3:0]sum0,sum1;
wire cout0, cout1;
wire c1, c2, c3, c4, c5, c6;
//sum for carry 0

FA f1(.sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(op2_4[0]), .cin(1'b0));
FA f2(.sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(op2_4[1]), .cin(c1));
FA f3(.sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(op2_4[2]), .cin(c2));
FA f4(.sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(op2_4[3]), .cin(c3));

//sum for carry 1

FA f5(.sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(op2_4[0]), .cin(1'b1));
FA f6(.sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(op2_4[1]), .cin(c4));
FA f7(.sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(op2_4[2]), .cin(c5));
FA f8(.sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(op2_4[3]), .cin(c6));

assign sum_4 = cin_4 ? sum1 : sum0;
assign cout_4 = cin_4 ? cout1 : cout0;
endmodule
