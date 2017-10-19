
module FA_0 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n1, n2, n3, n4, n5;

  CENX1 U1 ( .A(n4), .B(op1_fa), .Z(n1) );
  CDLY1XL U2 ( .A(n1), .Z(n2) );
  CND2IX2 U3 ( .B(n3), .A(n5), .Z(cout_fa) );
  CAN2XL U4 ( .A(op1_fa), .B(cin), .Z(n3) );
  CND2X2 U5 ( .A(n1), .B(op2_fa), .Z(n5) );
  CIVX20 U6 ( .A(cin), .Z(n4) );
  CEOXL U7 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_127 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8;

  CAN2X2 U1 ( .A(op1_fa), .B(cin), .Z(n6) );
  CND2X2 U2 ( .A(n3), .B(op1_fa), .Z(n4) );
  CND2X1 U3 ( .A(cin), .B(n2), .Z(n5) );
  CND2X2 U4 ( .A(n4), .B(n5), .Z(n8) );
  CIVXL U5 ( .A(op1_fa), .Z(n2) );
  CIVX2 U6 ( .A(cin), .Z(n3) );
  CND2IX2 U7 ( .B(n6), .A(n7), .Z(cout_fa) );
  CND2X2 U8 ( .A(n8), .B(op2_fa), .Z(n7) );
  CEOXL U9 ( .A(op2_fa), .B(n8), .Z(sum_fa) );
endmodule


module FA_126 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9;

  CND2X2 U1 ( .A(n1), .B(n8), .Z(n5) );
  CND2IX2 U2 ( .B(n9), .A(n7), .Z(n1) );
  CIVX2 U3 ( .A(cin), .Z(n7) );
  CND2X1 U4 ( .A(n4), .B(op1_fa), .Z(n2) );
  CND2IX1 U5 ( .B(op1_fa), .A(cin), .Z(n8) );
  CND2X2 U6 ( .A(n5), .B(op2_fa), .Z(n3) );
  CND2X2 U7 ( .A(n3), .B(n2), .Z(cout_fa) );
  CIVXL U8 ( .A(n7), .Z(n4) );
  CDLY1XL U9 ( .A(n5), .Z(n6) );
  CIVX1 U10 ( .A(op1_fa), .Z(n9) );
  CEOXL U11 ( .A(op2_fa), .B(n6), .Z(sum_fa) );
endmodule


module FA_125 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  CDLY1XL U1 ( .A(n11), .Z(n2) );
  CND2X2 U2 ( .A(n11), .B(op2_fa), .Z(n9) );
  CND2IX1 U3 ( .B(n4), .A(cin), .Z(n6) );
  CIVX1 U4 ( .A(op1_fa), .Z(n10) );
  CIVX3 U5 ( .A(n10), .Z(n4) );
  CND2IX2 U6 ( .B(n3), .A(n5), .Z(n7) );
  CIVX20 U7 ( .A(n4), .Z(n3) );
  CND2X2 U8 ( .A(n7), .B(n6), .Z(n11) );
  CIVX2 U9 ( .A(cin), .Z(n5) );
  CND2XL U10 ( .A(op1_fa), .B(cin), .Z(n8) );
  CND2X2 U11 ( .A(n9), .B(n8), .Z(cout_fa) );
  CEOXL U12 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_124 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6;

  CENX1 U1 ( .A(n3), .B(op1_fa), .Z(n6) );
  CDLY1XL U2 ( .A(n6), .Z(n2) );
  CIVX20 U3 ( .A(cin), .Z(n3) );
  CND2X2 U4 ( .A(n6), .B(op2_fa), .Z(n5) );
  CND2XL U5 ( .A(op1_fa), .B(cin), .Z(n4) );
  CND2X2 U6 ( .A(n5), .B(n4), .Z(cout_fa) );
  CEOXL U7 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_123 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  CND2XL U1 ( .A(n9), .B(n8), .Z(n2) );
  CND2IX1 U2 ( .B(op1_fa), .A(cin), .Z(n8) );
  CIVX1 U3 ( .A(op1_fa), .Z(n10) );
  CND2IX2 U4 ( .B(n10), .A(n7), .Z(n9) );
  CIVXL U5 ( .A(n2), .Z(n3) );
  CIVX2 U6 ( .A(n3), .Z(n4) );
  CND2X2 U7 ( .A(n9), .B(n8), .Z(n11) );
  CND2XL U8 ( .A(cin), .B(op1_fa), .Z(n5) );
  CND2X2 U9 ( .A(n11), .B(op2_fa), .Z(n6) );
  CND2X2 U10 ( .A(n5), .B(n6), .Z(cout_fa) );
  CIVX2 U11 ( .A(cin), .Z(n7) );
  CEOXL U12 ( .A(op2_fa), .B(n4), .Z(sum_fa) );
endmodule


module FA_122 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12;

  CND2IX1 U1 ( .B(op1_fa), .A(cin), .Z(n4) );
  CNIVX1 U2 ( .A(cin), .Z(n8) );
  CND2IX2 U3 ( .B(n11), .A(n3), .Z(n5) );
  CDLY1XL U4 ( .A(n12), .Z(n2) );
  CND2X2 U5 ( .A(n5), .B(n4), .Z(n12) );
  CIVX2 U6 ( .A(cin), .Z(n3) );
  CIVX2 U7 ( .A(op1_fa), .Z(n11) );
  CND2X1 U8 ( .A(op1_fa), .B(n8), .Z(n6) );
  CND2X2 U9 ( .A(n12), .B(op2_fa), .Z(n7) );
  CND2X2 U10 ( .A(n6), .B(n7), .Z(cout_fa) );
  CIVXL U11 ( .A(n2), .Z(n9) );
  CIVX2 U12 ( .A(n9), .Z(n10) );
  CEOXL U13 ( .A(op2_fa), .B(n10), .Z(sum_fa) );
endmodule


module FA_121 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8, n9, n10, n11;

  CAN2X1 U1 ( .A(cin), .B(op1_fa), .Z(n6) );
  CND2X1 U2 ( .A(cin), .B(n10), .Z(n4) );
  CND2X2 U3 ( .A(n2), .B(n3), .Z(n5) );
  CND2X2 U4 ( .A(n5), .B(n4), .Z(n11) );
  CIVX2 U5 ( .A(cin), .Z(n2) );
  CIVX2 U6 ( .A(n10), .Z(n3) );
  CIVX2 U7 ( .A(op1_fa), .Z(n10) );
  CND2IX2 U8 ( .B(n6), .A(n7), .Z(cout_fa) );
  CND2X2 U9 ( .A(n11), .B(op2_fa), .Z(n7) );
  CIVXL U10 ( .A(n11), .Z(n8) );
  CIVX2 U11 ( .A(n8), .Z(n9) );
  CEOXL U12 ( .A(op2_fa), .B(n9), .Z(sum_fa) );
endmodule


module mux_sum_0 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n2;

  CAOR2X1 U1 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n2), .Z(sum[3]) );
  CAOR2X1 U2 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n2), .Z(sum[2]) );
  CAOR2X1 U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n2), .Z(sum[1]) );
  CAOR2X1 U4 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n2), .Z(sum[0]) );
  CIVX1 U5 ( .A(Cin), .Z(n2) );
endmodule


module mux_carry_0 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n2, n1, n3;

  CIVX1 U2 ( .A(Cin), .Z(n2) );
  CND2X2 U1 ( .A(cout0), .B(n2), .Z(n3) );
  CND2X4 U3 ( .A(n1), .B(n3), .Z(cout) );
  CND2X2 U4 ( .A(cout1), .B(Cin), .Z(n1) );
endmodule


module CSA4_0 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_0 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_127 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_126 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_125 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_124 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_123 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_122 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_121 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_0 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_0 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
endmodule


module FA_120 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5;

  CND2X2 U1 ( .A(n5), .B(op2_fa), .Z(n3) );
  CND2XL U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CND2X2 U3 ( .A(n2), .B(n3), .Z(cout_fa) );
  CENX1 U4 ( .A(op1_fa), .B(n4), .Z(n5) );
  CIVX20 U5 ( .A(cin), .Z(n4) );
  CEOXL U6 ( .A(op2_fa), .B(n5), .Z(sum_fa) );
endmodule


module FA_119 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4;

  CAOR2X2 U1 ( .A(cin), .B(op1_fa), .C(n4), .D(op2_fa), .Z(cout_fa) );
  CENX2 U2 ( .A(n3), .B(cin), .Z(n4) );
  CIVX2 U3 ( .A(op1_fa), .Z(n3) );
  CDLY1XL U4 ( .A(n4), .Z(n2) );
  CEOXL U5 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_118 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5;

  CENX2 U1 ( .A(n4), .B(cin), .Z(n5) );
  CND2XL U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CND2X2 U3 ( .A(n5), .B(op2_fa), .Z(n3) );
  CND2X2 U4 ( .A(n2), .B(n3), .Z(cout_fa) );
  CIVX20 U5 ( .A(op1_fa), .Z(n4) );
  CEOXL U6 ( .A(op2_fa), .B(n5), .Z(sum_fa) );
endmodule


module FA_117 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4;

  CENXL U1 ( .A(n3), .B(cin), .Z(n2) );
  CENX1 U2 ( .A(cin), .B(n3), .Z(n4) );
  CAOR2X1 U3 ( .A(op1_fa), .B(cin), .C(n4), .D(op2_fa), .Z(cout_fa) );
  CIVX20 U4 ( .A(op1_fa), .Z(n3) );
  CEOXL U5 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_116 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8, n9;

  CIVXL U1 ( .A(op1_fa), .Z(n3) );
  CDLY1XL U2 ( .A(n9), .Z(n2) );
  CND2X1 U3 ( .A(n3), .B(cin), .Z(n6) );
  CND2X2 U4 ( .A(n9), .B(op2_fa), .Z(n8) );
  CND2XL U5 ( .A(op1_fa), .B(n4), .Z(n5) );
  CND2X1 U6 ( .A(n5), .B(n6), .Z(n9) );
  CIVX2 U7 ( .A(cin), .Z(n4) );
  CEOXL U8 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CND2XL U9 ( .A(op1_fa), .B(cin), .Z(n7) );
  CND2X2 U10 ( .A(n7), .B(n8), .Z(cout_fa) );
