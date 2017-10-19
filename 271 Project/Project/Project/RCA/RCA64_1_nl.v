
module HA_0 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n3;

  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
  CIVDX1 U1 ( .A(n3), .Z1(sum_ha) );
  CEOXL U3 ( .A(op2_ha), .B(op1_ha), .Z(n3) );
endmodule


module HA_126 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CIVX2 U1 ( .A(op1_ha), .Z(n2) );
  CIVX2 U2 ( .A(op2_ha), .Z(n1) );
  CND2X1 U3 ( .A(op2_ha), .B(n2), .Z(n3) );
  CND2X1 U4 ( .A(n1), .B(op1_ha), .Z(n4) );
  CND2X2 U5 ( .A(n3), .B(n4), .Z(sum_ha) );
  CAN2XL U6 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_125 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op1_ha), .Z(n1) );
  CND2X2 U2 ( .A(op1_ha), .B(op2_ha), .Z(n2) );
  CIVX2 U3 ( .A(n2), .Z(cout_ha) );
  CIVXL U4 ( .A(n1), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(op2_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_0 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_126 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_125 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_124 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_123 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_62 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_124 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_123 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_122 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_121 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_61 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_122 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_121 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_1 ( sum_fa4, cout_fa4, op1_fa4, op2_fa4 );
  output [3:0] sum_fa4;
  input [3:0] op1_fa4;
  input [3:0] op2_fa4;
  output cout_fa4;
  wire   cin1, cin2, cin3;

  HA_0 h1 ( .sum_ha(sum_fa4[0]), .cout_ha(cin1), .op1_ha(op1_fa4[0]), .op2_ha(
        op2_fa4[0]) );
  FA_1bit_0 f1 ( .sum_fa1(sum_fa4[1]), .cout_fa1(cin2), .op1_fa1(op1_fa4[1]), 
        .op2_fa1(op2_fa4[1]), .cin(cin1) );
  FA_1bit_62 f2 ( .sum_fa1(sum_fa4[2]), .cout_fa1(cin3), .op1_fa1(op1_fa4[2]), 
        .op2_fa1(op2_fa4[2]), .cin(cin2) );
  FA_1bit_61 f3 ( .sum_fa1(sum_fa4[3]), .cout_fa1(cout_fa4), .op1_fa1(
        op1_fa4[3]), .op2_fa1(op2_fa4[3]), .cin(cin3) );
endmodule


module HA_120 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_119 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_60 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_120 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_119 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_118 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_117 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_59 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_118 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_117 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_116 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_115 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_58 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_116 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_115 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_114 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_113 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_57 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_114 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_113 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_0 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_60 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_59 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_58 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_57 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_112 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_111 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_56 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_112 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_111 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_110 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_109 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_55 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_110 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_109 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_108 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_107 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_54 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_108 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_107 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n1), .A(c2), .Z(n2) );
  CIVX2 U2 ( .A(c1), .Z(n1) );
  CIVX2 U3 ( .A(n2), .Z(cout_fa1) );
endmodule


module HA_106 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_105 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_53 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_106 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_105 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(n1), .Z(cout_fa1) );
  CNR2IX2 U2 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module FA_4bit_2_14 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_56 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_55 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_54 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_53 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_104 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_103 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op2_ha), .Z(n1) );
  CND2X2 U2 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U3 ( .A(n2), .Z(cout_ha) );
  CIVXL U4 ( .A(n1), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_52 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_104 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_103 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_102 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_101 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_51 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_102 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_101 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_100 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_99 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_50 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_100 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_99 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_98 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_97 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_49 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_98 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_97 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module FA_4bit_2_13 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_52 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_51 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_50 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_49 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_96 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_95 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_48 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_96 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_95 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_94 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_93 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_47 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_94 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_93 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n1), .A(c2), .Z(n2) );
  CIVX2 U2 ( .A(c1), .Z(n1) );
  CIVX2 U3 ( .A(n2), .Z(cout_fa1) );
endmodule


module HA_92 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_91 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_46 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_92 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_91 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_90 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_89 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_45 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_90 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_89 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n1), .A(c2), .Z(n2) );
  CIVX2 U2 ( .A(c1), .Z(n1) );
  CIVX2 U3 ( .A(n2), .Z(cout_fa1) );
endmodule


module FA_4bit_2_12 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_48 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_47 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_46 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_45 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_88 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_87 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_44 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_88 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_87 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_86 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_85 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_43 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_86 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_85 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_84 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_83 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_42 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_84 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_83 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_82 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_81 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_41 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_82 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_81 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_11 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_44 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_43 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_42 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_41 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_80 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_79 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_40 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_80 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_79 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_78 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_77 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_39 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_78 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_77 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_76 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_75 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_38 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_76 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_75 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_74 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_73 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_37 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_74 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_73 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_10 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_40 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_39 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_38 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_37 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_72 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_71 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_36 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_72 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_71 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_70 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_69 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_35 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_70 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_69 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_68 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_67 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_34 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_68 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_67 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_66 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_65 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(n4), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_33 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_66 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_65 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_9 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_36 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_35 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_34 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_33 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_64 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_63 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVX2 U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(n7), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_32 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_64 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_63 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_62 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_61 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVX2 U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(n7), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_31 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_62 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_61 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(c2), .Z(n1) );
  CND2IX2 U2 ( .B(c1), .A(n1), .Z(cout_fa1) );
endmodule


module HA_60 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_59 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5;

  CNR2X2 U1 ( .A(n1), .B(n2), .Z(cout_ha) );
  CIVX2 U2 ( .A(op2_ha), .Z(n1) );
  CIVX2 U3 ( .A(op1_ha), .Z(n2) );
  CDLY1XL U4 ( .A(op2_ha), .Z(n3) );
  CIVXL U5 ( .A(n3), .Z(n4) );
  CIVX2 U6 ( .A(n4), .Z(n5) );
  CEOXL U7 ( .A(n5), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_30 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_60 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_59 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_58 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_57 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVX2 U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(n7), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_29 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_58 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_57 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_8 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_32 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_31 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_30 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_29 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_56 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_55 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CIVX1 U6 ( .A(n6), .Z(n7) );
  CDLY1XL U7 ( .A(n2), .Z(n5) );
  CIVXL U8 ( .A(n5), .Z(n6) );
  CEOXL U9 ( .A(n7), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_28 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_56 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_55 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_54 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_53 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CIVX1 U6 ( .A(n6), .Z(n7) );
  CDLY1XL U7 ( .A(n2), .Z(n5) );
  CIVXL U8 ( .A(n5), .Z(n6) );
  CEOXL U9 ( .A(n7), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_27 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_54 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_53 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_52 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_51 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_26 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_52 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_51 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_50 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_49 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_25 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_50 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_49 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_7 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_28 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_27 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_26 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_25 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_48 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_47 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_24 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_48 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_47 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_46 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_45 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_23 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_46 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_45 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_44 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_43 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_22 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_44 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_43 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_42 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_41 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1X2 U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_21 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_42 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_41 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_6 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_24 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_23 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_22 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_21 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_40 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_39 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4, n5, n6, n7;

  CDLY1X2 U1 ( .A(n3), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n3), .B(n4), .Z(cout_ha) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVX2 U5 ( .A(op1_ha), .Z(n4) );
  CDLY1XL U6 ( .A(n2), .Z(n5) );
  CIVXL U7 ( .A(n5), .Z(n6) );
  CIVXL U8 ( .A(n6), .Z(n7) );
  CEOXL U9 ( .A(op1_ha), .B(n7), .Z(sum_ha) );
endmodule


module FA_1bit_20 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_40 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_39 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(c2), .Z(n1) );
  CND2IX2 U2 ( .B(c1), .A(n1), .Z(cout_fa1) );
endmodule


module HA_38 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_37 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(n3), .Z(n1) );
  CNR2X2 U2 ( .A(n3), .B(n2), .Z(cout_ha) );
  CIVX2 U3 ( .A(op1_ha), .Z(n2) );
  CIVX2 U4 ( .A(op2_ha), .Z(n3) );
  CIVXL U5 ( .A(n1), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_19 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_38 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_37 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_36 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_35 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(n2), .Z(n1) );
  CNR2X2 U2 ( .A(n2), .B(n3), .Z(cout_ha) );
  CIVX2 U3 ( .A(op2_ha), .Z(n2) );
  CIVX2 U4 ( .A(op1_ha), .Z(n3) );
  CIVXL U5 ( .A(n1), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_18 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_36 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_35 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(c2), .Z(n1) );
  CND2IX2 U2 ( .B(c1), .A(n1), .Z(cout_fa1) );
endmodule


module HA_34 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_33 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CIVXL U4 ( .A(n2), .Z(n3) );
  CIVXL U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_17 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_34 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_33 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(n1), .Z(cout_fa1) );
  CNR2IX2 U2 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module FA_4bit_2_5 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_20 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_19 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_18 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_17 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_32 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_31 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op2_ha), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n3) );
  CND2X2 U3 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U4 ( .A(n2), .Z(cout_ha) );
  CIVXL U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_16 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_32 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_31 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_30 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_29 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op2_ha), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CIVXL U3 ( .A(n2), .Z(n3) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n4) );
  CIVX2 U5 ( .A(n4), .Z(cout_ha) );
  CEOXL U6 ( .A(op1_ha), .B(n3), .Z(sum_ha) );
