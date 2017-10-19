`timescale 1ns/10ps

//11bit CSA
module CSA11(s11,co11,a11,b11,in11);
output [10:0]s11;
output co11;
input [10:0]a11,b11;
input in11;
wire [10:0]s11;
wire c1,c2;

CSA3 R1(.sum_3(s11[2:0]),.cout_3(c1),.op1_3(a11[2:0]),.op2_3(b11[2:0]),.cin_3(in11));
CSA4 R2(.sum_4(s11[6:3]),.cout_4(c2),.op1_4(a11[6:3]),.op2_4(b11[6:3]),.cin_4(c1));
CSA4 R3(.sum_4(s11[10:7]),.cout_4(co11),.op1_4(a11[10:7]),.op2_4(b11[10:7]),.cin_4(c2));
endmodule
