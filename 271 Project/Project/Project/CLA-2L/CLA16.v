`timescale 1ns/10ps

module CLA16(sum_4,crout,op1_4,op2_4);
output [15:0]sum_4;
output crout;
input  [15:0]op1_4,op2_4;
wire [15:0]sum_4;
wire p1,p2,p3;
wire [3:0]G,P;

CLA4 C1(.sum(sum_4[3:0]),.crout(p1),.P1(P[0]),.G1(G[0]),.op1(op1_4[3:0]),.op2(op2_4[3:0]));
CLA4_2 C2(.sum(sum_4[7:4]),.crout(p2),.P2(P[1]),.G2(G[1]),.op1(op1_4[7:4]),.op2(op2_4[7:4]),.Cin(p1));
CLA4_2 C3(.sum(sum_4[11:8]),.crout(p3),.P2(P[2]),.G2(G[2]),.op1(op1_4[11:8]),.op2(op2_4[11:8]),.Cin(p2));
CLA4_2 C4(.sum(sum_4[15:12]),.crout(),.P2(P[3]),.G2(G[3]),.op1(op1_4[15:12]),.op2(op2_4[15:12]),.Cin(p3));

assign crout = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]);
endmodule