endmodule


module FA_1bit_15 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1, n2;

  HA_30 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_29 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CNR2IX2 U1 ( .B(n2), .A(c2), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_fa1) );
  CIVX2 U3 ( .A(c1), .Z(n2) );
endmodule


module HA_28 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_27 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CIVX2 U1 ( .A(op2_ha), .Z(n1) );
  CDLY1XL U2 ( .A(n1), .Z(n2) );
  CNR2X2 U3 ( .A(n1), .B(n3), .Z(cout_ha) );
  CIVX2 U4 ( .A(op1_ha), .Z(n3) );
  CIVXL U5 ( .A(n2), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_14 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_28 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_27 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CIVX2 U1 ( .A(c2), .Z(n1) );
  CND2IX2 U2 ( .B(c1), .A(n1), .Z(cout_fa1) );
endmodule


module HA_26 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_25 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op2_ha), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n2) );
  CIVXL U3 ( .A(n2), .Z(n3) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n4) );
  CIVX2 U5 ( .A(n4), .Z(cout_ha) );
  CEOXL U6 ( .A(op1_ha), .B(n3), .Z(sum_ha) );
endmodule


module FA_1bit_13 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_26 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_25 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_4 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_16 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_15 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_14 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_13 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_24 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_23 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CEOXL U4 ( .A(op1_ha), .B(n2), .Z(sum_ha) );
endmodule


module FA_1bit_12 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_24 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_23 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_22 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_21 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3, n4;

  CDLY1XL U1 ( .A(op2_ha), .Z(n1) );
  CIVXL U2 ( .A(n1), .Z(n3) );
  CND2X2 U3 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U4 ( .A(n2), .Z(cout_ha) );
  CIVXL U5 ( .A(n3), .Z(n4) );
  CEOXL U6 ( .A(op1_ha), .B(n4), .Z(sum_ha) );
endmodule


module FA_1bit_11 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_22 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_21 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_20 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_19 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CEOXL U4 ( .A(op1_ha), .B(n2), .Z(sum_ha) );
endmodule


module FA_1bit_10 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_20 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_19 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_18 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_17 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CEOXL U4 ( .A(op1_ha), .B(n2), .Z(sum_ha) );
endmodule


module FA_1bit_9 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_18 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_17 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_3 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_12 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_11 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_10 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_9 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_16 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_15 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CND2X2 U1 ( .A(op2_ha), .B(op1_ha), .Z(n1) );
  CIVX2 U2 ( .A(n1), .Z(cout_ha) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n2) );
  CEOXL U4 ( .A(n2), .B(op1_ha), .Z(sum_ha) );
endmodule


module FA_1bit_8 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_16 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_15 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_14 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_13 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3;

  CENX1 U1 ( .A(op1_ha), .B(n2), .Z(sum_ha) );
  CIVX1 U2 ( .A(n1), .Z(n2) );
  CDLY1XL U3 ( .A(op2_ha), .Z(n1) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(cout_ha) );
endmodule


module FA_1bit_7 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_14 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_13 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_12 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_11 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3;

  CDLY1X2 U1 ( .A(op2_ha), .Z(n2) );
  CENX2 U2 ( .A(n1), .B(n2), .Z(sum_ha) );
  CIVX20 U3 ( .A(op1_ha), .Z(n1) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n3) );
  CIVX2 U5 ( .A(n3), .Z(cout_ha) );
endmodule


module FA_1bit_6 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_12 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_11 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_10 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_9 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3;

  CENX2 U1 ( .A(n1), .B(n3), .Z(sum_ha) );
  CIVX20 U2 ( .A(op1_ha), .Z(n1) );
  CDLY1X2 U3 ( .A(op2_ha), .Z(n3) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U5 ( .A(n2), .Z(cout_ha) );
endmodule


module FA_1bit_5 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_10 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_9 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_2 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_8 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_7 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_6 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_5 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module HA_8 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_7 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2, n3;

  CENX1 U1 ( .A(n3), .B(n1), .Z(sum_ha) );
  CIVX20 U2 ( .A(op1_ha), .Z(n1) );
  CDLY1X2 U3 ( .A(op2_ha), .Z(n3) );
  CND2X2 U4 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U5 ( .A(n2), .Z(cout_ha) );
endmodule


module FA_1bit_4 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_8 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_7 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_6 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_5 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CENXL U1 ( .A(n1), .B(op1_ha), .Z(sum_ha) );
  CIVXL U2 ( .A(op2_ha), .Z(n1) );
  CND2X2 U3 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U4 ( .A(n2), .Z(cout_ha) );
endmodule


module FA_1bit_3 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_6 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_5 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_4 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_3 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1, n2;

  CENXL U1 ( .A(n1), .B(op1_ha), .Z(sum_ha) );
  CIVXL U2 ( .A(op2_ha), .Z(n1) );
  CND2X2 U3 ( .A(op2_ha), .B(op1_ha), .Z(n2) );
  CIVX2 U4 ( .A(n2), .Z(cout_ha) );
endmodule


module FA_1bit_2 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_4 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_3 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX2 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX2 U2 ( .A(c2), .Z(n1) );
endmodule


module HA_2 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;


  CEOX1 U1 ( .A(op2_ha), .B(op1_ha), .Z(sum_ha) );
  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
endmodule


module HA_1 ( sum_ha, cout_ha, op1_ha, op2_ha );
  input op1_ha, op2_ha;
  output sum_ha, cout_ha;
  wire   n1;

  CAN2X1 U2 ( .A(op2_ha), .B(op1_ha), .Z(cout_ha) );
  CENXL U1 ( .A(n1), .B(op2_ha), .Z(sum_ha) );
  CIVX20 U3 ( .A(op1_ha), .Z(n1) );
endmodule


module FA_1bit_1 ( sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin );
  input op1_fa1, op2_fa1, cin;
  output sum_fa1, cout_fa1;
  wire   s1, c1, c2, n1;

  HA_2 h1 ( .sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1) );
  HA_1 h2 ( .sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin) );
  CND2IX1 U1 ( .B(c1), .A(n1), .Z(cout_fa1) );
  CIVX1 U2 ( .A(c2), .Z(n1) );
endmodule


module FA_4bit_2_1 ( sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4 );
  output [3:0] sum_fa4_2;
  input [3:0] op1_fa4_2;
  input [3:0] op2_fa4_2;
  input cin_fa4;
  output cout_fa4_2;
  wire   cin1, cin2, cin3;

  FA_1bit_4 f1 ( .sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(
        op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4) );
  FA_1bit_3 f2 ( .sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(
        op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1) );
  FA_1bit_2 f3 ( .sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(
        op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2) );
  FA_1bit_1 f4 ( .sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(
        op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3) );
endmodule


