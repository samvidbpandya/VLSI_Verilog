//This is the top level module

//timescale
`timescale 1ns/10ps

//module definition
module randist (
  input clk, rst, pushin,
  input [63:0] U1, U2,
  output pushout,
  output [63:0] z
  );

localparam ONE = 64'h3FF0_0000_0000_0000;

//signal declaration
wire [8:0] vin1;
wire [63:0] a1,b1,c1,d1,delta1;
wire [63:0] delta3,Ad3,Bd2,Cd,Cd_D,Bd2_Cd_D,a;
wire pushin1,pushin_d3,pushin_Ad3,pushin_Bd2,pushin_Cd,pushin_Cd_D,pushin_Bd2_Cd_D,pushin_a;
wire [9:0] vin2;
wire [63:0] a2,b2,c2,delta2;
wire [63:0] Ad2,Bd,Bd_C,sinb;
wire pushin2,pushin_Ad2,pushin_Bd,pushin_sinb;
wire [63:0] Z_1;
wire pushout_1;
reg [63:0] U11, U21;
reg [63:0] A_1,A_2,A_3,A_4,A_5,A_6,A_7,A_8,A_9,A_10,D_1,D_2,D_3,D_4,D_5,D_6,D_7,D_8,D_9,D_10,C2_1,C2_2,C2_3,C2_4,C2_5,C2_6,C2_7,C2_8,C2_9,C2_10;
reg [63:0] Bd2_1,Bd2_2,Bd2_3,Bd2_4,Ad2_1,Ad2_2,Ad2_3,Ad2_4;
reg [63:0] Bd2_Cd_D_1,Bd2_Cd_D_2;
reg [63:0] sinb_1,sinb_2,sinb_3,sinb_4,sinb_5,sinb_6,Z_11;

reg pushinA_1,pushinA_2,pushinA_3,pushinA_4,pushinA_5,pushinA_6,pushinA_7,pushinA_8,pushinA_9,pushinA_10;
reg pushinD_1,pushinD_2,pushinD_3,pushinD_4,pushinD_5,pushinD_6,pushinD_7,pushinD_8,pushinD_9,pushinD_10;
reg pushinC2_1,pushinC2_2,pushinC2_3,pushinC2_4,pushinC2_5,pushinC2_6,pushinC2_7,pushinC2_8,pushinC2_9,pushinC2_10;
reg pushin_1,pushin_2,pushin_Bd2_1,pushin_Bd2_2,pushin_Bd2_3,pushin_Bd2_4,pushin_Ad2_1,pushin_Ad2_2,pushin_Ad2_3,pushin_Ad2_4,pushin_Bd2_Cd_D_1,pushin_Bd2_Cd_D_2;
reg pushin_sinb_1,pushin_sinb_2,pushin_sinb_3,pushin_sinb_4,pushin_sinb_5,pushin_sinb_6;
reg pushout_11;

assign z = Z_11;
assign pushout = pushout_11;

//SQRTLN

//delta and corresponding A,B,C,D
vin_delta # ("u1") inst_vin_delta1 (pushin_1,U11,vin1,delta1,pushin1);
sqrtln inst_sqrt (vin1,a1,b1,c1,d1);

//delta^3
fpmul inst_fpmul_d3 (clk,rst,pushin1,delta1,delta1,delta1,pushin_d3,delta3);

//A*delta^3
fpmul inst_fpmul_Ad3 (clk,rst,pushin_d3&pushinA_10,A_10,delta3,ONE,pushin_Ad3,Ad3);

//B*delta^2
fpmul inst_fpmul_Bd2 (clk,rst,pushin1,delta1,delta1,b1,pushin_Bd2,Bd2);

//C*delta
fpmul inst_fpmul_Cd (clk,rst,pushin1,delta1,c1,ONE,pushin_Cd,Cd);

//Cdelta + D
fpadd inst_fpadd_Cd_D (clk,rst,pushin_Cd&pushinD_10,Cd,D_10,pushin_Cd_D,Cd_D);

//B*delta^2+Cdelta+D
fpadd inst_fpadd_Bd2_Cd_D
(clk,rst,pushin_Cd_D&pushin_Bd2_4,Cd_D,Bd2_4,pushin_Bd2_Cd_D,Bd2_Cd_D);

//a = A*delta^3+B*delta^2+Cdelta+D
fpadd inst_fpadd_Ad3_Bd2_Cd_D
(clk,rst,pushin_Ad3&pushin_Bd2_Cd_D_2,Ad3,Bd2_Cd_D_2,pushin_a,a);

//SINE
//delta and corresponding A,B,C
vin_delta # ("u2") inst_vin_delta2 (pushin_2,U21,vin2,delta2,pushin2);
sin_lookup inst_sin (vin2,a2,b2,c2);

//A*delta2
fpmul inst_fpmul_Ad2 (clk,rst,pushin2,a2,delta2,delta2,pushin_Ad2,Ad2);

//B*delta
fpmul inst_fpmul_Bd (clk,rst,pushin2,b2,delta2,ONE,pushin_Bd,Bd);

//Bdelta+C
fpadd inst_fpadd_Bd_C (clk,rst,pushin_Bd&pushinC2_10,Bd,C2_10,pushin_Bd_C,Bd_C);

//sinb = Adelta^2+Bdelta+C
fpadd inst_fpadd_Ad2_Bd_C (clk,rst,pushin_Bd_C&pushin_Ad2_4,Ad2_4,Bd_C,pushin_sinb,sinb);

//Final result
//a*sinb
fpmul inst_fpmul_asinb (clk,rst,pushin_sinb_6&pushin_a,a,sinb_6,ONE,pushout_1,Z_1);

always @(posedge clk or posedge rst)
if(rst)
begin 

U11 <= 0;
U21 <= 0;
pushin_1 <= 0;
pushin_2 <= 0;

A_1 <= 0;
A_2 <= 0;
A_3 <= 0;
A_4 <= 0;
A_5 <= 0;
A_6 <= 0;
A_7 <= 0;
A_8 <= 0;
A_9 <= 0;
A_10 <= 0;

pushinA_1 <= 0;
pushinA_2 <= 0;
pushinA_3 <= 0;
pushinA_4 <= 0;
pushinA_5 <= 0;
pushinA_6 <= 0;
pushinA_7 <= 0;
pushinA_8 <= 0;
pushinA_9 <= 0;
pushinA_10 <= 0;

Bd2_1 <= 0;
Bd2_2 <= 0;
Bd2_3 <= 0;
Bd2_4 <= 0;

pushin_Bd2_1 <=0;
pushin_Bd2_2 <=0;
pushin_Bd2_3 <=0;
pushin_Bd2_4 <=0;


D_1 <= 0;
D_2 <= 0;
D_3 <= 0;
D_4 <= 0;
D_5 <= 0;
D_6 <= 0;
D_7 <= 0;
D_8 <= 0;
D_9 <= 0;
D_10 <= 0;


pushinD_1 <= 0;
pushinD_2 <= 0;
pushinD_3 <= 0;
pushinD_4 <= 0;
pushinD_5 <= 0;
pushinD_6 <= 0;
pushinD_7 <= 0;
pushinD_8 <= 0;
pushinD_9 <= 0;
pushinD_10 <= 0;

Bd2_Cd_D_1 <= 0;
Bd2_Cd_D_2 <= 0;


pushin_Bd2_Cd_D_1 <= 0;
pushin_Bd2_Cd_D_2 <= 0;


C2_1 <= 0;
C2_2 <= 0;
C2_3 <= 0;
C2_4 <= 0;
C2_5 <= 0;
C2_6 <= 0;
C2_7 <= 0;
C2_8 <= 0;
C2_9 <= 0;
C2_10 <= 0;

pushinC2_1 <= 0;
pushinC2_2 <= 0;
pushinC2_3 <= 0;
pushinC2_4 <= 0;
pushinC2_5 <= 0;
pushinC2_6 <= 0;
pushinC2_7 <= 0;
pushinC2_8 <= 0;
pushinC2_9 <= 0;
pushinC2_10 <= 0;


Ad2_1 <= 0;
Ad2_2 <= 0;
Ad2_3 <= 0;
Ad2_4 <= 0;

pushin_Ad2_1 <=0;
pushin_Ad2_2 <=0;
pushin_Ad2_3 <=0;
pushin_Ad2_4 <=0;

sinb_1 <= 0;
sinb_2 <= 0;
sinb_3 <= 0;
sinb_4 <= 0;
sinb_5 <= 0;
sinb_6 <= 0;

pushin_sinb_1 <=0;
pushin_sinb_2 <=0;
pushin_sinb_3 <=0;
pushin_sinb_4 <=0;
pushin_sinb_5 <=0;
pushin_sinb_6 <=0;

Z_11 <=0;

pushout_11 <=0;
end

else begin

U11 <= #1 U1;
U21 <= #1 U2;
pushin_1 <= #1 pushin;
pushin_2 <= #1 pushin;

A_1 <=  #1 a1;
A_2 <=  #1 A_1;
A_3 <=  #1 A_2;
A_4 <=  #1 A_3;
A_5 <=  #1 A_4;
A_6 <=  #1 A_5;
A_7 <=  #1 A_6;
A_8 <=  #1 A_7;
A_9 <=  #1 A_8;
A_10 <= #1 A_9;

pushinA_1 <= #1 pushin_1;
pushinA_2 <= #1 pushinA_1;
pushinA_3 <= #1 pushinA_2;
pushinA_4 <= #1 pushinA_3;
pushinA_5 <= #1 pushinA_4;
pushinA_6 <= #1 pushinA_5;
pushinA_7 <= #1 pushinA_6;
pushinA_8 <= #1 pushinA_7;
pushinA_9 <= #1 pushinA_8;
pushinA_10 <= #1 pushinA_9;


Bd2_1 <= #1 Bd2;
Bd2_2 <= #1 Bd2_1;
Bd2_3 <= #1 Bd2_2;
Bd2_4 <= #1 Bd2_3;

pushin_Bd2_1 <= #1 pushin_Bd2;
pushin_Bd2_2 <= #1 pushin_Bd2_1;
pushin_Bd2_3 <= #1 pushin_Bd2_2;
pushin_Bd2_4 <= #1 pushin_Bd2_3;


D_1 <=  #1 d1;
D_2 <=  #1 D_1;
D_3 <=  #1 D_2;
D_4 <=  #1 D_3;
D_5 <=  #1 D_4;
D_6 <=  #1 D_5;
D_7 <=  #1 D_6;
D_8 <=  #1 D_7;
D_9 <=  #1 D_8;
D_10 <= #1 D_9;

pushinD_1 <= #1 pushin_1;
pushinD_2 <= #1 pushinD_1;
pushinD_3 <= #1 pushinD_2;
pushinD_4 <= #1 pushinD_3;
pushinD_5 <= #1 pushinD_4;
pushinD_6 <= #1 pushinD_5;
pushinD_7 <= #1 pushinD_6;
pushinD_8 <= #1 pushinD_7;
pushinD_9 <= #1 pushinD_8;
pushinD_10 <= #1 pushinD_9;



Bd2_Cd_D_1 <= #1 Bd2_Cd_D;
Bd2_Cd_D_2 <= #1 Bd2_Cd_D_1;


pushin_Bd2_Cd_D_1 <= #1 pushin_Bd2_Cd_D;
pushin_Bd2_Cd_D_2 <= #1 pushin_Bd2_Cd_D_1;



C2_1 <=  #1 c2;
C2_2 <=  #1 C2_1;
C2_3 <=  #1 C2_2;
C2_4 <=  #1 C2_3;
C2_5 <=  #1 C2_4;
C2_6 <=  #1 C2_5;
C2_7 <=  #1 C2_6;
C2_8 <=  #1 C2_7;
C2_9 <=  #1 C2_8;
C2_10 <= #1 C2_9;

pushinC2_1 <= #1 pushin_2;
pushinC2_2 <= #1 pushinC2_1;
pushinC2_3 <= #1 pushinC2_2;
pushinC2_4 <= #1 pushinC2_3;
pushinC2_5 <= #1 pushinC2_4;
pushinC2_6 <= #1 pushinC2_5;
pushinC2_7 <= #1 pushinC2_6;
pushinC2_8 <= #1 pushinC2_7;
pushinC2_9 <= #1 pushinC2_8;
pushinC2_10 <= #1 pushinC2_9;


Ad2_1 <= #1 Ad2;
Ad2_2 <= #1 Ad2_1;
Ad2_3 <= #1 Ad2_2;
Ad2_4 <= #1 Ad2_3;


pushin_Ad2_1 <= #1 pushin_Ad2;
pushin_Ad2_2 <= #1 pushin_Ad2_1;
pushin_Ad2_3 <= #1 pushin_Ad2_2;
pushin_Ad2_4 <= #1 pushin_Ad2_3;


sinb_1 <= #1 sinb;
sinb_2 <= #1 sinb_1;
sinb_3 <= #1 sinb_2;
sinb_4 <= #1 sinb_3;
sinb_5 <= #1 sinb_4;
sinb_6 <= #1 sinb_5;

pushin_sinb_1 <= #1 pushin_sinb;
pushin_sinb_2 <= #1 pushin_sinb_1;
pushin_sinb_3 <= #1 pushin_sinb_2;
pushin_sinb_4 <= #1 pushin_sinb_3;
pushin_sinb_5 <= #1 pushin_sinb_4;
pushin_sinb_6 <= #1 pushin_sinb_5;


Z_11 <= #1 Z_1;

pushout_11 <= #1 pushout_1;

end

endmodule
