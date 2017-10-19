`timescale 1ns/10ps

//3 bit CSA

module CSA3(sum_3, cout_3, op1_3, op2_3, cin_3);
output [2:0]sum_3;
output cout_3;
input [2:0]op1_3,op2_3;
input cin_3;
wire [2:0]sum0,sum1;
wire cout0, cout1;
wire c1, c2, c3, c4;

//sum for carry 0
FA s1(.sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_3[0]), .op2_fa(op2_3[0]), .cin(1'b0));
FA s2(.sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_3[1]), .op2_fa(op2_3[1]), .cin(c1));
FA s3(.sum_fa(sum0[2]), .cout_fa(cout0), .op1_fa(op1_3[2]), .op2_fa(op2_3[2]), .cin(c2));

//sum for carry 1
FA s4(.sum_fa(sum1[0]), .cout_fa(c3), .op1_fa(op1_3[0]), .op2_fa(op2_3[0]), .cin(1'b1));
FA s5(.sum_fa(sum1[1]), .cout_fa(c4), .op1_fa(op1_3[1]), .op2_fa(op2_3[1]), .cin(c3));
FA s6(.sum_fa(sum1[2]), .cout_fa(cout1), .op1_fa(op1_3[2]), .op2_fa(op2_3[2]), .cin(c4));

assign sum_3 = cin_3 ? sum1 : sum0;
assign cout_3 = cin_3 ? cout1 : cout0;
endmodule