module RCA64 ( sum, crout, op1, op2, clock, reset );
  output [63:0] sum;
  input [63:0] op1;
  input [63:0] op2;
  input clock, reset;
  output crout;
  wire   c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15,
         croutf, n1, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85,
         n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99,
         n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         n111, n112, n113, n114, n115, n116, n117, n118, n119, n120, n121,
         n122, n123, n124, n125, n126, n127, n128, n129, n130, n131, n132,
         n133, n134, n135, n136, n137, n138, n139, n140, n141, n142, n143,
         n144, n145, n146, n147, n148, n149, n150, n151, n152, n153, n154,
         n155, n156, n157, n158, n159, n160, n161, n162, n163, n164, n165,
         n166, n167, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n261, n262, n263, n264, n265, n266,
         n267;
  wire   [63:0] sumf;
  wire   [63:0] op1f;
  wire   [63:0] op2f;

  CFD2QX1 \op2f_reg[16]  ( .D(n59), .CP(clock), .CD(n262), .Q(op2f[16]) );
  CFD2QX1 \op2f_reg[15]  ( .D(n57), .CP(clock), .CD(n262), .Q(op2f[15]) );
  CFD2QX1 \op2f_reg[14]  ( .D(n55), .CP(clock), .CD(n262), .Q(op2f[14]) );
  CFD2QX1 \op2f_reg[12]  ( .D(n53), .CP(clock), .CD(n262), .Q(op2f[12]) );
  CFD2QX1 \op2f_reg[11]  ( .D(n51), .CP(clock), .CD(n262), .Q(op2f[11]) );
  CFD2QX1 \op2f_reg[10]  ( .D(n49), .CP(clock), .CD(n263), .Q(op2f[10]) );
  CFD2QX1 \op2f_reg[9]  ( .D(n47), .CP(clock), .CD(n263), .Q(op2f[9]) );
  CFD2QX1 \op2f_reg[8]  ( .D(n45), .CP(clock), .CD(n263), .Q(op2f[8]) );
  CFD2QX1 \op2f_reg[7]  ( .D(n43), .CP(clock), .CD(n263), .Q(op2f[7]) );
  CFD2QX1 \op2f_reg[6]  ( .D(n41), .CP(clock), .CD(n263), .Q(op2f[6]) );
  CFD2QX1 \op2f_reg[5]  ( .D(n39), .CP(clock), .CD(n263), .Q(op2f[5]) );
  CFD2QX1 \op2f_reg[4]  ( .D(n37), .CP(clock), .CD(n264), .Q(op2f[4]) );
  CFD2QX1 \op2f_reg[3]  ( .D(n35), .CP(clock), .CD(n264), .Q(op2f[3]) );
  CFD2QX1 \op2f_reg[2]  ( .D(n33), .CP(clock), .CD(n264), .Q(op2f[2]) );
  CFD2QX1 \op2f_reg[0]  ( .D(n31), .CP(clock), .CD(n264), .Q(op2f[0]) );
  CFD2QX1 \op1f_reg[16]  ( .D(n29), .CP(clock), .CD(n265), .Q(op1f[16]) );
  CFD2QX1 \op1f_reg[15]  ( .D(n27), .CP(clock), .CD(n265), .Q(op1f[15]) );
  CFD2QX1 \op1f_reg[13]  ( .D(n25), .CP(clock), .CD(n265), .Q(op1f[13]) );
  CFD2QX1 \op1f_reg[12]  ( .D(n23), .CP(clock), .CD(n266), .Q(op1f[12]) );
  CFD2QX1 \op1f_reg[11]  ( .D(n21), .CP(clock), .CD(n266), .Q(op1f[11]) );
  CFD2QX1 \op1f_reg[10]  ( .D(n19), .CP(clock), .CD(n266), .Q(op1f[10]) );
  CFD2QX1 \op1f_reg[9]  ( .D(n17), .CP(clock), .CD(n266), .Q(op1f[9]) );
  CFD2QX1 \op1f_reg[8]  ( .D(n15), .CP(clock), .CD(n266), .Q(op1f[8]) );
  CFD2QX1 \op1f_reg[7]  ( .D(n13), .CP(clock), .CD(n266), .Q(op1f[7]) );
  CFD2QX1 \op1f_reg[6]  ( .D(n11), .CP(clock), .CD(n266), .Q(op1f[6]) );
  CFD2QX1 \op1f_reg[5]  ( .D(n9), .CP(clock), .CD(n266), .Q(op1f[5]) );
  CFD2QX1 \op1f_reg[3]  ( .D(n7), .CP(clock), .CD(n266), .Q(op1f[3]) );
  CFD2QX1 \op1f_reg[2]  ( .D(n5), .CP(clock), .CD(n266), .Q(op1f[2]) );
  CFD2QX1 \op1f_reg[0]  ( .D(n3), .CP(clock), .CD(n267), .Q(op1f[0]) );
  FA_4bit_1 F1 ( .sum_fa4(sumf[3:0]), .cout_fa4(c1), .op1_fa4(op1f[3:0]), 
        .op2_fa4(op2f[3:0]) );
  FA_4bit_2_0 F2 ( .sum_fa4_2(sumf[7:4]), .cout_fa4_2(c2), .op1_fa4_2(
        op1f[7:4]), .op2_fa4_2(op2f[7:4]), .cin_fa4(c1) );
  FA_4bit_2_14 F3 ( .sum_fa4_2(sumf[11:8]), .cout_fa4_2(c3), .op1_fa4_2(
        op1f[11:8]), .op2_fa4_2(op2f[11:8]), .cin_fa4(c2) );
  FA_4bit_2_13 F4 ( .sum_fa4_2(sumf[15:12]), .cout_fa4_2(c4), .op1_fa4_2(
        op1f[15:12]), .op2_fa4_2(op2f[15:12]), .cin_fa4(c3) );
  FA_4bit_2_12 F5 ( .sum_fa4_2(sumf[19:16]), .cout_fa4_2(c5), .op1_fa4_2(
        op1f[19:16]), .op2_fa4_2(op2f[19:16]), .cin_fa4(c4) );
  FA_4bit_2_11 F6 ( .sum_fa4_2(sumf[23:20]), .cout_fa4_2(c6), .op1_fa4_2(
        op1f[23:20]), .op2_fa4_2(op2f[23:20]), .cin_fa4(c5) );
  FA_4bit_2_10 F7 ( .sum_fa4_2(sumf[27:24]), .cout_fa4_2(c7), .op1_fa4_2(
        op1f[27:24]), .op2_fa4_2(op2f[27:24]), .cin_fa4(c6) );
  FA_4bit_2_9 F8 ( .sum_fa4_2(sumf[31:28]), .cout_fa4_2(c8), .op1_fa4_2(
        op1f[31:28]), .op2_fa4_2(op2f[31:28]), .cin_fa4(c7) );
  FA_4bit_2_8 F9 ( .sum_fa4_2(sumf[35:32]), .cout_fa4_2(c9), .op1_fa4_2(
        op1f[35:32]), .op2_fa4_2(op2f[35:32]), .cin_fa4(c8) );
  FA_4bit_2_7 F10 ( .sum_fa4_2(sumf[39:36]), .cout_fa4_2(c10), .op1_fa4_2(
        op1f[39:36]), .op2_fa4_2(op2f[39:36]), .cin_fa4(c9) );
  FA_4bit_2_6 F11 ( .sum_fa4_2(sumf[43:40]), .cout_fa4_2(c11), .op1_fa4_2(
        op1f[43:40]), .op2_fa4_2(op2f[43:40]), .cin_fa4(c10) );
  FA_4bit_2_5 F12 ( .sum_fa4_2(sumf[47:44]), .cout_fa4_2(c12), .op1_fa4_2(
        op1f[47:44]), .op2_fa4_2(op2f[47:44]), .cin_fa4(c11) );
  FA_4bit_2_4 F13 ( .sum_fa4_2(sumf[51:48]), .cout_fa4_2(c13), .op1_fa4_2(
        op1f[51:48]), .op2_fa4_2(op2f[51:48]), .cin_fa4(c12) );
  FA_4bit_2_3 F14 ( .sum_fa4_2(sumf[55:52]), .cout_fa4_2(c14), .op1_fa4_2(
        op1f[55:52]), .op2_fa4_2(op2f[55:52]), .cin_fa4(c13) );
  FA_4bit_2_2 F15 ( .sum_fa4_2(sumf[59:56]), .cout_fa4_2(c15), .op1_fa4_2(
        op1f[59:56]), .op2_fa4_2(op2f[59:56]), .cin_fa4(c14) );
  FA_4bit_2_1 F16 ( .sum_fa4_2(sumf[63:60]), .cout_fa4_2(croutf), .op1_fa4_2(
        op1f[63:60]), .op2_fa4_2(op2f[63:60]), .cin_fa4(c15) );
  CFD2QXL \sum_reg[62]  ( .D(sumf[62]), .CP(clock), .CD(n261), .Q(sum[62]) );
  CFD2QXL \sum_reg[61]  ( .D(sumf[61]), .CP(clock), .CD(n261), .Q(sum[61]) );
  CFD2QXL \op2f_reg[63]  ( .D(n63), .CP(clock), .CD(n1), .Q(op2f[63]) );
  CFD2QXL \op2f_reg[62]  ( .D(n65), .CP(clock), .CD(n1), .Q(op2f[62]) );
  CFD2QXL \op2f_reg[61]  ( .D(n67), .CP(clock), .CD(n1), .Q(op2f[61]) );
  CFD2QXL \op2f_reg[60]  ( .D(n69), .CP(clock), .CD(n1), .Q(op2f[60]) );
  CFD2QXL \op2f_reg[59]  ( .D(n71), .CP(clock), .CD(n1), .Q(op2f[59]) );
  CFD2QXL \op2f_reg[58]  ( .D(n73), .CP(clock), .CD(n1), .Q(op2f[58]) );
  CFD2QXL \op2f_reg[57]  ( .D(n75), .CP(clock), .CD(n1), .Q(op2f[57]) );
  CFD2QXL \op2f_reg[56]  ( .D(n77), .CP(clock), .CD(n1), .Q(op2f[56]) );
  CFD2QXL \op2f_reg[55]  ( .D(n79), .CP(clock), .CD(n1), .Q(op2f[55]) );
  CFD2QXL \op2f_reg[54]  ( .D(n81), .CP(clock), .CD(n1), .Q(op2f[54]) );
  CFD2QXL \op2f_reg[53]  ( .D(n83), .CP(clock), .CD(n1), .Q(op2f[53]) );
  CFD2QXL \op2f_reg[52]  ( .D(n85), .CP(clock), .CD(n1), .Q(op2f[52]) );
  CFD2QXL \op2f_reg[51]  ( .D(n87), .CP(clock), .CD(n1), .Q(op2f[51]) );
  CFD2QXL \op2f_reg[50]  ( .D(n89), .CP(clock), .CD(n1), .Q(op2f[50]) );
  CFD2QXL \op2f_reg[49]  ( .D(n91), .CP(clock), .CD(n1), .Q(op2f[49]) );
  CFD2QXL \op2f_reg[48]  ( .D(n93), .CP(clock), .CD(n1), .Q(op2f[48]) );
  CFD2QXL \op2f_reg[47]  ( .D(n95), .CP(clock), .CD(n1), .Q(op2f[47]) );
  CFD2QXL \op2f_reg[46]  ( .D(n97), .CP(clock), .CD(n1), .Q(op2f[46]) );
  CFD2QXL \op2f_reg[45]  ( .D(n99), .CP(clock), .CD(n1), .Q(op2f[45]) );
  CFD2QXL \op2f_reg[44]  ( .D(n101), .CP(clock), .CD(n1), .Q(op2f[44]) );
  CFD2QXL \op2f_reg[43]  ( .D(n103), .CP(clock), .CD(n1), .Q(op2f[43]) );
  CFD2QXL \op2f_reg[42]  ( .D(n105), .CP(clock), .CD(n1), .Q(op2f[42]) );
  CFD2QXL \op2f_reg[41]  ( .D(n107), .CP(clock), .CD(n1), .Q(op2f[41]) );
  CFD2QXL \op2f_reg[40]  ( .D(n109), .CP(clock), .CD(n1), .Q(op2f[40]) );
  CFD2QXL \op2f_reg[39]  ( .D(n111), .CP(clock), .CD(n1), .Q(op2f[39]) );
  CFD2QXL \op2f_reg[38]  ( .D(n113), .CP(clock), .CD(n1), .Q(op2f[38]) );
  CFD2QXL \op2f_reg[37]  ( .D(n115), .CP(clock), .CD(n1), .Q(op2f[37]) );
  CFD2QXL \op2f_reg[36]  ( .D(n117), .CP(clock), .CD(n1), .Q(op2f[36]) );
  CFD2QXL \op2f_reg[35]  ( .D(n119), .CP(clock), .CD(n1), .Q(op2f[35]) );
  CFD2QXL \op2f_reg[34]  ( .D(n121), .CP(clock), .CD(n1), .Q(op2f[34]) );
  CFD2QXL \op2f_reg[33]  ( .D(n123), .CP(clock), .CD(n1), .Q(op2f[33]) );
  CFD2QXL \op2f_reg[32]  ( .D(n125), .CP(clock), .CD(n1), .Q(op2f[32]) );
  CFD2QXL \op2f_reg[31]  ( .D(n127), .CP(clock), .CD(n1), .Q(op2f[31]) );
  CFD2QXL \op2f_reg[30]  ( .D(n129), .CP(clock), .CD(n1), .Q(op2f[30]) );
  CFD2QXL \op2f_reg[29]  ( .D(n131), .CP(clock), .CD(n1), .Q(op2f[29]) );
  CFD2QXL \op2f_reg[28]  ( .D(n133), .CP(clock), .CD(n1), .Q(op2f[28]) );
  CFD2QXL \op2f_reg[27]  ( .D(n135), .CP(clock), .CD(n1), .Q(op2f[27]) );
  CFD2QXL \op2f_reg[26]  ( .D(n137), .CP(clock), .CD(n1), .Q(op2f[26]) );
  CFD2QXL \op2f_reg[25]  ( .D(n139), .CP(clock), .CD(n1), .Q(op2f[25]) );
  CFD2QXL \op2f_reg[24]  ( .D(n141), .CP(clock), .CD(n1), .Q(op2f[24]) );
  CFD2QXL \op2f_reg[23]  ( .D(n143), .CP(clock), .CD(n1), .Q(op2f[23]) );
  CFD2QXL \op2f_reg[22]  ( .D(n145), .CP(clock), .CD(n1), .Q(op2f[22]) );
  CFD2QXL \op2f_reg[21]  ( .D(n147), .CP(clock), .CD(n1), .Q(op2f[21]) );
  CFD2QXL \op2f_reg[20]  ( .D(n149), .CP(clock), .CD(n1), .Q(op2f[20]) );
  CFD2QXL \op2f_reg[19]  ( .D(n151), .CP(clock), .CD(n1), .Q(op2f[19]) );
  CFD2QXL \op2f_reg[18]  ( .D(n153), .CP(clock), .CD(n1), .Q(op2f[18]) );
  CFD2QXL \op2f_reg[17]  ( .D(n155), .CP(clock), .CD(n1), .Q(op2f[17]) );
  CFD2QXL \op1f_reg[63]  ( .D(n157), .CP(clock), .CD(n1), .Q(op1f[63]) );
  CFD2QXL \op1f_reg[62]  ( .D(n159), .CP(clock), .CD(n1), .Q(op1f[62]) );
  CFD2QXL \op1f_reg[61]  ( .D(n161), .CP(clock), .CD(n1), .Q(op1f[61]) );
  CFD2QXL \op1f_reg[60]  ( .D(n163), .CP(clock), .CD(n1), .Q(op1f[60]) );
  CFD2QXL \op1f_reg[59]  ( .D(n165), .CP(clock), .CD(n1), .Q(op1f[59]) );
  CFD2QXL \op1f_reg[58]  ( .D(n167), .CP(clock), .CD(n1), .Q(op1f[58]) );
  CFD2QXL \op1f_reg[57]  ( .D(n169), .CP(clock), .CD(n1), .Q(op1f[57]) );
  CFD2QXL \op1f_reg[56]  ( .D(n171), .CP(clock), .CD(n1), .Q(op1f[56]) );
  CFD2QXL \op1f_reg[55]  ( .D(n173), .CP(clock), .CD(n1), .Q(op1f[55]) );
  CFD2QXL \op1f_reg[54]  ( .D(n175), .CP(clock), .CD(n1), .Q(op1f[54]) );
  CFD2QXL \op1f_reg[53]  ( .D(n177), .CP(clock), .CD(n1), .Q(op1f[53]) );
  CFD2QXL \op1f_reg[52]  ( .D(n179), .CP(clock), .CD(n1), .Q(op1f[52]) );
  CFD2QXL \op1f_reg[51]  ( .D(n181), .CP(clock), .CD(n1), .Q(op1f[51]) );
  CFD2QXL \op1f_reg[50]  ( .D(n183), .CP(clock), .CD(n1), .Q(op1f[50]) );
  CFD2QXL \op1f_reg[49]  ( .D(n185), .CP(clock), .CD(n1), .Q(op1f[49]) );
  CFD2QXL \op1f_reg[48]  ( .D(n187), .CP(clock), .CD(n1), .Q(op1f[48]) );
  CFD2QXL \op1f_reg[47]  ( .D(n189), .CP(clock), .CD(n1), .Q(op1f[47]) );
  CFD2QXL \op1f_reg[46]  ( .D(n191), .CP(clock), .CD(n1), .Q(op1f[46]) );
  CFD2QXL \op1f_reg[45]  ( .D(n193), .CP(clock), .CD(n1), .Q(op1f[45]) );
  CFD2QXL \op1f_reg[44]  ( .D(n195), .CP(clock), .CD(n1), .Q(op1f[44]) );
  CFD2QXL \op1f_reg[43]  ( .D(n197), .CP(clock), .CD(n1), .Q(op1f[43]) );
  CFD2QXL \op1f_reg[42]  ( .D(n199), .CP(clock), .CD(n1), .Q(op1f[42]) );
  CFD2QXL \op1f_reg[41]  ( .D(n201), .CP(clock), .CD(n1), .Q(op1f[41]) );
  CFD2QXL \op1f_reg[40]  ( .D(n203), .CP(clock), .CD(n1), .Q(op1f[40]) );
  CFD2QXL \op1f_reg[39]  ( .D(n205), .CP(clock), .CD(n1), .Q(op1f[39]) );
  CFD2QXL \op1f_reg[38]  ( .D(n207), .CP(clock), .CD(n1), .Q(op1f[38]) );
  CFD2QXL \op1f_reg[37]  ( .D(n209), .CP(clock), .CD(n1), .Q(op1f[37]) );
  CFD2QXL \op1f_reg[36]  ( .D(n211), .CP(clock), .CD(n1), .Q(op1f[36]) );
  CFD2QXL \op1f_reg[35]  ( .D(n213), .CP(clock), .CD(n1), .Q(op1f[35]) );
  CFD2QXL \op1f_reg[34]  ( .D(n215), .CP(clock), .CD(n1), .Q(op1f[34]) );
  CFD2QXL \op1f_reg[33]  ( .D(n217), .CP(clock), .CD(n1), .Q(op1f[33]) );
  CFD2QXL \op1f_reg[32]  ( .D(n219), .CP(clock), .CD(n1), .Q(op1f[32]) );
  CFD2QXL \op1f_reg[31]  ( .D(n221), .CP(clock), .CD(n1), .Q(op1f[31]) );
  CFD2QXL \op1f_reg[30]  ( .D(n223), .CP(clock), .CD(n1), .Q(op1f[30]) );
  CFD2QXL \op1f_reg[29]  ( .D(n225), .CP(clock), .CD(n1), .Q(op1f[29]) );
  CFD2QXL \op1f_reg[28]  ( .D(n227), .CP(clock), .CD(n1), .Q(op1f[28]) );
  CFD2QXL \op1f_reg[27]  ( .D(n229), .CP(clock), .CD(n1), .Q(op1f[27]) );
  CFD2QXL \op1f_reg[26]  ( .D(n231), .CP(clock), .CD(n1), .Q(op1f[26]) );
  CFD2QXL \op1f_reg[25]  ( .D(n233), .CP(clock), .CD(n1), .Q(op1f[25]) );
  CFD2QXL \op1f_reg[24]  ( .D(n235), .CP(clock), .CD(n1), .Q(op1f[24]) );
  CFD2QXL \op1f_reg[23]  ( .D(n237), .CP(clock), .CD(n1), .Q(op1f[23]) );
  CFD2QXL \op1f_reg[22]  ( .D(n239), .CP(clock), .CD(n1), .Q(op1f[22]) );
  CFD2QXL \op1f_reg[21]  ( .D(n241), .CP(clock), .CD(n1), .Q(op1f[21]) );
  CFD2QXL \op1f_reg[20]  ( .D(n243), .CP(clock), .CD(n1), .Q(op1f[20]) );
  CFD2QXL \op1f_reg[19]  ( .D(n245), .CP(clock), .CD(n1), .Q(op1f[19]) );
  CFD2QXL \op1f_reg[18]  ( .D(n247), .CP(clock), .CD(n1), .Q(op1f[18]) );
  CFD2QXL \sum_reg[0]  ( .D(sumf[0]), .CP(clock), .CD(n1), .Q(sum[0]) );
  CFD2QXL \sum_reg[1]  ( .D(sumf[1]), .CP(clock), .CD(n1), .Q(sum[1]) );
  CFD2QXL \sum_reg[2]  ( .D(sumf[2]), .CP(clock), .CD(n1), .Q(sum[2]) );
  CFD2QXL \sum_reg[3]  ( .D(sumf[3]), .CP(clock), .CD(n1), .Q(sum[3]) );
  CFD2QXL \sum_reg[4]  ( .D(sumf[4]), .CP(clock), .CD(n1), .Q(sum[4]) );
  CFD2QXL \sum_reg[5]  ( .D(sumf[5]), .CP(clock), .CD(n1), .Q(sum[5]) );
  CFD2QXL \sum_reg[6]  ( .D(sumf[6]), .CP(clock), .CD(n1), .Q(sum[6]) );
  CFD2QXL \sum_reg[7]  ( .D(sumf[7]), .CP(clock), .CD(n1), .Q(sum[7]) );
  CFD2QXL \sum_reg[8]  ( .D(sumf[8]), .CP(clock), .CD(n1), .Q(sum[8]) );
  CFD2QXL \sum_reg[9]  ( .D(sumf[9]), .CP(clock), .CD(n1), .Q(sum[9]) );
  CFD2QXL \sum_reg[10]  ( .D(sumf[10]), .CP(clock), .CD(n1), .Q(sum[10]) );
  CFD2QXL \sum_reg[11]  ( .D(sumf[11]), .CP(clock), .CD(n1), .Q(sum[11]) );
  CFD2QXL \sum_reg[12]  ( .D(sumf[12]), .CP(clock), .CD(n1), .Q(sum[12]) );
  CFD2QXL \sum_reg[13]  ( .D(sumf[13]), .CP(clock), .CD(n1), .Q(sum[13]) );
  CFD2QXL \sum_reg[14]  ( .D(sumf[14]), .CP(clock), .CD(n1), .Q(sum[14]) );
  CFD2QXL \sum_reg[15]  ( .D(sumf[15]), .CP(clock), .CD(n1), .Q(sum[15]) );
  CFD2QXL \sum_reg[16]  ( .D(sumf[16]), .CP(clock), .CD(n1), .Q(sum[16]) );
  CFD2QXL \sum_reg[17]  ( .D(sumf[17]), .CP(clock), .CD(n1), .Q(sum[17]) );
  CFD2QXL \sum_reg[18]  ( .D(sumf[18]), .CP(clock), .CD(n1), .Q(sum[18]) );
  CFD2QXL \sum_reg[19]  ( .D(sumf[19]), .CP(clock), .CD(n1), .Q(sum[19]) );
  CFD2QXL \sum_reg[20]  ( .D(sumf[20]), .CP(clock), .CD(n1), .Q(sum[20]) );
  CFD2QXL \sum_reg[21]  ( .D(sumf[21]), .CP(clock), .CD(n1), .Q(sum[21]) );
  CFD2QXL \sum_reg[22]  ( .D(sumf[22]), .CP(clock), .CD(n1), .Q(sum[22]) );
  CFD2QXL \sum_reg[23]  ( .D(sumf[23]), .CP(clock), .CD(n1), .Q(sum[23]) );
  CFD2QXL \sum_reg[24]  ( .D(sumf[24]), .CP(clock), .CD(n1), .Q(sum[24]) );
  CFD2QXL \sum_reg[25]  ( .D(sumf[25]), .CP(clock), .CD(n1), .Q(sum[25]) );
  CFD2QXL \sum_reg[26]  ( .D(sumf[26]), .CP(clock), .CD(n1), .Q(sum[26]) );
  CFD2QXL \sum_reg[27]  ( .D(sumf[27]), .CP(clock), .CD(n1), .Q(sum[27]) );
  CFD2QXL \sum_reg[28]  ( .D(sumf[28]), .CP(clock), .CD(n1), .Q(sum[28]) );
  CFD2QXL \sum_reg[29]  ( .D(sumf[29]), .CP(clock), .CD(n1), .Q(sum[29]) );
  CFD2QXL \sum_reg[30]  ( .D(sumf[30]), .CP(clock), .CD(n1), .Q(sum[30]) );
  CFD2QXL \sum_reg[31]  ( .D(sumf[31]), .CP(clock), .CD(n1), .Q(sum[31]) );
  CFD2QXL \sum_reg[32]  ( .D(sumf[32]), .CP(clock), .CD(n1), .Q(sum[32]) );
  CFD2QXL \sum_reg[33]  ( .D(sumf[33]), .CP(clock), .CD(n1), .Q(sum[33]) );
  CFD2QXL \sum_reg[34]  ( .D(sumf[34]), .CP(clock), .CD(n1), .Q(sum[34]) );
  CFD2QXL \sum_reg[35]  ( .D(sumf[35]), .CP(clock), .CD(n1), .Q(sum[35]) );
  CFD2QXL \sum_reg[36]  ( .D(sumf[36]), .CP(clock), .CD(n1), .Q(sum[36]) );
  CFD2QXL \sum_reg[37]  ( .D(sumf[37]), .CP(clock), .CD(n1), .Q(sum[37]) );
  CFD2QXL \sum_reg[38]  ( .D(sumf[38]), .CP(clock), .CD(n1), .Q(sum[38]) );
  CFD2QXL \sum_reg[39]  ( .D(sumf[39]), .CP(clock), .CD(n1), .Q(sum[39]) );
  CFD2QXL \sum_reg[40]  ( .D(sumf[40]), .CP(clock), .CD(n1), .Q(sum[40]) );
  CFD2QXL \sum_reg[41]  ( .D(sumf[41]), .CP(clock), .CD(n1), .Q(sum[41]) );
  CFD2QXL \sum_reg[42]  ( .D(sumf[42]), .CP(clock), .CD(n1), .Q(sum[42]) );
  CFD2QXL \sum_reg[45]  ( .D(sumf[45]), .CP(clock), .CD(n1), .Q(sum[45]) );
  CFD2QXL \sum_reg[43]  ( .D(sumf[43]), .CP(clock), .CD(n1), .Q(sum[43]) );
  CFD2QXL \sum_reg[44]  ( .D(sumf[44]), .CP(clock), .CD(n1), .Q(sum[44]) );
  CFD2QXL \op1f_reg[17]  ( .D(n249), .CP(clock), .CD(n1), .Q(op1f[17]) );
  CFD2QXL \sum_reg[48]  ( .D(sumf[48]), .CP(clock), .CD(n1), .Q(sum[48]) );
  CFD2QXL \sum_reg[46]  ( .D(sumf[46]), .CP(clock), .CD(n1), .Q(sum[46]) );
  CFD2QXL \sum_reg[49]  ( .D(sumf[49]), .CP(clock), .CD(n1), .Q(sum[49]) );
  CFD2QXL \sum_reg[47]  ( .D(sumf[47]), .CP(clock), .CD(n1), .Q(sum[47]) );
  CFD2QXL \sum_reg[50]  ( .D(sumf[50]), .CP(clock), .CD(n1), .Q(sum[50]) );
  CFD2QXL \op1f_reg[14]  ( .D(n251), .CP(clock), .CD(n1), .Q(op1f[14]) );
  CFD2QXL \op2f_reg[13]  ( .D(n253), .CP(clock), .CD(n1), .Q(op2f[13]) );
  CFD2QXL \sum_reg[51]  ( .D(sumf[51]), .CP(clock), .CD(n1), .Q(sum[51]) );
  CFD2QXL \sum_reg[53]  ( .D(sumf[53]), .CP(clock), .CD(n1), .Q(sum[53]) );
  CFD2QXL \sum_reg[52]  ( .D(sumf[52]), .CP(clock), .CD(n1), .Q(sum[52]) );
  CFD2QXL \sum_reg[54]  ( .D(sumf[54]), .CP(clock), .CD(n1), .Q(sum[54]) );
  CFD2QXL \sum_reg[55]  ( .D(sumf[55]), .CP(clock), .CD(n1), .Q(sum[55]) );
  CFD2QXL \sum_reg[56]  ( .D(sumf[56]), .CP(clock), .CD(n1), .Q(sum[56]) );
  CFD2QXL \op1f_reg[4]  ( .D(n255), .CP(clock), .CD(n1), .Q(op1f[4]) );
  CFD3QX2 \op2f_reg[1]  ( .D(n257), .CP(clock), .CD(n1), .SD(1'b1), .Q(op2f[1]) );
  CFD2QX1 \op1f_reg[1]  ( .D(n61), .CP(clock), .CD(n266), .Q(op1f[1]) );
  CFD2QX2 \sum_reg[60]  ( .D(sumf[60]), .CP(clock), .CD(n261), .Q(sum[60]) );
  CFD2QX2 \sum_reg[57]  ( .D(sumf[57]), .CP(clock), .CD(n1), .Q(sum[57]) );
  CFD2QX2 \sum_reg[59]  ( .D(sumf[59]), .CP(clock), .CD(n261), .Q(sum[59]) );
  CFD2QX2 \sum_reg[58]  ( .D(sumf[58]), .CP(clock), .CD(n1), .Q(sum[58]) );
  CFD2X1 crout_reg ( .D(croutf), .CP(clock), .CD(n261), .Q(crout) );
  CFD2QX4 \sum_reg[63]  ( .D(sumf[63]), .CP(clock), .CD(n261), .Q(sum[63]) );
  CDLY1XL U4 ( .A(op1[0]), .Z(n4) );
  CNIVX1 U5 ( .A(n4), .Z(n3) );
  CDLY1XL U6 ( .A(op1[2]), .Z(n6) );
  CNIVX1 U7 ( .A(n6), .Z(n5) );
  CDLY1XL U8 ( .A(op1[3]), .Z(n8) );
  CNIVX1 U9 ( .A(n8), .Z(n7) );
  CDLY1XL U10 ( .A(op1[5]), .Z(n10) );
  CNIVX1 U11 ( .A(n10), .Z(n9) );
  CDLY1XL U12 ( .A(op1[6]), .Z(n12) );
  CNIVX1 U13 ( .A(n12), .Z(n11) );
  CDLY1XL U14 ( .A(op1[7]), .Z(n14) );
  CNIVX1 U15 ( .A(n14), .Z(n13) );
  CDLY1XL U16 ( .A(op1[8]), .Z(n16) );
  CNIVX1 U17 ( .A(n16), .Z(n15) );
  CDLY1XL U18 ( .A(op1[9]), .Z(n18) );
  CNIVX1 U19 ( .A(n18), .Z(n17) );
  CDLY1XL U20 ( .A(op1[10]), .Z(n20) );
  CNIVX1 U21 ( .A(n20), .Z(n19) );
  CDLY1XL U22 ( .A(op1[11]), .Z(n22) );
  CNIVX1 U23 ( .A(n22), .Z(n21) );
  CDLY1XL U24 ( .A(op1[12]), .Z(n24) );
  CNIVX1 U25 ( .A(n24), .Z(n23) );
  CDLY1XL U26 ( .A(op1[13]), .Z(n26) );
  CNIVX1 U27 ( .A(n26), .Z(n25) );
  CDLY1XL U28 ( .A(op1[15]), .Z(n28) );
  CNIVX1 U29 ( .A(n28), .Z(n27) );
  CDLY1XL U30 ( .A(op1[16]), .Z(n30) );
  CNIVX1 U31 ( .A(n30), .Z(n29) );
  CDLY1XL U32 ( .A(op2[0]), .Z(n32) );
  CNIVX1 U33 ( .A(n32), .Z(n31) );
  CDLY1XL U34 ( .A(op2[2]), .Z(n34) );
  CNIVX1 U35 ( .A(n34), .Z(n33) );
  CDLY1XL U36 ( .A(op2[3]), .Z(n36) );
  CNIVX1 U37 ( .A(n36), .Z(n35) );
  CDLY1XL U38 ( .A(op2[4]), .Z(n38) );
  CNIVX1 U39 ( .A(n38), .Z(n37) );
  CDLY1XL U40 ( .A(op2[5]), .Z(n40) );
  CNIVX1 U41 ( .A(n40), .Z(n39) );
  CDLY1XL U42 ( .A(op2[6]), .Z(n42) );
  CNIVX1 U43 ( .A(n42), .Z(n41) );
  CDLY1XL U44 ( .A(op2[7]), .Z(n44) );
  CNIVX1 U45 ( .A(n44), .Z(n43) );
  CDLY1XL U46 ( .A(op2[8]), .Z(n46) );
  CNIVX1 U47 ( .A(n46), .Z(n45) );
  CDLY1XL U48 ( .A(op2[9]), .Z(n48) );
  CNIVX1 U49 ( .A(n48), .Z(n47) );
  CDLY1XL U50 ( .A(op2[10]), .Z(n50) );
  CNIVX1 U51 ( .A(n50), .Z(n49) );
  CDLY1XL U52 ( .A(op2[11]), .Z(n52) );
  CNIVX1 U53 ( .A(n52), .Z(n51) );
  CDLY1XL U54 ( .A(op2[12]), .Z(n54) );
  CNIVX1 U55 ( .A(n54), .Z(n53) );
  CDLY1XL U56 ( .A(op2[14]), .Z(n56) );
  CNIVX1 U57 ( .A(n56), .Z(n55) );
  CDLY1XL U58 ( .A(op2[15]), .Z(n58) );
  CNIVX1 U59 ( .A(n58), .Z(n57) );
  CDLY1XL U60 ( .A(op2[16]), .Z(n60) );
  CNIVX1 U61 ( .A(n60), .Z(n59) );
  CDLY1XL U62 ( .A(op1[1]), .Z(n62) );
  CNIVX1 U63 ( .A(n62), .Z(n61) );
  CDLY1XL U64 ( .A(op2[63]), .Z(n64) );
  CNIVX1 U65 ( .A(n64), .Z(n63) );
  CDLY1XL U66 ( .A(op2[62]), .Z(n66) );
  CNIVX1 U67 ( .A(n66), .Z(n65) );
  CDLY1XL U68 ( .A(op2[61]), .Z(n68) );
  CNIVX1 U69 ( .A(n68), .Z(n67) );
  CDLY1XL U70 ( .A(op2[60]), .Z(n70) );
  CNIVX1 U71 ( .A(n70), .Z(n69) );
  CDLY1XL U72 ( .A(op2[59]), .Z(n72) );
  CNIVX1 U73 ( .A(n72), .Z(n71) );
  CDLY1XL U74 ( .A(op2[58]), .Z(n74) );
  CNIVX1 U75 ( .A(n74), .Z(n73) );
  CDLY1XL U76 ( .A(op2[57]), .Z(n76) );
  CNIVX1 U77 ( .A(n76), .Z(n75) );
  CDLY1XL U78 ( .A(op2[56]), .Z(n78) );
  CNIVX1 U79 ( .A(n78), .Z(n77) );
  CDLY1XL U80 ( .A(op2[55]), .Z(n80) );
  CNIVX1 U81 ( .A(n80), .Z(n79) );
  CDLY1XL U82 ( .A(op2[54]), .Z(n82) );
  CNIVX1 U83 ( .A(n82), .Z(n81) );
  CDLY1XL U84 ( .A(op2[53]), .Z(n84) );
  CNIVX1 U85 ( .A(n84), .Z(n83) );
  CDLY1XL U86 ( .A(op2[52]), .Z(n86) );
  CNIVX1 U87 ( .A(n86), .Z(n85) );
  CDLY1XL U88 ( .A(op2[51]), .Z(n88) );
  CNIVX1 U89 ( .A(n88), .Z(n87) );
  CDLY1XL U90 ( .A(op2[50]), .Z(n90) );
  CNIVX1 U91 ( .A(n90), .Z(n89) );
  CDLY1XL U92 ( .A(op2[49]), .Z(n92) );
  CNIVX1 U93 ( .A(n92), .Z(n91) );
  CDLY1XL U94 ( .A(op2[48]), .Z(n94) );
  CNIVX1 U95 ( .A(n94), .Z(n93) );
  CDLY1XL U96 ( .A(op2[47]), .Z(n96) );
  CNIVX1 U97 ( .A(n96), .Z(n95) );
  CDLY1XL U98 ( .A(op2[46]), .Z(n98) );
  CNIVX1 U99 ( .A(n98), .Z(n97) );
  CDLY1XL U100 ( .A(op2[45]), .Z(n100) );
  CNIVX1 U101 ( .A(n100), .Z(n99) );
  CDLY1XL U102 ( .A(op2[44]), .Z(n102) );
  CNIVX1 U103 ( .A(n102), .Z(n101) );
  CDLY1XL U104 ( .A(op2[43]), .Z(n104) );
  CNIVX1 U105 ( .A(n104), .Z(n103) );
  CDLY1XL U106 ( .A(op2[42]), .Z(n106) );
  CNIVX1 U107 ( .A(n106), .Z(n105) );
  CDLY1XL U108 ( .A(op2[41]), .Z(n108) );
  CNIVX1 U109 ( .A(n108), .Z(n107) );
  CDLY1XL U110 ( .A(op2[40]), .Z(n110) );
  CNIVX1 U111 ( .A(n110), .Z(n109) );
  CDLY1XL U112 ( .A(op2[39]), .Z(n112) );
  CNIVX1 U113 ( .A(n112), .Z(n111) );
  CDLY1XL U114 ( .A(op2[38]), .Z(n114) );
  CNIVX1 U115 ( .A(n114), .Z(n113) );
  CDLY1XL U116 ( .A(op2[37]), .Z(n116) );
  CNIVX1 U117 ( .A(n116), .Z(n115) );
  CDLY1XL U118 ( .A(op2[36]), .Z(n118) );
  CNIVX1 U119 ( .A(n118), .Z(n117) );
  CDLY1XL U120 ( .A(op2[35]), .Z(n120) );
  CNIVX1 U121 ( .A(n120), .Z(n119) );
  CDLY1XL U122 ( .A(op2[34]), .Z(n122) );
  CNIVX1 U123 ( .A(n122), .Z(n121) );
  CDLY1XL U124 ( .A(op2[33]), .Z(n124) );
  CNIVX1 U125 ( .A(n124), .Z(n123) );
  CDLY1XL U126 ( .A(op2[32]), .Z(n126) );
  CNIVX1 U127 ( .A(n126), .Z(n125) );
  CDLY1XL U128 ( .A(op2[31]), .Z(n128) );
  CNIVX1 U129 ( .A(n128), .Z(n127) );
  CDLY1XL U130 ( .A(op2[30]), .Z(n130) );
  CNIVX1 U131 ( .A(n130), .Z(n129) );
  CDLY1XL U132 ( .A(op2[29]), .Z(n132) );
  CNIVX1 U133 ( .A(n132), .Z(n131) );
  CDLY1XL U134 ( .A(op2[28]), .Z(n134) );
  CNIVX1 U135 ( .A(n134), .Z(n133) );
  CDLY1XL U136 ( .A(op2[27]), .Z(n136) );
  CNIVX1 U137 ( .A(n136), .Z(n135) );
  CDLY1XL U138 ( .A(op2[26]), .Z(n138) );
  CNIVX1 U139 ( .A(n138), .Z(n137) );
  CDLY1XL U140 ( .A(op2[25]), .Z(n140) );
  CNIVX1 U141 ( .A(n140), .Z(n139) );
  CDLY1XL U142 ( .A(op2[24]), .Z(n142) );
  CNIVX1 U143 ( .A(n142), .Z(n141) );
  CDLY1XL U144 ( .A(op2[23]), .Z(n144) );
  CNIVX1 U145 ( .A(n144), .Z(n143) );
  CDLY1XL U146 ( .A(op2[22]), .Z(n146) );
  CNIVX1 U147 ( .A(n146), .Z(n145) );
  CDLY1XL U148 ( .A(op2[21]), .Z(n148) );
  CNIVX1 U149 ( .A(n148), .Z(n147) );
  CDLY1XL U150 ( .A(op2[20]), .Z(n150) );
  CNIVX1 U151 ( .A(n150), .Z(n149) );
  CDLY1XL U152 ( .A(op2[19]), .Z(n152) );
  CNIVX1 U153 ( .A(n152), .Z(n151) );
  CDLY1XL U154 ( .A(op2[18]), .Z(n154) );
  CNIVX1 U155 ( .A(n154), .Z(n153) );
  CDLY1XL U156 ( .A(op2[17]), .Z(n156) );
  CNIVX1 U157 ( .A(n156), .Z(n155) );
  CDLY1XL U158 ( .A(op1[63]), .Z(n158) );
  CNIVX1 U159 ( .A(n158), .Z(n157) );
  CDLY1XL U160 ( .A(op1[62]), .Z(n160) );
  CNIVX1 U161 ( .A(n160), .Z(n159) );
  CDLY1XL U162 ( .A(op1[61]), .Z(n162) );
  CNIVX1 U163 ( .A(n162), .Z(n161) );
  CDLY1XL U164 ( .A(op1[60]), .Z(n164) );
  CNIVX1 U165 ( .A(n164), .Z(n163) );
  CDLY1XL U166 ( .A(op1[59]), .Z(n166) );
  CNIVX1 U167 ( .A(n166), .Z(n165) );
  CDLY1XL U168 ( .A(op1[58]), .Z(n168) );
  CNIVX1 U169 ( .A(n168), .Z(n167) );
  CDLY1XL U170 ( .A(op1[57]), .Z(n170) );
  CNIVX1 U171 ( .A(n170), .Z(n169) );
  CDLY1XL U172 ( .A(op1[56]), .Z(n172) );
  CNIVX1 U173 ( .A(n172), .Z(n171) );
  CDLY1XL U174 ( .A(op1[55]), .Z(n174) );
  CNIVX1 U175 ( .A(n174), .Z(n173) );
  CDLY1XL U176 ( .A(op1[54]), .Z(n176) );
  CNIVX1 U177 ( .A(n176), .Z(n175) );
  CDLY1XL U178 ( .A(op1[53]), .Z(n178) );
  CNIVX1 U179 ( .A(n178), .Z(n177) );
  CDLY1XL U180 ( .A(op1[52]), .Z(n180) );
  CNIVX1 U181 ( .A(n180), .Z(n179) );
  CDLY1XL U182 ( .A(op1[51]), .Z(n182) );
  CNIVX1 U183 ( .A(n182), .Z(n181) );
  CDLY1XL U184 ( .A(op1[50]), .Z(n184) );
  CNIVX1 U185 ( .A(n184), .Z(n183) );
  CDLY1XL U186 ( .A(op1[49]), .Z(n186) );
  CNIVX1 U187 ( .A(n186), .Z(n185) );
  CDLY1XL U188 ( .A(op1[48]), .Z(n188) );
  CNIVX1 U189 ( .A(n188), .Z(n187) );
  CDLY1XL U190 ( .A(op1[47]), .Z(n190) );
  CNIVX1 U191 ( .A(n190), .Z(n189) );
  CDLY1XL U192 ( .A(op1[46]), .Z(n192) );
  CNIVX1 U193 ( .A(n192), .Z(n191) );
  CDLY1XL U194 ( .A(op1[45]), .Z(n194) );
  CNIVX1 U195 ( .A(n194), .Z(n193) );
  CDLY1XL U196 ( .A(op1[44]), .Z(n196) );
  CNIVX1 U197 ( .A(n196), .Z(n195) );
  CDLY1XL U198 ( .A(op1[43]), .Z(n198) );
  CNIVX1 U199 ( .A(n198), .Z(n197) );
  CDLY1XL U200 ( .A(op1[42]), .Z(n200) );
  CNIVX1 U201 ( .A(n200), .Z(n199) );
  CDLY1XL U202 ( .A(op1[41]), .Z(n202) );
  CNIVX1 U203 ( .A(n202), .Z(n201) );
  CDLY1XL U204 ( .A(op1[40]), .Z(n204) );
  CNIVX1 U205 ( .A(n204), .Z(n203) );
  CDLY1XL U206 ( .A(op1[39]), .Z(n206) );
  CNIVX1 U207 ( .A(n206), .Z(n205) );
  CDLY1XL U208 ( .A(op1[38]), .Z(n208) );
  CNIVX1 U209 ( .A(n208), .Z(n207) );
  CDLY1XL U210 ( .A(op1[37]), .Z(n210) );
  CNIVX1 U211 ( .A(n210), .Z(n209) );
  CDLY1XL U212 ( .A(op1[36]), .Z(n212) );
  CNIVX1 U213 ( .A(n212), .Z(n211) );
  CDLY1XL U214 ( .A(op1[35]), .Z(n214) );
  CNIVX1 U215 ( .A(n214), .Z(n213) );
  CDLY1XL U216 ( .A(op1[34]), .Z(n216) );
  CNIVX1 U217 ( .A(n216), .Z(n215) );
  CDLY1XL U218 ( .A(op1[33]), .Z(n218) );
  CNIVX1 U219 ( .A(n218), .Z(n217) );
  CDLY1XL U220 ( .A(op1[32]), .Z(n220) );
  CNIVX1 U221 ( .A(n220), .Z(n219) );
  CDLY1XL U222 ( .A(op1[31]), .Z(n222) );
  CNIVX1 U223 ( .A(n222), .Z(n221) );
  CDLY1XL U224 ( .A(op1[30]), .Z(n224) );
  CNIVX1 U225 ( .A(n224), .Z(n223) );
  CDLY1XL U226 ( .A(op1[29]), .Z(n226) );
  CNIVX1 U227 ( .A(n226), .Z(n225) );
  CDLY1XL U228 ( .A(op1[28]), .Z(n228) );
  CNIVX1 U229 ( .A(n228), .Z(n227) );
  CDLY1XL U230 ( .A(op1[27]), .Z(n230) );
  CNIVX1 U231 ( .A(n230), .Z(n229) );
  CDLY1XL U232 ( .A(op1[26]), .Z(n232) );
  CNIVX1 U233 ( .A(n232), .Z(n231) );
  CDLY1XL U234 ( .A(op1[25]), .Z(n234) );
  CNIVX1 U235 ( .A(n234), .Z(n233) );
  CDLY1XL U236 ( .A(op1[24]), .Z(n236) );
  CNIVX1 U237 ( .A(n236), .Z(n235) );
  CDLY1XL U238 ( .A(op1[23]), .Z(n238) );
  CNIVX1 U239 ( .A(n238), .Z(n237) );
  CDLY1XL U240 ( .A(op1[22]), .Z(n240) );
  CNIVX1 U241 ( .A(n240), .Z(n239) );
  CDLY1XL U242 ( .A(op1[21]), .Z(n242) );
  CNIVX1 U243 ( .A(n242), .Z(n241) );
  CDLY1XL U244 ( .A(op1[20]), .Z(n244) );
  CNIVX1 U245 ( .A(n244), .Z(n243) );
  CDLY1XL U246 ( .A(op1[19]), .Z(n246) );
  CNIVX1 U247 ( .A(n246), .Z(n245) );
  CDLY1XL U248 ( .A(op1[18]), .Z(n248) );
  CNIVX1 U249 ( .A(n248), .Z(n247) );
  CDLY1XL U250 ( .A(op1[17]), .Z(n250) );
  CNIVX1 U251 ( .A(n250), .Z(n249) );
  CDLY1XL U252 ( .A(op1[14]), .Z(n252) );
  CNIVX1 U253 ( .A(n252), .Z(n251) );
  CDLY1XL U254 ( .A(op2[13]), .Z(n254) );
  CNIVX1 U255 ( .A(n254), .Z(n253) );
  CDLY1XL U256 ( .A(op1[4]), .Z(n256) );
  CNIVX1 U257 ( .A(n256), .Z(n255) );
  CDLY1XL U258 ( .A(op2[1]), .Z(n258) );
  CNIVX1 U259 ( .A(n258), .Z(n257) );
  CNIVX1 U260 ( .A(n1), .Z(n267) );
  CNIVX1 U261 ( .A(n1), .Z(n266) );
  CNIVX1 U262 ( .A(n1), .Z(n265) );
  CNIVX1 U263 ( .A(n1), .Z(n264) );
  CNIVX1 U264 ( .A(n1), .Z(n263) );
  CNIVX1 U265 ( .A(n1), .Z(n262) );
  CIVX4 U266 ( .A(reset), .Z(n1) );
  CDLY2X2 U268 ( .A(n1), .Z(n261) );
endmodule

