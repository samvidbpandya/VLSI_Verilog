`timescale 1ns/10ps

module CLA4(sum,crout,P1,G1,op1,op2);
output [3:0]sum;
output crout;
output P1,G1;
input  [3:0] op1,op2;
wire [3:0]G,P,C;

    assign G = op1 & op2; //Generate
    assign P = op1 ^ op2; //Propagate
    assign C[0] = 0;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign crout = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) |(P[3] & P[2] & P[1] & P[0] & C[0]);
    assign sum = P ^ C;
    
    assign P1 = P[3] & P[2] & P[1] & P[0];
    assign G1 = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
endmodule
