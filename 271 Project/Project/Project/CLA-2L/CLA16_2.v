`timescale 1ns/10ps

module CLA16_2(sum_16,crout_16,op1_16,op2_16,Cin);
output [15:0]sum_16;
output crout_16;
input  [15:0]op1_16,op2_16;
input Cin;
wire p1,p2,p3;
wire [3:0]G,P;

CLA4_2 A1(.sum(sum_16[3:0]),.crout(p1), .P2(P[0]), .G2(G[0]), .op1(op1_16[3:0]),.op2(op2_16[3:0]), .Cin(Cin));
CLA4_2 A2(.sum(sum_16[7:4]),.crout(p2), .P2(P[1]),.G2(G[1]), .op1(op1_16[7:4]), .op2(op2_16[7:4]),.Cin(p1));
CLA4_2 A3(.sum(sum_16[11:8]),.crout(p3), .P2(P[2]),.G2(G[2]), .op1(op1_16[11:8]), .op2(op2_16[11:8]),.Cin(p2));
CLA4_2 A4(.sum(sum_16[15:12]),.crout(), .P2(P[3]),.G2(G[3]), .op1(op1_16[15:12]), .op2(op2_16[15:12]),.Cin(p3));

assign crout_16 = G[3] | (G[2] & P[3]) | (G[1] & P[2] & P[3]) | (G[0] & P[1] & P[2] & P[3]) | (Cin & P[0] & P[1] & P[2] & P[3]) ;

endmodule
