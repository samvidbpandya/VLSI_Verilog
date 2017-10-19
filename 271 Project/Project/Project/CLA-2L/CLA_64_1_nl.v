
module CLA4 ( sum, crout, P1, G1, op1, op2 );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  output crout, P1, G1;
  wire   n13, crout, n1, n2, n3, n4, n5, n6, n8, n9, n10, n11, n12;
  assign G1 = crout;

  CEOX1 U6 ( .A(op2[0]), .B(op1[0]), .Z(n13) );
  CAOR2X1 U7 ( .A(op2[3]), .B(op1[3]), .C(n2), .D(n1), .Z(crout) );
  CEOX1 U8 ( .A(op2[3]), .B(op1[3]), .Z(n1) );
  CEOX1 U10 ( .A(op2[2]), .B(op1[2]), .Z(n4) );
  CAOR2X1 U11 ( .A(n9), .B(op1[1]), .C(n6), .D(n5), .Z(n3) );
  CAN2X1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n5) );
  CNIVX1 U2 ( .A(n13), .Z(sum[0]) );
  CDLY1XL U3 ( .A(n6), .Z(n8) );
  CNIVX1 U4 ( .A(op2[1]), .Z(n9) );
  CDLY1XL U5 ( .A(n2), .Z(n10) );
  CND2X1 U9 ( .A(op2[2]), .B(op1[2]), .Z(n11) );
  CND2X2 U13 ( .A(n3), .B(n4), .Z(n12) );
  CND2X2 U14 ( .A(n12), .B(n11), .Z(n2) );
  CEOXL U15 ( .A(n1), .B(n10), .Z(sum[3]) );
  CEOXL U16 ( .A(n3), .B(n4), .Z(sum[2]) );
  CAN4XL U17 ( .A(n13), .B(n1), .C(n4), .D(n8), .Z(P1) );
  CEOXL U18 ( .A(n5), .B(n8), .Z(sum[1]) );
  CEOX2 U19 ( .A(op2[1]), .B(op1[1]), .Z(n6) );
endmodule


module CLA4_2_0 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16
;

  CENX1 U1 ( .A(n1), .B(n2), .Z(sum[3]) );
  CEOX1 U2 ( .A(n3), .B(n4), .Z(sum[2]) );
  CEOX1 U3 ( .A(n5), .B(n6), .Z(sum[1]) );
  CND2X1 U4 ( .A(n7), .B(n8), .Z(n6) );
  COND2X1 U6 ( .A(n10), .B(n11), .C(n1), .D(n12), .Z(crout) );
  CANR2X1 U7 ( .A(op2[2]), .B(op1[2]), .C(n4), .D(n3), .Z(n1) );
  CAOR1X1 U8 ( .A(n5), .B(n13), .C(n14), .Z(n4) );
  CIVX1 U9 ( .A(n8), .Z(n13) );
  CAN4X1 U11 ( .A(n2), .B(n3), .C(n9), .D(n5), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n9) );
  CIVX1 U14 ( .A(n2), .Z(n12) );
  CENX1 U15 ( .A(n10), .B(op1[3]), .Z(n2) );
  CANR2X1 U16 ( .A(n3), .B(n14), .C(op1[2]), .D(op2[2]), .Z(n15) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n5), .D(n16), .Z(n14) );
  CIVX1 U18 ( .A(n7), .Z(n16) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n7) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n3) );
  CIVX1 U22 ( .A(op1[3]), .Z(n11) );
  CIVX1 U23 ( .A(op2[3]), .Z(n10) );
  CEOX2 U5 ( .A(op2[1]), .B(op1[1]), .Z(n5) );
  COND2X1 U10 ( .A(n10), .B(n11), .C(n15), .D(n12), .Z(G2) );
  CEOXL U13 ( .A(Cin), .B(n9), .Z(sum[0]) );
  CND2XL U20 ( .A(Cin), .B(n9), .Z(n8) );
endmodule


module CLA4_2_14 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CENX1 U1 ( .A(n32), .B(n31), .Z(sum[3]) );
  CEOX1 U2 ( .A(n30), .B(n29), .Z(sum[2]) );
  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CND2X1 U4 ( .A(n26), .B(n25), .Z(n27) );
  CEOX1 U5 ( .A(Cin), .B(n24), .Z(sum[0]) );
  COND2X1 U6 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CANR2X1 U7 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CND2X1 U10 ( .A(Cin), .B(n24), .Z(n25) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
  CANR2XL U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CEOX2 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
endmodule


module CLA4_2_13 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CENX1 U1 ( .A(n32), .B(n31), .Z(sum[3]) );
  CEOX1 U2 ( .A(n30), .B(n29), .Z(sum[2]) );
  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CND2X1 U4 ( .A(n26), .B(n25), .Z(n27) );
  CEOX1 U5 ( .A(Cin), .B(n24), .Z(sum[0]) );
  COND2X1 U6 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CANR2X1 U7 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CND2X1 U10 ( .A(Cin), .B(n24), .Z(n25) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CANR2X1 U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
endmodule


module CLA16 ( sum_4, crout, op1_4, op2_4 );
  output [15:0] sum_4;
  input [15:0] op1_4;
  input [15:0] op2_4;
  output crout;
  wire   p1, p2, p3, n1, n2;
  wire   [3:0] P;
  wire   [3:0] G;

  CAOR1X1 U1 ( .A(P[3]), .B(n1), .C(G[3]), .Z(crout) );
  CND2IX1 U2 ( .B(G[2]), .A(n2), .Z(n1) );
  COND4CX1 U3 ( .A(P[1]), .B(G[0]), .C(G[1]), .D(P[2]), .Z(n2) );
  CLA4 C1 ( .sum(sum_4[3:0]), .crout(p1), .G1(G[0]), .op1(op1_4[3:0]), .op2(
        op2_4[3:0]) );
  CLA4_2_0 C2 ( .sum(sum_4[7:4]), .crout(p2), .P2(P[1]), .G2(G[1]), .op1(
        op1_4[7:4]), .op2(op2_4[7:4]), .Cin(p1) );
  CLA4_2_14 C3 ( .sum(sum_4[11:8]), .crout(p3), .P2(P[2]), .G2(G[2]), .op1(
        op1_4[11:8]), .op2(op2_4[11:8]), .Cin(p2) );
  CLA4_2_13 C4 ( .sum(sum_4[15:12]), .P2(P[3]), .G2(G[3]), .op1(op1_4[15:12]), 
        .op2(op2_4[15:12]), .Cin(p3) );
endmodule


module CLA4_2_12 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CANR2X1 U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
  CEOXL U1 ( .A(n30), .B(n29), .Z(sum[2]) );
  CND2X2 U2 ( .A(Cin), .B(n24), .Z(n25) );
  CND2XL U4 ( .A(n26), .B(n25), .Z(n27) );
  CENXL U5 ( .A(n32), .B(n31), .Z(sum[3]) );
  COND2X2 U6 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CANR2X2 U7 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
  CEOXL U10 ( .A(Cin), .B(n24), .Z(sum[0]) );
endmodule


module CLA4_2_11 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CANR2X1 U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
  CEOXL U1 ( .A(n30), .B(n29), .Z(sum[2]) );
  CEOXL U2 ( .A(Cin), .B(n24), .Z(sum[0]) );
  CENXL U4 ( .A(n32), .B(n31), .Z(sum[3]) );
  CND2XL U5 ( .A(n26), .B(n25), .Z(n27) );
  COND2X2 U6 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CND2X2 U7 ( .A(Cin), .B(n24), .Z(n25) );
  CANR2X2 U10 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
endmodule


module CLA4_2_10 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CANR2X1 U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
  CEOXL U1 ( .A(n30), .B(n29), .Z(sum[2]) );
  CEOXL U2 ( .A(Cin), .B(n24), .Z(sum[0]) );
  CND2X2 U4 ( .A(Cin), .B(n24), .Z(n25) );
  CND2XL U5 ( .A(n26), .B(n25), .Z(n27) );
  CENXL U6 ( .A(n32), .B(n31), .Z(sum[3]) );
  COND2X2 U7 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CANR2X2 U10 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
endmodule


module CLA4_2_9 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32;

  CENX1 U1 ( .A(n32), .B(n31), .Z(sum[3]) );
  CEOX1 U3 ( .A(n28), .B(n27), .Z(sum[1]) );
  CND2X1 U4 ( .A(n26), .B(n25), .Z(n27) );
  CAOR1X1 U8 ( .A(n28), .B(n20), .C(n19), .Z(n29) );
  CIVX1 U9 ( .A(n25), .Z(n20) );
  CAN4X1 U11 ( .A(n31), .B(n30), .C(n24), .D(n28), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n24) );
  COND2X1 U13 ( .A(n23), .B(n22), .C(n18), .D(n21), .Z(G2) );
  CIVX1 U14 ( .A(n31), .Z(n21) );
  CENX1 U15 ( .A(n23), .B(op1[3]), .Z(n31) );
  CANR2X1 U16 ( .A(n30), .B(n19), .C(op1[2]), .D(op2[2]), .Z(n18) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n28), .D(n17), .Z(n19) );
  CIVX1 U18 ( .A(n26), .Z(n17) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n26) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n28) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n30) );
  CIVX1 U22 ( .A(op1[3]), .Z(n22) );
  CIVX1 U23 ( .A(op2[3]), .Z(n23) );
  CND2X2 U2 ( .A(Cin), .B(n24), .Z(n25) );
  CEOXL U5 ( .A(Cin), .B(n24), .Z(sum[0]) );
  CEOXL U6 ( .A(n30), .B(n29), .Z(sum[2]) );
  COND2XL U7 ( .A(n23), .B(n22), .C(n32), .D(n21), .Z(crout) );
  CANR2X2 U10 ( .A(op2[2]), .B(op1[2]), .C(n29), .D(n30), .Z(n32) );
endmodule