endmodule


module FA_115 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6, n7, n8;

  CND2X2 U1 ( .A(op1_fa), .B(n3), .Z(n4) );
  CND2X1 U2 ( .A(n2), .B(cin), .Z(n5) );
  CND2X2 U3 ( .A(n4), .B(n5), .Z(n8) );
  CIVXL U4 ( .A(op1_fa), .Z(n2) );
  CIVX2 U5 ( .A(cin), .Z(n3) );
  CND2X2 U6 ( .A(n8), .B(op2_fa), .Z(n7) );
  CND2XL U7 ( .A(op1_fa), .B(cin), .Z(n6) );
  CND2X2 U8 ( .A(n6), .B(n7), .Z(cout_fa) );
  CEOXL U9 ( .A(op2_fa), .B(n8), .Z(sum_fa) );
endmodule


module FA_114 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6;

  CND2XL U1 ( .A(cin), .B(op1_fa), .Z(n2) );
  CND2X2 U2 ( .A(n6), .B(op2_fa), .Z(n3) );
  CND2X2 U3 ( .A(n2), .B(n3), .Z(cout_fa) );
  CDLY1XL U4 ( .A(n6), .Z(n4) );
  CENX2 U5 ( .A(n5), .B(cin), .Z(n6) );
  CIVX20 U6 ( .A(op1_fa), .Z(n5) );
  CEOXL U7 ( .A(op2_fa), .B(n4), .Z(sum_fa) );
endmodule


module FA_113 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6;

  CENX2 U1 ( .A(cin), .B(n5), .Z(n6) );
  CDLY1XL U2 ( .A(n6), .Z(n2) );
  CIVXL U3 ( .A(n2), .Z(n3) );
  CIVX2 U4 ( .A(n3), .Z(n4) );
  CIVX20 U5 ( .A(op1_fa), .Z(n5) );
  CAOR2X1 U6 ( .A(op1_fa), .B(cin), .C(n6), .D(op2_fa), .Z(cout_fa) );
  CEOXL U7 ( .A(op2_fa), .B(n4), .Z(sum_fa) );
endmodule


module mux_sum_15 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_15 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X1 U1 ( .A(Cin), .B(cout1), .Z(n1) );
  CIVX2 U2 ( .A(Cin), .Z(n4) );
  CND2X2 U3 ( .A(n4), .B(cout0), .Z(n3) );
  CND2X2 U4 ( .A(n3), .B(n1), .Z(cout) );
endmodule


module CSA4_15 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_120 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_119 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_118 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_117 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_116 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_115 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_114 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_113 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_15 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_15 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
endmodule


module FA_112 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n3), .D(op2_fa), .Z(cout_fa) );
  CENX1 U1 ( .A(op1_fa), .B(n2), .Z(n3) );
  CIVX20 U3 ( .A(cin), .Z(n2) );
  CEOXL U4 ( .A(op2_fa), .B(n3), .Z(sum_fa) );
endmodule


module FA_111 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U1 ( .A(cin), .B(op1_fa), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U2 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_110 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4;

  CEOX2 U1 ( .A(op1_fa), .B(cin), .Z(n4) );
  CND2XL U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CND2X2 U3 ( .A(n4), .B(op2_fa), .Z(n3) );
  CND2X2 U4 ( .A(n3), .B(n2), .Z(cout_fa) );
  CEOXL U5 ( .A(op2_fa), .B(n4), .Z(sum_fa) );
endmodule


module FA_109 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U1 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U2 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_108 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6;

  CND2XL U1 ( .A(op1_fa), .B(cin), .Z(n2) );
  CND2X1 U2 ( .A(n6), .B(op2_fa), .Z(n3) );
  CND2X2 U3 ( .A(n2), .B(n3), .Z(cout_fa) );
  CDLY1XL U4 ( .A(n6), .Z(n4) );
  CENX1 U5 ( .A(op1_fa), .B(n5), .Z(n6) );
  CIVX20 U6 ( .A(cin), .Z(n5) );
  CEOXL U7 ( .A(op2_fa), .B(n4), .Z(sum_fa) );
endmodule


module FA_107 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_106 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n3), .D(op2_fa), .Z(cout_fa) );
  CENX1 U1 ( .A(n2), .B(cin), .Z(n3) );
  CIVX20 U3 ( .A(op1_fa), .Z(n2) );
  CEOXL U4 ( .A(op2_fa), .B(n3), .Z(sum_fa) );
endmodule


module FA_105 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3, n4, n5, n6;

  CAOR2X1 U1 ( .A(op1_fa), .B(cin), .C(n6), .D(op2_fa), .Z(cout_fa) );
  CND2X1 U2 ( .A(cin), .B(n5), .Z(n3) );
  CIVX1 U3 ( .A(cin), .Z(n2) );
  CND2IX2 U4 ( .B(n5), .A(n2), .Z(n4) );
  CND2X2 U5 ( .A(n4), .B(n3), .Z(n6) );
  CIVX2 U6 ( .A(op1_fa), .Z(n5) );
  CEOXL U7 ( .A(op2_fa), .B(n6), .Z(sum_fa) );
endmodule


module mux_sum_14 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_14 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X2 U1 ( .A(n4), .B(cout0), .Z(n3) );
  CND2X2 U2 ( .A(n3), .B(n1), .Z(cout) );
  CND2X1 U3 ( .A(Cin), .B(cout1), .Z(n1) );
  CIVX2 U4 ( .A(Cin), .Z(n4) );
endmodule


module CSA4_14 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1, n2, n3;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_112 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_111 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_110 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_109 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_108 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_107 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_106 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_105 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_14 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n3) );
  mux_carry_14 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
  CIVXL U4 ( .A(n1), .Z(n2) );
  CIVX2 U5 ( .A(n2), .Z(n3) );
endmodule


module FA_104 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_103 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_102 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_101 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U1 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX2 U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CEOXL U3 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
endmodule


module FA_100 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3;

  CEOX1 U1 ( .A(op2_fa), .B(n3), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n3), .D(op2_fa), .Z(cout_fa) );
  CENX1 U3 ( .A(op1_fa), .B(n2), .Z(n3) );
  CIVX20 U4 ( .A(cin), .Z(n2) );
endmodule


module FA_99 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_98 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_97 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2, n3;

  CENX1 U1 ( .A(n2), .B(cin), .Z(n3) );
  CIVX20 U2 ( .A(op1_fa), .Z(n2) );
  CEOXL U3 ( .A(op2_fa), .B(n3), .Z(sum_fa) );
  CAOR2X1 U4 ( .A(op1_fa), .B(cin), .C(n3), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_13 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_13 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X2 U1 ( .A(n4), .B(cout0), .Z(n3) );
  CIVX2 U2 ( .A(Cin), .Z(n4) );
  CND2X1 U3 ( .A(Cin), .B(cout1), .Z(n1) );
  CND2X2 U4 ( .A(n3), .B(n1), .Z(cout) );
endmodule


module CSA4_13 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_104 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_103 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_102 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_101 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_100 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_99 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_98 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_97 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_13 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_13 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
endmodule


module FA_96 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_95 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_94 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_93 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2XL U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module FA_92 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_91 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_90 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_89 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2XL U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_12 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CAOR2XL U1 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CIVXL U2 ( .A(Cin), .Z(n1) );
  CAOR2XL U3 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
endmodule


module mux_carry_12 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X2 U1 ( .A(n4), .B(cout0), .Z(n3) );
  CIVX2 U2 ( .A(Cin), .Z(n4) );
  CND2X1 U3 ( .A(Cin), .B(cout1), .Z(n1) );
  CND2X2 U4 ( .A(n3), .B(n1), .Z(cout) );
endmodule


module CSA4_12 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_96 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_95 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_94 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_93 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_92 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_91 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_90 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_89 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_12 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n1) );
  mux_carry_12 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
endmodule


module FA_88 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_87 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_86 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOXL U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_85 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_84 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2XL U3 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module FA_83 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_82 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2X2 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module FA_81 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX2 U2 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2X2 U3 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_11 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_11 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n2, n3;

  CND2X1 U1 ( .A(cout1), .B(Cin), .Z(n1) );
  COR2X1 U2 ( .A(n3), .B(Cin), .Z(n2) );
  CND2X2 U3 ( .A(n1), .B(n2), .Z(cout) );
  CIVX2 U4 ( .A(cout0), .Z(n3) );
endmodule


module CSA4_11 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1, n2, n3;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_88 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_87 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_86 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_85 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_84 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_83 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_82 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_81 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_11 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n3) );
  mux_carry_11 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
  CIVXL U4 ( .A(n1), .Z(n2) );
  CIVX2 U5 ( .A(n2), .Z(n3) );
endmodule


module FA_80 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_79 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_78 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_77 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_76 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_75 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_74 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_73 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_10 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_10 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CIVX2 U1 ( .A(Cin), .Z(n4) );
  CND2X2 U2 ( .A(n1), .B(n3), .Z(cout) );
  CND2X1 U3 ( .A(Cin), .B(cout1), .Z(n1) );
  CND2X2 U4 ( .A(n4), .B(cout0), .Z(n3) );
endmodule


module CSA4_10 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_80 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_79 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_78 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_77 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_76 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_75 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_74 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_73 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_10 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n1) );
  mux_carry_10 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4)
         );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
endmodule


module FA_72 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_71 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_70 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_69 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_68 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_67 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_66 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_65 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_9 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_9 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X1 U1 ( .A(cout1), .B(Cin), .Z(n1) );
  CND2X2 U2 ( .A(cout0), .B(n4), .Z(n3) );
  CND2X4 U3 ( .A(n1), .B(n3), .Z(cout) );
  CIVX2 U4 ( .A(Cin), .Z(n4) );
