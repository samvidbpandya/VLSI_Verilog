`timescale 1ns/10ps


//2 bit CSA
module CSA2(sum_2, cout_2, op1_2, op2_2, cin_2);
output [1:0]sum_2;
output cout_2;
input [1:0]op1_2,op2_2;
input cin_2;
wire [1:0]sum0,sum1;
wire cout0, cout1;
wire crout1, crout2;

//sum for carry 0
FA f1(.sum_fa(sum0[0]), .cout_fa(crout1), .op1_fa(op1_2[0]), .op2_fa(op2_2[0]), .cin(1'b0));
FA f2(.sum_fa(sum0[1]), .cout_fa(cout0), .op1_fa(op1_2[1]), .op2_fa(op2_2[1]), .cin(crout1));

//sum for carry 1
FA f3(.sum_fa(sum1[0]), .cout_fa(crout2), .op1_fa(op1_2[0]), .op2_fa(op2_2[0]), .cin(1'b1));
FA f4(.sum_fa(sum1[1]), .cout_fa(cout1), .op1_fa(op1_2[1]), .op2_fa(op2_2[1]), .cin(crout2));

assign sum_2 = cin_2 ? sum1 : sum0;
assign cout_2 = cin_2 ? cout1 : cout0;
endmodule