module CLA16_2_0 ( sum_16, crout_16, op1_16, op2_16, Cin );
  output [15:0] sum_16;
  input [15:0] op1_16;
  input [15:0] op2_16;
  input Cin;
  output crout_16;
  wire   p1, p2, p3, n1, n2, n3, n4, n5;
  wire   [3:0] P;
  wire   [3:0] G;

  COND4CX1 U2 ( .A(P[2]), .B(n2), .C(G[2]), .D(P[3]), .Z(n1) );
  CND2IX1 U3 ( .B(G[1]), .A(n3), .Z(n2) );
  COND4CX1 U4 ( .A(P[0]), .B(Cin), .C(G[0]), .D(P[1]), .Z(n3) );
  CLA4_2_12 A1 ( .sum(sum_16[3:0]), .crout(p1), .P2(P[0]), .G2(G[0]), .op1(
        op1_16[3:0]), .op2(op2_16[3:0]), .Cin(n5) );
  CLA4_2_11 A2 ( .sum(sum_16[7:4]), .crout(p2), .P2(P[1]), .G2(G[1]), .op1(
        op1_16[7:4]), .op2(op2_16[7:4]), .Cin(p1) );
  CLA4_2_10 A3 ( .sum(sum_16[11:8]), .crout(p3), .P2(P[2]), .G2(G[2]), .op1(
        op1_16[11:8]), .op2(op2_16[11:8]), .Cin(p2) );
  CLA4_2_9 A4 ( .sum(sum_16[15:12]), .P2(P[3]), .G2(G[3]), .op1(op1_16[15:12]), 
        .op2(op2_16[15:12]), .Cin(p3) );
  CIVX1 U1 ( .A(n4), .Z(n5) );
  CND2IX1 U5 ( .B(G[3]), .A(n1), .Z(crout_16) );
  CIVXL U6 ( .A(Cin), .Z(n4) );
endmodule


module CLA4_2_8 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;

  CEOX1 U3 ( .A(n33), .B(n32), .Z(sum[1]) );
  CAOR1X1 U8 ( .A(n33), .B(n25), .C(n24), .Z(n34) );
  CAN4X1 U11 ( .A(n36), .B(n35), .C(n29), .D(n33), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n29) );
  COND2X1 U13 ( .A(n28), .B(n27), .C(n23), .D(n26), .Z(G2) );
  CIVX1 U14 ( .A(n36), .Z(n26) );
  CENX1 U15 ( .A(n28), .B(op1[3]), .Z(n36) );
  CANR2X1 U16 ( .A(n35), .B(n24), .C(op1[2]), .D(op2[2]), .Z(n23) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n33), .D(n22), .Z(n24) );
  CIVX1 U18 ( .A(n31), .Z(n22) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n31) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n33) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n35) );
  CIVX1 U22 ( .A(op1[3]), .Z(n27) );
  CIVX1 U23 ( .A(op2[3]), .Z(n28) );
  CIVX2 U1 ( .A(n30), .Z(n25) );
  CND2X2 U2 ( .A(Cin), .B(n29), .Z(n30) );
  CND2X2 U4 ( .A(n34), .B(n35), .Z(n20) );
  CDLY1XL U5 ( .A(n25), .Z(n17) );
  CIVXL U6 ( .A(n17), .Z(n18) );
  CEOXL U7 ( .A(n35), .B(n34), .Z(sum[2]) );
  CND2X1 U9 ( .A(op2[2]), .B(op1[2]), .Z(n19) );
  CAN2X2 U10 ( .A(n20), .B(n19), .Z(n37) );
  CDLY1XL U24 ( .A(Cin), .Z(n21) );
  CND2XL U25 ( .A(n31), .B(n18), .Z(n32) );
  CEOXL U26 ( .A(n21), .B(n29), .Z(sum[0]) );
  CENXL U27 ( .A(n37), .B(n36), .Z(sum[3]) );
  COND2X2 U28 ( .A(n28), .B(n27), .C(n37), .D(n26), .Z(crout) );
endmodule


module CLA4_2_7 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38;

  CEOX1 U3 ( .A(n34), .B(n33), .Z(sum[1]) );
  CAN4X1 U11 ( .A(n37), .B(n36), .C(n30), .D(n34), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n30) );
  COND2X1 U13 ( .A(n29), .B(n28), .C(n24), .D(n27), .Z(G2) );
  CIVX1 U14 ( .A(n37), .Z(n27) );
  CENX1 U15 ( .A(n29), .B(op1[3]), .Z(n37) );
  CANR2X1 U16 ( .A(n36), .B(n25), .C(op1[2]), .D(op2[2]), .Z(n24) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n34), .D(n23), .Z(n25) );
  CIVX1 U18 ( .A(n32), .Z(n23) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n32) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n34) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n36) );
  CIVX1 U22 ( .A(op1[3]), .Z(n28) );
  CIVX1 U23 ( .A(op2[3]), .Z(n29) );
  CND2X2 U1 ( .A(n26), .B(n34), .Z(n17) );
  CIVX2 U2 ( .A(n25), .Z(n18) );
  CND2X2 U4 ( .A(n17), .B(n18), .Z(n35) );
  CAN2X2 U5 ( .A(n21), .B(n22), .Z(n19) );
  CDLY1XL U6 ( .A(Cin), .Z(n20) );
  CND2X1 U7 ( .A(op2[2]), .B(op1[2]), .Z(n21) );
  CND2X2 U8 ( .A(n35), .B(n36), .Z(n22) );
  CAN2X2 U9 ( .A(n21), .B(n22), .Z(n38) );
  CIVX2 U10 ( .A(n31), .Z(n26) );
  CND2XL U24 ( .A(n32), .B(n31), .Z(n33) );
  CEOXL U25 ( .A(n36), .B(n35), .Z(sum[2]) );
  CEOXL U26 ( .A(n20), .B(n30), .Z(sum[0]) );
  CND2X2 U27 ( .A(Cin), .B(n30), .Z(n31) );
  CENXL U28 ( .A(n19), .B(n37), .Z(sum[3]) );
  COND2X2 U29 ( .A(n29), .B(n28), .C(n38), .D(n27), .Z(crout) );
endmodule


module CLA4_2_6 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37;

  CEOX1 U3 ( .A(n33), .B(n32), .Z(sum[1]) );
  CND2X1 U4 ( .A(n31), .B(n21), .Z(n32) );
  CAN4X1 U11 ( .A(n36), .B(n35), .C(n29), .D(n33), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n29) );
  COND2X1 U13 ( .A(n28), .B(n27), .C(n23), .D(n26), .Z(G2) );
  CIVX1 U14 ( .A(n36), .Z(n26) );
  CENX1 U15 ( .A(n28), .B(op1[3]), .Z(n36) );
  CANR2X1 U16 ( .A(n35), .B(n24), .C(op1[2]), .D(op2[2]), .Z(n23) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n33), .D(n22), .Z(n24) );
  CIVX1 U18 ( .A(n31), .Z(n22) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n31) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n33) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n35) );
  CIVX1 U22 ( .A(op1[3]), .Z(n27) );
  CIVX1 U23 ( .A(op2[3]), .Z(n28) );
  CND2X2 U1 ( .A(n17), .B(n18), .Z(n34) );
  CANR2X4 U2 ( .A(op2[2]), .B(op1[2]), .C(n35), .D(n34), .Z(n37) );
  CND2X2 U5 ( .A(n25), .B(n33), .Z(n17) );
  CIVX2 U6 ( .A(n24), .Z(n18) );
  CDLY1XL U7 ( .A(Cin), .Z(n19) );
  CDLY1XL U8 ( .A(n25), .Z(n20) );
  CIVXL U9 ( .A(n20), .Z(n21) );
  CIVX2 U10 ( .A(n30), .Z(n25) );
  CEOXL U24 ( .A(n35), .B(n34), .Z(sum[2]) );
  CND2X2 U25 ( .A(Cin), .B(n29), .Z(n30) );
  CEOXL U26 ( .A(n19), .B(n29), .Z(sum[0]) );
  CENXL U27 ( .A(n37), .B(n36), .Z(sum[3]) );
  COND2X2 U28 ( .A(n28), .B(n27), .C(n37), .D(n26), .Z(crout) );
endmodule


module CLA4_2_5 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38;

  CEOX1 U3 ( .A(n34), .B(n33), .Z(sum[1]) );
  CAOR1X1 U8 ( .A(n34), .B(n26), .C(n25), .Z(n35) );
  CAN4X1 U11 ( .A(n37), .B(n36), .C(n30), .D(n34), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n30) );
  COND2X1 U13 ( .A(n29), .B(n28), .C(n24), .D(n27), .Z(G2) );
  CIVX1 U14 ( .A(n37), .Z(n27) );
  CENX1 U15 ( .A(n29), .B(op1[3]), .Z(n37) );
  CANR2X1 U16 ( .A(n36), .B(n25), .C(op1[2]), .D(op2[2]), .Z(n24) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n34), .D(n23), .Z(n25) );
  CIVX1 U18 ( .A(n32), .Z(n23) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n32) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n34) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n36) );
  CIVX1 U22 ( .A(op1[3]), .Z(n28) );
  CIVX1 U23 ( .A(op2[3]), .Z(n29) );
  CIVXL U1 ( .A(Cin), .Z(n17) );
  CIVX2 U2 ( .A(n17), .Z(n18) );
  CEOX2 U4 ( .A(n38), .B(n19), .Z(sum[3]) );
  CIVX20 U5 ( .A(n37), .Z(n19) );
  CND2X1 U6 ( .A(op2[2]), .B(op1[2]), .Z(n20) );
  CND2X2 U7 ( .A(n35), .B(n36), .Z(n21) );
  CAN2X2 U9 ( .A(n20), .B(n21), .Z(n38) );
  CIVXL U10 ( .A(n26), .Z(n22) );
  CIVX2 U24 ( .A(n31), .Z(n26) );
  CEOXL U25 ( .A(n30), .B(n18), .Z(sum[0]) );
  CND2X2 U26 ( .A(Cin), .B(n30), .Z(n31) );
  CEOXL U27 ( .A(n36), .B(n35), .Z(sum[2]) );
  CND2XL U28 ( .A(n32), .B(n22), .Z(n33) );
  COND2XL U29 ( .A(n29), .B(n28), .C(n38), .D(n27), .Z(crout) );
endmodule