endmodule


module CSA4_9 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_72 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_71 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_70 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_69 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_68 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_67 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_66 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_65 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_9 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n1) );
  mux_carry_9 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
endmodule


module FA_64 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_63 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_62 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_61 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_60 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_59 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_58 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_57 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_8 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_8 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4, n5;

  CIVX2 U1 ( .A(Cin), .Z(n5) );
  CND2IX1 U2 ( .B(n1), .A(Cin), .Z(n3) );
  CIVX20 U3 ( .A(cout1), .Z(n1) );
  CND2X2 U4 ( .A(n5), .B(cout0), .Z(n4) );
  CND2X2 U5 ( .A(n4), .B(n3), .Z(cout) );
endmodule


module CSA4_8 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_64 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_63 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_62 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_61 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_60 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_59 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_58 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_57 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_8 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_8 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
endmodule


module FA_56 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_55 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_54 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_53 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_52 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_51 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_50 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_49 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_7 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U4 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_7 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n2, n3, n4;

  CIVX2 U1 ( .A(Cin), .Z(n2) );
  CNIVX1 U2 ( .A(Cin), .Z(n1) );
  COND2X2 U3 ( .A(n3), .B(n2), .C(n1), .D(n4), .Z(cout) );
  CIVX20 U4 ( .A(cout1), .Z(n3) );
  CIVX20 U5 ( .A(cout0), .Z(n4) );
endmodule


module CSA4_7 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_56 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_55 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_54 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_53 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_52 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_51 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_50 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_49 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_7 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n1) );
  mux_carry_7 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
endmodule


module FA_48 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_47 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_46 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_45 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_44 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_43 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_42 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_41 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2X2 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_6 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_6 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4, n5;

  CND2X2 U1 ( .A(n4), .B(n3), .Z(cout) );
  CND2IX1 U2 ( .B(n1), .A(Cin), .Z(n3) );
  CIVX20 U3 ( .A(cout1), .Z(n1) );
  CND2X2 U4 ( .A(n5), .B(cout0), .Z(n4) );
  CIVX2 U5 ( .A(Cin), .Z(n5) );
endmodule


module CSA4_6 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_48 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_47 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_46 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_45 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_44 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_43 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_42 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_41 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_6 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n1) );
  mux_carry_6 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CDLY1XL U3 ( .A(cin_4), .Z(n1) );
endmodule


module FA_40 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_39 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_38 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_37 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_36 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_35 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_34 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_33 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_5 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CAOR2XL U1 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U2 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U3 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U4 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
  CIVXL U5 ( .A(Cin), .Z(n1) );
endmodule


module mux_carry_5 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X1 U1 ( .A(Cin), .B(cout1), .Z(n1) );
  CND2X2 U2 ( .A(n4), .B(cout0), .Z(n3) );
  CND2X2 U3 ( .A(n1), .B(n3), .Z(cout) );
  CIVX2 U4 ( .A(Cin), .Z(n4) );
endmodule


module CSA4_5 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1, n2, n3;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_40 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_39 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_38 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_37 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_36 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_35 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_34 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_33 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_5 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n3) );
  mux_carry_5 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CDLY1X2 U3 ( .A(cin_4), .Z(n1) );
  CIVXL U4 ( .A(n1), .Z(n2) );
  CIVX1 U5 ( .A(n2), .Z(n3) );
endmodule


module FA_32 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_31 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_30 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_29 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_28 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_27 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_26 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_25 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2X2 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_4 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_4 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CND2X2 U1 ( .A(n3), .B(n1), .Z(cout) );
  CIVX2 U2 ( .A(Cin), .Z(n4) );
  CND2X2 U3 ( .A(n4), .B(cout0), .Z(n3) );
  CND2X1 U4 ( .A(Cin), .B(cout1), .Z(n1) );
endmodule


module CSA4_4 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1, n2;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_32 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_31 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_30 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_29 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_28 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_27 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_26 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_25 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_4 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n2) );
  mux_carry_4 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CIVXL U3 ( .A(cin_4), .Z(n1) );
  CIVX2 U4 ( .A(n1), .Z(n2) );
endmodule


module FA_24 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_23 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_22 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_21 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_20 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_19 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_18 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_17 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_3 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
  CAOR2XL U3 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U4 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U5 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
endmodule


module mux_carry_3 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4;

  CIVX2 U1 ( .A(Cin), .Z(n4) );
  CND2X1 U2 ( .A(Cin), .B(cout1), .Z(n1) );
  CND2X2 U3 ( .A(n4), .B(cout0), .Z(n3) );
  CND2X2 U4 ( .A(n3), .B(n1), .Z(cout) );
endmodule


module CSA4_3 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1, n1, n2;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_24 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_23 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_22 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_21 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_20 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_19 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_18 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_17 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_3 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(n2) );
  mux_carry_3 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
  CIVXL U3 ( .A(cin_4), .Z(n1) );
  CIVX1 U4 ( .A(n1), .Z(n2) );
endmodule


module FA_16 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_15 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_14 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_13 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_12 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_11 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_10 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_9 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
  CAOR2X2 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
endmodule


module mux_sum_2 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1;

  CIVXL U1 ( .A(Cin), .Z(n1) );
  CAOR2XL U2 ( .A(sum1[0]), .B(Cin), .C(sum0[0]), .D(n1), .Z(sum[0]) );
  CAOR2XL U3 ( .A(sum1[1]), .B(Cin), .C(sum0[1]), .D(n1), .Z(sum[1]) );
  CAOR2XL U4 ( .A(sum1[2]), .B(Cin), .C(sum0[2]), .D(n1), .Z(sum[2]) );
  CAOR2XL U5 ( .A(sum1[3]), .B(Cin), .C(sum0[3]), .D(n1), .Z(sum[3]) );
endmodule


module mux_carry_2 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1, n3, n4, n5, n6;

  CND2X2 U1 ( .A(n4), .B(n5), .Z(cout) );
  CND2IX2 U2 ( .B(n1), .A(n6), .Z(n5) );
  CIVX20 U3 ( .A(cout0), .Z(n1) );
  CND2IX1 U4 ( .B(n3), .A(Cin), .Z(n4) );
  CIVX20 U5 ( .A(cout1), .Z(n3) );
  CIVX2 U6 ( .A(Cin), .Z(n6) );
endmodule


module CSA4_2 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_16 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_15 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_14 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_13 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_12 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_11 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_10 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_9 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_2 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_2 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
endmodule


module FA_8 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_7 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_6 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_5 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_4 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_3 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_2 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module FA_1 ( sum_fa, cout_fa, op1_fa, op2_fa, cin );
  input op1_fa, op2_fa, cin;
  output sum_fa, cout_fa;
  wire   n2;

  CEOX1 U1 ( .A(op2_fa), .B(n2), .Z(sum_fa) );
  CAOR2X1 U2 ( .A(op1_fa), .B(cin), .C(n2), .D(op2_fa), .Z(cout_fa) );
  CEOX1 U3 ( .A(op1_fa), .B(cin), .Z(n2) );
endmodule


module mux_sum_1 ( sum, sum0, sum1, Cin );
  output [3:0] sum;
  input [3:0] sum0;
  input [3:0] sum1;
  input Cin;
  wire   n1, n3, n4;

  CAOR2X1 U2 ( .A(Cin), .B(sum1[2]), .C(n4), .D(sum0[2]), .Z(sum[2]) );
  CAOR2X1 U3 ( .A(Cin), .B(sum1[1]), .C(n4), .D(sum0[1]), .Z(sum[1]) );
  CAOR2X1 U4 ( .A(Cin), .B(sum1[0]), .C(n4), .D(sum0[0]), .Z(sum[0]) );
  CIVX1 U1 ( .A(Cin), .Z(n4) );
  COND2XL U5 ( .A(n4), .B(n1), .C(n3), .D(Cin), .Z(sum[3]) );
  CIVX20 U6 ( .A(sum1[3]), .Z(n1) );
  CIVX20 U7 ( .A(sum0[3]), .Z(n3) );
endmodule


module mux_carry_1 ( cout, cout0, cout1, Cin );
  input cout0, cout1, Cin;
  output cout;
  wire   n1;

  CAOR2X1 U1 ( .A(Cin), .B(cout1), .C(n1), .D(cout0), .Z(cout) );
  CIVXL U2 ( .A(Cin), .Z(n1) );
endmodule