module CLA16_2_2 ( sum_16, crout_16, op1_16, op2_16, Cin );
  output [15:0] sum_16;
  input [15:0] op1_16;
  input [15:0] op2_16;
  input Cin;
  output crout_16;
  wire   p1, p2, p3, n4, n5, n6;
  wire   [3:0] P;
  wire   [3:0] G;

  COND4CX1 U2 ( .A(P[2]), .B(n5), .C(G[2]), .D(P[3]), .Z(n6) );
  CND2IX1 U3 ( .B(G[1]), .A(n4), .Z(n5) );
  CLA4_2_8 A1 ( .sum(sum_16[3:0]), .crout(p1), .P2(P[0]), .G2(G[0]), .op1(
        op1_16[3:0]), .op2(op2_16[3:0]), .Cin(Cin) );
  CLA4_2_7 A2 ( .sum(sum_16[7:4]), .crout(p2), .P2(P[1]), .G2(G[1]), .op1(
        op1_16[7:4]), .op2(op2_16[7:4]), .Cin(p1) );
  CLA4_2_6 A3 ( .sum(sum_16[11:8]), .crout(p3), .P2(P[2]), .G2(G[2]), .op1(
        op1_16[11:8]), .op2(op2_16[11:8]), .Cin(p2) );
  CLA4_2_5 A4 ( .sum(sum_16[15:12]), .P2(P[3]), .G2(G[3]), .op1(op1_16[15:12]), 
        .op2(op2_16[15:12]), .Cin(p3) );
  CND2IX2 U1 ( .B(G[3]), .A(n6), .Z(crout_16) );
  COND4CX1 U4 ( .A(P[0]), .B(Cin), .C(G[0]), .D(P[1]), .Z(n4) );
endmodule


module CLA4_2_4 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n13, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35;

  CEOX1 U3 ( .A(n31), .B(n30), .Z(sum[1]) );
  CAN4X1 U11 ( .A(n34), .B(n33), .C(n27), .D(n31), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n27) );
  COND2X1 U13 ( .A(n26), .B(n25), .C(n22), .D(n24), .Z(G2) );
  CIVX1 U14 ( .A(n34), .Z(n24) );
  CENX1 U15 ( .A(n26), .B(op1[3]), .Z(n34) );
  CANR2X1 U16 ( .A(n33), .B(n23), .C(op1[2]), .D(op2[2]), .Z(n22) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n31), .D(n21), .Z(n23) );
  CIVX1 U18 ( .A(n29), .Z(n21) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n29) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n31) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n33) );
  CIVX1 U22 ( .A(op1[3]), .Z(n25) );
  CIVX1 U23 ( .A(op2[3]), .Z(n26) );
  CANR2XL U1 ( .A(op2[2]), .B(op1[2]), .C(n33), .D(n32), .Z(n13) );
  CANR2X2 U2 ( .A(op2[2]), .B(op1[2]), .C(n33), .D(n32), .Z(n35) );
  CDLY1XL U4 ( .A(Cin), .Z(n17) );
  CDLY1XL U5 ( .A(n32), .Z(n18) );
  CND2XL U6 ( .A(n29), .B(n28), .Z(n30) );
  COND1X2 U7 ( .A(n19), .B(n28), .C(n20), .Z(n32) );
  CIVX20 U8 ( .A(n31), .Z(n19) );
  CIVX20 U9 ( .A(n23), .Z(n20) );
  CEOXL U10 ( .A(n17), .B(n27), .Z(sum[0]) );
  CEOXL U24 ( .A(n33), .B(n18), .Z(sum[2]) );
  CND2X2 U25 ( .A(Cin), .B(n27), .Z(n28) );
  CENXL U26 ( .A(n13), .B(n34), .Z(sum[3]) );
  COND2X2 U27 ( .A(n26), .B(n25), .C(n35), .D(n24), .Z(crout) );
endmodule


module CLA4_2_3 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41;

  CEOX1 U3 ( .A(n37), .B(n36), .Z(sum[1]) );
  CND2X1 U4 ( .A(n35), .B(n25), .Z(n36) );
  CAN4X1 U11 ( .A(n40), .B(n39), .C(n33), .D(n37), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n33) );
  COND2X1 U13 ( .A(n32), .B(n31), .C(n27), .D(n30), .Z(G2) );
  CIVX1 U14 ( .A(n40), .Z(n30) );
  CENX1 U15 ( .A(n32), .B(op1[3]), .Z(n40) );
  CANR2X1 U16 ( .A(n39), .B(n28), .C(op1[2]), .D(op2[2]), .Z(n27) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n37), .D(n26), .Z(n28) );
  CIVX1 U18 ( .A(n35), .Z(n26) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n35) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n37) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n39) );
  CIVX1 U22 ( .A(op1[3]), .Z(n31) );
  CIVX1 U23 ( .A(op2[3]), .Z(n32) );
  CDLY1XL U1 ( .A(n38), .Z(n17) );
  CAN2X2 U2 ( .A(n23), .B(n22), .Z(n41) );
  CAN2XL U5 ( .A(n22), .B(n23), .Z(n18) );
  CIVXL U6 ( .A(n34), .Z(n29) );
  COND1X2 U7 ( .A(n19), .B(n34), .C(n20), .Z(n38) );
  CIVX20 U8 ( .A(n37), .Z(n19) );
  CIVX20 U9 ( .A(n28), .Z(n20) );
  CDLY1XL U10 ( .A(Cin), .Z(n21) );
  CND2X1 U24 ( .A(op2[2]), .B(op1[2]), .Z(n22) );
  CND2X2 U25 ( .A(n38), .B(n39), .Z(n23) );
  CDLY1XL U26 ( .A(n29), .Z(n24) );
  CIVXL U27 ( .A(n24), .Z(n25) );
  CEOXL U28 ( .A(n39), .B(n17), .Z(sum[2]) );
  CEOXL U29 ( .A(n21), .B(n33), .Z(sum[0]) );
  CND2X2 U30 ( .A(Cin), .B(n33), .Z(n34) );
  CENXL U31 ( .A(n18), .B(n40), .Z(sum[3]) );
  COND2X2 U32 ( .A(n32), .B(n31), .C(n41), .D(n30), .Z(crout) );
endmodule


module CLA4_2_2 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n13, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41;

  CEOX1 U3 ( .A(n37), .B(n36), .Z(sum[1]) );
  CAN4X1 U11 ( .A(n40), .B(n39), .C(n33), .D(n37), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n33) );
  COND2X1 U13 ( .A(n32), .B(n31), .C(n28), .D(n30), .Z(G2) );
  CIVX1 U14 ( .A(n40), .Z(n30) );
  CENX1 U15 ( .A(n32), .B(op1[3]), .Z(n40) );
  CANR2X1 U16 ( .A(n39), .B(n29), .C(op1[2]), .D(op2[2]), .Z(n28) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n37), .D(n27), .Z(n29) );
  CIVX1 U18 ( .A(n35), .Z(n27) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n35) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n37) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n39) );
  CIVX1 U22 ( .A(op1[3]), .Z(n31) );
  CIVX1 U23 ( .A(op2[3]), .Z(n32) );
  CEOX2 U1 ( .A(n39), .B(n19), .Z(sum[2]) );
  CIVX2 U2 ( .A(n17), .Z(n18) );
  CDLY1XL U4 ( .A(Cin), .Z(n13) );
  CDLY1XL U5 ( .A(n38), .Z(n17) );
  CAN2X2 U6 ( .A(n24), .B(n23), .Z(n41) );
  CAN2XL U7 ( .A(n23), .B(n24), .Z(n22) );
  CIVX2 U8 ( .A(n18), .Z(n19) );
  CIVXL U9 ( .A(n13), .Z(n20) );
  CIVX2 U10 ( .A(n20), .Z(n21) );
  CND2XL U24 ( .A(n34), .B(n35), .Z(n36) );
  CND2X1 U25 ( .A(op2[2]), .B(op1[2]), .Z(n23) );
  CND2X2 U26 ( .A(n38), .B(n39), .Z(n24) );
  COND1X2 U27 ( .A(n25), .B(n34), .C(n26), .Z(n38) );
  CIVX20 U28 ( .A(n37), .Z(n25) );
  CIVX20 U29 ( .A(n29), .Z(n26) );
  CEOXL U30 ( .A(n21), .B(n33), .Z(sum[0]) );
  CND2X2 U31 ( .A(Cin), .B(n33), .Z(n34) );
  CENXL U32 ( .A(n22), .B(n40), .Z(sum[3]) );
  COND2X2 U33 ( .A(n32), .B(n31), .C(n41), .D(n30), .Z(crout) );
endmodule


module CLA4_2_1 ( sum, crout, P2, G2, op1, op2, Cin );
  output [3:0] sum;
  input [3:0] op1;
  input [3:0] op2;
  input Cin;
  output crout, P2, G2;
  wire   n13, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38;

  CEOX1 U3 ( .A(n34), .B(n33), .Z(sum[1]) );
  CAN4X1 U11 ( .A(n37), .B(n36), .C(n30), .D(n34), .Z(P2) );
  CEOX1 U12 ( .A(op2[0]), .B(op1[0]), .Z(n30) );
  COND2X1 U13 ( .A(n29), .B(n28), .C(n25), .D(n27), .Z(G2) );
  CIVX1 U14 ( .A(n37), .Z(n27) );
  CENX1 U15 ( .A(n29), .B(op1[3]), .Z(n37) );
  CANR2X1 U16 ( .A(n36), .B(n26), .C(op1[2]), .D(op2[2]), .Z(n25) );
  CAOR2X1 U17 ( .A(op2[1]), .B(op1[1]), .C(n34), .D(n24), .Z(n26) );
  CIVX1 U18 ( .A(n32), .Z(n24) );
  CND2X1 U19 ( .A(op2[0]), .B(op1[0]), .Z(n32) );
  CEOX1 U20 ( .A(op2[1]), .B(op1[1]), .Z(n34) );
  CEOX1 U21 ( .A(op2[2]), .B(op1[2]), .Z(n36) );
  CIVX1 U22 ( .A(op1[3]), .Z(n28) );
  CIVX1 U23 ( .A(op2[3]), .Z(n29) );
  CAN2XL U1 ( .A(n23), .B(n22), .Z(n13) );
  COND1X2 U2 ( .A(n17), .B(n31), .C(n18), .Z(n35) );
  CIVX20 U4 ( .A(n34), .Z(n17) );
  CIVX20 U5 ( .A(n26), .Z(n18) );
  CIVXL U6 ( .A(Cin), .Z(n19) );
  CIVX2 U7 ( .A(n19), .Z(n20) );
  CEOX2 U8 ( .A(n38), .B(n21), .Z(sum[3]) );
  CIVX20 U9 ( .A(n37), .Z(n21) );
  CND2X1 U10 ( .A(op2[2]), .B(op1[2]), .Z(n22) );
  CND2X2 U24 ( .A(n35), .B(n36), .Z(n23) );
  CAN2X2 U25 ( .A(n23), .B(n22), .Z(n38) );
  CND2XL U26 ( .A(n31), .B(n32), .Z(n33) );
  CEOXL U27 ( .A(n30), .B(n20), .Z(sum[0]) );
  CND2X2 U28 ( .A(Cin), .B(n30), .Z(n31) );
  CEOXL U29 ( .A(n36), .B(n35), .Z(sum[2]) );
  COND2XL U30 ( .A(n29), .B(n28), .C(n13), .D(n27), .Z(crout) );
endmodule


module CLA16_2_1 ( sum_16, crout_16, op1_16, op2_16, Cin );
  output [15:0] sum_16;
  input [15:0] op1_16;
  input [15:0] op2_16;
  input Cin;
  output crout_16;
  wire   p1, p2, p3, n4, n5, n6;
  wire   [3:0] P;
  wire   [3:0] G;

  CND2IX1 U1 ( .B(G[3]), .A(n6), .Z(crout_16) );
  COND4CX1 U2 ( .A(P[2]), .B(n5), .C(G[2]), .D(P[3]), .Z(n6) );
  CND2IX1 U3 ( .B(G[1]), .A(n4), .Z(n5) );
  CLA4_2_4 A1 ( .sum(sum_16[3:0]), .crout(p1), .P2(P[0]), .G2(G[0]), .op1(
        op1_16[3:0]), .op2(op2_16[3:0]), .Cin(Cin) );
  CLA4_2_3 A2 ( .sum(sum_16[7:4]), .crout(p2), .P2(P[1]), .G2(G[1]), .op1(
        op1_16[7:4]), .op2(op2_16[7:4]), .Cin(p1) );
  CLA4_2_2 A3 ( .sum(sum_16[11:8]), .crout(p3), .P2(P[2]), .G2(G[2]), .op1(
        op1_16[11:8]), .op2(op2_16[11:8]), .Cin(p2) );
  CLA4_2_1 A4 ( .sum(sum_16[15:12]), .P2(P[3]), .G2(G[3]), .op1(op1_16[15:12]), 
        .op2(op2_16[15:12]), .Cin(p3) );
  COND4CXL U4 ( .A(P[0]), .B(Cin), .C(G[0]), .D(P[1]), .Z(n4) );
endmodule