module CSA4_1 ( sum_4, cout_4, op1_4, op2_4, cin_4 );
  output [3:0] sum_4;
  input [3:0] op1_4;
  input [3:0] op2_4;
  input cin_4;
  output cout_4;
  wire   c1, c2, c3, cout0, c4, c5, c6, cout1;
  wire   [3:0] sum0;
  wire   [3:0] sum1;

  FA_8 f1 ( .sum_fa(sum0[0]), .cout_fa(c1), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b0) );
  FA_7 f2 ( .sum_fa(sum0[1]), .cout_fa(c2), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c1) );
  FA_6 f3 ( .sum_fa(sum0[2]), .cout_fa(c3), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c2) );
  FA_5 f4 ( .sum_fa(sum0[3]), .cout_fa(cout0), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c3) );
  FA_4 f5 ( .sum_fa(sum1[0]), .cout_fa(c4), .op1_fa(op1_4[0]), .op2_fa(
        op2_4[0]), .cin(1'b1) );
  FA_3 f6 ( .sum_fa(sum1[1]), .cout_fa(c5), .op1_fa(op1_4[1]), .op2_fa(
        op2_4[1]), .cin(c4) );
  FA_2 f7 ( .sum_fa(sum1[2]), .cout_fa(c6), .op1_fa(op1_4[2]), .op2_fa(
        op2_4[2]), .cin(c5) );
  FA_1 f8 ( .sum_fa(sum1[3]), .cout_fa(cout1), .op1_fa(op1_4[3]), .op2_fa(
        op2_4[3]), .cin(c6) );
  mux_sum_1 m1 ( .sum(sum_4), .sum0(sum0), .sum1(sum1), .Cin(cin_4) );
  mux_carry_1 m2 ( .cout(cout_4), .cout0(cout0), .cout1(cout1), .Cin(cin_4) );
endmodule


module CSA64EQG ( sum, crout, op1, op2, clock, reset );
  output [63:0] sum;
  input [63:0] op1;
  input [63:0] op2;
  input clock, reset;
  output crout;
  wire   C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15,
         croutf, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56,
         n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84,
         n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98,
         n99, n100, n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
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
         n254, n255, n256, n257, n266;
  wire   [63:0] sumf;
  wire   [63:0] op1f;
  wire   [63:0] op2f;

  CSA4_0 s1 ( .sum_4(sumf[3:0]), .cout_4(C1), .op1_4(op1f[3:0]), .op2_4(
        op2f[3:0]), .cin_4(1'b0) );
  CSA4_15 s2 ( .sum_4(sumf[7:4]), .cout_4(C2), .op1_4(op1f[7:4]), .op2_4(
        op2f[7:4]), .cin_4(C1) );
  CSA4_14 s3 ( .sum_4(sumf[11:8]), .cout_4(C3), .op1_4(op1f[11:8]), .op2_4(
        op2f[11:8]), .cin_4(C2) );
  CSA4_13 s4 ( .sum_4(sumf[15:12]), .cout_4(C4), .op1_4(op1f[15:12]), .op2_4(
        op2f[15:12]), .cin_4(C3) );
  CSA4_12 s5 ( .sum_4(sumf[19:16]), .cout_4(C5), .op1_4(op1f[19:16]), .op2_4(
        op2f[19:16]), .cin_4(C4) );
  CSA4_11 s6 ( .sum_4(sumf[23:20]), .cout_4(C6), .op1_4(op1f[23:20]), .op2_4(
        op2f[23:20]), .cin_4(C5) );
  CSA4_10 s7 ( .sum_4(sumf[27:24]), .cout_4(C7), .op1_4(op1f[27:24]), .op2_4(
        op2f[27:24]), .cin_4(C6) );
  CSA4_9 s8 ( .sum_4(sumf[31:28]), .cout_4(C8), .op1_4(op1f[31:28]), .op2_4(
        op2f[31:28]), .cin_4(C7) );
  CSA4_8 s9 ( .sum_4(sumf[35:32]), .cout_4(C9), .op1_4(op1f[35:32]), .op2_4(
        op2f[35:32]), .cin_4(C8) );
  CSA4_7 s10 ( .sum_4(sumf[39:36]), .cout_4(C10), .op1_4(op1f[39:36]), .op2_4(
        op2f[39:36]), .cin_4(C9) );
  CSA4_6 s11 ( .sum_4(sumf[43:40]), .cout_4(C11), .op1_4(op1f[43:40]), .op2_4(
        op2f[43:40]), .cin_4(C10) );
  CSA4_5 s12 ( .sum_4(sumf[47:44]), .cout_4(C12), .op1_4(op1f[47:44]), .op2_4(
        op2f[47:44]), .cin_4(C11) );
  CSA4_4 s13 ( .sum_4(sumf[51:48]), .cout_4(C13), .op1_4(op1f[51:48]), .op2_4(
        op2f[51:48]), .cin_4(C12) );
  CSA4_3 s14 ( .sum_4(sumf[55:52]), .cout_4(C14), .op1_4(op1f[55:52]), .op2_4(
        op2f[55:52]), .cin_4(C13) );
  CSA4_2 s15 ( .sum_4(sumf[59:56]), .cout_4(C15), .op1_4(op1f[59:56]), .op2_4(
        op2f[59:56]), .cin_4(C14) );
  CSA4_1 s16 ( .sum_4(sumf[63:60]), .cout_4(croutf), .op1_4(op1f[63:60]), 
        .op2_4(op2f[63:60]), .cin_4(C15) );
  CFD2X2 \sum_reg[62]  ( .D(sumf[62]), .CP(clock), .CD(n266), .Q(sum[62]) );
  CFD2X2 \sum_reg[61]  ( .D(sumf[61]), .CP(clock), .CD(n266), .Q(sum[61]) );
  CFD2X2 \sum_reg[60]  ( .D(sumf[60]), .CP(clock), .CD(n266), .Q(sum[60]) );
  CFD2X2 crout_reg ( .D(croutf), .CP(clock), .CD(n266), .Q(crout) );
  CFD2QX1 \op1f_reg[6]  ( .D(n2), .CP(clock), .CD(n1), .Q(op1f[6]) );
  CFD2QX1 \op2f_reg[63]  ( .D(n6), .CP(clock), .CD(n1), .Q(op2f[63]) );
  CFD2QX1 \op2f_reg[62]  ( .D(n8), .CP(clock), .CD(n1), .Q(op2f[62]) );
  CFD2QX1 \op2f_reg[61]  ( .D(n10), .CP(clock), .CD(n1), .Q(op2f[61]) );
  CFD2QX1 \op2f_reg[60]  ( .D(n12), .CP(clock), .CD(n1), .Q(op2f[60]) );
  CFD2QX1 \op2f_reg[59]  ( .D(n14), .CP(clock), .CD(n1), .Q(op2f[59]) );
  CFD2QX1 \op2f_reg[58]  ( .D(n16), .CP(clock), .CD(n1), .Q(op2f[58]) );
  CFD2QX1 \op2f_reg[57]  ( .D(n18), .CP(clock), .CD(n1), .Q(op2f[57]) );
  CFD2QX1 \op2f_reg[56]  ( .D(n20), .CP(clock), .CD(n1), .Q(op2f[56]) );
  CFD2QX1 \op2f_reg[55]  ( .D(n22), .CP(clock), .CD(n1), .Q(op2f[55]) );
  CFD2QX1 \op2f_reg[54]  ( .D(n24), .CP(clock), .CD(n1), .Q(op2f[54]) );
  CFD2QX1 \op2f_reg[53]  ( .D(n26), .CP(clock), .CD(n1), .Q(op2f[53]) );
  CFD2QX1 \op2f_reg[52]  ( .D(n28), .CP(clock), .CD(n1), .Q(op2f[52]) );
  CFD2QX1 \op2f_reg[51]  ( .D(n30), .CP(clock), .CD(n1), .Q(op2f[51]) );
  CFD2QX1 \op2f_reg[50]  ( .D(n32), .CP(clock), .CD(n1), .Q(op2f[50]) );
  CFD2QX1 \op2f_reg[49]  ( .D(n34), .CP(clock), .CD(n1), .Q(op2f[49]) );
  CFD2QX1 \op2f_reg[48]  ( .D(n36), .CP(clock), .CD(n1), .Q(op2f[48]) );
  CFD2QX1 \op2f_reg[47]  ( .D(n38), .CP(clock), .CD(n1), .Q(op2f[47]) );
  CFD2QX1 \op2f_reg[46]  ( .D(n40), .CP(clock), .CD(n1), .Q(op2f[46]) );
  CFD2QX1 \op2f_reg[45]  ( .D(n42), .CP(clock), .CD(n1), .Q(op2f[45]) );
  CFD2QX1 \op2f_reg[44]  ( .D(n44), .CP(clock), .CD(n1), .Q(op2f[44]) );
  CFD2QX1 \op2f_reg[43]  ( .D(n46), .CP(clock), .CD(n1), .Q(op2f[43]) );
  CFD2QX1 \op2f_reg[42]  ( .D(n48), .CP(clock), .CD(n1), .Q(op2f[42]) );
  CFD2QX1 \op2f_reg[41]  ( .D(n50), .CP(clock), .CD(n1), .Q(op2f[41]) );
  CFD2QX1 \op2f_reg[40]  ( .D(n52), .CP(clock), .CD(n1), .Q(op2f[40]) );
  CFD2QX1 \op2f_reg[39]  ( .D(n54), .CP(clock), .CD(n1), .Q(op2f[39]) );
  CFD2QX1 \op2f_reg[38]  ( .D(n56), .CP(clock), .CD(n1), .Q(op2f[38]) );
  CFD2QX1 \op2f_reg[37]  ( .D(n58), .CP(clock), .CD(n1), .Q(op2f[37]) );
  CFD2QX1 \op2f_reg[36]  ( .D(n60), .CP(clock), .CD(n1), .Q(op2f[36]) );
  CFD2QX1 \op2f_reg[35]  ( .D(n62), .CP(clock), .CD(n1), .Q(op2f[35]) );
  CFD2QX1 \op2f_reg[34]  ( .D(n64), .CP(clock), .CD(n1), .Q(op2f[34]) );
  CFD2QX1 \op2f_reg[33]  ( .D(n66), .CP(clock), .CD(n1), .Q(op2f[33]) );
  CFD2QX1 \op2f_reg[32]  ( .D(n68), .CP(clock), .CD(n1), .Q(op2f[32]) );
  CFD2QX1 \op2f_reg[31]  ( .D(n70), .CP(clock), .CD(n1), .Q(op2f[31]) );
  CFD2QX1 \op2f_reg[30]  ( .D(n72), .CP(clock), .CD(n1), .Q(op2f[30]) );
  CFD2QX1 \op2f_reg[29]  ( .D(n74), .CP(clock), .CD(n1), .Q(op2f[29]) );
  CFD2QX1 \op2f_reg[28]  ( .D(n76), .CP(clock), .CD(n1), .Q(op2f[28]) );
  CFD2QX1 \op2f_reg[27]  ( .D(n78), .CP(clock), .CD(n1), .Q(op2f[27]) );
  CFD2QX1 \op2f_reg[26]  ( .D(n80), .CP(clock), .CD(n1), .Q(op2f[26]) );
  CFD2QX1 \op2f_reg[25]  ( .D(n82), .CP(clock), .CD(n1), .Q(op2f[25]) );
  CFD2QX1 \op2f_reg[24]  ( .D(n84), .CP(clock), .CD(n1), .Q(op2f[24]) );
  CFD2QX1 \op2f_reg[23]  ( .D(n86), .CP(clock), .CD(n1), .Q(op2f[23]) );
  CFD2QX1 \op2f_reg[22]  ( .D(n88), .CP(clock), .CD(n1), .Q(op2f[22]) );
  CFD2QX1 \op2f_reg[21]  ( .D(n90), .CP(clock), .CD(n1), .Q(op2f[21]) );
  CFD2QX1 \op2f_reg[20]  ( .D(n92), .CP(clock), .CD(n1), .Q(op2f[20]) );
  CFD2QX1 \op2f_reg[19]  ( .D(n94), .CP(clock), .CD(n1), .Q(op2f[19]) );
  CFD2QX1 \op2f_reg[18]  ( .D(n96), .CP(clock), .CD(n1), .Q(op2f[18]) );
  CFD2QX1 \op2f_reg[17]  ( .D(n98), .CP(clock), .CD(n1), .Q(op2f[17]) );
  CFD2QX1 \op2f_reg[16]  ( .D(n100), .CP(clock), .CD(n1), .Q(op2f[16]) );
  CFD2QX1 \op2f_reg[15]  ( .D(n102), .CP(clock), .CD(n1), .Q(op2f[15]) );
  CFD2QX1 \op2f_reg[14]  ( .D(n104), .CP(clock), .CD(n1), .Q(op2f[14]) );
  CFD2QX1 \op2f_reg[13]  ( .D(n106), .CP(clock), .CD(n1), .Q(op2f[13]) );
  CFD2QX1 \op2f_reg[12]  ( .D(n108), .CP(clock), .CD(n1), .Q(op2f[12]) );
  CFD2QX1 \op2f_reg[11]  ( .D(n110), .CP(clock), .CD(n1), .Q(op2f[11]) );
  CFD2QX1 \op2f_reg[10]  ( .D(n112), .CP(clock), .CD(n1), .Q(op2f[10]) );
  CFD2QX1 \op2f_reg[9]  ( .D(n114), .CP(clock), .CD(n1), .Q(op2f[9]) );
  CFD2QX1 \op2f_reg[8]  ( .D(n116), .CP(clock), .CD(n1), .Q(op2f[8]) );
  CFD2QX1 \op2f_reg[7]  ( .D(n118), .CP(clock), .CD(n1), .Q(op2f[7]) );
  CFD2QX1 \op2f_reg[5]  ( .D(n120), .CP(clock), .CD(n1), .Q(op2f[5]) );
  CFD2QX1 \op2f_reg[4]  ( .D(n122), .CP(clock), .CD(n1), .Q(op2f[4]) );
  CFD2QX1 \op2f_reg[3]  ( .D(n124), .CP(clock), .CD(n1), .Q(op2f[3]) );
  CFD2QX1 \op2f_reg[2]  ( .D(n126), .CP(clock), .CD(n1), .Q(op2f[2]) );
  CFD2QX1 \op2f_reg[1]  ( .D(n128), .CP(clock), .CD(n1), .Q(op2f[1]) );
  CFD2QX1 \op2f_reg[0]  ( .D(n130), .CP(clock), .CD(n1), .Q(op2f[0]) );
  CFD2QX1 \op1f_reg[63]  ( .D(n132), .CP(clock), .CD(n1), .Q(op1f[63]) );
  CFD2QX1 \op1f_reg[62]  ( .D(n134), .CP(clock), .CD(n1), .Q(op1f[62]) );
  CFD2QX1 \op1f_reg[61]  ( .D(n136), .CP(clock), .CD(n1), .Q(op1f[61]) );
  CFD2QX1 \op1f_reg[60]  ( .D(n138), .CP(clock), .CD(n1), .Q(op1f[60]) );
  CFD2QX1 \op1f_reg[59]  ( .D(n140), .CP(clock), .CD(n1), .Q(op1f[59]) );
  CFD2QX1 \op1f_reg[58]  ( .D(n142), .CP(clock), .CD(n1), .Q(op1f[58]) );
  CFD2QX1 \op1f_reg[57]  ( .D(n144), .CP(clock), .CD(n1), .Q(op1f[57]) );
  CFD2QX1 \op1f_reg[56]  ( .D(n146), .CP(clock), .CD(n1), .Q(op1f[56]) );
  CFD2QX1 \op1f_reg[55]  ( .D(n148), .CP(clock), .CD(n1), .Q(op1f[55]) );
  CFD2QX1 \op1f_reg[54]  ( .D(n150), .CP(clock), .CD(n1), .Q(op1f[54]) );
  CFD2QX1 \op1f_reg[53]  ( .D(n152), .CP(clock), .CD(n1), .Q(op1f[53]) );
  CFD2QX1 \op1f_reg[52]  ( .D(n154), .CP(clock), .CD(n1), .Q(op1f[52]) );
  CFD2QX1 \op1f_reg[51]  ( .D(n156), .CP(clock), .CD(n1), .Q(op1f[51]) );
  CFD2QX1 \op1f_reg[50]  ( .D(n158), .CP(clock), .CD(n1), .Q(op1f[50]) );
  CFD2QX1 \op1f_reg[49]  ( .D(n160), .CP(clock), .CD(n1), .Q(op1f[49]) );
  CFD2QX1 \op1f_reg[48]  ( .D(n162), .CP(clock), .CD(n1), .Q(op1f[48]) );
  CFD2QX1 \op1f_reg[47]  ( .D(n164), .CP(clock), .CD(n1), .Q(op1f[47]) );
  CFD2QX1 \op1f_reg[46]  ( .D(n166), .CP(clock), .CD(n1), .Q(op1f[46]) );
  CFD2QX1 \op1f_reg[45]  ( .D(n168), .CP(clock), .CD(n1), .Q(op1f[45]) );
  CFD2QX1 \op1f_reg[44]  ( .D(n170), .CP(clock), .CD(n1), .Q(op1f[44]) );
  CFD2QX1 \op1f_reg[43]  ( .D(n172), .CP(clock), .CD(n1), .Q(op1f[43]) );
  CFD2QX1 \op1f_reg[42]  ( .D(n174), .CP(clock), .CD(n1), .Q(op1f[42]) );
  CFD2QX1 \op1f_reg[41]  ( .D(n176), .CP(clock), .CD(n1), .Q(op1f[41]) );
  CFD2QX1 \op1f_reg[40]  ( .D(n178), .CP(clock), .CD(n1), .Q(op1f[40]) );
  CFD2QX1 \op1f_reg[39]  ( .D(n180), .CP(clock), .CD(n1), .Q(op1f[39]) );
  CFD2QX1 \op1f_reg[38]  ( .D(n182), .CP(clock), .CD(n1), .Q(op1f[38]) );
  CFD2QX1 \op1f_reg[37]  ( .D(n184), .CP(clock), .CD(n1), .Q(op1f[37]) );
  CFD2QX1 \op1f_reg[36]  ( .D(n186), .CP(clock), .CD(n1), .Q(op1f[36]) );
  CFD2QX1 \op1f_reg[35]  ( .D(n188), .CP(clock), .CD(n1), .Q(op1f[35]) );
  CFD2QX1 \op1f_reg[34]  ( .D(n190), .CP(clock), .CD(n1), .Q(op1f[34]) );
  CFD2QX1 \op1f_reg[33]  ( .D(n192), .CP(clock), .CD(n1), .Q(op1f[33]) );
  CFD2QX1 \op1f_reg[32]  ( .D(n194), .CP(clock), .CD(n1), .Q(op1f[32]) );
  CFD2QX1 \op1f_reg[31]  ( .D(n196), .CP(clock), .CD(n1), .Q(op1f[31]) );
  CFD2QX1 \op1f_reg[30]  ( .D(n198), .CP(clock), .CD(n1), .Q(op1f[30]) );
  CFD2QX1 \op1f_reg[29]  ( .D(n200), .CP(clock), .CD(n1), .Q(op1f[29]) );
  CFD2QX1 \op1f_reg[28]  ( .D(n202), .CP(clock), .CD(n1), .Q(op1f[28]) );
  CFD2QX1 \op1f_reg[27]  ( .D(n204), .CP(clock), .CD(n1), .Q(op1f[27]) );
  CFD2QX1 \op1f_reg[26]  ( .D(n206), .CP(clock), .CD(n1), .Q(op1f[26]) );
  CFD2QX1 \op1f_reg[25]  ( .D(n208), .CP(clock), .CD(n1), .Q(op1f[25]) );
  CFD2QX1 \op1f_reg[24]  ( .D(n210), .CP(clock), .CD(n1), .Q(op1f[24]) );
  CFD2QX1 \op1f_reg[23]  ( .D(n212), .CP(clock), .CD(n1), .Q(op1f[23]) );
  CFD2QX1 \op1f_reg[22]  ( .D(n214), .CP(clock), .CD(n1), .Q(op1f[22]) );
  CFD2QX1 \op1f_reg[21]  ( .D(n216), .CP(clock), .CD(n1), .Q(op1f[21]) );
  CFD2QX1 \op1f_reg[20]  ( .D(n218), .CP(clock), .CD(n1), .Q(op1f[20]) );
  CFD2QX1 \op1f_reg[19]  ( .D(n220), .CP(clock), .CD(n1), .Q(op1f[19]) );
  CFD2QX1 \op1f_reg[18]  ( .D(n222), .CP(clock), .CD(n1), .Q(op1f[18]) );
  CFD2QX1 \op1f_reg[17]  ( .D(n224), .CP(clock), .CD(n1), .Q(op1f[17]) );
  CFD2QX1 \op1f_reg[16]  ( .D(n226), .CP(clock), .CD(n1), .Q(op1f[16]) );
  CFD2QX1 \op1f_reg[15]  ( .D(n228), .CP(clock), .CD(n1), .Q(op1f[15]) );
  CFD2QX1 \op1f_reg[14]  ( .D(n230), .CP(clock), .CD(n1), .Q(op1f[14]) );
  CFD2QX1 \op1f_reg[13]  ( .D(n232), .CP(clock), .CD(n1), .Q(op1f[13]) );
  CFD2QX1 \op1f_reg[12]  ( .D(n234), .CP(clock), .CD(n1), .Q(op1f[12]) );
  CFD2QX1 \op1f_reg[11]  ( .D(n236), .CP(clock), .CD(n1), .Q(op1f[11]) );
  CFD2QX1 \op1f_reg[10]  ( .D(n238), .CP(clock), .CD(n1), .Q(op1f[10]) );
  CFD2QX1 \op1f_reg[9]  ( .D(n240), .CP(clock), .CD(n1), .Q(op1f[9]) );
  CFD2QX1 \op1f_reg[8]  ( .D(n242), .CP(clock), .CD(n1), .Q(op1f[8]) );
  CFD2QX1 \op1f_reg[7]  ( .D(n244), .CP(clock), .CD(n1), .Q(op1f[7]) );
  CFD2QX1 \op1f_reg[5]  ( .D(n246), .CP(clock), .CD(n1), .Q(op1f[5]) );
  CFD2QX1 \op1f_reg[4]  ( .D(n248), .CP(clock), .CD(n1), .Q(op1f[4]) );
  CFD2QX1 \op1f_reg[3]  ( .D(n250), .CP(clock), .CD(n1), .Q(op1f[3]) );
  CFD2QX1 \op1f_reg[2]  ( .D(n252), .CP(clock), .CD(n1), .Q(op1f[2]) );
  CFD2QX1 \op1f_reg[1]  ( .D(n254), .CP(clock), .CD(n1), .Q(op1f[1]) );
  CFD2QX1 \op2f_reg[6]  ( .D(n256), .CP(clock), .CD(n1), .Q(op2f[6]) );
  CFD2QX1 \sum_reg[0]  ( .D(sumf[0]), .CP(clock), .CD(n1), .Q(sum[0]) );
  CFD2QX1 \sum_reg[1]  ( .D(sumf[1]), .CP(clock), .CD(n1), .Q(sum[1]) );
  CFD2QX1 \sum_reg[5]  ( .D(sumf[5]), .CP(clock), .CD(n1), .Q(sum[5]) );
  CFD2QX1 \sum_reg[4]  ( .D(sumf[4]), .CP(clock), .CD(n1), .Q(sum[4]) );
  CFD2QX1 \sum_reg[6]  ( .D(sumf[6]), .CP(clock), .CD(n1), .Q(sum[6]) );
  CFD2QX1 \sum_reg[2]  ( .D(sumf[2]), .CP(clock), .CD(n1), .Q(sum[2]) );
  CFD2QX1 \sum_reg[3]  ( .D(sumf[3]), .CP(clock), .CD(n1), .Q(sum[3]) );
  CFD2QX1 \sum_reg[15]  ( .D(sumf[15]), .CP(clock), .CD(n1), .Q(sum[15]) );
  CFD2QX1 \sum_reg[14]  ( .D(sumf[14]), .CP(clock), .CD(n1), .Q(sum[14]) );
  CFD2QX1 \sum_reg[13]  ( .D(sumf[13]), .CP(clock), .CD(n1), .Q(sum[13]) );
  CFD2QX1 \sum_reg[12]  ( .D(sumf[12]), .CP(clock), .CD(n1), .Q(sum[12]) );
  CFD2QX1 \sum_reg[7]  ( .D(sumf[7]), .CP(clock), .CD(n1), .Q(sum[7]) );
  CFD2QX1 \sum_reg[11]  ( .D(sumf[11]), .CP(clock), .CD(n1), .Q(sum[11]) );
  CFD2QX1 \sum_reg[10]  ( .D(sumf[10]), .CP(clock), .CD(n1), .Q(sum[10]) );
  CFD2QX1 \sum_reg[9]  ( .D(sumf[9]), .CP(clock), .CD(n1), .Q(sum[9]) );
  CFD2QX1 \sum_reg[8]  ( .D(sumf[8]), .CP(clock), .CD(n1), .Q(sum[8]) );
  CFD2QX1 \sum_reg[19]  ( .D(sumf[19]), .CP(clock), .CD(n1), .Q(sum[19]) );
  CFD2QX1 \sum_reg[18]  ( .D(sumf[18]), .CP(clock), .CD(n1), .Q(sum[18]) );
  CFD2QX1 \sum_reg[17]  ( .D(sumf[17]), .CP(clock), .CD(n1), .Q(sum[17]) );
  CFD2QX1 \sum_reg[16]  ( .D(sumf[16]), .CP(clock), .CD(n1), .Q(sum[16]) );
  CFD2QX1 \sum_reg[23]  ( .D(sumf[23]), .CP(clock), .CD(n1), .Q(sum[23]) );
  CFD2QX1 \sum_reg[22]  ( .D(sumf[22]), .CP(clock), .CD(n1), .Q(sum[22]) );
  CFD2QX1 \sum_reg[21]  ( .D(sumf[21]), .CP(clock), .CD(n1), .Q(sum[21]) );
  CFD2QX1 \sum_reg[20]  ( .D(sumf[20]), .CP(clock), .CD(n1), .Q(sum[20]) );
  CFD2QX1 \sum_reg[35]  ( .D(sumf[35]), .CP(clock), .CD(n1), .Q(sum[35]) );
  CFD2QX1 \sum_reg[34]  ( .D(sumf[34]), .CP(clock), .CD(n1), .Q(sum[34]) );
  CFD2QX1 \sum_reg[33]  ( .D(sumf[33]), .CP(clock), .CD(n1), .Q(sum[33]) );
  CFD2QX1 \sum_reg[32]  ( .D(sumf[32]), .CP(clock), .CD(n1), .Q(sum[32]) );
  CFD2QX1 \sum_reg[27]  ( .D(sumf[27]), .CP(clock), .CD(n1), .Q(sum[27]) );
  CFD2QX1 \sum_reg[26]  ( .D(sumf[26]), .CP(clock), .CD(n1), .Q(sum[26]) );
  CFD2QX1 \sum_reg[25]  ( .D(sumf[25]), .CP(clock), .CD(n1), .Q(sum[25]) );
  CFD2QX1 \sum_reg[24]  ( .D(sumf[24]), .CP(clock), .CD(n1), .Q(sum[24]) );
  CFD2QX1 \sum_reg[31]  ( .D(sumf[31]), .CP(clock), .CD(n1), .Q(sum[31]) );
  CFD2QX1 \sum_reg[30]  ( .D(sumf[30]), .CP(clock), .CD(n1), .Q(sum[30]) );
  CFD2QX1 \sum_reg[29]  ( .D(sumf[29]), .CP(clock), .CD(n1), .Q(sum[29]) );
  CFD2QX1 \sum_reg[28]  ( .D(sumf[28]), .CP(clock), .CD(n1), .Q(sum[28]) );
  CFD2QX1 \sum_reg[39]  ( .D(sumf[39]), .CP(clock), .CD(n1), .Q(sum[39]) );
  CFD2QX1 \sum_reg[38]  ( .D(sumf[38]), .CP(clock), .CD(n1), .Q(sum[38]) );
  CFD2QX1 \sum_reg[37]  ( .D(sumf[37]), .CP(clock), .CD(n1), .Q(sum[37]) );
  CFD2QX1 \sum_reg[36]  ( .D(sumf[36]), .CP(clock), .CD(n1), .Q(sum[36]) );
  CFD2QX1 \sum_reg[51]  ( .D(sumf[51]), .CP(clock), .CD(n1), .Q(sum[51]) );
  CFD2QX1 \sum_reg[50]  ( .D(sumf[50]), .CP(clock), .CD(n1), .Q(sum[50]) );
  CFD2QX1 \sum_reg[49]  ( .D(sumf[49]), .CP(clock), .CD(n1), .Q(sum[49]) );
  CFD2QX1 \sum_reg[48]  ( .D(sumf[48]), .CP(clock), .CD(n1), .Q(sum[48]) );
  CFD2QX1 \sum_reg[43]  ( .D(sumf[43]), .CP(clock), .CD(n1), .Q(sum[43]) );
  CFD2QX1 \sum_reg[42]  ( .D(sumf[42]), .CP(clock), .CD(n1), .Q(sum[42]) );
  CFD2QX1 \sum_reg[41]  ( .D(sumf[41]), .CP(clock), .CD(n1), .Q(sum[41]) );
  CFD2QX1 \sum_reg[40]  ( .D(sumf[40]), .CP(clock), .CD(n1), .Q(sum[40]) );
  CFD2QX1 \sum_reg[55]  ( .D(sumf[55]), .CP(clock), .CD(n1), .Q(sum[55]) );
  CFD2QX1 \sum_reg[54]  ( .D(sumf[54]), .CP(clock), .CD(n1), .Q(sum[54]) );
  CFD2QX1 \sum_reg[53]  ( .D(sumf[53]), .CP(clock), .CD(n1), .Q(sum[53]) );
  CFD2QX1 \sum_reg[52]  ( .D(sumf[52]), .CP(clock), .CD(n1), .Q(sum[52]) );
  CFD2QX1 \sum_reg[59]  ( .D(sumf[59]), .CP(clock), .CD(n1), .Q(sum[59]) );
  CFD2QX1 \sum_reg[58]  ( .D(sumf[58]), .CP(clock), .CD(n1), .Q(sum[58]) );
  CFD2QX1 \sum_reg[57]  ( .D(sumf[57]), .CP(clock), .CD(n1), .Q(sum[57]) );
  CFD2QX1 \sum_reg[56]  ( .D(sumf[56]), .CP(clock), .CD(n1), .Q(sum[56]) );
  CFD2QX1 \sum_reg[63]  ( .D(sumf[63]), .CP(clock), .CD(n1), .Q(sum[63]) );
  CFD2QX1 \sum_reg[47]  ( .D(sumf[47]), .CP(clock), .CD(n1), .Q(sum[47]) );
  CFD2QX1 \sum_reg[46]  ( .D(sumf[46]), .CP(clock), .CD(n1), .Q(sum[46]) );
  CFD2QX1 \sum_reg[45]  ( .D(sumf[45]), .CP(clock), .CD(n1), .Q(sum[45]) );
  CFD2QX1 \sum_reg[44]  ( .D(sumf[44]), .CP(clock), .CD(n1), .Q(sum[44]) );
  CFD2QX2 \op1f_reg[0]  ( .D(n4), .CP(clock), .CD(n1), .Q(op1f[0]) );
  CDLY1XL U4 ( .A(op1[6]), .Z(n3) );
  CNIVX1 U5 ( .A(n3), .Z(n2) );
  CDLY1XL U6 ( .A(op1[0]), .Z(n5) );
  CNIVX1 U7 ( .A(n5), .Z(n4) );
  CDLY1XL U8 ( .A(op2[63]), .Z(n7) );
  CNIVX1 U9 ( .A(n7), .Z(n6) );
  CDLY1XL U10 ( .A(op2[62]), .Z(n9) );
  CNIVX1 U11 ( .A(n9), .Z(n8) );
  CDLY1XL U12 ( .A(op2[61]), .Z(n11) );
  CNIVX1 U13 ( .A(n11), .Z(n10) );
  CDLY1XL U14 ( .A(op2[60]), .Z(n13) );
  CNIVX1 U15 ( .A(n13), .Z(n12) );
  CDLY1XL U16 ( .A(op2[59]), .Z(n15) );
  CNIVX1 U17 ( .A(n15), .Z(n14) );
  CDLY1XL U18 ( .A(op2[58]), .Z(n17) );
  CNIVX1 U19 ( .A(n17), .Z(n16) );
  CDLY1XL U20 ( .A(op2[57]), .Z(n19) );
  CNIVX1 U21 ( .A(n19), .Z(n18) );
  CDLY1XL U22 ( .A(op2[56]), .Z(n21) );
  CNIVX1 U23 ( .A(n21), .Z(n20) );
  CDLY1XL U24 ( .A(op2[55]), .Z(n23) );
  CNIVX1 U25 ( .A(n23), .Z(n22) );
  CDLY1XL U26 ( .A(op2[54]), .Z(n25) );
  CNIVX1 U27 ( .A(n25), .Z(n24) );
  CDLY1XL U28 ( .A(op2[53]), .Z(n27) );
  CNIVX1 U29 ( .A(n27), .Z(n26) );
  CDLY1XL U30 ( .A(op2[52]), .Z(n29) );
  CNIVX1 U31 ( .A(n29), .Z(n28) );
  CDLY1XL U32 ( .A(op2[51]), .Z(n31) );
  CNIVX1 U33 ( .A(n31), .Z(n30) );
  CDLY1XL U34 ( .A(op2[50]), .Z(n33) );
  CNIVX1 U35 ( .A(n33), .Z(n32) );
  CDLY1XL U36 ( .A(op2[49]), .Z(n35) );
  CNIVX1 U37 ( .A(n35), .Z(n34) );
  CDLY1XL U38 ( .A(op2[48]), .Z(n37) );
  CNIVX1 U39 ( .A(n37), .Z(n36) );
  CDLY1XL U40 ( .A(op2[47]), .Z(n39) );
  CNIVX1 U41 ( .A(n39), .Z(n38) );
  CDLY1XL U42 ( .A(op2[46]), .Z(n41) );
  CNIVX1 U43 ( .A(n41), .Z(n40) );
  CDLY1XL U44 ( .A(op2[45]), .Z(n43) );
  CNIVX1 U45 ( .A(n43), .Z(n42) );
  CDLY1XL U46 ( .A(op2[44]), .Z(n45) );
  CNIVX1 U47 ( .A(n45), .Z(n44) );
  CDLY1XL U48 ( .A(op2[43]), .Z(n47) );
  CNIVX1 U49 ( .A(n47), .Z(n46) );
  CDLY1XL U50 ( .A(op2[42]), .Z(n49) );
  CNIVX1 U51 ( .A(n49), .Z(n48) );
  CDLY1XL U52 ( .A(op2[41]), .Z(n51) );
  CNIVX1 U53 ( .A(n51), .Z(n50) );
  CDLY1XL U54 ( .A(op2[40]), .Z(n53) );
  CNIVX1 U55 ( .A(n53), .Z(n52) );
  CDLY1XL U56 ( .A(op2[39]), .Z(n55) );
  CNIVX1 U57 ( .A(n55), .Z(n54) );
  CDLY1XL U58 ( .A(op2[38]), .Z(n57) );
  CNIVX1 U59 ( .A(n57), .Z(n56) );
  CDLY1XL U60 ( .A(op2[37]), .Z(n59) );
  CNIVX1 U61 ( .A(n59), .Z(n58) );
  CDLY1XL U62 ( .A(op2[36]), .Z(n61) );
  CNIVX1 U63 ( .A(n61), .Z(n60) );
  CDLY1XL U64 ( .A(op2[35]), .Z(n63) );
  CNIVX1 U65 ( .A(n63), .Z(n62) );
  CDLY1XL U66 ( .A(op2[34]), .Z(n65) );
  CNIVX1 U67 ( .A(n65), .Z(n64) );
  CDLY1XL U68 ( .A(op2[33]), .Z(n67) );
  CNIVX1 U69 ( .A(n67), .Z(n66) );
  CDLY1XL U70 ( .A(op2[32]), .Z(n69) );
  CNIVX1 U71 ( .A(n69), .Z(n68) );
  CDLY1XL U72 ( .A(op2[31]), .Z(n71) );
  CNIVX1 U73 ( .A(n71), .Z(n70) );
  CDLY1XL U74 ( .A(op2[30]), .Z(n73) );
  CNIVX1 U75 ( .A(n73), .Z(n72) );
  CDLY1XL U76 ( .A(op2[29]), .Z(n75) );
  CNIVX1 U77 ( .A(n75), .Z(n74) );
  CDLY1XL U78 ( .A(op2[28]), .Z(n77) );
  CNIVX1 U79 ( .A(n77), .Z(n76) );
  CDLY1XL U80 ( .A(op2[27]), .Z(n79) );
  CNIVX1 U81 ( .A(n79), .Z(n78) );
  CDLY1XL U82 ( .A(op2[26]), .Z(n81) );
  CNIVX1 U83 ( .A(n81), .Z(n80) );
  CDLY1XL U84 ( .A(op2[25]), .Z(n83) );
  CNIVX1 U85 ( .A(n83), .Z(n82) );
  CDLY1XL U86 ( .A(op2[24]), .Z(n85) );
  CNIVX1 U87 ( .A(n85), .Z(n84) );
  CDLY1XL U88 ( .A(op2[23]), .Z(n87) );
  CNIVX1 U89 ( .A(n87), .Z(n86) );
  CDLY1XL U90 ( .A(op2[22]), .Z(n89) );
  CNIVX1 U91 ( .A(n89), .Z(n88) );
  CDLY1XL U92 ( .A(op2[21]), .Z(n91) );
  CNIVX1 U93 ( .A(n91), .Z(n90) );
  CDLY1XL U94 ( .A(op2[20]), .Z(n93) );
  CNIVX1 U95 ( .A(n93), .Z(n92) );
  CDLY1XL U96 ( .A(op2[19]), .Z(n95) );
  CNIVX1 U97 ( .A(n95), .Z(n94) );
  CDLY1XL U98 ( .A(op2[18]), .Z(n97) );
  CNIVX1 U99 ( .A(n97), .Z(n96) );
  CDLY1XL U100 ( .A(op2[17]), .Z(n99) );
  CNIVX1 U101 ( .A(n99), .Z(n98) );
  CDLY1XL U102 ( .A(op2[16]), .Z(n101) );
  CNIVX1 U103 ( .A(n101), .Z(n100) );
  CDLY1XL U104 ( .A(op2[15]), .Z(n103) );
  CNIVX1 U105 ( .A(n103), .Z(n102) );
  CDLY1XL U106 ( .A(op2[14]), .Z(n105) );
  CNIVX1 U107 ( .A(n105), .Z(n104) );
  CDLY1XL U108 ( .A(op2[13]), .Z(n107) );
  CNIVX1 U109 ( .A(n107), .Z(n106) );
  CDLY1XL U110 ( .A(op2[12]), .Z(n109) );
  CNIVX1 U111 ( .A(n109), .Z(n108) );
  CDLY1XL U112 ( .A(op2[11]), .Z(n111) );
  CNIVX1 U113 ( .A(n111), .Z(n110) );
  CDLY1XL U114 ( .A(op2[10]), .Z(n113) );
  CNIVX1 U115 ( .A(n113), .Z(n112) );
  CDLY1XL U116 ( .A(op2[9]), .Z(n115) );
  CNIVX1 U117 ( .A(n115), .Z(n114) );
  CDLY1XL U118 ( .A(op2[8]), .Z(n117) );
  CNIVX1 U119 ( .A(n117), .Z(n116) );
  CDLY1XL U120 ( .A(op2[7]), .Z(n119) );
  CNIVX1 U121 ( .A(n119), .Z(n118) );
  CDLY1XL U122 ( .A(op2[5]), .Z(n121) );
  CNIVX1 U123 ( .A(n121), .Z(n120) );
  CDLY1XL U124 ( .A(op2[4]), .Z(n123) );
  CNIVX1 U125 ( .A(n123), .Z(n122) );
  CDLY1XL U126 ( .A(op2[3]), .Z(n125) );
  CNIVX1 U127 ( .A(n125), .Z(n124) );
  CDLY1XL U128 ( .A(op2[2]), .Z(n127) );
  CNIVX1 U129 ( .A(n127), .Z(n126) );
  CDLY1XL U130 ( .A(op2[1]), .Z(n129) );
  CNIVX1 U131 ( .A(n129), .Z(n128) );
  CDLY1XL U132 ( .A(op2[0]), .Z(n131) );
  CNIVX1 U133 ( .A(n131), .Z(n130) );
  CDLY1XL U134 ( .A(op1[63]), .Z(n133) );
  CNIVX1 U135 ( .A(n133), .Z(n132) );
  CDLY1XL U136 ( .A(op1[62]), .Z(n135) );
  CNIVX1 U137 ( .A(n135), .Z(n134) );
  CDLY1XL U138 ( .A(op1[61]), .Z(n137) );
  CNIVX1 U139 ( .A(n137), .Z(n136) );
  CDLY1XL U140 ( .A(op1[60]), .Z(n139) );
  CNIVX1 U141 ( .A(n139), .Z(n138) );
  CDLY1XL U142 ( .A(op1[59]), .Z(n141) );
  CNIVX1 U143 ( .A(n141), .Z(n140) );
  CDLY1XL U144 ( .A(op1[58]), .Z(n143) );
  CNIVX1 U145 ( .A(n143), .Z(n142) );
  CDLY1XL U146 ( .A(op1[57]), .Z(n145) );
  CNIVX1 U147 ( .A(n145), .Z(n144) );
  CDLY1XL U148 ( .A(op1[56]), .Z(n147) );
  CNIVX1 U149 ( .A(n147), .Z(n146) );
  CDLY1XL U150 ( .A(op1[55]), .Z(n149) );
  CNIVX1 U151 ( .A(n149), .Z(n148) );
  CDLY1XL U152 ( .A(op1[54]), .Z(n151) );
  CNIVX1 U153 ( .A(n151), .Z(n150) );
  CDLY1XL U154 ( .A(op1[53]), .Z(n153) );
  CNIVX1 U155 ( .A(n153), .Z(n152) );
  CDLY1XL U156 ( .A(op1[52]), .Z(n155) );
  CNIVX1 U157 ( .A(n155), .Z(n154) );
  CDLY1XL U158 ( .A(op1[51]), .Z(n157) );
  CNIVX1 U159 ( .A(n157), .Z(n156) );
  CDLY1XL U160 ( .A(op1[50]), .Z(n159) );
  CNIVX1 U161 ( .A(n159), .Z(n158) );
  CDLY1XL U162 ( .A(op1[49]), .Z(n161) );
  CNIVX1 U163 ( .A(n161), .Z(n160) );
  CDLY1XL U164 ( .A(op1[48]), .Z(n163) );
  CNIVX1 U165 ( .A(n163), .Z(n162) );
  CDLY1XL U166 ( .A(op1[47]), .Z(n165) );
  CNIVX1 U167 ( .A(n165), .Z(n164) );
  CDLY1XL U168 ( .A(op1[46]), .Z(n167) );
  CNIVX1 U169 ( .A(n167), .Z(n166) );
  CDLY1XL U170 ( .A(op1[45]), .Z(n169) );
  CNIVX1 U171 ( .A(n169), .Z(n168) );
  CDLY1XL U172 ( .A(op1[44]), .Z(n171) );
  CNIVX1 U173 ( .A(n171), .Z(n170) );
  CDLY1XL U174 ( .A(op1[43]), .Z(n173) );
  CNIVX1 U175 ( .A(n173), .Z(n172) );
  CDLY1XL U176 ( .A(op1[42]), .Z(n175) );
  CNIVX1 U177 ( .A(n175), .Z(n174) );
  CDLY1XL U178 ( .A(op1[41]), .Z(n177) );
  CNIVX1 U179 ( .A(n177), .Z(n176) );
  CDLY1XL U180 ( .A(op1[40]), .Z(n179) );
  CNIVX1 U181 ( .A(n179), .Z(n178) );
  CDLY1XL U182 ( .A(op1[39]), .Z(n181) );
  CNIVX1 U183 ( .A(n181), .Z(n180) );
  CDLY1XL U184 ( .A(op1[38]), .Z(n183) );
  CNIVX1 U185 ( .A(n183), .Z(n182) );
  CDLY1XL U186 ( .A(op1[37]), .Z(n185) );
  CNIVX1 U187 ( .A(n185), .Z(n184) );
  CDLY1XL U188 ( .A(op1[36]), .Z(n187) );
  CNIVX1 U189 ( .A(n187), .Z(n186) );
  CDLY1XL U190 ( .A(op1[35]), .Z(n189) );
  CNIVX1 U191 ( .A(n189), .Z(n188) );
  CDLY1XL U192 ( .A(op1[34]), .Z(n191) );
  CNIVX1 U193 ( .A(n191), .Z(n190) );
  CDLY1XL U194 ( .A(op1[33]), .Z(n193) );
  CNIVX1 U195 ( .A(n193), .Z(n192) );
  CDLY1XL U196 ( .A(op1[32]), .Z(n195) );
  CNIVX1 U197 ( .A(n195), .Z(n194) );
  CDLY1XL U198 ( .A(op1[31]), .Z(n197) );
  CNIVX1 U199 ( .A(n197), .Z(n196) );
  CDLY1XL U200 ( .A(op1[30]), .Z(n199) );
  CNIVX1 U201 ( .A(n199), .Z(n198) );
  CDLY1XL U202 ( .A(op1[29]), .Z(n201) );
  CNIVX1 U203 ( .A(n201), .Z(n200) );
  CDLY1XL U204 ( .A(op1[28]), .Z(n203) );
  CNIVX1 U205 ( .A(n203), .Z(n202) );
  CDLY1XL U206 ( .A(op1[27]), .Z(n205) );
  CNIVX1 U207 ( .A(n205), .Z(n204) );
  CDLY1XL U208 ( .A(op1[26]), .Z(n207) );
  CNIVX1 U209 ( .A(n207), .Z(n206) );
  CDLY1XL U210 ( .A(op1[25]), .Z(n209) );
  CNIVX1 U211 ( .A(n209), .Z(n208) );
  CDLY1XL U212 ( .A(op1[24]), .Z(n211) );
  CNIVX1 U213 ( .A(n211), .Z(n210) );
  CDLY1XL U214 ( .A(op1[23]), .Z(n213) );
  CNIVX1 U215 ( .A(n213), .Z(n212) );
  CDLY1XL U216 ( .A(op1[22]), .Z(n215) );
  CNIVX1 U217 ( .A(n215), .Z(n214) );
  CDLY1XL U218 ( .A(op1[21]), .Z(n217) );
  CNIVX1 U219 ( .A(n217), .Z(n216) );
  CDLY1XL U220 ( .A(op1[20]), .Z(n219) );
  CNIVX1 U221 ( .A(n219), .Z(n218) );
  CDLY1XL U222 ( .A(op1[19]), .Z(n221) );
  CNIVX1 U223 ( .A(n221), .Z(n220) );
  CDLY1XL U224 ( .A(op1[18]), .Z(n223) );
  CNIVX1 U225 ( .A(n223), .Z(n222) );
  CDLY1XL U226 ( .A(op1[17]), .Z(n225) );
  CNIVX1 U227 ( .A(n225), .Z(n224) );
  CDLY1XL U228 ( .A(op1[16]), .Z(n227) );
  CNIVX1 U229 ( .A(n227), .Z(n226) );
  CDLY1XL U230 ( .A(op1[15]), .Z(n229) );
  CNIVX1 U231 ( .A(n229), .Z(n228) );
  CDLY1XL U232 ( .A(op1[14]), .Z(n231) );
  CNIVX1 U233 ( .A(n231), .Z(n230) );
  CDLY1XL U234 ( .A(op1[13]), .Z(n233) );
  CNIVX1 U235 ( .A(n233), .Z(n232) );
  CDLY1XL U236 ( .A(op1[12]), .Z(n235) );
  CNIVX1 U237 ( .A(n235), .Z(n234) );
  CDLY1XL U238 ( .A(op1[11]), .Z(n237) );
  CNIVX1 U239 ( .A(n237), .Z(n236) );
  CDLY1XL U240 ( .A(op1[10]), .Z(n239) );
  CNIVX1 U241 ( .A(n239), .Z(n238) );
  CDLY1XL U242 ( .A(op1[9]), .Z(n241) );
  CNIVX1 U243 ( .A(n241), .Z(n240) );
  CDLY1XL U244 ( .A(op1[8]), .Z(n243) );
  CNIVX1 U245 ( .A(n243), .Z(n242) );
  CDLY1XL U246 ( .A(op1[7]), .Z(n245) );
  CNIVX1 U247 ( .A(n245), .Z(n244) );
  CDLY1XL U248 ( .A(op1[5]), .Z(n247) );
  CNIVX1 U249 ( .A(n247), .Z(n246) );
  CDLY1XL U250 ( .A(op1[4]), .Z(n249) );
  CNIVX1 U251 ( .A(n249), .Z(n248) );
  CDLY1XL U252 ( .A(op1[3]), .Z(n251) );
  CNIVX1 U253 ( .A(n251), .Z(n250) );
  CDLY1XL U254 ( .A(op1[2]), .Z(n253) );
  CNIVX1 U255 ( .A(n253), .Z(n252) );
  CDLY1XL U256 ( .A(op1[1]), .Z(n255) );
  CNIVX1 U257 ( .A(n255), .Z(n254) );
  CDLY1XL U258 ( .A(op2[6]), .Z(n257) );
  CNIVX1 U259 ( .A(n257), .Z(n256) );
  CNIVX1 U260 ( .A(n1), .Z(n266) );
  CIVX8 U261 ( .A(reset), .Z(n1) );
endmodule