module CLA_64 ( sum, crout, op1, op2, clock, reset );
  output [63:0] sum;
  input [63:0] op1;
  input [63:0] op2;
  input clock, reset;
  output crout;
  wire   c1, c2, c3, croutf, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158, n159, n160, n161, n162, n163,
         n164, n165, n166, n167, n168, n169, n170, n171, n172, n173, n174,
         n175, n176, n177, n178, n179, n180, n181, n182, n183, n184, n185,
         n186, n187, n188, n189, n190, n191, n192, n193, n194, n195, n196,
         n197, n198, n199, n200, n201, n202, n203, n204, n205, n206, n207,
         n208, n209, n210, n211, n212, n213, n214, n215, n216, n217, n218,
         n219, n220, n221, n222, n223, n224, n225, n226, n227, n228, n229,
         n230, n231, n232, n233, n234, n235, n236, n237, n238, n239, n240,
         n241, n242, n243, n244, n245, n246, n247, n248, n249, n250, n251,
         n252, n253, n254, n255, n256, n257, n258, n259, n260, n261, n262,
         n263, n264, n265, n266, n267, n268, n269, n270, n271, n272, n273,
         n274;
  wire   [63:0] sum_f;
  wire   [63:0] op1_f;
  wire   [63:0] op2_f;

  CFD2QX1 \op2_f_reg[61]  ( .D(n234), .CP(clock), .CD(n258), .Q(op2_f[61]) );
  CFD2QX1 \op2_f_reg[60]  ( .D(n232), .CP(clock), .CD(n258), .Q(op2_f[60]) );
  CFD2QX1 \op2_f_reg[59]  ( .D(n230), .CP(clock), .CD(n258), .Q(op2_f[59]) );
  CFD2QX1 \op2_f_reg[57]  ( .D(n228), .CP(clock), .CD(n259), .Q(op2_f[57]) );
  CFD2QX1 \op2_f_reg[56]  ( .D(n226), .CP(clock), .CD(n259), .Q(op2_f[56]) );
  CFD2QX1 \op2_f_reg[55]  ( .D(n224), .CP(clock), .CD(n259), .Q(op2_f[55]) );
  CFD2QX1 \op2_f_reg[53]  ( .D(n222), .CP(clock), .CD(n259), .Q(op2_f[53]) );
  CFD2QX1 \op2_f_reg[52]  ( .D(n220), .CP(clock), .CD(n260), .Q(op2_f[52]) );
  CFD2QX1 \op2_f_reg[51]  ( .D(n218), .CP(clock), .CD(n260), .Q(op2_f[51]) );
  CFD2QX1 \op2_f_reg[50]  ( .D(n216), .CP(clock), .CD(n260), .Q(op2_f[50]) );
  CFD2QX1 \op2_f_reg[49]  ( .D(n214), .CP(clock), .CD(n260), .Q(op2_f[49]) );
  CFD2QX1 \op2_f_reg[48]  ( .D(n212), .CP(clock), .CD(n260), .Q(op2_f[48]) );
  CFD2QX1 \op2_f_reg[47]  ( .D(n210), .CP(clock), .CD(n260), .Q(op2_f[47]) );
  CFD2QX1 \op2_f_reg[45]  ( .D(n208), .CP(clock), .CD(n261), .Q(op2_f[45]) );
  CFD2QX1 \op2_f_reg[44]  ( .D(n206), .CP(clock), .CD(n261), .Q(op2_f[44]) );
  CFD2QX1 \op2_f_reg[43]  ( .D(n204), .CP(clock), .CD(n261), .Q(op2_f[43]) );
  CFD2QX1 \op2_f_reg[42]  ( .D(n202), .CP(clock), .CD(n261), .Q(op2_f[42]) );
  CFD2QX1 \op2_f_reg[41]  ( .D(n200), .CP(clock), .CD(n261), .Q(op2_f[41]) );
  CFD2QX1 \op2_f_reg[40]  ( .D(n198), .CP(clock), .CD(n262), .Q(op2_f[40]) );
  CFD2QX1 \op2_f_reg[39]  ( .D(n196), .CP(clock), .CD(n262), .Q(op2_f[39]) );
  CFD2QX1 \op2_f_reg[37]  ( .D(n194), .CP(clock), .CD(n262), .Q(op2_f[37]) );
  CFD2QX1 \op2_f_reg[36]  ( .D(n192), .CP(clock), .CD(n262), .Q(op2_f[36]) );
  CFD2QX1 \op2_f_reg[35]  ( .D(n190), .CP(clock), .CD(n262), .Q(op2_f[35]) );
  CFD2QX1 \op2_f_reg[34]  ( .D(n188), .CP(clock), .CD(n263), .Q(op2_f[34]) );
  CFD2QX1 \op2_f_reg[33]  ( .D(n186), .CP(clock), .CD(n263), .Q(op2_f[33]) );
  CFD2QX1 \op2_f_reg[32]  ( .D(n184), .CP(clock), .CD(n263), .Q(op2_f[32]) );
  CFD2QX1 \op2_f_reg[31]  ( .D(n182), .CP(clock), .CD(n263), .Q(op2_f[31]) );
  CFD2QX1 \op2_f_reg[30]  ( .D(n180), .CP(clock), .CD(n263), .Q(op2_f[30]) );
  CFD2QX1 \op2_f_reg[29]  ( .D(n178), .CP(clock), .CD(n263), .Q(op2_f[29]) );
  CFD2QX1 \op2_f_reg[28]  ( .D(n176), .CP(clock), .CD(n264), .Q(op2_f[28]) );
  CFD2QX1 \op2_f_reg[27]  ( .D(n174), .CP(clock), .CD(n264), .Q(op2_f[27]) );
  CFD2QX1 \op2_f_reg[26]  ( .D(n172), .CP(clock), .CD(n264), .Q(op2_f[26]) );
  CFD2QX1 \op2_f_reg[25]  ( .D(n170), .CP(clock), .CD(n264), .Q(op2_f[25]) );
  CFD2QX1 \op2_f_reg[24]  ( .D(n168), .CP(clock), .CD(n264), .Q(op2_f[24]) );
  CFD2QX1 \op2_f_reg[23]  ( .D(n166), .CP(clock), .CD(n264), .Q(op2_f[23]) );
  CFD2QX1 \op2_f_reg[22]  ( .D(n164), .CP(clock), .CD(n265), .Q(op2_f[22]) );
  CFD2QX1 \op2_f_reg[21]  ( .D(n162), .CP(clock), .CD(n265), .Q(op2_f[21]) );
  CFD2QX1 \op2_f_reg[20]  ( .D(n160), .CP(clock), .CD(n265), .Q(op2_f[20]) );
  CFD2QX1 \op2_f_reg[19]  ( .D(n158), .CP(clock), .CD(n265), .Q(op2_f[19]) );
  CFD2QX1 \op2_f_reg[18]  ( .D(n156), .CP(clock), .CD(n265), .Q(op2_f[18]) );
  CFD2QX1 \op2_f_reg[17]  ( .D(n154), .CP(clock), .CD(n265), .Q(op2_f[17]) );
  CFD2QX1 \op2_f_reg[16]  ( .D(n152), .CP(clock), .CD(n266), .Q(op2_f[16]) );
  CFD2QX1 \op2_f_reg[15]  ( .D(n150), .CP(clock), .CD(n266), .Q(op2_f[15]) );
  CFD2QX1 \op2_f_reg[14]  ( .D(n148), .CP(clock), .CD(n266), .Q(op2_f[14]) );
  CFD2QX1 \op2_f_reg[13]  ( .D(n146), .CP(clock), .CD(n266), .Q(op2_f[13]) );
  CFD2QX1 \op2_f_reg[12]  ( .D(n144), .CP(clock), .CD(n266), .Q(op2_f[12]) );
  CFD2QX1 \op2_f_reg[11]  ( .D(n142), .CP(clock), .CD(n266), .Q(op2_f[11]) );
  CFD2QX1 \op2_f_reg[10]  ( .D(n140), .CP(clock), .CD(n267), .Q(op2_f[10]) );
  CFD2QX1 \op2_f_reg[9]  ( .D(n138), .CP(clock), .CD(n267), .Q(op2_f[9]) );
  CFD2QX1 \op2_f_reg[8]  ( .D(n136), .CP(clock), .CD(n267), .Q(op2_f[8]) );
  CFD2QX1 \op2_f_reg[7]  ( .D(n134), .CP(clock), .CD(n267), .Q(op2_f[7]) );
  CFD2QX1 \op2_f_reg[6]  ( .D(n132), .CP(clock), .CD(n267), .Q(op2_f[6]) );
  CFD2QX1 \op2_f_reg[5]  ( .D(n130), .CP(clock), .CD(n267), .Q(op2_f[5]) );
  CFD2QX1 \op2_f_reg[4]  ( .D(n128), .CP(clock), .CD(n268), .Q(op2_f[4]) );
  CFD2QX1 \op2_f_reg[3]  ( .D(n126), .CP(clock), .CD(n268), .Q(op2_f[3]) );
  CFD2QX1 \op2_f_reg[2]  ( .D(n124), .CP(clock), .CD(n268), .Q(op2_f[2]) );
  CFD2QX1 \op2_f_reg[1]  ( .D(n122), .CP(clock), .CD(n268), .Q(op2_f[1]) );
  CFD2QX1 \op2_f_reg[0]  ( .D(n120), .CP(clock), .CD(n268), .Q(op2_f[0]) );
  CFD2QX1 \op1_f_reg[63]  ( .D(n118), .CP(clock), .CD(n268), .Q(op1_f[63]) );
  CFD2QX1 \op1_f_reg[61]  ( .D(n116), .CP(clock), .CD(n268), .Q(op1_f[61]) );
  CFD2QX1 \op1_f_reg[60]  ( .D(n114), .CP(clock), .CD(n269), .Q(op1_f[60]) );
  CFD2QX1 \op1_f_reg[59]  ( .D(n112), .CP(clock), .CD(n269), .Q(op1_f[59]) );
  CFD2QX1 \op1_f_reg[57]  ( .D(n110), .CP(clock), .CD(n269), .Q(op1_f[57]) );
  CFD2QX1 \op1_f_reg[56]  ( .D(n108), .CP(clock), .CD(n269), .Q(op1_f[56]) );
  CFD2QX1 \op1_f_reg[55]  ( .D(n106), .CP(clock), .CD(n269), .Q(op1_f[55]) );
  CFD2QX1 \op1_f_reg[53]  ( .D(n104), .CP(clock), .CD(n269), .Q(op1_f[53]) );
  CFD2QX1 \op1_f_reg[52]  ( .D(n102), .CP(clock), .CD(n269), .Q(op1_f[52]) );
  CFD2QX1 \op1_f_reg[51]  ( .D(n100), .CP(clock), .CD(n269), .Q(op1_f[51]) );
  CFD2QX1 \op1_f_reg[50]  ( .D(n98), .CP(clock), .CD(n269), .Q(op1_f[50]) );
  CFD2QX1 \op1_f_reg[49]  ( .D(n96), .CP(clock), .CD(n269), .Q(op1_f[49]) );
  CFD2QX1 \op1_f_reg[48]  ( .D(n94), .CP(clock), .CD(n270), .Q(op1_f[48]) );
  CFD2QX1 \op1_f_reg[47]  ( .D(n92), .CP(clock), .CD(n270), .Q(op1_f[47]) );
  CFD2QX1 \op1_f_reg[45]  ( .D(n90), .CP(clock), .CD(n270), .Q(op1_f[45]) );
  CFD2QX1 \op1_f_reg[44]  ( .D(n88), .CP(clock), .CD(n270), .Q(op1_f[44]) );
  CFD2QX1 \op1_f_reg[43]  ( .D(n86), .CP(clock), .CD(n270), .Q(op1_f[43]) );
  CFD2QX1 \op1_f_reg[42]  ( .D(n84), .CP(clock), .CD(n270), .Q(op1_f[42]) );
  CFD2QX1 \op1_f_reg[41]  ( .D(n82), .CP(clock), .CD(n270), .Q(op1_f[41]) );
  CFD2QX1 \op1_f_reg[40]  ( .D(n80), .CP(clock), .CD(n270), .Q(op1_f[40]) );
  CFD2QX1 \op1_f_reg[39]  ( .D(n78), .CP(clock), .CD(n270), .Q(op1_f[39]) );
  CFD2QX1 \op1_f_reg[37]  ( .D(n76), .CP(clock), .CD(n270), .Q(op1_f[37]) );
  CFD2QX1 \op1_f_reg[36]  ( .D(n74), .CP(clock), .CD(n271), .Q(op1_f[36]) );
  CFD2QX1 \op1_f_reg[35]  ( .D(n72), .CP(clock), .CD(n271), .Q(op1_f[35]) );
  CFD2QX1 \op1_f_reg[34]  ( .D(n70), .CP(clock), .CD(n271), .Q(op1_f[34]) );
  CFD2QX1 \op1_f_reg[33]  ( .D(n68), .CP(clock), .CD(n271), .Q(op1_f[33]) );
  CFD2QX1 \op1_f_reg[32]  ( .D(n66), .CP(clock), .CD(n271), .Q(op1_f[32]) );
  CFD2QX1 \op1_f_reg[31]  ( .D(n64), .CP(clock), .CD(n271), .Q(op1_f[31]) );
  CFD2QX1 \op1_f_reg[30]  ( .D(n62), .CP(clock), .CD(n271), .Q(op1_f[30]) );
  CFD2QX1 \op1_f_reg[29]  ( .D(n60), .CP(clock), .CD(n271), .Q(op1_f[29]) );
  CFD2QX1 \op1_f_reg[28]  ( .D(n58), .CP(clock), .CD(n271), .Q(op1_f[28]) );
  CFD2QX1 \op1_f_reg[27]  ( .D(n56), .CP(clock), .CD(n271), .Q(op1_f[27]) );
  CFD2QX1 \op1_f_reg[26]  ( .D(n54), .CP(clock), .CD(n271), .Q(op1_f[26]) );
  CFD2QX1 \op1_f_reg[25]  ( .D(n52), .CP(clock), .CD(n271), .Q(op1_f[25]) );
  CFD2QX1 \op1_f_reg[24]  ( .D(n50), .CP(clock), .CD(n272), .Q(op1_f[24]) );
  CFD2QX1 \op1_f_reg[23]  ( .D(n48), .CP(clock), .CD(n272), .Q(op1_f[23]) );
  CFD2QX1 \op1_f_reg[22]  ( .D(n46), .CP(clock), .CD(n272), .Q(op1_f[22]) );
  CFD2QX1 \op1_f_reg[21]  ( .D(n44), .CP(clock), .CD(n272), .Q(op1_f[21]) );
  CFD2QX1 \op1_f_reg[20]  ( .D(n42), .CP(clock), .CD(n272), .Q(op1_f[20]) );
  CFD2QX1 \op1_f_reg[19]  ( .D(n40), .CP(clock), .CD(n272), .Q(op1_f[19]) );
  CFD2QX1 \op1_f_reg[18]  ( .D(n38), .CP(clock), .CD(n272), .Q(op1_f[18]) );
  CFD2QX1 \op1_f_reg[17]  ( .D(n36), .CP(clock), .CD(n272), .Q(op1_f[17]) );
  CFD2QX1 \op1_f_reg[16]  ( .D(n34), .CP(clock), .CD(n272), .Q(op1_f[16]) );
  CFD2QX1 \op1_f_reg[15]  ( .D(n32), .CP(clock), .CD(n272), .Q(op1_f[15]) );
  CFD2QX1 \op1_f_reg[14]  ( .D(n30), .CP(clock), .CD(n272), .Q(op1_f[14]) );
  CFD2QX1 \op1_f_reg[13]  ( .D(n28), .CP(clock), .CD(n272), .Q(op1_f[13]) );
  CFD2QX1 \op1_f_reg[12]  ( .D(n26), .CP(clock), .CD(n273), .Q(op1_f[12]) );
  CFD2QX1 \op1_f_reg[11]  ( .D(n24), .CP(clock), .CD(n273), .Q(op1_f[11]) );
  CFD2QX1 \op1_f_reg[10]  ( .D(n22), .CP(clock), .CD(n273), .Q(op1_f[10]) );
  CFD2QX1 \op1_f_reg[9]  ( .D(n20), .CP(clock), .CD(n273), .Q(op1_f[9]) );
  CFD2QX1 \op1_f_reg[8]  ( .D(n18), .CP(clock), .CD(n273), .Q(op1_f[8]) );
  CFD2QX1 \op1_f_reg[7]  ( .D(n16), .CP(clock), .CD(n273), .Q(op1_f[7]) );
  CFD2QX1 \op1_f_reg[6]  ( .D(n14), .CP(clock), .CD(n273), .Q(op1_f[6]) );
  CFD2QX1 \op1_f_reg[5]  ( .D(n12), .CP(clock), .CD(n273), .Q(op1_f[5]) );
  CFD2QX1 \op1_f_reg[4]  ( .D(n10), .CP(clock), .CD(n273), .Q(op1_f[4]) );
  CFD2QX1 \op1_f_reg[3]  ( .D(n8), .CP(clock), .CD(n273), .Q(op1_f[3]) );
  CFD2QX1 \op1_f_reg[2]  ( .D(n6), .CP(clock), .CD(n273), .Q(op1_f[2]) );
  CFD2QX1 \op1_f_reg[1]  ( .D(n4), .CP(clock), .CD(n273), .Q(op1_f[1]) );
  CFD2QX1 \op1_f_reg[0]  ( .D(n2), .CP(clock), .CD(n274), .Q(op1_f[0]) );
  CFD2QX1 crout_reg ( .D(croutf), .CP(clock), .CD(n258), .Q(crout) );
  CFD2QX1 \sum_reg[48]  ( .D(sum_f[48]), .CP(clock), .CD(n260), .Q(sum[48]) );
  CFD2QX1 \sum_reg[49]  ( .D(sum_f[49]), .CP(clock), .CD(n260), .Q(sum[49]) );
  CFD2QX1 \sum_reg[50]  ( .D(sum_f[50]), .CP(clock), .CD(n260), .Q(sum[50]) );
  CFD2QX1 \sum_reg[51]  ( .D(sum_f[51]), .CP(clock), .CD(n260), .Q(sum[51]) );
  CFD2QX1 \sum_reg[52]  ( .D(sum_f[52]), .CP(clock), .CD(n259), .Q(sum[52]) );
  CFD2QX1 \sum_reg[53]  ( .D(sum_f[53]), .CP(clock), .CD(n259), .Q(sum[53]) );
  CFD2QX1 \sum_reg[55]  ( .D(sum_f[55]), .CP(clock), .CD(n259), .Q(sum[55]) );
  CFD2QX1 \sum_reg[56]  ( .D(sum_f[56]), .CP(clock), .CD(n259), .Q(sum[56]) );
  CFD2QX1 \sum_reg[57]  ( .D(sum_f[57]), .CP(clock), .CD(n259), .Q(sum[57]) );
  CFD2QX1 \sum_reg[58]  ( .D(sum_f[58]), .CP(clock), .CD(n258), .Q(sum[58]) );
  CFD2QX1 \sum_reg[59]  ( .D(sum_f[59]), .CP(clock), .CD(n258), .Q(sum[59]) );
  CFD2QX1 \sum_reg[61]  ( .D(sum_f[61]), .CP(clock), .CD(n258), .Q(sum[61]) );
  CFD2QX1 \sum_reg[33]  ( .D(sum_f[33]), .CP(clock), .CD(n263), .Q(sum[33]) );
  CFD2QX1 \sum_reg[36]  ( .D(sum_f[36]), .CP(clock), .CD(n262), .Q(sum[36]) );
  CFD2QX1 \sum_reg[37]  ( .D(sum_f[37]), .CP(clock), .CD(n262), .Q(sum[37]) );
  CFD2QX1 \sum_reg[39]  ( .D(sum_f[39]), .CP(clock), .CD(n262), .Q(sum[39]) );
  CFD2QX1 \sum_reg[40]  ( .D(sum_f[40]), .CP(clock), .CD(n261), .Q(sum[40]) );
  CFD2QX1 \sum_reg[41]  ( .D(sum_f[41]), .CP(clock), .CD(n261), .Q(sum[41]) );
  CFD2QX1 \sum_reg[43]  ( .D(sum_f[43]), .CP(clock), .CD(n261), .Q(sum[43]) );
  CFD2QX1 \sum_reg[44]  ( .D(sum_f[44]), .CP(clock), .CD(n261), .Q(sum[44]) );
  CFD2QX1 \sum_reg[45]  ( .D(sum_f[45]), .CP(clock), .CD(n261), .Q(sum[45]) );
  CFD2QX1 \sum_reg[46]  ( .D(sum_f[46]), .CP(clock), .CD(n260), .Q(sum[46]) );
  CFD2QX1 \sum_reg[47]  ( .D(sum_f[47]), .CP(clock), .CD(n260), .Q(sum[47]) );
  CFD2QX1 \sum_reg[16]  ( .D(sum_f[16]), .CP(clock), .CD(n265), .Q(sum[16]) );
  CFD2QX1 \sum_reg[17]  ( .D(sum_f[17]), .CP(clock), .CD(n265), .Q(sum[17]) );
  CFD2QX1 \sum_reg[18]  ( .D(sum_f[18]), .CP(clock), .CD(n265), .Q(sum[18]) );
  CFD2QX1 \sum_reg[19]  ( .D(sum_f[19]), .CP(clock), .CD(n265), .Q(sum[19]) );
  CFD2QX1 \sum_reg[20]  ( .D(sum_f[20]), .CP(clock), .CD(n265), .Q(sum[20]) );
  CFD2QX1 \sum_reg[21]  ( .D(sum_f[21]), .CP(clock), .CD(n265), .Q(sum[21]) );
  CFD2QX1 \sum_reg[22]  ( .D(sum_f[22]), .CP(clock), .CD(n264), .Q(sum[22]) );
  CFD2QX1 \sum_reg[23]  ( .D(sum_f[23]), .CP(clock), .CD(n264), .Q(sum[23]) );
  CFD2QX1 \sum_reg[24]  ( .D(sum_f[24]), .CP(clock), .CD(n264), .Q(sum[24]) );
  CFD2QX1 \sum_reg[25]  ( .D(sum_f[25]), .CP(clock), .CD(n264), .Q(sum[25]) );
  CFD2QX1 \sum_reg[26]  ( .D(sum_f[26]), .CP(clock), .CD(n264), .Q(sum[26]) );
  CFD2QX1 \sum_reg[27]  ( .D(sum_f[27]), .CP(clock), .CD(n264), .Q(sum[27]) );
  CFD2QX1 \sum_reg[28]  ( .D(sum_f[28]), .CP(clock), .CD(n263), .Q(sum[28]) );
  CFD2QX1 \sum_reg[29]  ( .D(sum_f[29]), .CP(clock), .CD(n263), .Q(sum[29]) );
  CFD2QX1 \sum_reg[30]  ( .D(sum_f[30]), .CP(clock), .CD(n263), .Q(sum[30]) );
  CFD2QX1 \sum_reg[31]  ( .D(sum_f[31]), .CP(clock), .CD(n263), .Q(sum[31]) );
  CFD2QX1 \sum_reg[0]  ( .D(sum_f[0]), .CP(clock), .CD(n268), .Q(sum[0]) );
  CFD2QX1 \sum_reg[1]  ( .D(sum_f[1]), .CP(clock), .CD(n268), .Q(sum[1]) );
  CFD2QX1 \sum_reg[2]  ( .D(sum_f[2]), .CP(clock), .CD(n268), .Q(sum[2]) );
  CFD2QX1 \sum_reg[5]  ( .D(sum_f[5]), .CP(clock), .CD(n267), .Q(sum[5]) );
  CFD2QX1 \sum_reg[6]  ( .D(sum_f[6]), .CP(clock), .CD(n267), .Q(sum[6]) );
  CFD2QX1 \sum_reg[7]  ( .D(sum_f[7]), .CP(clock), .CD(n267), .Q(sum[7]) );
  CFD2QX1 \sum_reg[8]  ( .D(sum_f[8]), .CP(clock), .CD(n267), .Q(sum[8]) );
  CFD2QX1 \sum_reg[9]  ( .D(sum_f[9]), .CP(clock), .CD(n267), .Q(sum[9]) );
  CFD2QX1 \sum_reg[10]  ( .D(sum_f[10]), .CP(clock), .CD(n266), .Q(sum[10]) );
  CFD2QX1 \sum_reg[11]  ( .D(sum_f[11]), .CP(clock), .CD(n266), .Q(sum[11]) );
  CFD2QX1 \sum_reg[12]  ( .D(sum_f[12]), .CP(clock), .CD(n266), .Q(sum[12]) );
  CFD2QX1 \sum_reg[13]  ( .D(sum_f[13]), .CP(clock), .CD(n266), .Q(sum[13]) );
  CFD2QX1 \sum_reg[14]  ( .D(sum_f[14]), .CP(clock), .CD(n266), .Q(sum[14]) );
  CFD2QX1 \sum_reg[15]  ( .D(sum_f[15]), .CP(clock), .CD(n266), .Q(sum[15]) );
  CIVX2 U3 ( .A(reset), .Z(n1) );
  CLA16 A1 ( .sum_4(sum_f[15:0]), .crout(c1), .op1_4(op1_f[15:0]), .op2_4(
        op2_f[15:0]) );
  CLA16_2_0 A2 ( .sum_16(sum_f[31:16]), .crout_16(c2), .op1_16(op1_f[31:16]), 
        .op2_16(op2_f[31:16]), .Cin(c1) );
  CLA16_2_2 A3 ( .sum_16(sum_f[47:32]), .crout_16(c3), .op1_16(op1_f[47:32]), 
        .op2_16(op2_f[47:32]), .Cin(c2) );
  CLA16_2_1 A4 ( .sum_16(sum_f[63:48]), .crout_16(croutf), .op1_16(
        op1_f[63:48]), .op2_16(op2_f[63:48]), .Cin(c3) );
  CFD2QX4 \sum_reg[63]  ( .D(sum_f[63]), .CP(clock), .CD(n258), .Q(sum[63]) );
  CFD2QXL \op1_f_reg[58]  ( .D(n238), .CP(clock), .CD(n269), .Q(op1_f[58]) );
  CFD2QXL \op2_f_reg[58]  ( .D(n236), .CP(clock), .CD(n259), .Q(op2_f[58]) );
  CFD2QXL \sum_reg[32]  ( .D(sum_f[32]), .CP(clock), .CD(n263), .Q(sum[32]) );
  CFD2QXL \sum_reg[60]  ( .D(sum_f[60]), .CP(clock), .CD(n258), .Q(sum[60]) );
  CFD2QXL \sum_reg[54]  ( .D(sum_f[54]), .CP(clock), .CD(n259), .Q(sum[54]) );
  CFD2QXL \sum_reg[62]  ( .D(sum_f[62]), .CP(clock), .CD(n258), .Q(sum[62]) );
  CFD2QXL \op1_f_reg[54]  ( .D(n246), .CP(clock), .CD(n269), .Q(op1_f[54]) );
  CFD2QXL \op2_f_reg[54]  ( .D(n244), .CP(clock), .CD(n259), .Q(op2_f[54]) );
  CFD2QXL \op1_f_reg[62]  ( .D(n242), .CP(clock), .CD(n268), .Q(op1_f[62]) );
  CFD2QXL \op2_f_reg[62]  ( .D(n240), .CP(clock), .CD(n258), .Q(op2_f[62]) );
  CFD2QXL \sum_reg[35]  ( .D(sum_f[35]), .CP(clock), .CD(n262), .Q(sum[35]) );
  CFD2QXL \sum_reg[42]  ( .D(sum_f[42]), .CP(clock), .CD(n261), .Q(sum[42]) );
  CFD2QXL \sum_reg[34]  ( .D(sum_f[34]), .CP(clock), .CD(n262), .Q(sum[34]) );
  CFD2QXL \sum_reg[38]  ( .D(sum_f[38]), .CP(clock), .CD(n262), .Q(sum[38]) );
  CFD2QXL \op1_f_reg[38]  ( .D(n254), .CP(clock), .CD(n270), .Q(op1_f[38]) );
  CFD2QXL \op2_f_reg[38]  ( .D(n252), .CP(clock), .CD(n262), .Q(op2_f[38]) );
  CFD2QXL \op1_f_reg[46]  ( .D(n250), .CP(clock), .CD(n270), .Q(op1_f[46]) );
  CFD2QXL \op2_f_reg[46]  ( .D(n248), .CP(clock), .CD(n261), .Q(op2_f[46]) );
  CFD2QXL \sum_reg[3]  ( .D(sum_f[3]), .CP(clock), .CD(n268), .Q(sum[3]) );
  CFD2QXL \sum_reg[4]  ( .D(sum_f[4]), .CP(clock), .CD(n267), .Q(sum[4]) );
  CFD2QXL \op2_f_reg[63]  ( .D(n256), .CP(clock), .CD(n1), .Q(op2_f[63]) );
  CDLY1XL U4 ( .A(op1[0]), .Z(n3) );
  CNIVX1 U5 ( .A(n3), .Z(n2) );
  CDLY1XL U6 ( .A(op1[1]), .Z(n5) );
  CNIVX1 U7 ( .A(n5), .Z(n4) );
  CDLY1XL U8 ( .A(op1[2]), .Z(n7) );
  CNIVX1 U9 ( .A(n7), .Z(n6) );
  CDLY1XL U10 ( .A(op1[3]), .Z(n9) );
  CNIVX1 U11 ( .A(n9), .Z(n8) );
  CDLY1XL U12 ( .A(op1[4]), .Z(n11) );
  CNIVX1 U13 ( .A(n11), .Z(n10) );
  CDLY1XL U14 ( .A(op1[5]), .Z(n13) );
  CNIVX1 U15 ( .A(n13), .Z(n12) );
  CDLY1XL U16 ( .A(op1[6]), .Z(n15) );
  CNIVX1 U17 ( .A(n15), .Z(n14) );
  CDLY1XL U18 ( .A(op1[7]), .Z(n17) );
  CNIVX1 U19 ( .A(n17), .Z(n16) );
  CDLY1XL U20 ( .A(op1[8]), .Z(n19) );
  CNIVX1 U21 ( .A(n19), .Z(n18) );
  CDLY1XL U22 ( .A(op1[9]), .Z(n21) );
  CNIVX1 U23 ( .A(n21), .Z(n20) );
  CDLY1XL U24 ( .A(op1[10]), .Z(n23) );
  CNIVX1 U25 ( .A(n23), .Z(n22) );
  CDLY1XL U26 ( .A(op1[11]), .Z(n25) );
  CNIVX1 U27 ( .A(n25), .Z(n24) );
  CDLY1XL U28 ( .A(op1[12]), .Z(n27) );
  CNIVX1 U29 ( .A(n27), .Z(n26) );
  CDLY1XL U30 ( .A(op1[13]), .Z(n29) );
  CNIVX1 U31 ( .A(n29), .Z(n28) );
  CDLY1XL U32 ( .A(op1[14]), .Z(n31) );
  CNIVX1 U33 ( .A(n31), .Z(n30) );
  CDLY1XL U34 ( .A(op1[15]), .Z(n33) );
  CNIVX1 U35 ( .A(n33), .Z(n32) );
  CDLY1XL U36 ( .A(op1[16]), .Z(n35) );
  CNIVX1 U37 ( .A(n35), .Z(n34) );
  CDLY1XL U38 ( .A(op1[17]), .Z(n37) );
  CNIVX1 U39 ( .A(n37), .Z(n36) );
  CDLY1XL U40 ( .A(op1[18]), .Z(n39) );
  CNIVX1 U41 ( .A(n39), .Z(n38) );
  CDLY1XL U42 ( .A(op1[19]), .Z(n41) );
  CNIVX1 U43 ( .A(n41), .Z(n40) );
  CDLY1XL U44 ( .A(op1[20]), .Z(n43) );
  CNIVX1 U45 ( .A(n43), .Z(n42) );
  CDLY1XL U46 ( .A(op1[21]), .Z(n45) );
  CNIVX1 U47 ( .A(n45), .Z(n44) );
  CDLY1XL U48 ( .A(op1[22]), .Z(n47) );
  CNIVX1 U49 ( .A(n47), .Z(n46) );
  CDLY1XL U50 ( .A(op1[23]), .Z(n49) );
  CNIVX1 U51 ( .A(n49), .Z(n48) );
  CDLY1XL U52 ( .A(op1[24]), .Z(n51) );
  CNIVX1 U53 ( .A(n51), .Z(n50) );
  CDLY1XL U54 ( .A(op1[25]), .Z(n53) );
  CNIVX1 U55 ( .A(n53), .Z(n52) );
  CDLY1XL U56 ( .A(op1[26]), .Z(n55) );
  CNIVX1 U57 ( .A(n55), .Z(n54) );
  CDLY1XL U58 ( .A(op1[27]), .Z(n57) );
  CNIVX1 U59 ( .A(n57), .Z(n56) );
  CDLY1XL U60 ( .A(op1[28]), .Z(n59) );
  CNIVX1 U61 ( .A(n59), .Z(n58) );
  CDLY1XL U62 ( .A(op1[29]), .Z(n61) );
  CNIVX1 U63 ( .A(n61), .Z(n60) );
  CDLY1XL U64 ( .A(op1[30]), .Z(n63) );
  CNIVX1 U65 ( .A(n63), .Z(n62) );
  CDLY1XL U66 ( .A(op1[31]), .Z(n65) );
  CNIVX1 U67 ( .A(n65), .Z(n64) );
  CDLY1XL U68 ( .A(op1[32]), .Z(n67) );
  CNIVX1 U69 ( .A(n67), .Z(n66) );
  CDLY1XL U70 ( .A(op1[33]), .Z(n69) );
  CNIVX1 U71 ( .A(n69), .Z(n68) );
  CDLY1XL U72 ( .A(op1[34]), .Z(n71) );
  CNIVX1 U73 ( .A(n71), .Z(n70) );
  CDLY1XL U74 ( .A(op1[35]), .Z(n73) );
  CNIVX1 U75 ( .A(n73), .Z(n72) );
  CDLY1XL U76 ( .A(op1[36]), .Z(n75) );
  CNIVX1 U77 ( .A(n75), .Z(n74) );
  CDLY1XL U78 ( .A(op1[37]), .Z(n77) );
  CNIVX1 U79 ( .A(n77), .Z(n76) );
  CDLY1XL U80 ( .A(op1[39]), .Z(n79) );
  CNIVX1 U81 ( .A(n79), .Z(n78) );
  CDLY1XL U82 ( .A(op1[40]), .Z(n81) );
  CNIVX1 U83 ( .A(n81), .Z(n80) );
  CDLY1XL U84 ( .A(op1[41]), .Z(n83) );
  CNIVX1 U85 ( .A(n83), .Z(n82) );
  CDLY1XL U86 ( .A(op1[42]), .Z(n85) );
  CNIVX1 U87 ( .A(n85), .Z(n84) );
  CDLY1XL U88 ( .A(op1[43]), .Z(n87) );
  CNIVX1 U89 ( .A(n87), .Z(n86) );
  CDLY1XL U90 ( .A(op1[44]), .Z(n89) );
  CNIVX1 U91 ( .A(n89), .Z(n88) );
  CDLY1XL U92 ( .A(op1[45]), .Z(n91) );
  CNIVX1 U93 ( .A(n91), .Z(n90) );
  CDLY1XL U94 ( .A(op1[47]), .Z(n93) );
  CNIVX1 U95 ( .A(n93), .Z(n92) );
  CDLY1XL U96 ( .A(op1[48]), .Z(n95) );
  CNIVX1 U97 ( .A(n95), .Z(n94) );
  CDLY1XL U98 ( .A(op1[49]), .Z(n97) );
  CNIVX1 U99 ( .A(n97), .Z(n96) );
  CDLY1XL U100 ( .A(op1[50]), .Z(n99) );
  CNIVX1 U101 ( .A(n99), .Z(n98) );
  CDLY1XL U102 ( .A(op1[51]), .Z(n101) );
  CNIVX1 U103 ( .A(n101), .Z(n100) );
  CDLY1XL U104 ( .A(op1[52]), .Z(n103) );
  CNIVX1 U105 ( .A(n103), .Z(n102) );
  CDLY1XL U106 ( .A(op1[53]), .Z(n105) );
  CNIVX1 U107 ( .A(n105), .Z(n104) );
  CDLY1XL U108 ( .A(op1[55]), .Z(n107) );
  CNIVX1 U109 ( .A(n107), .Z(n106) );
  CDLY1XL U110 ( .A(op1[56]), .Z(n109) );
  CNIVX1 U111 ( .A(n109), .Z(n108) );
  CDLY1XL U112 ( .A(op1[57]), .Z(n111) );
  CNIVX1 U113 ( .A(n111), .Z(n110) );
  CDLY1XL U114 ( .A(op1[59]), .Z(n113) );
  CNIVX1 U115 ( .A(n113), .Z(n112) );
  CDLY1XL U116 ( .A(op1[60]), .Z(n115) );
  CNIVX1 U117 ( .A(n115), .Z(n114) );
  CDLY1XL U118 ( .A(op1[61]), .Z(n117) );
  CNIVX1 U119 ( .A(n117), .Z(n116) );
  CDLY1XL U120 ( .A(op1[63]), .Z(n119) );
  CNIVX1 U121 ( .A(n119), .Z(n118) );
  CDLY1XL U122 ( .A(op2[0]), .Z(n121) );
  CNIVX1 U123 ( .A(n121), .Z(n120) );
  CDLY1XL U124 ( .A(op2[1]), .Z(n123) );
  CNIVX1 U125 ( .A(n123), .Z(n122) );
  CDLY1XL U126 ( .A(op2[2]), .Z(n125) );
  CNIVX1 U127 ( .A(n125), .Z(n124) );
  CDLY1XL U128 ( .A(op2[3]), .Z(n127) );
  CNIVX1 U129 ( .A(n127), .Z(n126) );
  CDLY1XL U130 ( .A(op2[4]), .Z(n129) );
  CNIVX1 U131 ( .A(n129), .Z(n128) );
  CDLY1XL U132 ( .A(op2[5]), .Z(n131) );
  CNIVX1 U133 ( .A(n131), .Z(n130) );
  CDLY1XL U134 ( .A(op2[6]), .Z(n133) );
  CNIVX1 U135 ( .A(n133), .Z(n132) );
  CDLY1XL U136 ( .A(op2[7]), .Z(n135) );
  CNIVX1 U137 ( .A(n135), .Z(n134) );
  CDLY1XL U138 ( .A(op2[8]), .Z(n137) );
  CNIVX1 U139 ( .A(n137), .Z(n136) );
  CDLY1XL U140 ( .A(op2[9]), .Z(n139) );
  CNIVX1 U141 ( .A(n139), .Z(n138) );
  CDLY1XL U142 ( .A(op2[10]), .Z(n141) );
  CNIVX1 U143 ( .A(n141), .Z(n140) );
  CDLY1XL U144 ( .A(op2[11]), .Z(n143) );
  CNIVX1 U145 ( .A(n143), .Z(n142) );
  CDLY1XL U146 ( .A(op2[12]), .Z(n145) );
  CNIVX1 U147 ( .A(n145), .Z(n144) );
  CDLY1XL U148 ( .A(op2[13]), .Z(n147) );
  CNIVX1 U149 ( .A(n147), .Z(n146) );
  CDLY1XL U150 ( .A(op2[14]), .Z(n149) );
  CNIVX1 U151 ( .A(n149), .Z(n148) );
  CDLY1XL U152 ( .A(op2[15]), .Z(n151) );
  CNIVX1 U153 ( .A(n151), .Z(n150) );
  CDLY1XL U154 ( .A(op2[16]), .Z(n153) );
  CNIVX1 U155 ( .A(n153), .Z(n152) );
  CDLY1XL U156 ( .A(op2[17]), .Z(n155) );
  CNIVX1 U157 ( .A(n155), .Z(n154) );
  CDLY1XL U158 ( .A(op2[18]), .Z(n157) );
  CNIVX1 U159 ( .A(n157), .Z(n156) );
  CDLY1XL U160 ( .A(op2[19]), .Z(n159) );
  CNIVX1 U161 ( .A(n159), .Z(n158) );
  CDLY1XL U162 ( .A(op2[20]), .Z(n161) );
  CNIVX1 U163 ( .A(n161), .Z(n160) );
  CDLY1XL U164 ( .A(op2[21]), .Z(n163) );
  CNIVX1 U165 ( .A(n163), .Z(n162) );
  CDLY1XL U166 ( .A(op2[22]), .Z(n165) );
  CNIVX1 U167 ( .A(n165), .Z(n164) );
  CDLY1XL U168 ( .A(op2[23]), .Z(n167) );
  CNIVX1 U169 ( .A(n167), .Z(n166) );
  CDLY1XL U170 ( .A(op2[24]), .Z(n169) );
  CNIVX1 U171 ( .A(n169), .Z(n168) );
  CDLY1XL U172 ( .A(op2[25]), .Z(n171) );
  CNIVX1 U173 ( .A(n171), .Z(n170) );
  CDLY1XL U174 ( .A(op2[26]), .Z(n173) );
  CNIVX1 U175 ( .A(n173), .Z(n172) );
  CDLY1XL U176 ( .A(op2[27]), .Z(n175) );
  CNIVX1 U177 ( .A(n175), .Z(n174) );
  CDLY1XL U178 ( .A(op2[28]), .Z(n177) );
  CNIVX1 U179 ( .A(n177), .Z(n176) );
  CDLY1XL U180 ( .A(op2[29]), .Z(n179) );
  CNIVX1 U181 ( .A(n179), .Z(n178) );
  CDLY1XL U182 ( .A(op2[30]), .Z(n181) );
  CNIVX1 U183 ( .A(n181), .Z(n180) );
  CDLY1XL U184 ( .A(op2[31]), .Z(n183) );
  CNIVX1 U185 ( .A(n183), .Z(n182) );
  CDLY1XL U186 ( .A(op2[32]), .Z(n185) );
  CNIVX1 U187 ( .A(n185), .Z(n184) );
  CDLY1XL U188 ( .A(op2[33]), .Z(n187) );
  CNIVX1 U189 ( .A(n187), .Z(n186) );
  CDLY1XL U190 ( .A(op2[34]), .Z(n189) );
  CNIVX1 U191 ( .A(n189), .Z(n188) );
  CDLY1XL U192 ( .A(op2[35]), .Z(n191) );
  CNIVX1 U193 ( .A(n191), .Z(n190) );
  CDLY1XL U194 ( .A(op2[36]), .Z(n193) );
  CNIVX1 U195 ( .A(n193), .Z(n192) );
  CDLY1XL U196 ( .A(op2[37]), .Z(n195) );
  CNIVX1 U197 ( .A(n195), .Z(n194) );
  CDLY1XL U198 ( .A(op2[39]), .Z(n197) );
  CNIVX1 U199 ( .A(n197), .Z(n196) );
  CDLY1XL U200 ( .A(op2[40]), .Z(n199) );
  CNIVX1 U201 ( .A(n199), .Z(n198) );
  CDLY1XL U202 ( .A(op2[41]), .Z(n201) );
  CNIVX1 U203 ( .A(n201), .Z(n200) );
  CDLY1XL U204 ( .A(op2[42]), .Z(n203) );
  CNIVX1 U205 ( .A(n203), .Z(n202) );
  CDLY1XL U206 ( .A(op2[43]), .Z(n205) );
  CNIVX1 U207 ( .A(n205), .Z(n204) );
  CDLY1XL U208 ( .A(op2[44]), .Z(n207) );
  CNIVX1 U209 ( .A(n207), .Z(n206) );
  CDLY1XL U210 ( .A(op2[45]), .Z(n209) );
  CNIVX1 U211 ( .A(n209), .Z(n208) );
  CDLY1XL U212 ( .A(op2[47]), .Z(n211) );
  CNIVX1 U213 ( .A(n211), .Z(n210) );
  CDLY1XL U214 ( .A(op2[48]), .Z(n213) );
  CNIVX1 U215 ( .A(n213), .Z(n212) );
  CDLY1XL U216 ( .A(op2[49]), .Z(n215) );
  CNIVX1 U217 ( .A(n215), .Z(n214) );
  CDLY1XL U218 ( .A(op2[50]), .Z(n217) );
  CNIVX1 U219 ( .A(n217), .Z(n216) );
  CDLY1XL U220 ( .A(op2[51]), .Z(n219) );
  CNIVX1 U221 ( .A(n219), .Z(n218) );
  CDLY1XL U222 ( .A(op2[52]), .Z(n221) );
  CNIVX1 U223 ( .A(n221), .Z(n220) );
  CDLY1XL U224 ( .A(op2[53]), .Z(n223) );
  CNIVX1 U225 ( .A(n223), .Z(n222) );
  CDLY1XL U226 ( .A(op2[55]), .Z(n225) );
  CNIVX1 U227 ( .A(n225), .Z(n224) );
  CDLY1XL U228 ( .A(op2[56]), .Z(n227) );
  CNIVX1 U229 ( .A(n227), .Z(n226) );
  CDLY1XL U230 ( .A(op2[57]), .Z(n229) );
  CNIVX1 U231 ( .A(n229), .Z(n228) );
  CDLY1XL U232 ( .A(op2[59]), .Z(n231) );
  CNIVX1 U233 ( .A(n231), .Z(n230) );
  CDLY1XL U234 ( .A(op2[60]), .Z(n233) );
  CNIVX1 U235 ( .A(n233), .Z(n232) );
  CDLY1XL U236 ( .A(op2[61]), .Z(n235) );
  CNIVX1 U237 ( .A(n235), .Z(n234) );
  CDLY1XL U238 ( .A(op2[58]), .Z(n237) );
  CNIVX1 U239 ( .A(n237), .Z(n236) );
  CDLY1XL U240 ( .A(op1[58]), .Z(n239) );
  CNIVX1 U241 ( .A(n239), .Z(n238) );
  CDLY1XL U242 ( .A(op2[62]), .Z(n241) );
  CNIVX1 U243 ( .A(n241), .Z(n240) );
  CDLY1XL U244 ( .A(op1[62]), .Z(n243) );
  CNIVX1 U245 ( .A(n243), .Z(n242) );
  CDLY1XL U246 ( .A(op2[54]), .Z(n245) );
  CNIVX1 U247 ( .A(n245), .Z(n244) );
  CDLY1XL U248 ( .A(op1[54]), .Z(n247) );
  CNIVX1 U249 ( .A(n247), .Z(n246) );
  CDLY1XL U250 ( .A(op2[46]), .Z(n249) );
  CNIVX1 U251 ( .A(n249), .Z(n248) );
  CDLY1XL U252 ( .A(op1[46]), .Z(n251) );
  CNIVX1 U253 ( .A(n251), .Z(n250) );
  CDLY1XL U254 ( .A(op2[38]), .Z(n253) );
  CNIVX1 U255 ( .A(n253), .Z(n252) );
  CDLY1XL U256 ( .A(op1[38]), .Z(n255) );
  CNIVX1 U257 ( .A(n255), .Z(n254) );
  CDLY1XL U258 ( .A(op2[63]), .Z(n257) );
  CNIVX1 U259 ( .A(n257), .Z(n256) );
  CDLY2X2 U260 ( .A(n1), .Z(n258) );
  CDLY2X2 U261 ( .A(n1), .Z(n259) );
  CDLY2X2 U262 ( .A(n1), .Z(n260) );
  CDLY2X2 U263 ( .A(n1), .Z(n261) );
  CDLY2X2 U264 ( .A(n1), .Z(n262) );
  CDLY2X2 U265 ( .A(n1), .Z(n263) );
  CDLY2X2 U266 ( .A(n1), .Z(n264) );
  CDLY2X2 U267 ( .A(n1), .Z(n265) );
  CDLY2X2 U268 ( .A(n1), .Z(n266) );
  CDLY2X2 U269 ( .A(n1), .Z(n267) );
  CDLY2X2 U270 ( .A(n1), .Z(n268) );
  CDLY2X2 U271 ( .A(n1), .Z(n269) );
  CDLY2X2 U272 ( .A(n1), .Z(n270) );
  CDLY2X2 U273 ( .A(n1), .Z(n271) );
  CDLY2X2 U274 ( .A(n1), .Z(n272) );
  CDLY2X2 U275 ( .A(n1), .Z(n273) );
  CDLY2X2 U276 ( .A(n1), .Z(n274) );
endmodule

