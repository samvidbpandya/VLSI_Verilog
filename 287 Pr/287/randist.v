//This is the top level module

//timescale
`timescale 1ns/10ps

//module definition
module randist (
  input clk, rst, pushin,
  input [63:0] U1, U2,
  output reg pushout,
  output reg [63:0] z
  );

localparam ONE = 64'h3FF0_0000_0000_0000;

//signal declaration
reg push_r1,push_r2;
reg [63:0] u1_r1,u2_r1;
wire [9:0] vin_sqrtln,vin_sine;
wire [63:0] A_sqrtln,B_sqrtln,C_sqrtln,D_sqrtln,delta_sqrtln,A_sine,B_sine,C_sine,delta_sine;
reg [63:0] A_sqrtln_r2,B_sqrtln_r2,C_sqrtln_r2,D_sqrtln_r2,A_sine_r2,B_sine_r2,C_sine_r2,delta_sqrtln_r2,delta_sine_r2;
wire [63:0] A_sqrtln_r11,D_sqrtln_r11,d3_r11,Bd2_r11,Cd_r11,Ad2_r11,Bd_r11,C_sine_r11;
wire [63:0] Ad3_r20,Ad3_r25,Bd2_r18,Cd_D_r18,Bd2_Cd_D_r25,Ad2_r18,Bd_C_r18,sinb_r25;
wire [63:0] a_r32,sinb_r32;
wire [63:0] z_41;

//---------
//1st stage
//---------
always @ (posedge clk or posedge rst)
begin
  if (rst)
  begin
    push_r1 <= #1 1'b0;
    u1_r1 <= #1 64'b0;
    u2_r1 <= #1 64'b0;
  end
  else
  begin
    push_r1 <= #1 pushin;
    u1_r1 <= #1 U1;
    u2_r1 <= #1 U2;
  end
end

//---------
//2nd stage
//---------
//sqrtln: delta and corresponding A,B,C,D
vin_delta_sqrtln /*#("u1")*/ inst_vin_sqrtln (push_r1,u1_r1,vin_sqrtln,delta_sqrtln,push_sqrtln);
sqrtln inst_sqrt (vin_sqrtln[8:0],A_sqrtln,B_sqrtln,C_sqrtln,D_sqrtln);
//sine: delta and corresponding A,B,C
vin_delta_sine /*#("u2")*/ inst_vin_sine (push_r1,u2_r1,vin_sine,delta_sine,push_sine);
sin_lookup inst_sin (vin_sine,A_sine,B_sine,C_sine);

always @ (posedge clk or posedge rst)
begin
  if (rst)
  begin
    push_r2 <= #1 1'b0;
    A_sqrtln_r2 <= #1 64'b0;
    B_sqrtln_r2 <= #1 64'b0;
    C_sqrtln_r2 <= #1 64'b0;
    D_sqrtln_r2 <= #1 64'b0;
    A_sine_r2 <= #1 64'b0;
    B_sine_r2 <= #1 64'b0;
    C_sine_r2 <= #1 64'b0;
    delta_sqrtln_r2 <= #1 64'b0;
    delta_sine_r2 <= #1 64'b0;
  end
  else
  begin
    push_r2 <= #1 push_sqrtln&push_sine;
    A_sqrtln_r2 <= #1 A_sqrtln;
    B_sqrtln_r2 <= #1 B_sqrtln;
    C_sqrtln_r2 <= #1 C_sqrtln;
    D_sqrtln_r2 <= #1 D_sqrtln;
    A_sine_r2 <= #1 A_sine;
    B_sine_r2 <= #1 B_sine;
    C_sine_r2 <= #1 C_sine;
    delta_sqrtln_r2 <= #1 delta_sqrtln;
    delta_sine_r2 <= #1 delta_sine;
  end
end

//-----------------
//3rd to 11th stage
//-----------------
//sqrtln: delta^3
fpmul inst_fpmul_d3
(clk,rst,push_r2,delta_sqrtln_r2,delta_sqrtln_r2,delta_sqrtln_r2,push_d3_r11,d3_r11);
//sqrtln: B*delta^2
fpmul inst_fpmul_Bd2
(clk,rst,push_r2,delta_sqrtln_r2,delta_sqrtln_r2,B_sqrtln_r2,push_Bd2_r11,Bd2_r11);
//sqrtln: C*delta
fpmul inst_fpmul_Cd
(clk,rst,push_r2,delta_sqrtln_r2,C_sqrtln_r2,ONE,push_Cd_r11,Cd_r11);
//sqrtln: 9 stage register for A
reg_9stage inst_reg_9stage_A
(clk,rst,push_r2,A_sqrtln_r2,push_A_sqrtln_r11,A_sqrtln_r11);
//sqrtln: 9 stage register for D
reg_9stage inst_reg_9stage_D
(clk,rst,push_r2,D_sqrtln_r2,push_D_sqrtln_r11,D_sqrtln_r11);
//sine: A*delta^2
fpmul inst_fpmul_Ad2
(clk,rst,push_r2,A_sine_r2,delta_sine_r2,delta_sine_r2,push_Ad2_r11,Ad2_r11);
//sine: B*delta
fpmul inst_fpmul_Bd
(clk,rst,push_r2,B_sine_r2,delta_sine_r2,ONE,push_Bd_r11,Bd_r11);
//sine: 9 stage register for C
reg_9stage inst_reg_9stage_C
(clk,rst,push_r2,C_sine_r2,push_C_sine_r11,C_sine_r11);

//------------------
//12th to 25th stage
//------------------
//sqrtln: A*delta^3
fpmul inst_fpmul_Ad3
(clk,rst,push_d3_r11&push_A_sqrtln_r11,A_sqrtln_r11,d3_r11,ONE,push_Ad3_r20,Ad3_r20);
//sqrtln: 5 stage register for Ad3
reg_5stage inst_reg_5stage_Ad3
(clk,rst,push_Ad3_r20,Ad3_r20,push_Ad3_r25,Ad3_r25);
//sqrtln: 7 stage register for Bd2
reg_7stage inst_reg_7stage_Bd2
(clk,rst,push_Bd2_r11,Bd2_r11,push_Bd2_r18,Bd2_r18);
//sqrtln: C*delta+D
fpadd inst_fpadd_Cd_D 
(clk,rst,push_Cd_r11&push_D_sqrtln_r11,Cd_r11,D_sqrtln_r11,push_Cd_D_r18,Cd_D_r18);
//sqrtln: B*delta^2+C*delta+D
fpadd inst_fpadd_Bd2_Cd_D
(clk,rst,push_Cd_D_r18&push_Bd2_r18,Cd_D_r18,Bd2_r18,push_Bd2_Cd_D_r25,Bd2_Cd_D_r25);
//sine: 7 stage register for Ad2
reg_7stage inst_reg_7stage_Ad2
(clk,rst,push_Ad2_r11,Ad2_r11,push_Ad2_r18,Ad2_r18);
//sine: Bdelta+C
fpadd inst_fpadd_Bd_C
(clk,rst,push_Bd_r11&push_C_sine_r11,Bd_r11,C_sine_r11,push_Bd_C_r18,Bd_C_r18);
//sinb = Adelta^2+Bdelta+C
fpadd inst_fpadd_Ad2_Bd_C
(clk,rst,push_Bd_C_r18&push_Ad2_r18,Ad2_r18,Bd_C_r18,push_sinb_r25,sinb_r25);


//------------------
//26th to 32nd stage
//------------------
//sqrtln: a = A*delta^3+B*delta^2+Cdelta+D
fpadd inst_fpadd_Ad3_Bd2_Cd_D
(clk,rst,push_Ad3_r25&push_Bd2_Cd_D_r25,Ad3_r25,Bd2_Cd_D_r25,push_a_r32,a_r32);
//sine: 7 stage register for sinb
reg_7stage inst_reg_7stage_sinb
(clk,rst,push_sinb_r25,sinb_r25,push_sinb_r32,sinb_r32);


//------------------
//32nd to 41st stage
//------------------
//Final result: a*sinb
fpmul inst_fpmul_asinb (clk,rst,push_sinb_r32&push_a_r32,a_r32,sinb_r32,ONE,push_z_41,z_41);


//------------------
//42nd stage
//------------------
always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    pushout <= #1 1'b0;
    z <= #1 64'b0;
  end
  else begin
    pushout <= #1 push_z_41;
    z <= #1 z_41;
  end
end

endmodule
//A sin table for randist
// The input is a 10 bit integer representing
// <input>/1024  You need to denormalize the FP
// Value to get a correct answer from the lookup
// Multiply the difference from the <input> by the slope
// To get an interpolated value.
// get the delta from the floating version of the lookup value
// sin = A*delta*delta+B*delta+C
//
// Answer should be good to about 1e-9 (8-10 digits)

module sin_lookup(vin,A,B,C);
input [9:0] vin;
output [63:0] A,B,C;
reg [63:0] a,b,c;
assign A=a;
assign B=b;
assign C=c;
reg [63:0] a0,b0,c0;
reg [63:0] a1,b1,c1;
reg [63:0] a2,b2,c2;
reg [63:0] a3,b3,c3;
reg [63:0] a4,b4,c4;
reg [63:0] a5,b5,c5;
reg [63:0] a6,b6,c6;
reg [63:0] a7,b7,c7;
reg [63:0] a8,b8,c8;
reg [63:0] a9,b9,c9;
reg [63:0] a10,b10,c10;
reg [63:0] a11,b11,c11;
reg [63:0] a12,b12,c12;
reg [63:0] a13,b13,c13;
reg [63:0] a14,b14,c14;
reg [63:0] a15,b15,c15;

always @(*) begin

  case(vin[5:0])
  0: begin 
      a0=64'hbfaf019691240000;
      b0=64'h401922007f3248fc;
      c0=64'h0000000000000000;
    end
  1: begin 
      a0=64'hbfc7411dcc940000;
      b0=64'h401921e17d9227b8;
      c0=64'h3f7921f0fe67006a;
    end
  2: begin 
      a0=64'hbfd360ce4a160000;
      b0=64'h401921847907d538;
      c0=64'h3f8921d1fcdec77d;
    end
  3: begin 
      a0=64'hbfdb20dddda00000;
      b0=64'h401920e97278d480;
      c0=64'h3f92d936bbe30ef8;
    end
  4: begin 
      a0=64'hbfe1705540b80000;
      b0=64'h401920106b63a7d0;
      c0=64'h3f992155f7a36677;
    end
  5: begin 
      a0=64'hbfe550108b600000;
      b0=64'h40191ef965dfcd60;
      c0=64'h3f9f693731d1cef8;
    end
  6: begin 
      a0=64'hbfe92f973fc40000;
      b0=64'h40191da4649db9c0;
      c0=64'h3fa2d865759455c8;
    end
  7: begin 
      a0=64'hbfed0edfcf680000;
      b0=64'h40191c116ae6d1c0;
      c0=64'h3fa5fc00d290cd3d;
    end
  8: begin 
      a0=64'hbff076f056360000;
      b0=64'h40191a407c9d61c0;
      c0=64'h3fa91f65f10dd80d;
    end
  9: begin 
      a0=64'hbff2664824ce0000;
      b0=64'h401918319e3c94c0;
      c0=64'h3fac428d12c0d7db;
    end
  10: begin 
      a0=64'hbff455728d480000;
      b0=64'h401915e4d4d868c0;
      c0=64'h3faf656e79f820d7;
    end
  11: begin 
      a0=64'hbff6446ac9dc0000;
      b0=64'h4019135a261da200;
      c0=64'h3fb1440134d709ae;
    end
  12: begin 
      a0=64'hbff8332c154c0000;
      b0=64'h401910919851be80;
      c0=64'h3fb2d52092ce19f1;
    end
  13: begin 
      a0=64'hbffa21b1aac80000;
      b0=64'h40190d8b3252e4c0;
      c0=64'h3fb4661179272090;
    end
  14: begin 
      a0=64'hbffc0ff6c62c0000;
      b0=64'h40190a46fb97d340;
      c0=64'h3fb5f6d00a9aa413;
    end
  15: begin 
      a0=64'hbffdfdf6a3e40000;
      b0=64'h401906c4fc2fcf00;
      c0=64'h3fb787586a5d5b1b;
    end
  16: begin 
      a0=64'hbfffebac81140000;
      b0=64'h401903053cc28e80;
      c0=64'h3fb917a6bc29b425;
    end
  17: begin 
      a0=64'hc000ec89cdc20000;
      b0=64'h4018ff07c6902540;
      c0=64'h3fbaa7b724495bfc;
    end
  18: begin 
      a0=64'hc001e31398e60000;
      b0=64'h4018facca370ebc0;
      c0=64'h3fbc3785c79ec2cd;
    end
  19: begin 
      a0=64'hc002d97141a80000;
      b0=64'h4018f653ddd56940;
      c0=64'h3fbdc70ecbae9fc0;
    end
  20: begin 
      a0=64'hc003cfa068280000;
      b0=64'h4018f19d80c63780;
      c0=64'h3fbf564e56a97305;
    end
  21: begin 
      a0=64'hc004c59eacf00000;
      b0=64'h4018eca997e3e980;
      c0=64'h3fc072a047ba8318;
    end
  22: begin 
      a0=64'hc005bb69b1100000;
      b0=64'h4018e7782f66ed00;
      c0=64'h3fc139f0cedaf572;
    end
  23: begin 
      a0=64'hc006b0ff16140000;
      b0=64'h4018e209541f7000;
      c0=64'h3fc20116d4ec7bc9;
    end
  24: begin 
      a0=64'hc007a65c7e000000;
      b0=64'h4018dc5d13753b00;
      c0=64'h3fc2c8106e8e6135;
    end
  25: begin 
      a0=64'hc0089b7f8b740000;
      b0=64'h4018d6737b679700;
      c0=64'h3fc38edbb0cd8d0e;
    end
  26: begin 
      a0=64'hc0099065e1880000;
      b0=64'h4018d04c9a8d2400;
      c0=64'h3fc45576b1293e54;
    end
  27: begin 
      a0=64'hc00a850d24080000;
      b0=64'h4018c9e88013bb80;
      c0=64'h3fc51bdf8597c5ec;
    end
  28: begin 
      a0=64'hc00b7972f7440000;
      b0=64'h4018c3473bc04600;
      c0=64'h3fc5e214448b3fc0;
    end
  29: begin 
      a0=64'hc00c6d9500380000;
      b0=64'h4018bc68ddee9700;
      c0=64'h3fc6a81304f64aab;
    end
  30: begin 
      a0=64'hc00d6170e4840000;
      b0=64'h4018b54d77914280;
      c0=64'h3fc76dd9de50bf2b;
    end
  31: begin 
      a0=64'hc00e55044a700000;
      b0=64'h4018adf51a317700;
      c0=64'h3fc83366e89c64be;
    end
  32: begin 
      a0=64'hc00f484cd9000000;
      b0=64'h4018a65fd7eecb80;
      c0=64'h3fc8f8b83c69a604;
    end
  33: begin 
      a0=64'hc0101da41bfe0000;
      b0=64'h40189e8dc37f1c80;
      c0=64'h3fc9bdcbf2dc4360;
    end
  34: begin 
      a0=64'hc01096fa07e20000;
      b0=64'h4018967ef02e5280;
      c0=64'h3fca82a025b00449;
    end
  35: begin 
      a0=64'hc011102704d40000;
      b0=64'h40188e3371de3d00;
      c0=64'h3fcb4732ef3d671b;
    end
  36: begin 
      a0=64'hc0118929e7d00000;
      b0=64'h401885ab5d065800;
      c0=64'h3fcc0b826a7e4f5b;
    end
  37: begin 
      a0=64'hc012020186440000;
      b0=64'h40187ce6c6b3a300;
      c0=64'h3fcccf8cb312b27e;
    end
  38: begin 
      a0=64'hc0127aacb6060000;
      b0=64'h401873e5c4886280;
      c0=64'h3fcd934fe5454309;
    end
  39: begin 
      a0=64'hc012f32a4d5a0000;
      b0=64'h40186aa86cbbf680;
      c0=64'h3fce56ca1e101a13;
    end
  40: begin 
      a0=64'hc0136b7922f00000;
      b0=64'h4018612ed61a9780;
      c0=64'h3fcf19f97b215f12;
    end
  41: begin 
      a0=64'hc013e3980df40000;
      b0=64'h4018577918052900;
      c0=64'h3fcfdcdc1adfedf0;
    end
  42: begin 
      a0=64'hc0145b85e5fc0000;
      b0=64'h40184d874a70f700;
      c0=64'h3fd04fb80e37fda9;
    end
  43: begin 
      a0=64'hc014d34183280000;
      b0=64'h4018435985e78400;
      c0=64'h3fd0b0d9cfdbdb8b;
    end
  44: begin 
      a0=64'hc0154ac9be080000;
      b0=64'h401838efe3864200;
      c0=64'h3fd111d262b1f673;
    end
  45: begin 
      a0=64'hc015c21d6fa00000;
      b0=64'h40182e4a7cfe5a00;
      c0=64'h3fd172a0d7765172;
    end
  46: begin 
      a0=64'hc016393b71980000;
      b0=64'h401823696c947200;
      c0=64'h3fd1d3443f4cdb39;
    end
  47: begin 
      a0=64'hc016b0229dfc0000;
      b0=64'h4018184ccd206400;
      c0=64'h3fd233bbabc3bb6c;
    end
  48: begin 
      a0=64'hc01726d1cf680000;
      b0=64'h40180cf4ba0cfa00;
      c0=64'h3fd294062ed59f01;
    end
  49: begin 
      a0=64'hc0179d47e1100000;
      b0=64'h401801614f57b600;
      c0=64'h3fd2f422daec0381;
    end
  50: begin 
      a0=64'hc0181383ae980000;
      b0=64'h4017f592a9907f00;
      c0=64'h3fd35410c2e1814c;
    end
  51: begin 
      a0=64'hc018898414540000;
      b0=64'h4017e988e5d96800;
      c0=64'h3fd3b3cefa0414b2;
    end
  52: begin 
      a0=64'hc018ff47ef180000;
      b0=64'h4017dd4421e65b00;
      c0=64'h3fd4135c941765fc;
    end
  53: begin 
      a0=64'hc01974ce1c500000;
      b0=64'h4017d0c47bfcd900;
      c0=64'h3fd472b8a557104e;
    end
  54: begin 
      a0=64'hc019ea157a000000;
      b0=64'h4017c40a12f3af00;
      c0=64'h3fd4d1e24278e764;
    end
  55: begin 
      a0=64'hc01a5f1ce6d40000;
      b0=64'h4017b7150632a300;
      c0=64'h3fd530d880af3c1e;
    end
  56: begin 
      a0=64'hc01ad3e341f80000;
      b0=64'h4017a9e575b22c00;
      c0=64'h3fd58f9a75ab1fd7;
    end
  57: begin 
      a0=64'hc01b48676b580000;
      b0=64'h40179c7b81fb2200;
      c0=64'h3fd5ee27379ea68d;
    end
  58: begin 
      a0=64'hc01bbca843740000;
      b0=64'h40178ed74c267100;
      c0=64'h3fd64c7ddd3f27c0;
    end
  59: begin 
      a0=64'hc01c30a4ab700000;
      b0=64'h401780f8f5dcbd00;
      c0=64'h3fd6aa9d7dc77e11;
    end
  60: begin 
      a0=64'hc01ca45b851c0000;
      b0=64'h401772e0a1561d00;
      c0=64'h3fd7088530fa4598;
    end
  61: begin 
      a0=64'hc01d17cbb2fc0000;
      b0=64'h4017648e7159bb00;
      c0=64'h3fd766340f2418f0;
    end
  62: begin 
      a0=64'hc01d8af4183c0000;
      b0=64'h40175602893d8600;
      c0=64'h3fd7c3a9311dcce0;
    end
  63: begin 
      a0=64'hc01dfdd398b00000;
      b0=64'h4017473d0ce5d400;
      c0=64'h3fd820e3b04eaabe;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a1=64'hc01e706918ec0000;
      b1=64'h4017383e20c50e00;
      c1=64'h3fd87de2a6aea95c;
    end
  1: begin 
      a1=64'hc01ee2b37e340000;
      b1=64'h40172905e9db5700;
      c1=64'h3fd8daa52ec8a4a9;
    end
  2: begin 
      a1=64'hc01f54b1ae940000;
      b1=64'h401719948db62e00;
      c1=64'h3fd9372a63bc93d1;
    end
  3: begin 
      a1=64'hc01fc66290b40000;
      b1=64'h401709ea32701000;
      c1=64'h3fd993716141bdf8;
    end
  4: begin 
      a1=64'hc0201be286120000;
      b1=64'h4016fa06feb02000;
      c1=64'h3fd9ef7943a8ed83;
    end
  5: begin 
      a1=64'hc020546c04860000;
      b1=64'h4016e9eb19a9bc00;
      c1=64'h3fda4b4127dea1dd;
    end
  6: begin 
      a1=64'hc0208ccd38400000;
      b1=64'h4016d996ab1c3000;
      c1=64'h3fdaa6c82b6d3fc3;
    end
  7: begin 
      a1=64'hc020c505961a0000;
      b1=64'h4016c909db523b00;
      c1=64'h3fdb020d6c7f4002;
    end
  8: begin 
      a1=64'hc020fd1493660000;
      b1=64'h4016b844d321c300;
      c1=64'h3fdb5d1009e15cb9;
    end
  9: begin 
      a1=64'hc02134f9a5cc0000;
      b1=64'h4016a747bbeb5f00;
      c1=64'h3fdbb7cf2304bcf9;
    end
  10: begin 
      a1=64'hc0216cb443620000;
      b1=64'h40169612bf99fa00;
      c1=64'h3fdc1249d8011edf;
    end
  11: begin 
      a1=64'hc021a443e2aa0000;
      b1=64'h401684a608a26900;
      c1=64'h3fdc6c7f49970003;
    end
  12: begin 
      a1=64'hc021dba7fa8a0000;
      b1=64'h40167301c2030400;
      c1=64'h3fdcc66e9931c456;
    end
  13: begin 
      a1=64'hc02212e002560000;
      b1=64'h4016612617433700;
      c1=64'h3fdd2016e8e9db53;
    end
  14: begin 
      a1=64'hc02249eb71d00000;
      b1=64'h40164f1334731b00;
      c1=64'h3fdd79775b86e382;
    end
  15: begin 
      a1=64'hc02280c9c1260000;
      b1=64'h40163cc9462b0c00;
      c1=64'h3fddd28f1481cc50;
    end
  16: begin 
      a1=64'hc022b77a68f80000;
      b1=64'h40162a48798b3300;
      c1=64'h3fde2b5d3806f633;
    end
  17: begin 
      a1=64'hc022edfce2580000;
      b1=64'h40161790fc3b1d00;
      c1=64'h3fde83e0eaf8510c;
    end
  18: begin 
      a1=64'hc0232450a6c00000;
      b1=64'h401604a2fc694400;
      c1=64'h3fdedc1952ef78ce;
    end
  19: begin 
      a1=64'hc0235a7530240000;
      b1=64'h4015f17ea8caa700;
      c1=64'h3fdf3405963fd05f;
    end
  20: begin 
      a1=64'hc0239069f8f20000;
      b1=64'h4015de24309a4e00;
      c1=64'h3fdf8ba4dbf89ab1;
    end
  21: begin 
      a1=64'hc023c62e7c040000;
      b1=64'h4015ca93c398da00;
      c1=64'h3fdfe2f64be71207;
    end
  22: begin 
      a1=64'hc023fbc234b40000;
      b1=64'h4015b6cd920c0c00;
      c1=64'h3fe01cfc874c3eb2;
    end
  23: begin 
      a1=64'hc02431249ecc0000;
      b1=64'h4015a2d1ccbe4e00;
      c1=64'h3fe0485626ae2217;
    end
  24: begin 
      a1=64'hc024665536940000;
      b1=64'h40158ea0a4fe4400;
      c1=64'h3fe073879922ffea;
    end
  25: begin 
      a1=64'hc0249b5378d00000;
      b1=64'h40157a3a4c9e3e00;
      c1=64'h3fe09e907417c5dc;
    end
  26: begin 
      a1=64'hc024d01ee2bc0000;
      b1=64'h4015659ef5f3d600;
      c1=64'h3fe0c9704d5d898a;
    end
  27: begin 
      a1=64'hc02504b6f2180000;
      b1=64'h401550ced3d76000;
      c1=64'h3fe0f426bb2a8e79;
    end
  28: begin 
      a1=64'hc025391b25200000;
      b1=64'h40153bca19a37400;
      c1=64'h3fe11eb3541b4b1e;
    end
  29: begin 
      a1=64'hc0256d4afa880000;
      b1=64'h40152690fb347200;
      c1=64'h3fe14915af336ce6;
    end
  30: begin 
      a1=64'hc025a145f1940000;
      b1=64'h40151123ace80200;
      c1=64'h3fe1734d63dedb44;
    end
  31: begin 
      a1=64'hc025d50b89f80000;
      b1=64'h4014fb82639c8400;
      c1=64'h3fe19d5a09f2b9b4;
    end
  32: begin 
      a1=64'hc026089b44040000;
      b1=64'h4014e5ad54b0ac00;
      c1=64'h3fe1c73b39ae68c4;
    end
  33: begin 
      a1=64'hc0263bf4a0740000;
      b1=64'h4014cfa4b602d800;
      c1=64'h3fe1f0f08bbc8616;
    end
  34: begin 
      a1=64'hc0266f1720980000;
      b1=64'h4014b968bdf0ae00;
      c1=64'h3fe21a799933eb54;
    end
  35: begin 
      a1=64'hc026a20246440000;
      b1=64'h4014a2f9a3568200;
      c1=64'h3fe243d5fb98ac1a;
    end
  36: begin 
      a1=64'hc026d4b593dc0000;
      b1=64'h40148c579d8ed200;
      c1=64'h3fe26d054cdd12da;
    end
  37: begin 
      a1=64'hc02707308c3c0000;
      b1=64'h40147582e471be00;
      c1=64'h3fe2960727629ca3;
    end
  38: begin 
      a1=64'hc0273972b2dc0000;
      b1=64'h40145e7bb0548400;
      c1=64'h3fe2bedb25faf3e6;
    end
  39: begin 
      a1=64'hc0276b7b8bc00000;
      b1=64'h401447423a08ee00;
      c1=64'h3fe2e780e3e8ea12;
    end
  40: begin 
      a1=64'hc0279d4a9b680000;
      b1=64'h40142fd6badcc600;
      c1=64'h3fe30ff7fce17030;
    end
  41: begin 
      a1=64'hc027cedf66f40000;
      b1=64'h401418396c994800;
      c1=64'h3fe338400d0c8e52;
    end
  42: begin 
      a1=64'hc028003974080000;
      b1=64'h4014006a89829c00;
      c1=64'h3fe36058b10659ee;
    end
  43: begin 
      a1=64'hc028315848f00000;
      b1=64'h4013e86a4c574200;
      c1=64'h3fe3884185dfeb1d;
    end
  44: begin 
      a1=64'hc028623b6c600000;
      b1=64'h4013d038f04f7600;
      c1=64'h3fe3affa292050b4;
    end
  45: begin 
      a1=64'hc02892e265d00000;
      b1=64'h4013b7d6b11cb200;
      c1=64'h3fe3d78238c5833f;
    end
  46: begin 
      a1=64'hc028c34cbd280000;
      b1=64'h40139f43cae90200;
      c1=64'h3fe3fed9534556d0;
    end
  47: begin 
      a1=64'hc028f379faf00000;
      b1=64'h401386807a568a00;
      c1=64'h3fe425ff178e6bad;
    end
  48: begin 
      a1=64'hc0292369a84c0000;
      b1=64'h40136d8cfc7ede00;
      c1=64'h3fe44cf325091dd1;
    end
  49: begin 
      a1=64'hc029531b4efc0000;
      b1=64'h401354698ef27800;
      c1=64'h3fe473b51b987342;
    end
  50: begin 
      a1=64'hc029828e79480000;
      b1=64'h40133b166fb80a00;
      c1=64'h3fe49a449b9b0934;
    end
  51: begin 
      a1=64'hc029b1c2b2200000;
      b1=64'h40132193dd4c0400;
      c1=64'h3fe4c0a145ebffff;
    end
  52: begin 
      a1=64'hc029e0b7850c0000;
      b1=64'h401307e2169fe000;
      c1=64'h3fe4e6cabbe3e5e4;
    end
  53: begin 
      a1=64'hc02a0f6c7e340000;
      b1=64'h4012ee015b199800;
      c1=64'h3fe50cc09f59a097;
    end
  54: begin 
      a1=64'hc02a3de12a540000;
      b1=64'h4012d3f1ea92fa00;
      c1=64'h3fe5328292a35591;
    end
  55: begin 
      a1=64'hc02a6c1516d00000;
      b1=64'h4012b9b405591a00;
      c1=64'h3fe5581038975132;
    end
  56: begin 
      a1=64'hc02a9a07d19c0000;
      b1=64'h40129f47ec2ba600;
      c1=64'h3fe57d69348cec9b;
    end
  57: begin 
      a1=64'hc02ac7b8e9680000;
      b1=64'h401284ade03c5200;
      c1=64'h3fe5a28d2a5d724b;
    end
  58: begin 
      a1=64'hc02af527ed700000;
      b1=64'h401269e6232e2c00;
      c1=64'h3fe5c77bbe650187;
    end
  59: begin 
      a1=64'hc02b22546d980000;
      b1=64'h40124ef0f7150200;
      c1=64'h3fe5ec349583706f;
    end
  60: begin 
      a1=64'hc02b4f3dfa700000;
      b1=64'h401233ce9e74bc00;
      c1=64'h3fe610b7551d2cd9;
    end
  61: begin 
      a1=64'hc02b7be425200000;
      b1=64'h4012187f5c40ba00;
      c1=64'h3fe63503a31c1be4;
    end
  62: begin 
      a1=64'hc02ba8467f7c0000;
      b1=64'h4011fd0373db2600;
      c1=64'h3fe6591925f07839;
    end
  63: begin 
      a1=64'hc02bd4649c0c0000;
      b1=64'h4011e15b29146400;
      c1=64'h3fe67cf78491af0b;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a2=64'hc02c003e0de80000;
      b2=64'h4011c586c02a4a00;
      c2=64'h3fe6a09e667f3bc7;
    end
  1: begin 
      a2=64'hc02c2bd268ec0000;
      b2=64'h4011a9867dc79200;
      c2=64'h3fe6c40d73c18270;
    end
  2: begin 
      a2=64'hc02c572141880000;
      b2=64'h40118d5aa7032800;
      c2=64'h3fe6e74454eaa8a9;
    end
  3: begin 
      a2=64'hc02c822a2cdc0000;
      b2=64'h40117103815f7c00;
      c2=64'h3fe70a42b3176d74;
    end
  4: begin 
      a2=64'hc02cacecc0c40000;
      b2=64'h4011548152c9dc00;
      c2=64'h3fe72d0837efff91;
    end
  5: begin 
      a2=64'hc02cd76893b40000;
      b2=64'h401137d46199c400;
      c2=64'h3fe74f948da8d288;
    end
  6: begin 
      a2=64'hc02d019d3ce00000;
      b2=64'h40111afcf4903200;
      c2=64'h3fe771e75f03725c;
    end
  7: begin 
      a2=64'hc02d2b8a54200000;
      b2=64'h4010fdfb52d6f600;
      c2=64'h3fe79400574f55e0;
    end
  8: begin 
      a2=64'hc02d552f72040000;
      b2=64'h4010e0cfc4000400;
      c2=64'h3fe7b5df226aafaa;
    end
  9: begin 
      a2=64'hc02d7e8c2fd40000;
      b2=64'h4010c37a9004c800;
      c2=64'h3fe7d7836cc33dad;
    end
  10: begin 
      a2=64'hc02da7a027740000;
      b2=64'h4010a5fbff456600;
      c2=64'h3fe7f8ece357176b;
    end
  11: begin 
      a2=64'hc02dd06af3880000;
      b2=64'h401088545a881800;
      c2=64'h3fe81a1b33b57ac6;
    end
  12: begin 
      a2=64'hc02df8ec2f740000;
      b2=64'h40106a83eaf86800;
      c2=64'h3fe83b0e0bff9769;
    end
  13: begin 
      a2=64'hc02e212377400000;
      b2=64'h40104c8afa269800;
      c2=64'h3fe85bc51ae958c7;
    end
  14: begin 
      a2=64'hc02e491067b00000;
      b2=64'h40102e69d206ce00;
      c2=64'h3fe87c400fba2eba;
    end
  15: begin 
      a2=64'hc02e70b29e480000;
      b2=64'h40101020bcf06e00;
      c2=64'h3fe89c7e9a4dd4a5;
    end
  16: begin 
      a2=64'hc02e9809b9380000;
      b2=64'h400fe3600b3ac400;
      c2=64'h3fe8bc806b15173b;
    end
  17: begin 
      a2=64'hc02ebf1557700000;
      b2=64'h400fa62fee52b000;
      c2=64'h3fe8dc45331698c7;
    end
  18: begin 
      a2=64'hc02ee5d5189c0000;
      b2=64'h400f68b1ba223400;
      c2=64'h3fe8fbcca3ef9407;
    end
  19: begin 
      a2=64'hc02f0c489d180000;
      b2=64'h400f2ae606637000;
      c2=64'h3fe91b166fd49d9d;
    end
  20: begin 
      a2=64'hc02f326f860c0000;
      b2=64'h400eeccd6b8fec00;
      c2=64'h3fe93a22499263f6;
    end
  21: begin 
      a2=64'hc02f584975500000;
      b2=64'h400eae6882debc00;
      c2=64'h3fe958efe48e6dd2;
    end
  22: begin 
      a2=64'hc02f7dd60d840000;
      b2=64'h400e6fb7e6436400;
      c2=64'h3fe9777ef4c7d73d;
    end
  23: begin 
      a2=64'hc02fa314f2040000;
      b2=64'h400e30bc306c2000;
      c2=64'h3fe995cf2ed80d1d;
    end
  24: begin 
      a2=64'hc02fc805c6dc0000;
      b2=64'h400df175fcc07400;
      c2=64'h3fe9b3e047f3873b;
    end
  25: begin 
      a2=64'hc02feca830f40000;
      b2=64'h400db1e5e75fb400;
      c2=64'h3fe9d1b1f5ea80d0;
    end
  26: begin 
      a2=64'hc030087deaf20000;
      b2=64'h400d720c8d1f8400;
      c2=64'h3fe9ef43ef29af8f;
    end
  27: begin 
      a2=64'hc0301a802e020000;
      b2=64'h400d31ea8b8a5000;
      c2=64'h3fea0c95eabaf932;
    end
  28: begin 
      a2=64'hc0302c5ab5420000;
      b2=64'h400cf18080ddc800;
      c2=64'h3fea29a7a046277d;
    end
  29: begin 
      a2=64'hc0303e0d549c0000;
      b2=64'h400cb0cf0c095400;
      c2=64'h3fea4678c8119ac3;
    end
  30: begin 
      a2=64'hc0304f97e06a0000;
      b2=64'h400c6fd6ccac8c00;
      c2=64'h3fea63091b02fadd;
    end
  31: begin 
      a2=64'hc03060fa2d660000;
      b2=64'h400c2e986315d400;
      c2=64'h3fea7f58529fe697;
    end
  32: begin 
      a2=64'hc030723410a60000;
      b2=64'h400bed1470407c00;
      c2=64'h3fea9b66290ea19e;
    end
  33: begin 
      a2=64'hc03083455faa0000;
      b2=64'h400bab4b95d39400;
      c2=64'h3feab7325916c0cf;
    end
  34: begin 
      a2=64'hc030942df0580000;
      b2=64'h400b693e76201400;
      c2=64'h3fead2bc9e21d50c;
    end
  35: begin 
      a2=64'hc030a4ed98f80000;
      b2=64'h400b26edb41f7c00;
      c2=64'h3feaee04b43c146f;
    end
  36: begin 
      a2=64'hc030b58430340000;
      b2=64'h400ae459f3721c00;
      c2=64'h3feb090a581501fb;
    end
  37: begin 
      a2=64'hc030c5f18d200000;
      b2=64'h400aa183d85da000;
      c2=64'h3feb23cd470013af;
    end
  38: begin 
      a2=64'hc030d63587360000;
      b2=64'h400a5e6c07cb5c00;
      c2=64'h3feb3e4d3ef5570d;
    end
  39: begin 
      a2=64'hc030e64ff64e0000;
      b2=64'h400a1b132746d400;
      c2=64'h3feb5889fe921400;
    end
  40: begin 
      a2=64'hc030f640b2ae0000;
      b2=64'h4009d779dcfc0800;
      c2=64'h3feb728345196e38;
    end
  41: begin 
      a2=64'hc031060795040000;
      b2=64'h400993a0cfb5f000;
      c2=64'h3feb8c38d27504e4;
    end
  42: begin 
      a2=64'hc03115a4765e0000;
      b2=64'h40094f88a6dcd400;
      c2=64'h3feba5aa673590cd;
    end
  43: begin 
      a2=64'hc0312517303c0000;
      b2=64'h40090b320a74b400;
      c2=64'h3febbed7c49380e5;
    end
  44: begin 
      a2=64'hc031345f9c7c0000;
      b2=64'h4008c69da31bac00;
      c2=64'h3febd7c0ac6f9524;
    end
  45: begin 
      a2=64'hc031437d95680000;
      b2=64'h400881cc1a083c00;
      c2=64'h3febf064e15377d8;
    end
  46: begin 
      a2=64'hc0315270f5b60000;
      b2=64'h40083cbe1907d000;
      c2=64'h3fec08c426725545;
    end
  47: begin 
      a2=64'hc031613998800000;
      b2=64'h4007f7744a7d0400;
      c2=64'h3fec20de3fa971ab;
    end
  48: begin 
      a2=64'hc0316fd759500000;
      b2=64'h4007b1ef595df400;
      c2=64'h3fec38b2f180bdac;
    end
  49: begin 
      a2=64'hc0317e4a14120000;
      b2=64'h40076c2ff132b400;
      c2=64'h3fec5042012b6902;
    end
  50: begin 
      a2=64'hc0318c91a51e0000;
      b2=64'h40072636be139400;
      c2=64'h3fec678b34887397;
    end
  51: begin 
      a2=64'hc0319aade93c0000;
      b2=64'h4006e0046ca77c00;
      c2=64'h3fec7e8e52233cef;
    end
  52: begin 
      a2=64'hc031a89ebd9c0000;
      b2=64'h40069999aa224400;
      c2=64'h3fec954b213411f0;
    end
  53: begin 
      a2=64'hc031b663ffd60000;
      b2=64'h400652f724430800;
      c2=64'h3fecabc169a0b8fc;
    end
  54: begin 
      a2=64'hc031c3fd8dee0000;
      b2=64'h40060c1d89527400;
      c2=64'h3fecc1f0f3fcfc58;
    end
  55: begin 
      a2=64'hc031d16b46580000;
      b2=64'h4005c50d88213000;
      c2=64'h3fecd7d9898b32f1;
    end
  56: begin 
      a2=64'hc031dead07f00000;
      b2=64'h40057dc7d0060000;
      c2=64'h3feced7af43cc76e;
    end
  57: begin 
      a2=64'hc031ebc2b2040000;
      b2=64'h4005364d10dc5000;
      c2=64'h3fed02d4feb2bd8e;
    end
  58: begin 
      a2=64'hc031f8ac24480000;
      b2=64'h4004ee9dfb025000;
      c2=64'h3fed17e7743e35d7;
    end
  59: begin 
      a2=64'hc03205693ede0000;
      b2=64'h4004a6bb3f575800;
      c2=64'h3fed2cb220e0ef9a;
    end
  60: begin 
      a2=64'hc03211f9e25e0000;
      b2=64'h40045ea58f3a3400;
      c2=64'h3fed4134d14dc935;
    end
  61: begin 
      a2=64'hc0321e5defc00000;
      b2=64'h4004165d9c875800;
      c2=64'h3fed556f52e93ead;
    end
  62: begin 
      a2=64'hc0322a9548780000;
      b2=64'h4003cde419976000;
      c2=64'h3fed696173c9e687;
    end
  63: begin 
      a2=64'hc032369fce5e0000;
      b2=64'h40038539b93d0c00;
      c2=64'h3fed7d0b02b8ecf5;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a3=64'hc032427d63be0000;
      b3=64'h40033c5f2ec3bc00;
      c3=64'h3fed906bcf328d42;
    end
  1: begin 
      a3=64'hc0324e2deb4c0000;
      b3=64'h4002f3552dedac00;
      c3=64'h3feda383a9668984;
    end
  2: begin 
      a3=64'hc03259b148380000;
      b3=64'h4002aa1c6af23800;
      c3=64'h3fedb6526238a097;
    end
  3: begin 
      a3=64'hc03265075e160000;
      b3=64'h400260b59a7c0800;
      c3=64'h3fedc8d7cb41025c;
    end
  4: begin 
      a3=64'hc032703010ee0000;
      b3=64'h4002172171a77800;
      c3=64'h3feddb13b6ccc238;
    end
  5: begin 
      a3=64'hc0327b2b45340000;
      b3=64'h4001cd60a600b800;
      c3=64'h3feded05f7de47d6;
    end
  6: begin 
      a3=64'hc03285f8dfd20000;
      b3=64'h40018373ed822800;
      c3=64'h3fedfeae622dbe27;
    end
  7: begin 
      a3=64'hc0329098c6240000;
      b3=64'h4001395bfe928000;
      c3=64'h3fee100cca2980a8;
    end
  8: begin 
      a3=64'hc0329b0addea0000;
      b3=64'h4000ef1990031400;
      c3=64'h3fee212104f686e1;
    end
  9: begin 
      a3=64'hc032a54f0d660000;
      b3=64'h4000a4ad590e2400;
      c3=64'h3fee31eae870ce21;
    end
  10: begin 
      a3=64'hc032af653b440000;
      b3=64'h40005a1811550400;
      c3=64'h3fee426a4b2bc17a;
    end
  11: begin 
      a3=64'hc032b94d4e980000;
      b3=64'h40000f5a70de4800;
      c3=64'h3fee529f04729ff8;
    end
  12: begin 
      a3=64'hc032c3072ef80000;
      b3=64'h3fff88ea60284800;
      c3=64'h3fee6288ec48e10f;
    end
  13: begin 
      a3=64'hc032cc92c4620000;
      b3=64'h3ffef2d20f851800;
      c3=64'h3fee7227db6a9741;
    end
  14: begin 
      a3=64'hc032d5eff74a0000;
      b3=64'h3ffe5c6d622af000;
      c3=64'h3fee817bab4cd109;
    end
  15: begin 
      a3=64'hc032df1eb0940000;
      b3=64'h3ffdc5bdcb2e2000;
      c3=64'h3fee9084361df7ef;
    end
  16: begin 
      a3=64'hc032e81ed9980000;
      b3=64'h3ffd2ec4be5bc000;
      c3=64'h3fee9f4156c62dd7;
    end
  17: begin 
      a3=64'hc032f0f05c200000;
      b3=64'h3ffc9783b0365000;
      c3=64'h3feeadb2e8e7a88a;
    end
  18: begin 
      a3=64'hc032f993226a0000;
      b3=64'h3ffbfffc15f1c800;
      c3=64'h3feebbd8c8df0b71;
    end
  19: begin 
      a3=64'hc0330207172c0000;
      b3=64'h3ffb682f65706800;
      c3=64'h3feec9b2d3c3bf81;
    end
  20: begin 
      a3=64'hc0330a4c25840000;
      b3=64'h3ffad01f153ec000;
      c3=64'h3feed740e7684960;
    end
  21: begin 
      a3=64'hc0331262390a0000;
      b3=64'h3ffa37cc9c903000;
      c3=64'h3feee482e25a9db9;
    end
  22: begin 
      a3=64'hc0331a493dd20000;
      b3=64'h3ff99f39733ba000;
      c3=64'h3feef178a3e473bf;
    end
  23: begin 
      a3=64'hc033220120560000;
      b3=64'h3ff9066711b72800;
      c3=64'h3feefe220c0b95e9;
    end
  24: begin 
      a3=64'hc0332989cd8a0000;
      b3=64'h3ff86d56f1153000;
      c3=64'h3fef0a7efb9230d4;
    end
  25: begin 
      a3=64'hc03330e332da0000;
      b3=64'h3ff7d40a8b005800;
      c3=64'h3fef168f53f7205a;
    end
  26: begin 
      a3=64'hc033380d3e260000;
      b3=64'h3ff73a8359b81800;
      c3=64'h3fef2252f7763ad7;
    end
  27: begin 
      a3=64'hc0333f07ddba0000;
      b3=64'h3ff6a0c2d80cb800;
      c3=64'h3fef2dc9c9089a9a;
    end
  28: begin 
      a3=64'hc03345d300640000;
      b3=64'h3ff606ca815c4000;
      c3=64'h3fef38f3ac64e586;
    end
  29: begin 
      a3=64'hc0334c6e95600000;
      b3=64'h3ff56c9bd18e2000;
      c3=64'h3fef43d085ff92da;
    end
  30: begin 
      a3=64'hc03352da8c5c0000;
      b3=64'h3ff4d23845102000;
      c3=64'h3fef4e603b0b2f2a;
    end
  31: begin 
      a3=64'hc0335916d5840000;
      b3=64'h3ff437a158d26000;
      c3=64'h3fef58a2b1789e82;
    end
  32: begin 
      a3=64'hc0335f2361740000;
      b3=64'h3ff39cd88a43e800;
      c3=64'h3fef6297cff75cae;
    end
  33: begin 
      a3=64'hc033650021400000;
      b3=64'h3ff301df574e8000;
      c3=64'h3fef6c3f7df5bbb5;
    end
  34: begin 
      a3=64'hc0336aad06700000;
      b3=64'h3ff266b73e53a800;
      c3=64'h3fef7599a3a12075;
    end
  35: begin 
      a3=64'hc033702a03000000;
      b3=64'h3ff1cb61be287800;
      c3=64'h3fef7ea629e63d6c;
    end
  36: begin 
      a3=64'hc0337577096a0000;
      b3=64'h3ff12fe056121000;
      c3=64'h3fef8764fa714ba7;
    end
  37: begin 
      a3=64'hc0337a940c9c0000;
      b3=64'h3ff0943485c1e800;
      c3=64'h3fef8fd5ffae41d9;
    end
  38: begin 
      a3=64'hc0337f80fff00000;
      b3=64'h3feff0bf9aa43000;
      c3=64'h3fef97f924c90998;
    end
  39: begin 
      a3=64'hc033843dd7420000;
      b3=64'h3feeb8c75a836000;
      c3=64'h3fef9fce55adb2c6;
    end
  40: begin 
      a3=64'hc03388ca86e60000;
      b3=64'h3fed80834ce1c000;
      c3=64'h3fefa7557f08a515;
    end
  41: begin 
      a3=64'hc0338d27039e0000;
      b3=64'h3fec47f6743b0000;
      c3=64'h3fefae8e8e46cfb9;
    end
  42: begin 
      a3=64'hc033915342a60000;
      b3=64'h3feb0f23d3be5000;
      c3=64'h3fefb5797195d73f;
    end
  43: begin 
      a3=64'hc033954f39b60000;
      b3=64'h3fe9d60e6f46e000;
      c3=64'h3fefbc1617e44184;
    end
  44: begin 
      a3=64'hc033991adef60000;
      b3=64'h3fe89cb94b54e000;
      c3=64'h3fefc26470e19fd2;
    end
  45: begin 
      a3=64'hc0339cb6290e0000;
      b3=64'h3fe763276d05d000;
      c3=64'h3fefc8646cfeb720;
    end
  46: begin 
      a3=64'hc033a0210f100000;
      b3=64'h3fe6295bda0ca000;
      c3=64'h3fefce15fd6da679;
    end
  47: begin 
      a3=64'hc033a35b88920000;
      b3=64'h3fe4ef5998ab2000;
      c3=64'h3fefd37914220b83;
    end
  48: begin 
      a3=64'hc033a6658d9e0000;
      b3=64'h3fe3b523afa9b000;
      c3=64'h3fefd88da3d12524;
    end
  49: begin 
      a3=64'hc033a93f16b00000;
      b3=64'h3fe27abd26504000;
      c3=64'h3fefdd539ff1f455;
    end
  50: begin 
      a3=64'hc033abe81cc20000;
      b3=64'h3fe14029045ef000;
      c3=64'h3fefe1cafcbd5b08;
    end
  51: begin 
      a3=64'hc033ae6099460000;
      b3=64'h3fe0056a52062000;
      c3=64'h3fefe5f3af2e393f;
    end
  52: begin 
      a3=64'hc033b0a886200000;
      b3=64'h3fdd95082fbe4000;
      c3=64'h3fefe9cdad018839;
    end
  53: begin 
      a3=64'hc033b2bfddb00000;
      b3=64'h3fdb1ef2bdca6000;
      c3=64'h3fefed58ecb673c3;
    end
  54: begin 
      a3=64'hc033b4a69ad00000;
      b3=64'h3fd8a89a60da8000;
      c3=64'h3feff095658e71ac;
    end
  55: begin 
      a3=64'hc033b65cb8cc0000;
      b3=64'h3fd632052c3de000;
      c3=64'h3feff3830f8d575b;
    end
  56: begin 
      a3=64'hc033b7e2336a0000;
      b3=64'h3fd3bb3933d9a000;
      c3=64'h3feff621e3796d7d;
    end
  57: begin 
      a3=64'hc033b93706ec0000;
      b3=64'h3fd1443c8c1ac000;
      c3=64'h3feff871dadb81df;
    end
  58: begin 
      a3=64'hc033ba5b30080000;
      b3=64'h3fcd9a2a93cac000;
      c3=64'h3feffa72effef75c;
    end
  59: begin 
      a3=64'hc033bb4eabec0000;
      b3=64'h3fc8ab93050ec000;
      c3=64'h3feffc251df1d3f8;
    end
  60: begin 
      a3=64'hc033bc1178420000;
      b3=64'h3fc3bcbe97518000;
      c3=64'h3feffd886084cd0c;
    end
  61: begin 
      a3=64'hc033bca393240000;
      b3=64'h3fbd9b72ecf00000;
      c3=64'h3feffe9cb44b51a1;
    end
  62: begin 
      a3=64'hc033bd04fb320000;
      b3=64'h3fb3bd1f9dc38000;
      c3=64'h3fefff62169b92db;
    end
  63: begin 
      a3=64'hc033bd35af720000;
      b3=64'h3fa3bd3735140000;
      c3=64'h3fefffd8858e8a92;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a4=64'hc033bd35af720000;
      b4=64'hbe685a2000000000;
      c4=64'h3ff0000000000000;
    end
  1: begin 
      a4=64'hc033bd04fb300000;
      b4=64'hbfa3bd3a40560000;
      c4=64'h3fefffd8858e8a92;
    end
  2: begin 
      a4=64'hc033bca393260000;
      b4=64'hbfb3bd21235e0000;
      c4=64'h3fefff62169b92dc;
    end
  3: begin 
      a4=64'hc033bc1178420000;
      b4=64'hbfbd9b7472820000;
      c4=64'h3feffe9cb44b51a1;
    end
  4: begin 
      a4=64'hc033bb4eabec0000;
      b4=64'hbfc3bcbf5a13c000;
      c4=64'h3feffd886084cd0d;
    end
  5: begin 
      a4=64'hc033ba5b30080000;
      b4=64'hbfc8ab93c7c8c000;
      c4=64'h3feffc251df1d3f9;
    end
  6: begin 
      a4=64'hc033b93706ee0000;
      b4=64'hbfcd9a2b567a4000;
      c4=64'h3feffa72effef75d;
    end
  7: begin 
      a4=64'hc033b7e2336a0000;
      b4=64'hbfd1443ced6c6000;
      c4=64'h3feff871dadb81e0;
    end
  8: begin 
      a4=64'hc033b65cb8ca0000;
      b4=64'hbfd3bb3995246000;
      c4=64'h3feff621e3796d7f;
    end
  9: begin 
      a4=64'hc033b4a69ace0000;
      b4=64'hbfd632058d80a000;
      c4=64'h3feff3830f8d575d;
    end
  10: begin 
      a4=64'hc033b2bfddb00000;
      b4=64'hbfd8a89ac2142000;
      c4=64'h3feff095658e71ae;
    end
  11: begin 
      a4=64'hc033b0a886200000;
      b4=64'hbfdb1ef31efa6000;
      c4=64'h3fefed58ecb673c5;
    end
  12: begin 
      a4=64'hc033ae6099460000;
      b4=64'hbfdd950890e36000;
      c4=64'h3fefe9cdad01883b;
    end
  13: begin 
      a4=64'hc033abe81cc20000;
      b4=64'hbfe0056a8292d000;
      c4=64'h3fefe5f3af2e3942;
    end
  14: begin 
      a4=64'hc033a93f16b20000;
      b4=64'hbfe1402934e55000;
      c4=64'h3fefe1cafcbd5b0a;
    end
  15: begin 
      a4=64'hc033a6658d9c0000;
      b4=64'hbfe27abd56cfe000;
      c4=64'h3fefdd539ff1f457;
    end
  16: begin 
      a4=64'hc033a35b88940000;
      b4=64'hbfe3b523e021e000;
      c4=64'h3fefd88da3d12527;
    end
  17: begin 
      a4=64'hc033a0210f0e0000;
      b4=64'hbfe4ef59c91ba000;
      c4=64'h3fefd37914220b86;
    end
  18: begin 
      a4=64'hc0339cb6290c0000;
      b4=64'hbfe6295c0a751000;
      c4=64'h3fefce15fd6da67d;
    end
  19: begin 
      a4=64'hc033991adef80000;
      b4=64'hbfe763279d657000;
      c4=64'h3fefc8646cfeb723;
    end
  20: begin 
      a4=64'hc033954f39b80000;
      b4=64'hbfe89cb97bab8000;
      c4=64'h3fefc26470e19fd5;
    end
  21: begin 
      a4=64'hc033915342a60000;
      b4=64'hbfe9d60e9f93e000;
      c4=64'h3fefbc1617e44188;
    end
  22: begin 
      a4=64'hc0338d27039e0000;
      b4=64'hbfeb0f2404012000;
      c4=64'h3fefb5797195d743;
    end
  23: begin 
      a4=64'hc03388ca86e60000;
      b4=64'hbfec47f6a4736000;
      c4=64'h3fefae8e8e46cfbd;
    end
  24: begin 
      a4=64'hc033843dd7420000;
      b4=64'hbfed80837d0f3000;
      c4=64'h3fefa7557f08a519;
    end
  25: begin 
      a4=64'hc0337f80ffee0000;
      b4=64'hbfeeb8c78aa54000;
      c4=64'h3fef9fce55adb2cb;
    end
  26: begin 
      a4=64'hc0337a940c9a0000;
      b4=64'hbfeff0bfcaba3000;
      c4=64'h3fef97f924c9099d;
    end
  27: begin 
      a4=64'hc0337577096c0000;
      b4=64'hbff094349dc6b800;
      c4=64'h3fef8fd5ffae41dd;
    end
  28: begin 
      a4=64'hc033702a03020000;
      b4=64'hbff12fe06e107000;
      c4=64'h3fef8764fa714bac;
    end
  29: begin 
      a4=64'hc0336aad066e0000;
      b4=64'hbff1cb61d6203800;
      c4=64'h3fef7ea629e63d71;
    end
  30: begin 
      a4=64'hc033650021400000;
      b4=64'hbff266b756448000;
      c4=64'h3fef7599a3a1207a;
    end
  31: begin 
      a4=64'hc0335f2361760000;
      b4=64'hbff301df6f384000;
      c4=64'h3fef6c3f7df5bbba;
    end
  32: begin 
      a4=64'hc0335916d5840000;
      b4=64'hbff39cd8a2264000;
      c4=64'h3fef6297cff75cb3;
    end
  33: begin 
      a4=64'hc03352da8c5c0000;
      b4=64'hbff437a170ad4000;
      c4=64'h3fef58a2b1789e88;
    end
  34: begin 
      a4=64'hc0334c6e95600000;
      b4=64'hbff4d2385ce32000;
      c4=64'h3fef4e603b0b2f30;
    end
  35: begin 
      a4=64'hc03345d300660000;
      b4=64'hbff56c9be9591000;
      c4=64'h3fef43d085ff92e0;
    end
  36: begin 
      a4=64'hc0333f07ddba0000;
      b4=64'hbff606ca991ef000;
      c4=64'h3fef38f3ac64e58d;
    end
  37: begin 
      a4=64'hc033380d3e240000;
      b4=64'hbff6a0c2efc6f800;
      c4=64'h3fef2dc9c9089aa1;
    end
  38: begin 
      a4=64'hc03330e332da0000;
      b4=64'hbff73a8371699000;
      c4=64'h3fef2252f7763add;
    end
  39: begin 
      a4=64'hc0332989cd8a0000;
      b4=64'hbff7d40aa2a8e800;
      c4=64'h3fef168f53f72061;
    end
  40: begin 
      a4=64'hc033220120540000;
      b4=64'hbff86d5708b48000;
      c4=64'h3fef0a7efb9230db;
    end
  41: begin 
      a4=64'hc0331a493dd00000;
      b4=64'hbff90667294d1800;
      c4=64'h3feefe220c0b95f1;
    end
  42: begin 
      a4=64'hc0331262390a0000;
      b4=64'hbff99f398ac7e000;
      c4=64'h3feef178a3e473c7;
    end
  43: begin 
      a4=64'hc0330a4c25820000;
      b4=64'hbffa37ccb412a800;
      c4=64'h3feee482e25a9dc0;
    end
  44: begin 
      a4=64'hc0330207172c0000;
      b4=64'hbffad01f2cb71000;
      c4=64'h3feed740e7684968;
    end
  45: begin 
      a4=64'hc032f993226a0000;
      b4=64'hbffb682f7cde7800;
      c4=64'h3feec9b2d3c3bf89;
    end
  46: begin 
      a4=64'hc032f0f05c200000;
      b4=64'hbffbfffc2d555000;
      c4=64'h3feebbd8c8df0b79;
    end
  47: begin 
      a4=64'hc032e81ed9980000;
      b4=64'hbffc9783c78f0800;
      c4=64'h3feeadb2e8e7a893;
    end
  48: begin 
      a4=64'hc032df1eb0920000;
      b4=64'hbffd2ec4d5a98000;
      c4=64'h3fee9f4156c62ddf;
    end
  49: begin 
      a4=64'hc032d5eff74a0000;
      b4=64'hbffdc5bde270a000;
      c4=64'h3fee9084361df7f8;
    end
  50: begin 
      a4=64'hc032cc92c4620000;
      b4=64'hbffe5c6d79620800;
      c4=64'h3fee817bab4cd112;
    end
  51: begin 
      a4=64'hc032c3072ef80000;
      b4=64'hbffef2d226b08800;
      c4=64'h3fee7227db6a974a;
    end
  52: begin 
      a4=64'hc032b94d4e980000;
      b4=64'hbfff88ea7747c800;
      c4=64'h3fee6288ec48e118;
    end
  53: begin 
      a4=64'hc032af653b420000;
      b4=64'hc0000f5a7c67fc00;
      c4=64'h3fee529f0472a002;
    end
  54: begin 
      a4=64'hc032a54f0d680000;
      b4=64'hc0005a181cd88c00;
      c4=64'h3fee426a4b2bc184;
    end
  55: begin 
      a4=64'hc0329b0addec0000;
      b4=64'hc000a4ad648b6c00;
      c4=64'h3fee31eae870ce2a;
    end
  56: begin 
      a4=64'hc0329098c6220000;
      b4=64'hc000ef199b79f400;
      c4=64'h3fee212104f686eb;
    end
  57: begin 
      a4=64'hc03285f8dfd20000;
      b4=64'hc001395c0a02dc00;
      c4=64'h3fee100cca2980b2;
    end
  58: begin 
      a4=64'hc0327b2b45340000;
      b4=64'hc0018373f8ebec00;
      c4=64'h3fedfeae622dbe31;
    end
  59: begin 
      a4=64'hc032703010ec0000;
      b4=64'hc001cd60b163c400;
      c4=64'h3feded05f7de47e0;
    end
  60: begin 
      a4=64'hc03265075e160000;
      b4=64'hc00217217d03b000;
      c4=64'h3feddb13b6ccc243;
    end
  61: begin 
      a4=64'hc03259b1483a0000;
      b4=64'hc00260b5a5d15400;
      c4=64'h3fedc8d7cb410267;
    end
  62: begin 
      a4=64'hc0324e2deb4e0000;
      b4=64'hc002aa1c76407c00;
      c4=64'h3fedb6526238a0a2;
    end
  63: begin 
      a4=64'hc032427d63be0000;
      b4=64'hc002f3553934c400;
      c4=64'h3feda383a966898f;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a5=64'hc032369fce5e0000;
      b5=64'hc0033c5f3a039000;
      c5=64'h3fed906bcf328d4d;
    end
  1: begin 
      a5=64'hc0322a9548780000;
      b5=64'hc0038539c4758000;
      c5=64'h3fed7d0b02b8ed01;
    end
  2: begin 
      a5=64'hc0321e5defc20000;
      b5=64'hc003cde424c85800;
      c5=64'h3fed696173c9e692;
    end
  3: begin 
      a5=64'hc03211f9e25e0000;
      b5=64'hc004165da7b0bc00;
      c5=64'h3fed556f52e93eb8;
    end
  4: begin 
      a5=64'hc03205693ede0000;
      b5=64'hc0045ea59a5bdc00;
      c5=64'h3fed4134d14dc941;
    end
  5: begin 
      a5=64'hc031f8ac24480000;
      b5=64'hc004a6bb4a713400;
      c5=64'h3fed2cb220e0efa6;
    end
  6: begin 
      a5=64'hc031ebc2b2020000;
      b5=64'hc004ee9e06144400;
      c5=64'h3fed17e7743e35e3;
    end
  7: begin 
      a5=64'hc031dead07ee0000;
      b5=64'hc005364d1be64400;
      c5=64'h3fed02d4feb2bd9b;
    end
  8: begin 
      a5=64'hc031d16b46560000;
      b5=64'hc0057dc7db07d000;
      c5=64'h3feced7af43cc77b;
    end
  9: begin 
      a5=64'hc031c3fd8dea0000;
      b5=64'hc005c50d931ac400;
      c5=64'h3fecd7d9898b32ff;
    end
  10: begin 
      a5=64'hc031b663ffd40000;
      b5=64'hc0060c1d9443b400;
      c5=64'h3fecc1f0f3fcfc64;
    end
  11: begin 
      a5=64'hc031a89ebd9a0000;
      b5=64'hc00652f72f2bd800;
      c5=64'h3fecabc169a0b90a;
    end
  12: begin 
      a5=64'hc0319aade9400000;
      b5=64'hc0069999b5028400;
      c5=64'h3fec954b213411fd;
    end
  13: begin 
      a5=64'hc0318c91a51e0000;
      b5=64'hc006e004777f1800;
      c5=64'h3fec7e8e52233cfb;
    end
  14: begin 
      a5=64'hc0317e4a14120000;
      b5=64'hc0072636c8e27000;
      c5=64'h3fec678b348873a4;
    end
  15: begin 
      a5=64'hc0316fd759520000;
      b5=64'hc0076c2ffbf8b400;
      c5=64'h3fec5042012b690f;
    end
  16: begin 
      a5=64'hc031613998840000;
      b5=64'hc007b1ef641afc00;
      c5=64'h3fec38b2f180bdba;
    end
  17: begin 
      a5=64'hc0315270f5b60000;
      b5=64'hc007f7745530f800;
      c5=64'h3fec20de3fa971b8;
    end
  18: begin 
      a5=64'hc031437d956a0000;
      b5=64'hc0083cbe23b29c00;
      c5=64'h3fec08c426725553;
    end
  19: begin 
      a5=64'hc031345f9c7a0000;
      b5=64'hc00881cc24a9bc00;
      c5=64'h3febf064e15377e6;
    end
  20: begin 
      a5=64'hc031251730380000;
      b5=64'hc008c69dadb3d000;
      c5=64'h3febd7c0ac6f9534;
    end
  21: begin 
      a5=64'hc03115a4765e0000;
      b5=64'hc0090b3215035800;
      c5=64'h3febbed7c49380f3;
    end
  22: begin 
      a5=64'hc031060794fe0000;
      b5=64'hc0094f88b161ec00;
      c5=64'h3feba5aa673590dd;
    end
  23: begin 
      a5=64'hc030f640b2ae0000;
      b5=64'hc00993a0da315000;
      c5=64'h3feb8c38d27504f2;
    end
  24: begin 
      a5=64'hc030e64ff64a0000;
      b5=64'hc009d779e76da400;
      c5=64'h3feb728345196e48;
    end
  25: begin 
      a5=64'hc030d63587340000;
      b5=64'hc00a1b1331ae8800;
      c5=64'h3feb5889fe92140f;
    end
  26: begin 
      a5=64'hc030c5f18d1e0000;
      b5=64'hc00a5e6c12292400;
      c5=64'h3feb3e4d3ef5571d;
    end
  27: begin 
      a5=64'hc030b58430380000;
      b5=64'hc00aa183e2b14400;
      c5=64'h3feb23cd470013bf;
    end
  28: begin 
      a5=64'hc030a4ed98f80000;
      b5=64'hc00ae459fdbb9c00;
      c5=64'h3feb090a58150209;
    end
  29: begin 
      a5=64'hc030942df05a0000;
      b5=64'hc00b26edbe5eb000;
      c5=64'h3feaee04b43c147f;
    end
  30: begin 
      a5=64'hc03083455fa80000;
      b5=64'hc00b693e8054e800;
      c5=64'h3fead2bc9e21d51b;
    end
  31: begin 
      a5=64'hc030723410a80000;
      b5=64'hc00bab4b9ffde400;
      c5=64'h3feab7325916c0e0;
    end
  32: begin 
      a5=64'hc03060fa2d660000;
      b5=64'hc00bed147a603c00;
      c5=64'h3fea9b66290ea1ad;
    end
  33: begin 
      a5=64'hc0304f97e06e0000;
      b5=64'hc00c2e986d2ae000;
      c5=64'h3fea7f58529fe6a8;
    end
  34: begin 
      a5=64'hc0303e0d549e0000;
      b5=64'hc00c6fd6d6b6e000;
      c5=64'h3fea63091b02faed;
    end
  35: begin 
      a5=64'hc0302c5ab5400000;
      b5=64'hc00cb0cf1608c800;
      c5=64'h3fea4678c8119ad4;
    end
  36: begin 
      a5=64'hc0301a802e040000;
      b5=64'hc00cf1808ad24400;
      c5=64'h3fea29a7a046278d;
    end
  37: begin 
      a5=64'hc030087deaee0000;
      b5=64'hc00d31ea9573c400;
      c5=64'h3fea0c95eabaf943;
    end
  38: begin 
      a5=64'hc02feca830f40000;
      b5=64'hc00d720c96fdc800;
      c5=64'h3fe9ef43ef29afa0;
    end
  39: begin 
      a5=64'hc02fc805c6d80000;
      b5=64'hc00db1e5f132bc00;
      c5=64'h3fe9d1b1f5ea80e2;
    end
  40: begin 
      a5=64'hc02fa314f2040000;
      b5=64'hc00df17606881c00;
      c5=64'h3fe9b3e047f3874d;
    end
  41: begin 
      a5=64'hc02f7dd60d800000;
      b5=64'hc00e30bc3a286400;
      c5=64'h3fe995cf2ed80d30;
    end
  42: begin 
      a5=64'hc02f584975580000;
      b5=64'hc00e6fb7eff41000;
      c5=64'h3fe9777ef4c7d74e;
    end
  43: begin 
      a5=64'hc02f326f860c0000;
      b5=64'hc00eae688c83d000;
      c5=64'h3fe958efe48e6de2;
    end
  44: begin 
      a5=64'hc02f0c489d200000;
      b5=64'hc00eeccd75293c00;
      c5=64'h3fe93a2249926408;
    end
  45: begin 
      a5=64'hc02ee5d5189c0000;
      b5=64'hc00f2ae60ff0f400;
      c5=64'h3fe91b166fd49dae;
    end
  46: begin 
      a5=64'hc02ebf1557780000;
      b5=64'hc00f68b1c3a3cc00;
      c5=64'h3fe8fbcca3ef941a;
    end
  47: begin 
      a5=64'hc02e9809b9380000;
      b5=64'hc00fa62ff7c85000;
      c5=64'h3fe8dc45331698d8;
    end
  48: begin 
      a5=64'hc02e70b29e4c0000;
      b5=64'hc00fe36014a44c00;
      c5=64'h3fe8bc806b15174f;
    end
  49: begin 
      a5=64'hc02e491067b00000;
      b5=64'hc0101020c19f1c00;
      c5=64'h3fe89c7e9a4dd4b7;
    end
  50: begin 
      a5=64'hc02e212377340000;
      b5=64'hc0102e69d6af5e00;
      c5=64'h3fe87c400fba2ecd;
    end
  51: begin 
      a5=64'hc02df8ec2f700000;
      b5=64'hc0104c8afec8f600;
      c5=64'h3fe85bc51ae958da;
    end
  52: begin 
      a5=64'hc02dd06af3840000;
      b5=64'hc0106a83ef949000;
      c5=64'h3fe83b0e0bff977d;
    end
  53: begin 
      a5=64'hc02da7a027740000;
      b5=64'hc01088545f1df400;
      c5=64'h3fe81a1b33b57ad9;
    end
  54: begin 
      a5=64'hc02d7e8c2fcc0000;
      b5=64'hc010a5fc03d4fa00;
      c5=64'h3fe7f8ece3571780;
    end
  55: begin 
      a5=64'hc02d552f72080000;
      b5=64'hc010c37a948dfc00;
      c5=64'h3fe7d7836cc33dc0;
    end
  56: begin 
      a5=64'hc02d2b8a541c0000;
      b5=64'hc010e0cfc882d800;
      c5=64'h3fe7b5df226aafbf;
    end
  57: begin 
      a5=64'hc02d019d3ce40000;
      b5=64'hc010fdfb57535000;
      c5=64'h3fe79400574f55f3;
    end
  58: begin 
      a5=64'hc02cd76893b00000;
      b5=64'hc0111afcf9061000;
      c5=64'h3fe771e75f03726f;
    end
  59: begin 
      a5=64'hc02cacecc0c80000;
      b5=64'hc01137d466091800;
      c5=64'h3fe74f948da8d29c;
    end
  60: begin 
      a5=64'hc02c822a2cdc0000;
      b5=64'hc01154815732a000;
      c5=64'h3fe72d0837efffa4;
    end
  61: begin 
      a5=64'hc02c5721418c0000;
      b5=64'hc011710385c1a000;
      c5=64'h3fe70a42b3176d89;
    end
  62: begin 
      a5=64'hc02c2bd268ec0000;
      b5=64'hc0118d5aab5ea600;
      c5=64'h3fe6e74454eaa8bd;
    end
  63: begin 
      a5=64'hc02c003e0df00000;
      b5=64'hc011a986821c5e00;
      c5=64'h3fe6c40d73c18285;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a6=64'hc02bd4649c0c0000;
      b6=64'hc011c586c4785600;
      c6=64'h3fe6a09e667f3bdb;
    end
  1: begin 
      a6=64'hc02ba8467f7c0000;
      b6=64'hc011e15b2d5bac00;
      c6=64'h3fe67cf78491af20;
    end
  2: begin 
      a6=64'hc02b7be4251c0000;
      b6=64'hc011fd03781b9a00;
      c6=64'h3fe6591925f0784d;
    end
  3: begin 
      a6=64'hc02b4f3dfa680000;
      b6=64'hc012187f607a5400;
      c6=64'h3fe63503a31c1bfa;
    end
  4: begin 
      a6=64'hc02b22546d980000;
      b6=64'hc01233cea2a76800;
      c6=64'h3fe610b7551d2cee;
    end
  5: begin 
      a6=64'hc02af527ed680000;
      b6=64'hc0124ef0fb40c000;
      c6=64'h3fe5ec3495837086;
    end
  6: begin 
      a6=64'hc02ac7b8e9680000;
      b6=64'hc01269e62752ea00;
      c6=64'h3fe5c77bbe65019c;
    end
  7: begin 
      a6=64'hc02a9a07d1980000;
      b6=64'hc01284ade45a0e00;
      c6=64'h3fe5a28d2a5d7262;
    end
  8: begin 
      a6=64'hc02a6c1516d00000;
      b6=64'hc0129f47f0424c00;
      c6=64'h3fe57d69348cecb0;
    end
  9: begin 
      a6=64'hc02a3de12a540000;
      b6=64'hc012b9b40968a600;
      c6=64'h3fe5581038975147;
    end
  10: begin 
      a6=64'hc02a0f6c7e3c0000;
      b6=64'hc012d3f1ee9b6000;
      c6=64'h3fe5328292a355a7;
    end
  11: begin 
      a6=64'hc029e0b785100000;
      b6=64'hc012ee015f1ad000;
      c6=64'h3fe50cc09f59a0ab;
    end
  12: begin 
      a6=64'hc029b1c2b2280000;
      b6=64'hc01307e21a99de00;
      c6=64'h3fe4e6cabbe3e5fb;
    end
  13: begin 
      a6=64'hc029828e79480000;
      b6=64'hc0132193e13ec000;
      c6=64'h3fe4c0a145ec0014;
    end
  14: begin 
      a6=64'hc029531b4f000000;
      b6=64'hc0133b1673a37800;
      c6=64'h3fe49a449b9b094b;
    end
  15: begin 
      a6=64'hc0292369a8500000;
      b6=64'hc013546992d69000;
      c6=64'h3fe473b51b987358;
    end
  16: begin 
      a6=64'hc028f379fae80000;
      b6=64'hc0136d8d005ba000;
      c6=64'h3fe44cf325091de9;
    end
  17: begin 
      a6=64'hc028c34cbd240000;
      b6=64'hc01386807e2bdc00;
      c6=64'h3fe425ff178e6bc3;
    end
  18: begin 
      a6=64'hc02892e265cc0000;
      b6=64'hc0139f43ceb6e200;
      c6=64'h3fe3fed9534556e7;
    end
  19: begin 
      a6=64'hc028623b6c640000;
      b6=64'hc013b7d6b4e31200;
      c6=64'h3fe3d78238c58355;
    end
  20: begin 
      a6=64'hc028315848e80000;
      b6=64'hc013d038f40e5a00;
      c6=64'h3fe3affa292050cd;
    end
  21: begin 
      a6=64'hc028003974080000;
      b6=64'hc013e86a500e9200;
      c6=64'h3fe3884185dfeb34;
    end
  22: begin 
      a6=64'hc027cedf66ec0000;
      b6=64'hc014006a8d325800;
      c6=64'h3fe36058b1065a07;
    end
  23: begin 
      a6=64'hc0279d4a9b6c0000;
      b6=64'hc014183970415a00;
      c6=64'h3fe338400d0c8e69;
    end
  24: begin 
      a6=64'hc0276b7b8bbc0000;
      b6=64'hc0142fd6be7d3000;
      c6=64'h3fe30ff7fce17046;
    end
  25: begin 
      a6=64'hc0273972b2e40000;
      b6=64'hc01447423da1a400;
      c6=64'h3fe2e780e3e8ea2a;
    end
  26: begin 
      a6=64'hc02707308c3c0000;
      b6=64'hc0145e7bb3e58200;
      c6=64'h3fe2bedb25faf3fc;
    end
  27: begin 
      a6=64'hc026d4b593e00000;
      b6=64'hc0147582e7faf600;
      c6=64'h3fe2960727629cbc;
    end
  28: begin 
      a6=64'hc026a20246440000;
      b6=64'hc0148c57a1103e00;
      c6=64'h3fe26d054cdd12f1;
    end
  29: begin 
      a6=64'hc0266f17209c0000;
      b6=64'hc014a2f9a6d01600;
      c6=64'h3fe243d5fb98ac33;
    end
  30: begin 
      a6=64'hc0263bf4a0740000;
      b6=64'hc014b968c1626400;
      c6=64'h3fe21a799933eb6b;
    end
  31: begin 
      a6=64'hc026089b43fc0000;
      b6=64'hc014cfa4b96cac00;
      c6=64'h3fe1f0f08bbc862f;
    end
  32: begin 
      a6=64'hc025d50b89fc0000;
      b6=64'hc014e5ad58128800;
      c6=64'h3fe1c73b39ae68db;
    end
  33: begin 
      a6=64'hc025a145f18c0000;
      b6=64'hc014fb8266f67400;
      c6=64'h3fe19d5a09f2b9cd;
    end
  34: begin 
      a6=64'hc0256d4afa8c0000;
      b6=64'hc0151123b039e800;
      c6=64'h3fe1734d63dedb5c;
    end
  35: begin 
      a6=64'hc025391b25180000;
      b6=64'hc0152690fe7e5a00;
      c6=64'h3fe14915af336d01;
    end
  36: begin 
      a6=64'hc02504b6f21c0000;
      b6=64'hc0153bca1ce54400;
      c6=64'h3fe11eb3541b4b37;
    end
  37: begin 
      a6=64'hc024d01ee2b80000;
      b6=64'hc01550ced7111c00;
      c6=64'h3fe0f426bb2a8e93;
    end
  38: begin 
      a6=64'hc0249b5378d80000;
      b6=64'hc015659ef9256c00;
      c6=64'h3fe0c9704d5d89a3;
    end
  39: begin 
      a6=64'hc024665536940000;
      b6=64'hc0157a3a4fc7ae00;
      c6=64'h3fe09e907417c5f3;
    end
  40: begin 
      a6=64'hc02431249ed40000;
      b6=64'hc0158ea0a81f8200;
      c6=64'h3fe0738799230003;
    end
  41: begin 
      a6=64'hc023fbc234b40000;
      b6=64'hc015a2d1cfd75800;
      c6=64'h3fe0485626ae222e;
    end
  42: begin 
      a6=64'hc023c62e7c0c0000;
      b6=64'hc015b6cd951cd200;
      c6=64'h3fe01cfc874c3ecc;
    end
  43: begin 
      a6=64'hc0239069f8f20000;
      b6=64'hc015ca93c6a15c00;
      c6=64'h3fdfe2f64be71238;
    end
  44: begin 
      a6=64'hc0235a75302c0000;
      b6=64'hc015de24339a7f00;
      c6=64'h3fdf8ba4dbf89ae6;
    end
  45: begin 
      a6=64'hc0232450a6be0000;
      b6=64'hc015f17eabc28400;
      c6=64'h3fdf3405963fd090;
    end
  46: begin 
      a6=64'hc022edfce2500000;
      b6=64'hc01604a2ff58ca00;
      c6=64'h3fdedc1952ef7902;
    end
  47: begin 
      a6=64'hc022b77a68fa0000;
      b6=64'hc0161790ff223700;
      c6=64'h3fde83e0eaf8513e;
    end
  48: begin 
      a6=64'hc02280c9c1200000;
      b6=64'hc0162a487c69ea00;
      c6=64'h3fde2b5d3806f669;
    end
  49: begin 
      a6=64'hc02249eb71d00000;
      b6=64'hc0163cc949014a00;
      c6=64'h3fddd28f1481cc83;
    end
  50: begin 
      a6=64'hc02212e0024e0000;
      b6=64'hc0164f133740e600;
      c6=64'h3fdd79775b86e3b8;
    end
  51: begin 
      a6=64'hc021dba7fa880000;
      b6=64'hc01661261a087a00;
      c6=64'h3fdd2016e8e9db86;
    end
  52: begin 
      a6=64'hc021a443e2a20000;
      b6=64'hc0167301c4bfc500;
      c6=64'h3fdcc66e9931c48e;
    end
  53: begin 
      a6=64'hc0216cb443680000;
      b6=64'hc01684a60b569500;
      c6=64'h3fdc6c7f49970037;
    end
  54: begin 
      a6=64'hc02134f9a5ca0000;
      b6=64'hc0169612c2459300;
      c6=64'h3fdc1249d8011f10;
    end
  55: begin 
      a6=64'hc020fd14936c0000;
      b6=64'hc016a747be8e5b00;
      c6=64'h3fdbb7cf2304bd2f;
    end
  56: begin 
      a6=64'hc020c505961a0000;
      b6=64'hc016b844d5bc1f00;
      c6=64'h3fdb5d1009e15ceb;
    end
  57: begin 
      a6=64'hc0208ccd38460000;
      b6=64'hc016c909dde3ee00;
      c6=64'h3fdb020d6c7f4038;
    end
  58: begin 
      a6=64'hc020546c04880000;
      b6=64'hc016d996ada53500;
      c6=64'h3fdaa6c82b6d3ff5;
    end
  59: begin 
      a6=64'hc0201be286180000;
      b6=64'hc016e9eb1c2a0b00;
      c6=64'h3fda4b4127dea214;
    end
  60: begin 
      a6=64'hc01fc66290bc0000;
      b6=64'hc016fa070127b300;
      c6=64'h3fd9ef7943a8edb6;
    end
  61: begin 
      a6=64'hc01f54b1ae800000;
      b6=64'hc01709ea34deea00;
      c6=64'h3fd993716141be2f;
    end
  62: begin 
      a6=64'hc01ee2b37e3c0000;
      b6=64'hc0171994901c3a00;
      c6=64'h3fd9372a63bc9404;
    end
  63: begin 
      a6=64'hc01e706918dc0000;
      b6=64'hc0172905ec389d00;
      c6=64'h3fd8daa52ec8a4e1;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a7=64'hc01dfdd398ac0000;
      b7=64'hc017383e23197b00;
      c7=64'h3fd87de2a6aea991;
    end
  1: begin 
      a7=64'hc01d8af4182c0000;
      b7=64'hc017473d0f316d00;
      c7=64'h3fd820e3b04eaaf6;
    end
  2: begin 
      a7=64'hc01d17cbb2fc0000;
      b7=64'hc01756028b803b00;
      c7=64'h3fd7c3a9311dcd16;
    end
  3: begin 
      a7=64'hc01ca45b85100000;
      b7=64'hc017648e73939400;
      c7=64'h3fd766340f24192a;
    end
  4: begin 
      a7=64'hc01c30a4ab7c0000;
      b7=64'hc01772e0a3870400;
      c7=64'h3fd7088530fa45cf;
    end
  5: begin 
      a7=64'hc01bbca843700000;
      b7=64'hc01780f8f804b700;
      c7=64'h3fd6aa9d7dc77e43;
    end
  6: begin 
      a7=64'hc01b48676b680000;
      b7=64'hc0178ed74e457300;
      c7=64'h3fd64c7ddd3f27f7;
    end
  7: begin 
      a7=64'hc01ad3e341f80000;
      b7=64'hc0179c7b84112f00;
      c7=64'h3fd5ee27379ea6c1;
    end
  8: begin 
      a7=64'hc01a5f1ce6e00000;
      b7=64'hc017a9e577bf3800;
      c7=64'h3fd58f9a75ab200f;
    end
  9: begin 
      a7=64'hc019ea157a000000;
      b7=64'hc017b7150836ad00;
      c7=64'h3fd530d880af3c52;
    end
  10: begin 
      a7=64'hc01974ce1c600000;
      b7=64'hc017c40a14eeaf00;
      c7=64'h3fd4d1e24278e79d;
    end
  11: begin 
      a7=64'hc018ff47ef180000;
      b7=64'hc017d0c47deecd00;
      c7=64'h3fd472b8a5571083;
    end
  12: begin 
      a7=64'hc018898414480000;
      b7=64'hc017dd4423cf4200;
      c7=64'h3fd4135c94176635;
    end
  13: begin 
      a7=64'hc0181383ae980000;
      b7=64'hc017e988e7b93300;
      c7=64'h3fd3b3cefa0414e8;
    end
  14: begin 
      a7=64'hc0179d47e0fc0000;
      b7=64'hc017f592ab673400;
      c7=64'h3fd35410c2e18186;
    end
  15: begin 
      a7=64'hc01726d1cf680000;
      b7=64'hc018016151254500;
      c7=64'h3fd2f422daec03b8;
    end
  16: begin 
      a7=64'hc016b0229de80000;
      b7=64'hc0180cf4bbd16b00;
      c7=64'h3fd294062ed59f3b;
    end
  17: begin 
      a7=64'hc016393b71980000;
      b7=64'hc018184ccedba600;
      c7=64'h3fd233bbabc3bba4;
    end
  18: begin 
      a7=64'hc015c21d6f940000;
      b7=64'hc01823696e468e00;
      c7=64'h3fd1d3443f4cdb74;
    end
  19: begin 
      a7=64'hc0154ac9be180000;
      b7=64'hc0182e4a7ea73b00;
      c7=64'h3fd172a0d77651aa;
    end
  20: begin 
      a7=64'hc014d34183280000;
      b7=64'hc01838efe525ee00;
      c7=64'h3fd111d262b1f6a7;
    end
  21: begin 
      a7=64'hc0145b85e60c0000;
      b7=64'hc0184359877df600;
      c7=64'h3fd0b0d9cfdbdbc4;
    end
  22: begin 
      a7=64'hc013e3980df00000;
      b7=64'hc0184d874bfe2f00;
      c7=64'h3fd04fb80e37fddf;
    end
  23: begin 
      a7=64'hc0136b7923000000;
      b7=64'hc018577919891d00;
      c7=64'h3fcfdcdc1adfee63;
    end
  24: begin 
      a7=64'hc012f32a4d5a0000;
      b7=64'hc018612ed7954880;
      c7=64'h3fcf19f97b215f7e;
    end
  25: begin 
      a7=64'hc0127aacb6180000;
      b7=64'hc0186aa86e2d5c00;
      c7=64'h3fce56ca1e101a87;
    end
  26: begin 
      a7=64'hc012020186440000;
      b7=64'hc01873e5c5f07f00;
      c7=64'h3fcd934fe5454376;
    end
  27: begin 
      a7=64'hc0118929e7c00000;
      b7=64'hc0187ce6c8127580;
      c7=64'h3fcccf8cb312b2f4;
    end
  28: begin 
      a7=64'hc011102704d40000;
      b7=64'hc01885ab5e5bd200;
      c7=64'h3fcc0b826a7e4fca;
    end
  29: begin 
      a7=64'hc01096fa07d20000;
      b7=64'hc0188e33732a6680;
      c7=64'h3fcb4732ef3d6792;
    end
  30: begin 
      a7=64'hc0101da41bfe0000;
      b7=64'hc018967ef1711d00;
      c7=64'h3fca82a025b004b9;
    end
  31: begin 
      a7=64'hc00f484cd8e80000;
      b7=64'hc0189e8dc4b88f00;
      c7=64'h3fc9bdcbf2dc43d7;
    end
  32: begin 
      a7=64'hc00e55044a700000;
      b7=64'hc018a65fd91ed980;
      c7=64'h3fc8f8b83c69a675;
    end
  33: begin 
      a7=64'hc00d6170e4600000;
      b7=64'hc018adf51b582780;
      c7=64'h3fc83366e89c6539;
    end
  34: begin 
      a7=64'hc00c6d9500540000;
      b7=64'hc018b54d78ae8680;
      c7=64'h3fc76dd9de50bf9d;
    end
  35: begin 
      a7=64'hc00b7972f7400000;
      b7=64'hc018bc68df027400;
      c7=64'h3fc6a81304f64b17;
    end
  36: begin 
      a7=64'hc00a850d24280000;
      b7=64'hc018c3473ccab680;
      c7=64'h3fc5e214448b4034;
    end
  37: begin 
      a7=64'hc0099065e18c0000;
      b7=64'hc018c9e88114c080;
      c7=64'h3fc51bdf8597c658;
    end
  38: begin 
      a7=64'hc0089b7f8b940000;
      b7=64'hc018d04c9b84b780;
      c7=64'h3fc45576b1293ec9;
    end
  39: begin 
      a7=64'hc007a65c7e000000;
      b7=64'hc018d6737c55ba00;
      c7=64'h3fc38edbb0cd8d7c;
    end
  40: begin 
      a7=64'hc006b0ff16340000;
      b7=64'hc018dc5d1459e780;
      c7=64'h3fc2c8106e8e61ab;
    end
  41: begin 
      a7=64'hc005bb69b1140000;
      b7=64'hc018e20954faa780;
      c7=64'h3fc20116d4ec7c39;
    end
  42: begin 
      a7=64'hc004c59eacd00000;
      b7=64'hc018e7783038b200;
      c7=64'h3fc139f0cedaf5e9;
    end
  43: begin 
      a7=64'hc003cfa068240000;
      b7=64'hc018eca998ac2d80;
      c7=64'h3fc072a047ba8389;
    end
  44: begin 
      a7=64'hc002d97141840000;
      b7=64'hc018f19d81850480;
      c7=64'h3fbf564e56a973f7;
    end
  45: begin 
      a7=64'hc001e31398e40000;
      b7=64'hc018f653de8ab1c0;
      c7=64'h3fbdc70ecbaea0a4;
    end
  46: begin 
      a7=64'hc000ec89cda20000;
      b7=64'hc018facca41cb9c0;
      c7=64'h3fbc3785c79ec3c1;
    end
  47: begin 
      a7=64'hbfffebac81140000;
      b7=64'hc018ff07c7326b40;
      c7=64'h3fbaa7b724495ce1;
    end
  48: begin 
      a7=64'hbffdfdf6a3ac0000;
      b7=64'hc01903053d5b56c0;
      c7=64'h3fb917a6bc29b51b;
    end
  49: begin 
      a7=64'hbffc0ff6c6700000;
      b7=64'hc01906c4fcbf0a80;
      c7=64'h3fb787586a5d5c02;
    end
  50: begin 
      a7=64'hbffa21b1aacc0000;
      b7=64'hc0190a46fc1d8a80;
      c7=64'h3fb5f6d00a9aa4ec;
    end
  51: begin 
      a7=64'hbff8332c158c0000;
      b7=64'hc0190d8b32cf1200;
      c7=64'h3fb466117927217a;
    end
  52: begin 
      a7=64'hbff6446ac9e00000;
      b7=64'hc019109198c46540;
      c7=64'h3fb2d52092ce1acc;
    end
  53: begin 
      a7=64'hbff455728d880000;
      b7=64'hc019135a2686bc80;
      c7=64'h3fb1440134d70a9a;
    end
  54: begin 
      a7=64'hbff2664824d00000;
      b7=64'hc01915e4d537f9e0;
      c7=64'h3faf656e79f82292;
    end
  55: begin 
      a7=64'hbff076f056780000;
      b7=64'hc01918319e9297e0;
      c7=64'h3fac428d12c0d9b8;
    end
  56: begin 
      a7=64'hbfed0edfcf680000;
      b7=64'hc0191a407ce9da40;
      c7=64'h3fa91f65f10dd9cd;
    end
  57: begin 
      a7=64'hbfe92f973f440000;
      b7=64'hc0191c116b29c260;
      c7=64'h3fa5fc00d290cf1f;
    end
  58: begin 
      a7=64'hbfe550108b600000;
      b7=64'hc0191da464d71660;
      c7=64'h3fa2d8657594578c;
    end
  59: begin 
      a7=64'hbfe17055403a0000;
      b7=64'hc0191ef9660fa120;
      c7=64'h3f9f693731d1d2c5;
    end
  60: begin 
      a7=64'hbfdb20dddda00000;
      b7=64'hc01920106b89e660;
      c7=64'h3f992155f7a36a09;
    end
  61: begin 
      a7=64'hbfd360ce49160000;
      b7=64'hc01920e972958978;
      c7=64'h3f92d936bbe312ce;
    end
  62: begin 
      a7=64'hbfc7411dcc900000;
      b7=64'hc0192184791af460;
      c7=64'h3f8921d1fcdeceb3;
    end
  63: begin 
      a7=64'hbfaf019689240000;
      b7=64'hc01921e17d9bbcc4;
      c7=64'h3f7921f0fe670fe6;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a8=64'h3faf019689240000;
      b8=64'hc01922007f3245ec;
      c8=64'h3ced1a62633145c0;
    end
  1: begin 
      a8=64'h3fc7411dcc900000;
      b8=64'hc01921e17d9226a0;
      c8=64'hbf7921f0fe66f2cc;
    end
  2: begin 
      a8=64'h3fd360ce49160000;
      b8=64'hc01921847907d230;
      c8=64'hbf8921d1fcdec026;
    end
  3: begin 
      a8=64'h3fdb20dddda00000;
      b8=64'hc01920e97278d370;
      c8=64'hbf92d936bbe30b88;
    end
  4: begin 
      a8=64'h3fe1705540380000;
      b8=64'hc01920106b63a4c0;
      c8=64'hbf992155f7a362c3;
    end
  5: begin 
      a8=64'h3fe550108b600000;
      b8=64'hc0191ef965dfcc60;
      c8=64'hbf9f693731d1cb80;
    end
  6: begin 
      a8=64'h3fe92f973f400000;
      b8=64'hc0191da4649db6a0;
      c8=64'hbfa2d865759453ea;
    end
  7: begin 
      a8=64'h3fed0edfcf680000;
      b8=64'hc0191c116ae6d0a0;
      c8=64'hbfa5fc00d290cb7d;
    end
  8: begin 
      a8=64'h3ff076f056760000;
      b8=64'hc0191a407c9d66c0;
      c8=64'hbfa91f65f10dd62b;
    end
  9: begin 
      a8=64'h3ff2664824ce0000;
      b8=64'hc01918319e3c93c0;
      c8=64'hbfac428d12c0d617;
    end
  10: begin 
      a8=64'h3ff455728d880000;
      b8=64'hc01915e4d4d86d80;
      c8=64'hbfaf656e79f81ef1;
    end
  11: begin 
      a8=64'h3ff6446ac9e40000;
      b8=64'hc019135a261da140;
      c8=64'hbfb1440134d708ca;
    end
  12: begin 
      a8=64'h3ff8332c15900000;
      b8=64'hc01910919851c400;
      c8=64'hbfb2d52092ce18fb;
    end
  13: begin 
      a8=64'h3ffa21b1aacc0000;
      b8=64'hc0190d8b3252e400;
      c8=64'hbfb4661179271faa;
    end
  14: begin 
      a8=64'h3ffc0ff6c66c0000;
      b8=64'hc0190a46fb97d840;
      c8=64'hbfb5f6d00a9aa31c;
    end
  15: begin 
      a8=64'h3ffdfdf6a3a40000;
      b8=64'hc01906c4fc2fcc00;
      c8=64'hbfb787586a5d5a33;
    end
  16: begin 
      a8=64'h3fffebac81140000;
      b8=64'hc01903053cc28d80;
      c8=64'hbfb917a6bc29b34c;
    end
  17: begin 
      a8=64'h4000ec89cda20000;
      b8=64'hc018ff07c6902240;
      c8=64'hbfbaa7b724495b12;
    end
  18: begin 
      a8=64'h4001e31398e40000;
      b8=64'hc018facca370eac0;
      c8=64'hbfbc3785c79ec1f2;
    end
  19: begin 
      a8=64'h4002d97141860000;
      b8=64'hc018f653ddd56600;
      c8=64'hbfbdc70ecbae9ed5;
    end
  20: begin 
      a8=64'h4003cfa068240000;
      b8=64'hc018f19d80c63600;
      c8=64'hbfbf564e56a97229;
    end
  21: begin 
      a8=64'h4004c59eacd00000;
      b8=64'hc018eca997e3e600;
      c8=64'hbfc072a047ba82a2;
    end
  22: begin 
      a8=64'h4005bb69b1140000;
      b8=64'hc018e7782f66ec80;
      c8=64'hbfc139f0cedaf503;
    end
  23: begin 
      a8=64'h4006b0ff16300000;
      b8=64'hc018e209541f7480;
      c8=64'hbfc20116d4ec7b52;
    end
  24: begin 
      a8=64'h4007a65c7e000000;
      b8=64'hc018dc5d13753a00;
      c8=64'hbfc2c8106e8e60c5;
    end
  25: begin 
      a8=64'h40089b7f8b940000;
      b8=64'hc018d6737b679c00;
      c8=64'hbfc38edbb0cd8c96;
    end
  26: begin 
      a8=64'h40099065e18c0000;
      b8=64'hc018d04c9a8d2380;
      c8=64'hbfc45576b1293de3;
    end
  27: begin 
      a8=64'h400a850d242c0000;
      b8=64'hc018c9e88013c080;
      c8=64'hbfc51bdf8597c573;
    end
  28: begin 
      a8=64'h400b7972f7440000;
      b8=64'hc018c3473bc04580;
      c8=64'hbfc5e214448b3f4e;
    end
  29: begin 
      a8=64'h400c6d9500540000;
      b8=64'hc018bc68ddee9b00;
      c8=64'hbfc6a81304f64a32;
    end
  30: begin 
      a8=64'h400d6170e4600000;
      b8=64'hc018b54d77913f80;
      c8=64'hbfc76dd9de50beb8;
    end
  31: begin 
      a8=64'h400e55044a700000;
      b8=64'hc018adf51a317580;
      c8=64'hbfc83366e89c6454;
    end
  32: begin 
      a8=64'h400f484cd8e40000;
      b8=64'hc018a65fd7eec900;
      c8=64'hbfc8f8b83c69a590;
    end
  33: begin 
      a8=64'h40101da41bfe0000;
      b8=64'hc0189e8dc37f1c00;
      c8=64'hbfc9bdcbf2dc42f3;
    end
  34: begin 
      a8=64'h401096fa07d40000;
      b8=64'hc018967ef02e5000;
      c8=64'hbfca82a025b003d5;
    end
  35: begin 
      a8=64'h4011102704d40000;
      b8=64'hc0188e3371de3c00;
      c8=64'hbfcb4732ef3d66ae;
    end
  36: begin 
      a8=64'h40118929e7c00000;
      b8=64'hc01885ab5d065600;
      c8=64'hbfcc0b826a7e4ee6;
    end
  37: begin 
      a8=64'h4012020186460000;
      b8=64'hc0187ce6c6b3a180;
      c8=64'hbfcccf8cb312b211;
    end
  38: begin 
      a8=64'h40127aacb6160000;
      b8=64'hc01873e5c4886780;
      c8=64'hbfcd934fe5454294;
    end
  39: begin 
      a8=64'h4012f32a4d5a0000;
      b8=64'hc0186aa86cbbf500;
      c8=64'hbfce56ca1e1019a5;
    end
  40: begin 
      a8=64'h40136b7923000000;
      b8=64'hc018612ed61a9c80;
      c8=64'hbfcf19f97b215e9c;
    end
  41: begin 
      a8=64'h4013e3980df40000;
      b8=64'hc018577918052800;
      c8=64'hbfcfdcdc1adfed81;
    end
  42: begin 
      a8=64'h40145b85e60c0000;
      b8=64'hc0184d874a70fc00;
      c8=64'hbfd04fb80e37fd6e;
    end
  43: begin 
      a8=64'h4014d34183240000;
      b8=64'hc018435985e78200;
      c8=64'hbfd0b0d9cfdbdb54;
    end
  44: begin 
      a8=64'h40154ac9be140000;
      b8=64'hc01838efe3864500;
      c8=64'hbfd111d262b1f637;
    end
  45: begin 
      a8=64'h4015c21d6f900000;
      b8=64'hc0182e4a7cfe5700;
      c8=64'hbfd172a0d776513a;
    end
  46: begin 
      a8=64'h4016393b71980000;
      b8=64'hc01823696c947100;
      c8=64'hbfd1d3443f4cdb05;
    end
  47: begin 
      a8=64'h4016b0229dec0000;
      b8=64'hc018184ccd206100;
      c8=64'hbfd233bbabc3bb34;
    end
  48: begin 
      a8=64'h401726d1cf6c0000;
      b8=64'hc0180cf4ba0cfa00;
      c8=64'hbfd294062ed59ecc;
    end
  49: begin 
      a8=64'h40179d47e0fc0000;
      b8=64'hc01801614f57b200;
      c8=64'hbfd2f422daec0349;
    end
  50: begin 
      a8=64'h40181383ae980000;
      b8=64'hc017f592a9907f00;
      c8=64'hbfd35410c2e18117;
    end
  51: begin 
      a8=64'h4018898414440000;
      b8=64'hc017e988e5d96500;
      c8=64'hbfd3b3cefa041479;
    end
  52: begin 
      a8=64'h4018ff47ef180000;
      b8=64'hc017dd4421e65a00;
      c8=64'hbfd4135c941765c6;
    end
  53: begin 
      a8=64'h401974ce1c600000;
      b8=64'hc017d0c47bfcde00;
      c8=64'hbfd472b8a5571015;
    end
  54: begin 
      a8=64'h4019ea157a000000;
      b8=64'hc017c40a12f3ae00;
      c8=64'hbfd4d1e24278e72f;
    end
  55: begin 
      a8=64'h401a5f1ce6e40000;
      b8=64'hc017b7150632a800;
      c8=64'hbfd530d880af3be4;
    end
  56: begin 
      a8=64'h401ad3e341f80000;
      b8=64'hc017a9e575b22a00;
      c8=64'hbfd58f9a75ab1fa1;
    end
  57: begin 
      a8=64'h401b48676b640000;
      b8=64'hc0179c7b81fb2600;
      c8=64'hbfd5ee27379ea654;
    end
  58: begin 
      a8=64'h401bbca843700000;
      b8=64'hc0178ed74c266e00;
      c8=64'hbfd64c7ddd3f278a;
    end
  59: begin 
      a8=64'h401c30a4ab7c0000;
      b8=64'hc01780f8f5dcc100;
      c8=64'hbfd6aa9d7dc77dd7;
    end
  60: begin 
      a8=64'h401ca45b850c0000;
      b8=64'hc01772e0a1561a00;
      c8=64'hbfd7088530fa4562;
    end
  61: begin 
      a8=64'h401d17cbb2fc0000;
      b8=64'hc017648e7159bb00;
      c8=64'hbfd766340f2418bd;
    end
  62: begin 
      a8=64'h401d8af4182c0000;
      b8=64'hc0175602893d8300;
      c8=64'hbfd7c3a9311dccaa;
    end
  63: begin 
      a8=64'h401dfdd398b00000;
      b8=64'hc017473d0ce5d300;
      c8=64'hbfd820e3b04eaa8a;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a9=64'h401e706918dc0000;
      b9=64'hc017383e20c50b00;
      c9=64'hbfd87de2a6aea925;
    end
  1: begin 
      a9=64'h401ee2b37e340000;
      b9=64'hc0172905e9db5700;
      c9=64'hbfd8daa52ec8a476;
    end
  2: begin 
      a9=64'h401f54b1ae880000;
      b9=64'hc01719948db62c00;
      c9=64'hbfd9372a63bc9399;
    end
  3: begin 
      a9=64'h401fc66290b80000;
      b9=64'hc01709ea32701000;
      c9=64'hbfd993716141bdc4;
    end
  4: begin 
      a9=64'h40201be286180000;
      b9=64'hc016fa06feb02300;
      c9=64'hbfd9ef7943a8ed4c;
    end
  5: begin 
      a9=64'h4020546c04880000;
      b9=64'hc016e9eb19a9bb00;
      c9=64'hbfda4b4127dea1aa;
    end
  6: begin 
      a9=64'h40208ccd38480000;
      b9=64'hc016d996ab1c3400;
      c9=64'hbfdaa6c82b6d3f8b;
    end
  7: begin 
      a9=64'h4020c505961c0000;
      b9=64'hc016c909db523c00;
      c9=64'hbfdb020d6c7f3fce;
    end
  8: begin 
      a9=64'h4020fd14936c0000;
      b9=64'hc016b844d321c800;
      c9=64'hbfdb5d1009e15c81;
    end
  9: begin 
      a9=64'h402134f9a5cc0000;
      b9=64'hc016a747bbeb5e00;
      c9=64'hbfdbb7cf2304bcc6;
    end
  10: begin 
      a9=64'h40216cb4436a0000;
      b9=64'hc0169612bf99ff00;
      c9=64'hbfdc1249d8011ea7;
    end
  11: begin 
      a9=64'h4021a443e2a20000;
      b9=64'hc01684a608a26700;
      c9=64'hbfdc6c7f4996ffcf;
    end
  12: begin 
      a9=64'h4021dba7fa8a0000;
      b9=64'hc0167301c2030300;
      c9=64'hbfdcc66e9931c426;
    end
  13: begin 
      a9=64'h402212e0024e0000;
      b9=64'hc016612617433400;
      c9=64'hbfdd2016e8e9db1f;
    end
  14: begin 
      a9=64'h402249eb71d00000;
      b9=64'hc0164f1334731a00;
      c9=64'hbfdd79775b86e351;
    end
  15: begin 
      a9=64'h402280c9c1200000;
      b9=64'hc0163cc9462b0900;
      c9=64'hbfddd28f1481cc1c;
    end
  16: begin 
      a9=64'h4022b77a68fc0000;
      b9=64'hc0162a48798b3200;
      c9=64'hbfde2b5d3806f602;
    end
  17: begin 
      a9=64'h4022edfce2500000;
      b9=64'hc0161790fc3b1a00;
      c9=64'hbfde83e0eaf850d7;
    end
  18: begin 
      a9=64'h40232450a6c00000;
      b9=64'hc01604a2fc694300;
      c9=64'hbfdedc1952ef789c;
    end
  19: begin 
      a9=64'h40235a75302c0000;
      b9=64'hc015f17ea8caab00;
      c9=64'hbfdf3405963fd02a;
    end
  20: begin 
      a9=64'h40239069f8f20000;
      b9=64'hc015de24309a4e00;
      c9=64'hbfdf8ba4dbf89a80;
    end
  21: begin 
      a9=64'h4023c62e7c0c0000;
      b9=64'hc015ca93c398df00;
      c9=64'hbfdfe2f64be711d3;
    end
  22: begin 
      a9=64'h4023fbc234b40000;
      b9=64'hc015b6cd920c0c00;
      c9=64'hbfe01cfc874c3e9a;
    end
  23: begin 
      a9=64'h402431249ed40000;
      b9=64'hc015a2d1ccbe5400;
      c9=64'hbfe0485626ae21fc;
    end
  24: begin 
      a9=64'h4024665536900000;
      b9=64'hc0158ea0a4fe4000;
      c9=64'hbfe073879922ffd1;
    end
  25: begin 
      a9=64'h40249b5378d40000;
      b9=64'hc0157a3a4c9e4200;
      c9=64'hbfe09e907417c5c2;
    end
  26: begin 
      a9=64'h4024d01ee2b80000;
      b9=64'hc015659ef5f3d400;
      c9=64'hbfe0c9704d5d8972;
    end
  27: begin 
      a9=64'h402504b6f2180000;
      b9=64'hc01550ced3d75e00;
      c9=64'hbfe0f426bb2a8e62;
    end
  28: begin 
      a9=64'h4025391b251c0000;
      b9=64'hc0153bca19a37200;
      c9=64'hbfe11eb3541b4b05;
    end
  29: begin 
      a9=64'h40256d4afa880000;
      b9=64'hc0152690fb347200;
      c9=64'hbfe14915af336cd0;
    end
  30: begin 
      a9=64'h4025a145f18c0000;
      b9=64'hc0151123ace80000;
      c9=64'hbfe1734d63dedb2b;
    end
  31: begin 
      a9=64'h4025d50b89f80000;
      b9=64'hc014fb82639c8400;
      c9=64'hbfe19d5a09f2b99c;
    end
  32: begin 
      a9=64'h4026089b43fc0000;
      b9=64'hc014e5ad54b0a800;
      c9=64'hbfe1c73b39ae68ab;
    end
  33: begin 
      a9=64'h40263bf4a0740000;
      b9=64'hc014cfa4b602d800;
      c9=64'hbfe1f0f08bbc85ff;
    end
  34: begin 
      a9=64'h40266f1720a00000;
      b9=64'hc014b968bdf0b400;
      c9=64'hbfe21a799933eb3b;
    end
  35: begin 
      a9=64'h4026a20246440000;
      b9=64'hc014a2f9a3568200;
      c9=64'hbfe243d5fb98ac03;
    end
  36: begin 
      a9=64'h4026d4b593e40000;
      b9=64'hc0148c579d8ed600;
      c9=64'hbfe26d054cdd12c1;
    end
  37: begin 
      a9=64'h402707308c3c0000;
      b9=64'hc0147582e471be00;
      c9=64'hbfe2960727629c8c;
    end
  38: begin 
      a9=64'h40273972b2e40000;
      b9=64'hc0145e7bb0548a00;
      c9=64'hbfe2bedb25faf3cc;
    end
  39: begin 
      a9=64'h40276b7b8bbc0000;
      b9=64'hc01447423a08ec00;
      c9=64'hbfe2e780e3e8e9fb;
    end
  40: begin 
      a9=64'h40279d4a9b6c0000;
      b9=64'hc0142fd6badcc800;
      c9=64'hbfe30ff7fce17017;
    end
  41: begin 
      a9=64'h4027cedf66ec0000;
      b9=64'hc01418396c994600;
      c9=64'hbfe338400d0c8e3b;
    end
  42: begin 
      a9=64'h40280039740c0000;
      b9=64'hc014006a89829c00;
      c9=64'hbfe36058b10659d8;
    end
  43: begin 
      a9=64'h4028315848e80000;
      b9=64'hc013e86a4c574000;
      c9=64'hbfe3884185dfeb06;
    end
  44: begin 
      a9=64'h4028623b6c600000;
      b9=64'hc013d038f04f7600;
      c9=64'hbfe3affa2920509f;
    end
  45: begin 
      a9=64'h402892e265c80000;
      b9=64'hc013b7d6b11cae00;
      c9=64'hbfe3d78238c58328;
    end
  46: begin 
      a9=64'h4028c34cbd240000;
      b9=64'hc0139f43cae90000;
      c9=64'hbfe3fed9534556ba;
    end
  47: begin 
      a9=64'h4028f379faec0000;
      b9=64'hc01386807a568800;
      c9=64'hbfe425ff178e6b95;
    end
  48: begin 
      a9=64'h40292369a84c0000;
      b9=64'hc0136d8cfc7ede00;
      c9=64'hbfe44cf325091dbc;
    end
  49: begin 
      a9=64'h4029531b4f040000;
      b9=64'hc01354698ef27a00;
      c9=64'hbfe473b51b98732b;
    end
  50: begin 
      a9=64'h4029828e79480000;
      b9=64'hc0133b166fb80a00;
      c9=64'hbfe49a449b9b091e;
    end
  51: begin 
      a9=64'h4029b1c2b22c0000;
      b9=64'hc0132193dd4c0800;
      c9=64'hbfe4c0a145ebffe8;
    end
  52: begin 
      a9=64'h4029e0b785140000;
      b9=64'hc01307e2169fe200;
      c9=64'hbfe4e6cabbe3e5ce;
    end
  53: begin 
      a9=64'h402a0f6c7e3c0000;
      b9=64'hc012ee015b199c00;
      c9=64'hbfe50cc09f59a07f;
    end
  54: begin 
      a9=64'h402a3de12a540000;
      b9=64'hc012d3f1ea92fa00;
      c9=64'hbfe5328292a3557b;
    end
  55: begin 
      a9=64'h402a6c1516d40000;
      b9=64'hc012b9b405592000;
      c9=64'hbfe558103897511b;
    end
  56: begin 
      a9=64'h402a9a07d1980000;
      b9=64'hc0129f47ec2ba400;
      c9=64'hbfe57d69348cec85;
    end
  57: begin 
      a9=64'h402ac7b8e9680000;
      b9=64'hc01284ade03c5000;
      c9=64'hbfe5a28d2a5d7237;
    end
  58: begin 
      a9=64'h402af527ed6c0000;
      b9=64'hc01269e6232e2800;
      c9=64'hbfe5c77bbe650172;
    end
  59: begin 
      a9=64'h402b22546d980000;
      b9=64'hc0124ef0f7150200;
      c9=64'hbfe5ec349583705b;
    end
  60: begin 
      a9=64'h402b4f3dfa680000;
      b9=64'hc01233ce9e74ba00;
      c9=64'hbfe610b7551d2cc4;
    end
  61: begin 
      a9=64'h402b7be4251c0000;
      b9=64'hc012187f5c40b800;
      c9=64'hbfe63503a31c1bd0;
    end
  62: begin 
      a9=64'h402ba8467f780000;
      b9=64'hc011fd0373db2600;
      c9=64'hbfe6591925f07823;
    end
  63: begin 
      a9=64'h402bd4649c100000;
      b9=64'hc011e15b29146400;
      c9=64'hbfe67cf78491aef7;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a10=64'h402c003e0df00000;
      b10=64'hc011c586c02a4c00;
      c10=64'hbfe6a09e667f3bb2;
    end
  1: begin 
      a10=64'h402c2bd268ec0000;
      b10=64'hc011a9867dc79200;
      c10=64'hbfe6c40d73c1825c;
    end
  2: begin 
      a10=64'h402c5721418c0000;
      b10=64'hc0118d5aa7032c00;
      c10=64'hbfe6e74454eaa894;
    end
  3: begin 
      a10=64'h402c822a2cdc0000;
      b10=64'hc0117103815f7a00;
      c10=64'hbfe70a42b3176d61;
    end
  4: begin 
      a10=64'h402cacecc0c40000;
      b10=64'hc011548152c9de00;
      c10=64'hbfe72d0837efff7c;
    end
  5: begin 
      a10=64'h402cd76893b00000;
      b10=64'hc01137d46199c200;
      c10=64'hbfe74f948da8d274;
    end
  6: begin 
      a10=64'h402d019d3ce40000;
      b10=64'hc0111afcf4903600;
      c10=64'hbfe771e75f037247;
    end
  7: begin 
      a10=64'h402d2b8a541c0000;
      b10=64'hc010fdfb52d6f400;
      c10=64'hbfe79400574f55cc;
    end
  8: begin 
      a10=64'h402d552f720c0000;
      b10=64'hc010e0cfc4000800;
      c10=64'hbfe7b5df226aaf97;
    end
  9: begin 
      a10=64'h402d7e8c2fd00000;
      b10=64'hc010c37a9004c800;
      c10=64'hbfe7d7836cc33d99;
    end
  10: begin 
      a10=64'h402da7a027700000;
      b10=64'hc010a5fbff456400;
      c10=64'hbfe7f8ece3571759;
    end
  11: begin 
      a10=64'h402dd06af3840000;
      b10=64'hc01088545a881400;
      c10=64'hbfe81a1b33b57ab3;
    end
  12: begin 
      a10=64'h402df8ec2f640000;
      b10=64'hc0106a83eaf86200;
      c10=64'hbfe83b0e0bff9757;
    end
  13: begin 
      a10=64'h402e212377480000;
      b10=64'hc0104c8afa269c00;
      c10=64'hbfe85bc51ae958b4;
    end
  14: begin 
      a10=64'h402e491067b00000;
      b10=64'hc0102e69d206d000;
      c10=64'hbfe87c400fba2ea5;
    end
  15: begin 
      a10=64'h402e70b29e3c0000;
      b10=64'hc0101020bcf06a00;
      c10=64'hbfe89c7e9a4dd495;
    end
  16: begin 
      a10=64'h402e9809b9400000;
      b10=64'hc00fe3600b3ac800;
      c10=64'hbfe8bc806b15172a;
    end
  17: begin 
      a10=64'h402ebf1557780000;
      b10=64'hc00fa62fee52b800;
      c10=64'hbfe8dc45331698b4;
    end
  18: begin 
      a10=64'h402ee5d518980000;
      b10=64'hc00f68b1ba223400;
      c10=64'hbfe8fbcca3ef93f3;
    end
  19: begin 
      a10=64'h402f0c489d100000;
      b10=64'hc00f2ae606636800;
      c10=64'hbfe91b166fd49d8c;
    end
  20: begin 
      a10=64'h402f326f86140000;
      b10=64'hc00eeccd6b8ff000;
      c10=64'hbfe93a22499263e4;
    end
  21: begin 
      a10=64'h402f5849755c0000;
      b10=64'hc00eae6882dec800;
      c10=64'hbfe958efe48e6dbf;
    end
  22: begin 
      a10=64'h402f7dd60d840000;
      b10=64'hc00e6fb7e6436800;
      c10=64'hbfe9777ef4c7d729;
    end
  23: begin 
      a10=64'h402fa314f1f40000;
      b10=64'hc00e30bc306c1400;
      c10=64'hbfe995cf2ed80d0d;
    end
  24: begin 
      a10=64'h402fc805c6e80000;
      b10=64'hc00df175fcc07800;
      c10=64'hbfe9b3e047f3872a;
    end
  25: begin 
      a10=64'h402feca830f40000;
      b10=64'hc00db1e5e75fb800;
      c10=64'hbfe9d1b1f5ea80be;
    end
  26: begin 
      a10=64'h4030087deaee0000;
      b10=64'hc00d720c8d1f7c00;
      c10=64'hbfe9ef43ef29af80;
    end
  27: begin 
      a10=64'h40301a802e000000;
      b10=64'hc00d31ea8b8a4800;
      c10=64'hbfea0c95eabaf921;
    end
  28: begin 
      a10=64'h40302c5ab5460000;
      b10=64'hc00cf18080ddd000;
      c10=64'hbfea29a7a046276c;
    end
  29: begin 
      a10=64'h40303e0d549c0000;
      b10=64'hc00cb0cf0c095800;
      c10=64'hbfea4678c8119ab1;
    end
  30: begin 
      a10=64'h40304f97e0660000;
      b10=64'hc00c6fd6ccac8800;
      c10=64'hbfea63091b02face;
    end
  31: begin 
      a10=64'h403060fa2d6a0000;
      b10=64'hc00c2e986315d800;
      c10=64'hbfea7f58529fe688;
    end
  32: begin 
      a10=64'h4030723410aa0000;
      b10=64'hc00bed1470408400;
      c10=64'hbfea9b66290ea18d;
    end
  33: begin 
      a10=64'h403083455fac0000;
      b10=64'hc00bab4b95d39800;
      c10=64'hbfeab7325916c0bd;
    end
  34: begin 
      a10=64'h4030942df0560000;
      b10=64'hc00b693e76200c00;
      c10=64'hbfead2bc9e21d4fd;
    end
  35: begin 
      a10=64'h4030a4ed98fe0000;
      b10=64'hc00b26edb41f8400;
      c10=64'hbfeaee04b43c145f;
    end
  36: begin 
      a10=64'h4030b584303a0000;
      b10=64'hc00ae459f3722400;
      c10=64'hbfeb090a581501ea;
    end
  37: begin 
      a10=64'h4030c5f18d220000;
      b10=64'hc00aa183d85da400;
      c10=64'hbfeb23cd4700139e;
    end
  38: begin 
      a10=64'h4030d635872e0000;
      b10=64'hc00a5e6c07cb5400;
      c10=64'hbfeb3e4d3ef556fe;
    end
  39: begin 
      a10=64'h4030e64ff6500000;
      b10=64'hc00a1b132746d800;
      c10=64'hbfeb5889fe9213f1;
    end
  40: begin 
      a10=64'h4030f640b2ac0000;
      b10=64'hc009d779dcfc0400;
      c10=64'hbfeb728345196e29;
    end
  41: begin 
      a10=64'h4031060794fc0000;
      b10=64'hc00993a0cfb5e400;
      c10=64'hbfeb8c38d27504d7;
    end
  42: begin 
      a10=64'h403115a4765a0000;
      b10=64'hc0094f88a6dcc800;
      c10=64'hbfeba5aa673590c0;
    end
  43: begin 
      a10=64'h40312517303e0000;
      b10=64'hc0090b320a74c000;
      c10=64'hbfebbed7c49380d6;
    end
  44: begin 
      a10=64'h4031345f9c7a0000;
      b10=64'hc008c69da31ba800;
      c10=64'hbfebd7c0ac6f9515;
    end
  45: begin 
      a10=64'h4031437d95620000;
      b10=64'hc00881cc1a083000;
      c10=64'hbfebf064e15377cc;
    end
  46: begin 
      a10=64'h40315270f5ba0000;
      b10=64'hc0083cbe1907dc00;
      c10=64'hbfec08c426725537;
    end
  47: begin 
      a10=64'h4031613998860000;
      b10=64'hc007f7744a7d0c00;
      c10=64'hbfec20de3fa9719c;
    end
  48: begin 
      a10=64'h40316fd759500000;
      b10=64'hc007b1ef595df800;
      c10=64'hbfec38b2f180bd9d;
    end
  49: begin 
      a10=64'h40317e4a140e0000;
      b10=64'hc0076c2ff132b400;
      c10=64'hbfec5042012b68f6;
    end
  50: begin 
      a10=64'h40318c91a5240000;
      b10=64'hc0072636be139c00;
      c10=64'hbfec678b34887389;
    end
  51: begin 
      a10=64'h40319aade9420000;
      b10=64'hc006e0046ca78800;
      c10=64'hbfec7e8e52233ce0;
    end
  52: begin 
      a10=64'h4031a89ebd9c0000;
      b10=64'hc0069999aa224400;
      c10=64'hbfec954b213411e2;
    end
  53: begin 
      a10=64'h4031b663ffd00000;
      b10=64'hc00652f72442fc00;
      c10=64'hbfecabc169a0b8f0;
    end
  54: begin 
      a10=64'h4031c3fd8df00000;
      b10=64'hc0060c1d89527c00;
      c10=64'hbfecc1f0f3fcfc4b;
    end
  55: begin 
      a10=64'h4031d16b46560000;
      b10=64'hc005c50d88212c00;
      c10=64'hbfecd7d9898b32e4;
    end
  56: begin 
      a10=64'h4031dead07ec0000;
      b10=64'hc0057dc7d005f400;
      c10=64'hbfeced7af43cc764;
    end
  57: begin 
      a10=64'h4031ebc2b2000000;
      b10=64'hc005364d10dc4400;
      c10=64'hbfed02d4feb2bd82;
    end
  58: begin 
      a10=64'h4031f8ac244a0000;
      b10=64'hc004ee9dfb025800;
      c10=64'hbfed17e7743e35cb;
    end
  59: begin 
      a10=64'h403205693ede0000;
      b10=64'hc004a6bb3f575800;
      c10=64'hbfed2cb220e0ef8d;
    end
  60: begin 
      a10=64'h403211f9e25a0000;
      b10=64'hc0045ea58f3a2c00;
      c10=64'hbfed4134d14dc92b;
    end
  61: begin 
      a10=64'h40321e5defc40000;
      b10=64'hc004165d9c876000;
      c10=64'hbfed556f52e93ea1;
    end
  62: begin 
      a10=64'h40322a95487c0000;
      b10=64'hc003cde419976800;
      c10=64'hbfed696173c9e67b;
    end
  63: begin 
      a10=64'h4032369fce600000;
      b10=64'hc0038539b93d0c00;
      c10=64'hbfed7d0b02b8ece9;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a11=64'h4032427d63bc0000;
      b11=64'hc0033c5f2ec3b800;
      c11=64'hbfed906bcf328d38;
    end
  1: begin 
      a11=64'h40324e2deb520000;
      b11=64'hc002f3552dedb400;
      c11=64'hbfeda383a9668979;
    end
  2: begin 
      a11=64'h403259b1483c0000;
      b11=64'hc002aa1c6af24000;
      c11=64'hbfedb6526238a08b;
    end
  3: begin 
      a11=64'h403265075e160000;
      b11=64'hc00260b59a7c0c00;
      c11=64'hbfedc8d7cb410250;
    end
  4: begin 
      a11=64'h4032703010ea0000;
      b11=64'hc002172171a77000;
      c11=64'hbfeddb13b6ccc22f;
    end
  5: begin 
      a11=64'h40327b2b45360000;
      b11=64'hc001cd60a600c000;
      c11=64'hbfeded05f7de47cb;
    end
  6: begin 
      a11=64'h403285f8dfd20000;
      b11=64'hc0018373ed822800;
      c11=64'hbfedfeae622dbe1c;
    end
  7: begin 
      a11=64'h40329098c61e0000;
      b11=64'hc001395bfe927800;
      c11=64'hbfee100cca29809f;
    end
  8: begin 
      a11=64'h40329b0adde60000;
      b11=64'hc000ef1990030c00;
      c11=64'hbfee212104f686d8;
    end
  9: begin 
      a11=64'h4032a54f0d6a0000;
      b11=64'hc000a4ad590e3000;
      c11=64'hbfee31eae870ce17;
    end
  10: begin 
      a11=64'h4032af653b420000;
      b11=64'hc0005a1811550400;
      c11=64'hbfee426a4b2bc170;
    end
  11: begin 
      a11=64'h4032b94d4e980000;
      b11=64'hc0000f5a70de4400;
      c11=64'hbfee529f04729ff0;
    end
  12: begin 
      a11=64'h4032c3072efc0000;
      b11=64'hbfff88ea60285000;
      c11=64'hbfee6288ec48e105;
    end
  13: begin 
      a11=64'h4032cc92c4660000;
      b11=64'hbffef2d20f852800;
      c11=64'hbfee7227db6a9737;
    end
  14: begin 
      a11=64'h4032d5eff74a0000;
      b11=64'hbffe5c6d622af800;
      c11=64'hbfee817bab4cd0ff;
    end
  15: begin 
      a11=64'h4032df1eb0920000;
      b11=64'hbffdc5bdcb2e1800;
      c11=64'hbfee9084361df7e7;
    end
  16: begin 
      a11=64'h4032e81ed99a0000;
      b11=64'hbffd2ec4be5bd000;
      c11=64'hbfee9f4156c62dcf;
    end
  17: begin 
      a11=64'h4032f0f05c240000;
      b11=64'hbffc9783b0365800;
      c11=64'hbfeeadb2e8e7a881;
    end
  18: begin 
      a11=64'h4032f993226c0000;
      b11=64'hbffbfffc15f1d000;
      c11=64'hbfeebbd8c8df0b68;
    end
  19: begin 
      a11=64'h40330207172a0000;
      b11=64'hbffb682f65706000;
      c11=64'hbfeec9b2d3c3bf79;
    end
  20: begin 
      a11=64'h40330a4c25860000;
      b11=64'hbffad01f153ec800;
      c11=64'hbfeed740e7684958;
    end
  21: begin 
      a11=64'h40331262390c0000;
      b11=64'hbffa37cc9c904000;
      c11=64'hbfeee482e25a9db0;
    end
  22: begin 
      a11=64'h40331a493dce0000;
      b11=64'hbff99f39733b8800;
      c11=64'hbfeef178a3e473b9;
    end
  23: begin 
      a11=64'h4033220120520000;
      b11=64'hbff9066711b72000;
      c11=64'hbfeefe220c0b95e3;
    end
  24: begin 
      a11=64'h40332989cd8a0000;
      b11=64'hbff86d56f1153800;
      c11=64'hbfef0a7efb9230cd;
    end
  25: begin 
      a11=64'h403330e332da0000;
      b11=64'hbff7d40a8b006800;
      c11=64'hbfef168f53f72052;
    end
  26: begin 
      a11=64'h4033380d3e240000;
      b11=64'hbff73a8359b81000;
      c11=64'hbfef2252f7763ad1;
    end
  27: begin 
      a11=64'h40333f07ddbc0000;
      b11=64'hbff6a0c2d80cc800;
      c11=64'hbfef2dc9c9089a94;
    end
  28: begin 
      a11=64'h403345d300660000;
      b11=64'hbff606ca815c4000;
      c11=64'hbfef38f3ac64e57f;
    end
  29: begin 
      a11=64'h40334c6e95600000;
      b11=64'hbff56c9bd18e2800;
      c11=64'hbfef43d085ff92d3;
    end
  30: begin 
      a11=64'h403352da8c5c0000;
      b11=64'hbff4d23845101800;
      c11=64'hbfef4e603b0b2f25;
    end
  31: begin 
      a11=64'h40335916d5860000;
      b11=64'hbff437a158d27000;
      c11=64'hbfef58a2b1789e7c;
    end
  32: begin 
      a11=64'h40335f2361740000;
      b11=64'hbff39cd88a43e000;
      c11=64'hbfef6297cff75ca8;
    end
  33: begin 
      a11=64'h40336500213e0000;
      b11=64'hbff301df574e8000;
      c11=64'hbfef6c3f7df5bbaf;
    end
  34: begin 
      a11=64'h40336aad066c0000;
      b11=64'hbff266b73e53a000;
      c11=64'hbfef7599a3a12070;
    end
  35: begin 
      a11=64'h4033702a03020000;
      b11=64'hbff1cb61be287800;
      c11=64'hbfef7ea629e63d67;
    end
  36: begin 
      a11=64'h40337577096c0000;
      b11=64'hbff12fe056121000;
      c11=64'hbfef8764fa714ba2;
    end
  37: begin 
      a11=64'h40337a940c980000;
      b11=64'hbff0943485c1e000;
      c11=64'hbfef8fd5ffae41d4;
    end
  38: begin 
      a11=64'h40337f80ffee0000;
      b11=64'hbfeff0bf9aa42000;
      c11=64'hbfef97f924c90994;
    end
  39: begin 
      a11=64'h4033843dd7440000;
      b11=64'hbfeeb8c75a835000;
      c11=64'hbfef9fce55adb2c2;
    end
  40: begin 
      a11=64'h403388ca86e60000;
      b11=64'hbfed80834ce1c000;
      c11=64'hbfefa7557f08a510;
    end
  41: begin 
      a11=64'h40338d27039c0000;
      b11=64'hbfec47f6743af000;
      c11=64'hbfefae8e8e46cfb5;
    end
  42: begin 
      a11=64'h4033915342a80000;
      b11=64'hbfeb0f23d3be5000;
      c11=64'hbfefb5797195d73c;
    end
  43: begin 
      a11=64'h4033954f39b80000;
      b11=64'hbfe9d60e6f46f000;
      c11=64'hbfefbc1617e44180;
    end
  44: begin 
      a11=64'h4033991adef60000;
      b11=64'hbfe89cb94b550000;
      c11=64'hbfefc26470e19fce;
    end
  45: begin 
      a11=64'h40339cb6290a0000;
      b11=64'hbfe763276d05b000;
      c11=64'hbfefc8646cfeb71d;
    end
  46: begin 
      a11=64'h4033a0210f100000;
      b11=64'hbfe6295bda0cb000;
      c11=64'hbfefce15fd6da676;
    end
  47: begin 
      a11=64'h4033a35b88940000;
      b11=64'hbfe4ef5998ab2000;
      c11=64'hbfefd37914220b80;
    end
  48: begin 
      a11=64'h4033a6658d9c0000;
      b11=64'hbfe3b523afa9a000;
      c11=64'hbfefd88da3d12521;
    end
  49: begin 
      a11=64'h4033a93f16ae0000;
      b11=64'hbfe27abd26504000;
      c11=64'hbfefdd539ff1f452;
    end
  50: begin 
      a11=64'h4033abe81cc40000;
      b11=64'hbfe14029045f0000;
      c11=64'hbfefe1cafcbd5b05;
    end
  51: begin 
      a11=64'h4033ae6099460000;
      b11=64'hbfe0056a52061000;
      c11=64'hbfefe5f3af2e393d;
    end
  52: begin 
      a11=64'h4033b0a886200000;
      b11=64'hbfdd95082fbe6000;
      c11=64'hbfefe9cdad018837;
    end
  53: begin 
      a11=64'h4033b2bfddb00000;
      b11=64'hbfdb1ef2bdca4000;
      c11=64'hbfefed58ecb673c1;
    end
  54: begin 
      a11=64'h4033b4a69ad00000;
      b11=64'hbfd8a89a60da8000;
      c11=64'hbfeff095658e71ab;
    end
  55: begin 
      a11=64'h4033b65cb8cc0000;
      b11=64'hbfd632052c3dc000;
      c11=64'hbfeff3830f8d5759;
    end
  56: begin 
      a11=64'h4033b7e2336c0000;
      b11=64'hbfd3bb3933d9c000;
      c11=64'hbfeff621e3796d7c;
    end
  57: begin 
      a11=64'h4033b93706ee0000;
      b11=64'hbfd1443c8c1ac000;
      c11=64'hbfeff871dadb81dd;
    end
  58: begin 
      a11=64'h4033ba5b30080000;
      b11=64'hbfcd9a2a93cac000;
      c11=64'hbfeffa72effef75b;
    end
  59: begin 
      a11=64'h4033bb4eabea0000;
      b11=64'hbfc8ab93050ec000;
      c11=64'hbfeffc251df1d3f7;
    end
  60: begin 
      a11=64'h4033bc1178400000;
      b11=64'hbfc3bcbe97514000;
      c11=64'hbfeffd886084cd0c;
    end
  61: begin 
      a11=64'h4033bca393240000;
      b11=64'hbfbd9b72ecf08000;
      c11=64'hbfeffe9cb44b51a0;
    end
  62: begin 
      a11=64'h4033bd04fb300000;
      b11=64'hbfb3bd1f9dc30000;
      c11=64'hbfefff62169b92db;
    end
  63: begin 
      a11=64'h4033bd35af720000;
      b11=64'hbfa3bd3735140000;
      c11=64'hbfefffd8858e8a92;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a12=64'h4033bd35af700000;
      b12=64'h3e685a3000000000;
      c12=64'hbff0000000000000;
    end
  1: begin 
      a12=64'h4033bd04fb2e0000;
      b12=64'h3fa3bd3a40560000;
      c12=64'hbfefffd8858e8a93;
    end
  2: begin 
      a12=64'h4033bca393240000;
      b12=64'h3fb3bd21235e8000;
      c12=64'hbfefff62169b92dc;
    end
  3: begin 
      a12=64'h4033bc1178400000;
      b12=64'h3fbd9b7472830000;
      c12=64'hbfeffe9cb44b51a2;
    end
  4: begin 
      a12=64'h4033bb4eabec0000;
      b12=64'h3fc3bcbf5a138000;
      c12=64'hbfeffd886084cd0e;
    end
  5: begin 
      a12=64'h4033ba5b30080000;
      b12=64'h3fc8ab93c7c90000;
      c12=64'hbfeffc251df1d3fa;
    end
  6: begin 
      a12=64'h4033b93706ec0000;
      b12=64'h3fcd9a2b567a0000;
      c12=64'hbfeffa72effef75e;
    end
  7: begin 
      a12=64'h4033b7e2336c0000;
      b12=64'h3fd1443ced6c6000;
      c12=64'hbfeff871dadb81e1;
    end
  8: begin 
      a12=64'h4033b65cb8cc0000;
      b12=64'h3fd3bb3995246000;
      c12=64'hbfeff621e3796d80;
    end
  9: begin 
      a12=64'h4033b4a69ad00000;
      b12=64'h3fd632058d806000;
      c12=64'hbfeff3830f8d575e;
    end
  10: begin 
      a12=64'h4033b2bfddb00000;
      b12=64'h3fd8a89ac2144000;
      c12=64'hbfeff095658e71b0;
    end
  11: begin 
      a12=64'h4033b0a886200000;
      b12=64'h3fdb1ef31efa4000;
      c12=64'hbfefed58ecb673c7;
    end
  12: begin 
      a12=64'h4033ae6099460000;
      b12=64'h3fdd950890e38000;
      c12=64'hbfefe9cdad01883d;
    end
  13: begin 
      a12=64'h4033abe81cc40000;
      b12=64'h3fe0056a8292c000;
      c12=64'hbfefe5f3af2e3944;
    end
  14: begin 
      a12=64'h4033a93f16ae0000;
      b12=64'h3fe1402934e55000;
      c12=64'hbfefe1cafcbd5b0d;
    end
  15: begin 
      a12=64'h4033a6658d9e0000;
      b12=64'h3fe27abd56cfd000;
      c12=64'hbfefdd539ff1f45a;
    end
  16: begin 
      a12=64'h4033a35b88900000;
      b12=64'h3fe3b523e0220000;
      c12=64'hbfefd88da3d1252a;
    end
  17: begin 
      a12=64'h4033a0210f100000;
      b12=64'h3fe4ef59c91bb000;
      c12=64'hbfefd37914220b89;
    end
  18: begin 
      a12=64'h40339cb6290e0000;
      b12=64'h3fe6295c0a74f000;
      c12=64'hbfefce15fd6da67f;
    end
  19: begin 
      a12=64'h4033991adef80000;
      b12=64'h3fe763279d656000;
      c12=64'hbfefc8646cfeb726;
    end
  20: begin 
      a12=64'h4033954f39b60000;
      b12=64'h3fe89cb97bab9000;
      c12=64'hbfefc26470e19fd9;
    end
  21: begin 
      a12=64'h4033915342a60000;
      b12=64'h3fe9d60e9f93e000;
      c12=64'hbfefbc1617e4418c;
    end
  22: begin 
      a12=64'h40338d27039e0000;
      b12=64'h3feb0f2404012000;
      c12=64'hbfefb5797195d747;
    end
  23: begin 
      a12=64'h403388ca86e40000;
      b12=64'h3fec47f6a4737000;
      c12=64'hbfefae8e8e46cfc1;
    end
  24: begin 
      a12=64'h4033843dd7420000;
      b12=64'h3fed80837d0f3000;
      c12=64'hbfefa7557f08a51d;
    end
  25: begin 
      a12=64'h40337f80fff00000;
      b12=64'h3feeb8c78aa54000;
      c12=64'hbfef9fce55adb2d0;
    end
  26: begin 
      a12=64'h40337a940c9a0000;
      b12=64'h3feff0bfcaba3000;
      c12=64'hbfef97f924c909a1;
    end
  27: begin 
      a12=64'h40337577096a0000;
      b12=64'h3ff094349dc6b800;
      c12=64'hbfef8fd5ffae41e2;
    end
  28: begin 
      a12=64'h4033702a03000000;
      b12=64'h3ff12fe06e107800;
      c12=64'hbfef8764fa714bb1;
    end
  29: begin 
      a12=64'h40336aad06700000;
      b12=64'h3ff1cb61d6203000;
      c12=64'hbfef7ea629e63d77;
    end
  30: begin 
      a12=64'h4033650021400000;
      b12=64'h3ff266b756447800;
      c12=64'hbfef7599a3a1207f;
    end
  31: begin 
      a12=64'h40335f2361740000;
      b12=64'h3ff301df6f384000;
      c12=64'hbfef6c3f7df5bbc0;
    end
  32: begin 
      a12=64'h40335916d5860000;
      b12=64'h3ff39cd8a2264000;
      c12=64'hbfef6297cff75cb9;
    end
  33: begin 
      a12=64'h403352da8c5e0000;
      b12=64'h3ff437a170ad3800;
      c12=64'hbfef58a2b1789e8d;
    end
  34: begin 
      a12=64'h40334c6e95620000;
      b12=64'h3ff4d2385ce31800;
      c12=64'hbfef4e603b0b2f36;
    end
  35: begin 
      a12=64'h403345d300640000;
      b12=64'h3ff56c9be9591800;
      c12=64'hbfef43d085ff92e6;
    end
  36: begin 
      a12=64'h40333f07ddba0000;
      b12=64'h3ff606ca991ef000;
      c12=64'hbfef38f3ac64e593;
    end
  37: begin 
      a12=64'h4033380d3e240000;
      b12=64'h3ff6a0c2efc6f000;
      c12=64'hbfef2dc9c9089aa7;
    end
  38: begin 
      a12=64'h403330e332d80000;
      b12=64'h3ff73a8371699800;
      c12=64'hbfef2252f7763ae4;
    end
  39: begin 
      a12=64'h40332989cd860000;
      b12=64'h3ff7d40aa2a8f000;
      c12=64'hbfef168f53f72068;
    end
  40: begin 
      a12=64'h4033220120540000;
      b12=64'h3ff86d5708b48800;
      c12=64'hbfef0a7efb9230e3;
    end
  41: begin 
      a12=64'h40331a493dd40000;
      b12=64'h3ff90667294d0000;
      c12=64'hbfeefe220c0b95f7;
    end
  42: begin 
      a12=64'h4033126239080000;
      b12=64'h3ff99f398ac7e800;
      c12=64'hbfeef178a3e473ce;
    end
  43: begin 
      a12=64'h40330a4c25820000;
      b12=64'h3ffa37ccb412a800;
      c12=64'hbfeee482e25a9dc8;
    end
  44: begin 
      a12=64'h40330207172c0000;
      b12=64'h3ffad01f2cb71800;
      c12=64'hbfeed740e7684971;
    end
  45: begin 
      a12=64'h4032f99322700000;
      b12=64'h3ffb682f7cde6000;
      c12=64'hbfeec9b2d3c3bf90;
    end
  46: begin 
      a12=64'h4032f0f05c1e0000;
      b12=64'h3ffbfffc2d555800;
      c12=64'hbfeebbd8c8df0b81;
    end
  47: begin 
      a12=64'h4032e81ed9980000;
      b12=64'h3ffc9783c78f0800;
      c12=64'hbfeeadb2e8e7a89b;
    end
  48: begin 
      a12=64'h4032df1eb0940000;
      b12=64'h3ffd2ec4d5a97800;
      c12=64'hbfee9f4156c62de7;
    end
  49: begin 
      a12=64'h4032d5eff74c0000;
      b12=64'h3ffdc5bde2709800;
      c12=64'hbfee9084361df800;
    end
  50: begin 
      a12=64'h4032cc92c4600000;
      b12=64'h3ffe5c6d79621000;
      c12=64'hbfee817bab4cd11b;
    end
  51: begin 
      a12=64'h4032c3072ef80000;
      b12=64'h3ffef2d226b08000;
      c12=64'hbfee7227db6a9753;
    end
  52: begin 
      a12=64'h4032b94d4e9a0000;
      b12=64'h3fff88ea7747c000;
      c12=64'hbfee6288ec48e120;
    end
  53: begin 
      a12=64'h4032af653b400000;
      b12=64'h40000f5a7c680000;
      c12=64'hbfee529f0472a00b;
    end
  54: begin 
      a12=64'h4032a54f0d640000;
      b12=64'h40005a181cd88c00;
      c12=64'hbfee426a4b2bc18e;
    end
  55: begin 
      a12=64'h40329b0addec0000;
      b12=64'h4000a4ad648b6c00;
      c12=64'hbfee31eae870ce35;
    end
  56: begin 
      a12=64'h40329098c6240000;
      b12=64'h4000ef199b79f000;
      c12=64'hbfee212104f686f4;
    end
  57: begin 
      a12=64'h403285f8dfd00000;
      b12=64'h4001395c0a02e000;
      c12=64'hbfee100cca2980bc;
    end
  58: begin 
      a12=64'h40327b2b45300000;
      b12=64'h40018373f8ebf000;
      c12=64'hbfedfeae622dbe3c;
    end
  59: begin 
      a12=64'h4032703010ee0000;
      b12=64'h4001cd60b163c400;
      c12=64'hbfeded05f7de47ec;
    end
  60: begin 
      a12=64'h403265075e1a0000;
      b12=64'h400217217d03a800;
      c12=64'hbfeddb13b6ccc24d;
    end
  61: begin 
      a12=64'h403259b148380000;
      b12=64'h400260b5a5d15400;
      c12=64'hbfedc8d7cb410271;
    end
  62: begin 
      a12=64'h40324e2deb500000;
      b12=64'h4002aa1c76407800;
      c12=64'hbfedb6526238a0ad;
    end
  63: begin 
      a12=64'h4032427d63c20000;
      b12=64'h4002f3553934bc00;
      c12=64'hbfeda383a9668998;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a13=64'h4032369fce620000;
      b13=64'h40033c5f3a038800;
      c13=64'hbfed906bcf328d58;
    end
  1: begin 
      a13=64'h40322a9548740000;
      b13=64'h40038539c4758400;
      c13=64'hbfed7d0b02b8ed0c;
    end
  2: begin 
      a13=64'h40321e5defc20000;
      b13=64'h4003cde424c85c00;
      c13=64'hbfed696173c9e69f;
    end
  3: begin 
      a13=64'h403211f9e2600000;
      b13=64'h4004165da7b0b400;
      c13=64'hbfed556f52e93ec2;
    end
  4: begin 
      a13=64'h403205693eda0000;
      b13=64'h40045ea59a5be800;
      c13=64'hbfed4134d14dc94d;
    end
  5: begin 
      a13=64'h4031f8ac24440000;
      b13=64'h4004a6bb4a713800;
      c13=64'hbfed2cb220e0efb3;
    end
  6: begin 
      a13=64'h4031ebc2b2040000;
      b13=64'h4004ee9e06144400;
      c13=64'hbfed17e7743e35f1;
    end
  7: begin 
      a13=64'h4031dead07f40000;
      b13=64'h4005364d1be63800;
      c13=64'hbfed02d4feb2bda5;
    end
  8: begin 
      a13=64'h4031d16b46540000;
      b13=64'h40057dc7db07d400;
      c13=64'hbfeced7af43cc787;
    end
  9: begin 
      a13=64'h4031c3fd8dea0000;
      b13=64'h4005c50d931ac400;
      c13=64'hbfecd7d9898b330b;
    end
  10: begin 
      a13=64'h4031b663ffd40000;
      b13=64'h40060c1d9443b400;
      c13=64'hbfecc1f0f3fcfc73;
    end
  11: begin 
      a13=64'h4031a89ebda00000;
      b13=64'h400652f72f2bcc00;
      c13=64'hbfecabc169a0b915;
    end
  12: begin 
      a13=64'h40319aade93a0000;
      b13=64'h40069999b5028c00;
      c13=64'hbfec954b2134120b;
    end
  13: begin 
      a13=64'h40318c91a5200000;
      b13=64'h4006e004777f1c00;
      c13=64'hbfec7e8e52233d0a;
    end
  14: begin 
      a13=64'h40317e4a14160000;
      b13=64'h40072636c8e26800;
      c13=64'hbfec678b348873b0;
    end
  15: begin 
      a13=64'h40316fd759540000;
      b13=64'h40076c2ffbf8b000;
      c13=64'hbfec5042012b691d;
    end
  16: begin 
      a13=64'h40316139987e0000;
      b13=64'h4007b1ef641b0400;
      c13=64'hbfec38b2f180bdc8;
    end
  17: begin 
      a13=64'h40315270f5b60000;
      b13=64'h4007f7745530fc00;
      c13=64'hbfec20de3fa971c8;
    end
  18: begin 
      a13=64'h4031437d956a0000;
      b13=64'h40083cbe23b29400;
      c13=64'hbfec08c42672555f;
    end
  19: begin 
      a13=64'h4031345f9c760000;
      b13=64'h400881cc24a9c800;
      c13=64'hbfebf064e15377f4;
    end
  20: begin 
      a13=64'h4031251730360000;
      b13=64'h4008c69dadb3d400;
      c13=64'hbfebd7c0ac6f9542;
    end
  21: begin 
      a13=64'h403115a4765c0000;
      b13=64'h40090b3215036400;
      c13=64'hbfebbed7c4938104;
    end
  22: begin 
      a13=64'h4031060795040000;
      b13=64'h40094f88b161e000;
      c13=64'hbfeba5aa673590ea;
    end
  23: begin 
      a13=64'h4030f640b2aa0000;
      b13=64'h400993a0da315800;
      c13=64'hbfeb8c38d2750501;
    end
  24: begin 
      a13=64'h4030e64ff6480000;
      b13=64'h4009d779e76da400;
      c13=64'hbfeb728345196e57;
    end
  25: begin 
      a13=64'h4030d63587340000;
      b13=64'h400a1b1331ae8c00;
      c13=64'hbfeb5889fe921420;
    end
  26: begin 
      a13=64'h4030c5f18d260000;
      b13=64'h400a5e6c12291400;
      c13=64'hbfeb3e4d3ef5572a;
    end
  27: begin 
      a13=64'h4030b58430320000;
      b13=64'h400aa183e2b15000;
      c13=64'hbfeb23cd470013ce;
    end
  28: begin 
      a13=64'h4030a4ed98f80000;
      b13=64'h400ae459fdbb9c00;
      c13=64'hbfeb090a5815021b;
    end
  29: begin 
      a13=64'h4030942df05c0000;
      b13=64'h400b26edbe5ea800;
      c13=64'hbfeaee04b43c148c;
    end
  30: begin 
      a13=64'h403083455fae0000;
      b13=64'h400b693e8054dc00;
      c13=64'hbfead2bc9e21d52b;
    end
  31: begin 
      a13=64'h4030723410a00000;
      b13=64'h400bab4b9ffdf000;
      c13=64'hbfeab7325916c0f0;
    end
  32: begin 
      a13=64'h403060fa2d640000;
      b13=64'h400bed147a604400;
      c13=64'hbfea9b66290ea1c0;
    end
  33: begin 
      a13=64'h40304f97e06e0000;
      b13=64'h400c2e986d2ad800;
      c13=64'hbfea7f58529fe6b6;
    end
  34: begin 
      a13=64'h40303e0d54980000;
      b13=64'h400c6fd6d6b6e800;
      c13=64'hbfea63091b02fafd;
    end
  35: begin 
      a13=64'h40302c5ab53e0000;
      b13=64'h400cb0cf1608cc00;
      c13=64'hbfea4678c8119ae5;
    end
  36: begin 
      a13=64'h40301a802e040000;
      b13=64'h400cf1808ad24400;
      c13=64'hbfea29a7a04627a0;
    end
  37: begin 
      a13=64'h4030087deaf60000;
      b13=64'h400d31ea9573b400;
      c13=64'hbfea0c95eabaf952;
    end
  38: begin 
      a13=64'h402feca830ec0000;
      b13=64'h400d720c96fdd400;
      c13=64'hbfe9ef43ef29afb1;
    end
  39: begin 
      a13=64'h402fc805c6d40000;
      b13=64'h400db1e5f132c000;
      c13=64'hbfe9d1b1f5ea80f4;
    end
  40: begin 
      a13=64'h402fa314f2000000;
      b13=64'h400df17606882000;
      c13=64'hbfe9b3e047f38760;
    end
  41: begin 
      a13=64'h402f7dd60d8c0000;
      b13=64'h400e30bc3a285000;
      c13=64'hbfe995cf2ed80d3f;
    end
  42: begin 
      a13=64'h402f584975480000;
      b13=64'h400e6fb7eff42400;
      c13=64'hbfe9777ef4c7d760;
    end
  43: begin 
      a13=64'h402f326f860c0000;
      b13=64'h400eae688c83d000;
      c13=64'hbfe958efe48e6df6;
    end
  44: begin 
      a13=64'h402f0c489d240000;
      b13=64'h400eeccd75293400;
      c13=64'hbfe93a2249926418;
    end
  45: begin 
      a13=64'h402ee5d518a40000;
      b13=64'h400f2ae60ff0f000;
      c13=64'hbfe91b166fd49dc0;
    end
  46: begin 
      a13=64'h402ebf15576c0000;
      b13=64'h400f68b1c3a3d400;
      c13=64'hbfe8fbcca3ef942c;
    end
  47: begin 
      a13=64'h402e9809b9380000;
      b13=64'h400fa62ff7c85800;
      c13=64'hbfe8dc45331698ed;
    end
  48: begin 
      a13=64'h402e70b29e540000;
      b13=64'h400fe36014a43c00;
      c13=64'hbfe8bc806b15175e;
    end
  49: begin 
      a13=64'h402e491067a40000;
      b13=64'h40101020c19f2400;
      c13=64'hbfe89c7e9a4dd4ca;
    end
  50: begin 
      a13=64'h402e212377300000;
      b13=64'h40102e69d6af6000;
      c13=64'hbfe87c400fba2ee0;
    end
  51: begin 
      a13=64'h402df8ec2f740000;
      b13=64'h40104c8afec8f600;
      c13=64'hbfe85bc51ae958ef;
    end
  52: begin 
      a13=64'h402dd06af3940000;
      b13=64'h40106a83ef948800;
      c13=64'hbfe83b0e0bff978d;
    end
  53: begin 
      a13=64'h402da7a027640000;
      b13=64'h401088545f1dfa00;
      c13=64'hbfe81a1b33b57aec;
    end
  54: begin 
      a13=64'h402d7e8c2fcc0000;
      b13=64'h4010a5fc03d4fa00;
      c13=64'hbfe7f8ece3571793;
    end
  55: begin 
      a13=64'h402d552f720c0000;
      b13=64'h4010c37a948dfe00;
      c13=64'hbfe7d7836cc33dd6;
    end
  56: begin 
      a13=64'h402d2b8a542c0000;
      b13=64'h4010e0cfc882ce00;
      c13=64'hbfe7b5df226aafcf;
    end
  57: begin 
      a13=64'h402d019d3cd40000;
      b13=64'h4010fdfb57535600;
      c13=64'hbfe79400574f5607;
    end
  58: begin 
      a13=64'h402cd76893b40000;
      b13=64'h40111afcf9061200;
      c13=64'hbfe771e75f037285;
    end
  59: begin 
      a13=64'h402cacecc0d00000;
      b13=64'h401137d466091400;
      c13=64'hbfe74f948da8d2ad;
    end
  60: begin 
      a13=64'h402c822a2ce80000;
      b13=64'h4011548157329a00;
      c13=64'hbfe72d0837efffb8;
    end
  61: begin 
      a13=64'h402c5721417c0000;
      b13=64'h4011710385c1a800;
      c13=64'hbfe70a42b3176d9d;
    end
  62: begin 
      a13=64'h402c2bd268e80000;
      b13=64'h40118d5aab5eaa00;
      c13=64'hbfe6e74454eaa8d4;
    end
  63: begin 
      a13=64'h402c003e0df40000;
      b13=64'h4011a986821c5800;
      c13=64'hbfe6c40d73c18297;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a14=64'h402bd4649c040000;
      b14=64'h4011c586c4785c00;
      c14=64'hbfe6a09e667f3bf0;
    end
  1: begin 
      a14=64'h402ba8467f740000;
      b14=64'h4011e15b2d5bb000;
      c14=64'hbfe67cf78491af35;
    end
  2: begin 
      a14=64'h402b7be425200000;
      b14=64'h4011fd03781b9c00;
      c14=64'hbfe6591925f07864;
    end
  3: begin 
      a14=64'h402b4f3dfa780000;
      b14=64'h4012187f607a4800;
      c14=64'hbfe63503a31c1c0c;
    end
  4: begin 
      a14=64'h402b22546d880000;
      b14=64'h401233cea2a77000;
      c14=64'hbfe610b7551d2d04;
    end
  5: begin 
      a14=64'h402af527ed600000;
      b14=64'h40124ef0fb40c200;
      c14=64'hbfe5ec349583709b;
    end
  6: begin 
      a14=64'h402ac7b8e9640000;
      b14=64'h401269e62752ee00;
      c14=64'hbfe5c77bbe6501b5;
    end
  7: begin 
      a14=64'h402a9a07d1a40000;
      b14=64'h401284ade45a0600;
      c14=64'hbfe5a28d2a5d7275;
    end
  8: begin 
      a14=64'h402a6c1516c40000;
      b14=64'h40129f47f0425200;
      c14=64'hbfe57d69348cecc6;
    end
  9: begin 
      a14=64'h402a3de12a580000;
      b14=64'h4012b9b40968a800;
      c14=64'hbfe558103897515f;
    end
  10: begin 
      a14=64'h402a0f6c7e400000;
      b14=64'h4012d3f1ee9b5c00;
      c14=64'hbfe5328292a355ba;
    end
  11: begin 
      a14=64'h4029e0b7851c0000;
      b14=64'h4012ee015f1aca00;
      c14=64'hbfe50cc09f59a0c1;
    end
  12: begin 
      a14=64'h4029b1c2b2180000;
      b14=64'h401307e21a99e600;
      c14=64'hbfe4e6cabbe3e611;
    end
  13: begin 
      a14=64'h4029828e79480000;
      b14=64'h40132193e13ec400;
      c14=64'hbfe4c0a145ec002d;
    end
  14: begin 
      a14=64'h4029531b4f080000;
      b14=64'h40133b1673a37400;
      c14=64'hbfe49a449b9b095e;
    end
  15: begin 
      a14=64'h40292369a8440000;
      b14=64'h4013546992d69600;
      c14=64'hbfe473b51b98736e;
    end
  16: begin 
      a14=64'h4028f379fae00000;
      b14=64'h40136d8d005ba000;
      c14=64'hbfe44cf325091dff;
    end
  17: begin 
      a14=64'h4028c34cbd240000;
      b14=64'h401386807e2bde00;
      c14=64'hbfe425ff178e6bdc;
    end
  18: begin 
      a14=64'h402892e265dc0000;
      b14=64'h40139f43ceb6d800;
      c14=64'hbfe3fed9534556fb;
    end
  19: begin 
      a14=64'h4028623b6c580000;
      b14=64'h4013b7d6b4e31800;
      c14=64'hbfe3d78238c5836c;
    end
  20: begin 
      a14=64'h4028315848e00000;
      b14=64'h4013d038f40e5a00;
      c14=64'hbfe3affa292050e4;
    end
  21: begin 
      a14=64'h40280039740c0000;
      b14=64'h4013e86a500e9400;
      c14=64'hbfe3884185dfeb4e;
    end
  22: begin 
      a14=64'h4027cedf66fc0000;
      b14=64'h4014006a8d324e00;
      c14=64'hbfe36058b1065a1b;
    end
  23: begin 
      a14=64'h40279d4a9b5c0000;
      b14=64'h4014183970416200;
      c14=64'hbfe338400d0c8e80;
    end
  24: begin 
      a14=64'h40276b7b8bbc0000;
      b14=64'h40142fd6be7d3200;
      c14=64'hbfe30ff7fce17061;
    end
  25: begin 
      a14=64'h40273972b2ec0000;
      b14=64'h401447423da1a000;
      c14=64'hbfe2e780e3e8ea3e;
    end
  26: begin 
      a14=64'h402707308c480000;
      b14=64'h40145e7bb3e57c00;
      c14=64'hbfe2bedb25faf413;
    end
  27: begin 
      a14=64'h4026d4b593cc0000;
      b14=64'h40147582e7fafc00;
      c14=64'hbfe2960727629cd3;
    end
  28: begin 
      a14=64'h4026a20246440000;
      b14=64'h40148c57a1104000;
      c14=64'hbfe26d054cdd130c;
    end
  29: begin 
      a14=64'h40266f1720a00000;
      b14=64'h4014a2f9a6d01200;
      c14=64'hbfe243d5fb98ac48;
    end
  30: begin 
      a14=64'h40263bf4a0640000;
      b14=64'h4014b968c1626c00;
      c14=64'hbfe21a799933eb83;
    end
  31: begin 
      a14=64'h4026089b43f40000;
      b14=64'h4014cfa4b96cae00;
      c14=64'hbfe1f0f08bbc8647;
    end
  32: begin 
      a14=64'h4025d50b89fc0000;
      b14=64'h4014e5ad58128e00;
      c14=64'hbfe1c73b39ae68f7;
    end
  33: begin 
      a14=64'h4025a145f19c0000;
      b14=64'h4014fb8266f66800;
      c14=64'hbfe19d5a09f2b9e2;
    end
  34: begin 
      a14=64'h40256d4afa7c0000;
      b14=64'h40151123b039f000;
      c14=64'hbfe1734d63dedb75;
    end
  35: begin 
      a14=64'h4025391b25100000;
      b14=64'h40152690fe7e5c00;
      c14=64'hbfe14915af336d19;
    end
  36: begin 
      a14=64'h402504b6f2180000;
      b14=64'h40153bca1ce54800;
      c14=64'hbfe11eb3541b4b52;
    end
  37: begin 
      a14=64'h4024d01ee2cc0000;
      b14=64'h401550ced7111200;
      c14=64'hbfe0f426bb2a8ea9;
    end
  38: begin 
      a14=64'h40249b5378c00000;
      b14=64'h4015659ef9257600;
      c14=64'hbfe0c9704d5d89bc;
    end
  39: begin 
      a14=64'h4024665536940000;
      b14=64'h40157a3a4fc7b200;
      c14=64'hbfe09e907417c610;
    end
  40: begin 
      a14=64'h402431249ed80000;
      b14=64'h40158ea0a81f7c00;
      c14=64'hbfe0738799230018;
    end
  41: begin 
      a14=64'h4023fbc234c40000;
      b14=64'h4015a2d1cfd74e00;
      c14=64'hbfe0485626ae2247;
    end
  42: begin 
      a14=64'h4023c62e7bf80000;
      b14=64'h4015b6cd951cda00;
      c14=64'hbfe01cfc874c3ee5;
    end
  43: begin 
      a14=64'h40239069f8f20000;
      b14=64'h4015ca93c6a15f00;
      c14=64'hbfdfe2f64be71271;
    end
  44: begin 
      a14=64'h40235a7530320000;
      b14=64'h4015de24339a7b00;
      c14=64'hbfdf8ba4dbf89b11;
    end
  45: begin 
      a14=64'h40232450a6b00000;
      b14=64'h4015f17eabc28b00;
      c14=64'hbfdf3405963fd0c3;
    end
  46: begin 
      a14=64'h4022edfce24a0000;
      b14=64'h401604a2ff58cb00;
      c14=64'hbfdedc1952ef7935;
    end
  47: begin 
      a14=64'h4022b77a68fc0000;
      b14=64'h40161790ff223b00;
      c14=64'hbfde83e0eaf85178;
    end
  48: begin 
      a14=64'h402280c9c1360000;
      b14=64'h40162a487c69dd00;
      c14=64'hbfde2b5d3806f695;
    end
  49: begin 
      a14=64'h402249eb71c20000;
      b14=64'h40163cc949015100;
      c14=64'hbfddd28f1481ccb6;
    end
  50: begin 
      a14=64'h402212e002480000;
      b14=64'h40164f133740e700;
      c14=64'hbfdd79775b86e3ec;
    end
  51: begin 
      a14=64'h4021dba7fa880000;
      b14=64'h401661261a087e00;
      c14=64'hbfdd2016e8e9dbc1;
    end
  52: begin 
      a14=64'h4021a443e2b60000;
      b14=64'h40167301c4bfb900;
      c14=64'hbfdcc66e9931c4bb;
    end
  53: begin 
      a14=64'h40216cb443520000;
      b14=64'h401684a60b569e00;
      c14=64'hbfdc6c7f4997006b;
    end
  54: begin 
      a14=64'h402134f9a5ca0000;
      b14=64'h40169612c2459700;
      c14=64'hbfdc1249d8011f4c;
    end
  55: begin 
      a14=64'h4020fd1493740000;
      b14=64'h4016a747be8e5500;
      c14=64'hbfdbb7cf2304bd5c;
    end
  56: begin 
      a14=64'h4020c505962a0000;
      b14=64'h4016b844d5bc1700;
      c14=64'hbfdb5d1009e15d1f;
    end
  57: begin 
      a14=64'h40208ccd38320000;
      b14=64'h4016c909dde3f600;
      c14=64'hbfdb020d6c7f406c;
    end
  58: begin 
      a14=64'h4020546c04860000;
      b14=64'h4016d996ada53900;
      c14=64'hbfdaa6c82b6d4031;
    end
  59: begin 
      a14=64'h40201be286200000;
      b14=64'h4016e9eb1c2a0600;
      c14=64'hbfda4b4127dea242;
    end
  60: begin 
      a14=64'h401fc66290980000;
      b14=64'h4016fa070127bc00;
      c14=64'hbfd9ef7943a8edec;
    end
  61: begin 
      a14=64'h401f54b1ae780000;
      b14=64'h401709ea34deeb00;
      c14=64'hbfd993716141be64;
    end
  62: begin 
      a14=64'h401ee2b37e380000;
      b14=64'h40171994901c3f00;
      c14=64'hbfd9372a63bc9441;
    end
  63: begin 
      a14=64'h401e706919080000;
      b14=64'h40172905ec389000;
      c14=64'hbfd8daa52ec8a50f;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a15=64'h401dfdd398900000;
      b15=64'h4017383e23198200;
      c15=64'hbfd87de2a6aea9c7;
    end
  1: begin 
      a15=64'h401d8af4181c0000;
      b15=64'h4017473d0f316f00;
      c15=64'hbfd820e3b04eab2c;
    end
  2: begin 
      a15=64'h401d17cbb2fc0000;
      b15=64'h401756028b804000;
      c15=64'hbfd7c3a9311dcd54;
    end
  3: begin 
      a15=64'h401ca45b853c0000;
      b15=64'h4017648e73938600;
      c15=64'hbfd766340f241958;
    end
  4: begin 
      a15=64'h401c30a4ab500000;
      b15=64'h401772e0a3870d00;
      c15=64'hbfd7088530fa4605;
    end
  5: begin 
      a15=64'h401bbca843700000;
      b15=64'h401780f8f804ba00;
      c15=64'hbfd6aa9d7dc77e81;
    end
  6: begin 
      a15=64'h401b48676b740000;
      b15=64'h40178ed74e456e00;
      c15=64'hbfd64c7ddd3f2826;
    end
  7: begin 
      a15=64'h401ad3e342140000;
      b15=64'h40179c7b84112800;
      c15=64'hbfd5ee27379ea6f8;
    end
  8: begin 
      a15=64'h401a5f1ce6b00000;
      b15=64'h4017a9e577bf4000;
      c15=64'hbfd58f9a75ab2046;
    end
  9: begin 
      a15=64'h4019ea157a040000;
      b15=64'h4017b7150836b100;
      c15=64'hbfd530d880af3c91;
    end
  10: begin 
      a15=64'h401974ce1c700000;
      b15=64'h4017c40a14eea900;
      c15=64'hbfd4d1e24278e7cc;
    end
  11: begin 
      a15=64'h4018ff47eefc0000;
      b15=64'h4017d0c47deed400;
      c15=64'hbfd472b8a55710ba;
    end
  12: begin 
      a15=64'h4018898414340000;
      b15=64'h4017dd4423cf4400;
      c15=64'hbfd4135c9417666c;
    end
  13: begin 
      a15=64'h40181383ae9c0000;
      b15=64'h4017e988e7b93500;
      c15=64'hbfd3b3cefa041527;
    end
  14: begin 
      a15=64'h40179d47e1280000;
      b15=64'h4017f592ab672700;
      c15=64'hbfd35410c2e181b6;
    end
  15: begin 
      a15=64'h401726d1cf480000;
      b15=64'h4018016151254d00;
      c15=64'hbfd2f422daec03f0;
    end
  16: begin 
      a15=64'h4016b0229ddc0000;
      b15=64'h40180cf4bbd16d00;
      c15=64'hbfd294062ed59f73;
    end
  17: begin 
      a15=64'h4016393b71980000;
      b15=64'h4018184ccedba900;
      c15=64'hbfd233bbabc3bbe3;
    end
  18: begin 
      a15=64'h4015c21d6fc00000;
      b15=64'h401823696e468000;
      c15=64'hbfd1d3443f4cdba5;
    end
  19: begin 
      a15=64'h40154ac9bde80000;
      b15=64'h40182e4a7ea74500;
      c15=64'hbfd172a0d77651e2;
    end
  20: begin 
      a15=64'h4014d34183280000;
      b15=64'h401838efe525f200;
      c15=64'hbfd111d262b1f6e7;
    end
  21: begin 
      a15=64'h40145b85e61c0000;
      b15=64'h40184359877df100;
      c15=64'hbfd0b0d9cfdbdbf5;
    end
  22: begin 
      a15=64'h4013e3980e140000;
      b15=64'h40184d874bfe2600;
      c15=64'hbfd04fb80e37fe17;
    end
  23: begin 
      a15=64'h40136b7922d20000;
      b15=64'h4018577919892680;
      c15=64'hbfcfdcdc1adfeed3;
    end
  24: begin 
      a15=64'h4012f32a4d580000;
      b15=64'h4018612ed7954c00;
      c15=64'hbfcf19f97b215ffe;
    end
  25: begin 
      a15=64'h40127aacb6260000;
      b15=64'h40186aa86e2d5700;
      c15=64'hbfce56ca1e101ae9;
    end
  26: begin 
      a15=64'h4012020186260000;
      b15=64'h401873e5c5f08680;
      c15=64'hbfcd934fe54543e7;
    end
  27: begin 
      a15=64'h40118929e7b20000;
      b15=64'h40187ce6c8127700;
      c15=64'hbfcccf8cb312b365;
    end
  28: begin 
      a15=64'h4011102704d20000;
      b15=64'h401885ab5e5bd600;
      c15=64'hbfcc0b826a7e504b;
    end
  29: begin 
      a15=64'h401096fa08020000;
      b15=64'h40188e33732a5880;
      c15=64'hbfcb4732ef3d67f4;
    end
  30: begin 
      a15=64'h40101da41bde0000;
      b15=64'h4018967ef1712480;
      c15=64'hbfca82a025b0052b;
    end
  31: begin 
      a15=64'h400f484cd8c80000;
      b15=64'h40189e8dc4b89180;
      c15=64'hbfc9bdcbf2dc4449;
    end
  32: begin 
      a15=64'h400e55044a700000;
      b15=64'h4018a65fd91edd80;
      c15=64'hbfc8f8b83c69a6f7;
    end
  33: begin 
      a15=64'h400d6170e4bc0000;
      b15=64'h4018adf51b581980;
      c15=64'hbfc83366e89c659b;
    end
  34: begin 
      a15=64'h400c6d94fff80000;
      b15=64'h4018b54d78ae9000;
      c15=64'hbfc76dd9de50c010;
    end
  35: begin 
      a15=64'h400b7972f7440000;
      b15=64'h4018bc68df027800;
      c15=64'hbfc6a81304f64b99;
    end
  36: begin 
      a15=64'h400a850d24480000;
      b15=64'h4018c3473ccab080;
      c15=64'hbfc5e214448b4097;
    end
  37: begin 
      a15=64'h40099065e1c80000;
      b15=64'h4018c9e88114b880;
      c15=64'hbfc51bdf8597c6cb;
    end
  38: begin 
      a15=64'h40089b7f8b300000;
      b15=64'h4018d04c9b84c180;
      c15=64'hbfc45576b1293f3c;
    end
  39: begin 
      a15=64'h4007a65c7e040000;
      b15=64'h4018d6737c55bd80;
      c15=64'hbfc38edbb0cd8dff;
    end
  40: begin 
      a15=64'h4006b0ff16540000;
      b15=64'h4018dc5d1459e200;
      c15=64'hbfc2c8106e8e620e;
    end
  41: begin 
      a15=64'h4005bb69b0d40000;
      b15=64'h4018e20954faaf80;
      c15=64'hbfc20116d4ec7cac;
    end
  42: begin 
      a15=64'h4004c59eacb00000;
      b15=64'h4018e7783038b480;
      c15=64'hbfc139f0cedaf65d;
    end
  43: begin 
      a15=64'h4003cfa068240000;
      b15=64'h4018eca998ac3100;
      c15=64'hbfc072a047ba840c;
    end
  44: begin 
      a15=64'h4002d97141e60000;
      b15=64'h4018f19d8184f680;
      c15=64'hbfbf564e56a974be;
    end
  45: begin 
      a15=64'h4001e31398a40000;
      b15=64'h4018f653de8ab980;
      c15=64'hbfbdc70ecbaea18b;
    end
  46: begin 
      a15=64'h4000ec89cd820000;
      b15=64'h4018facca41cbbc0;
      c15=64'hbfbc3785c79ec4a8;
    end
  47: begin 
      a15=64'h3fffebac81100000;
      b15=64'h4018ff07c7326f80;
      c15=64'hbfbaa7b724495de9;
    end
  48: begin 
      a15=64'h3ffdfdf6a4680000;
      b15=64'h401903053d5b4900;
      c15=64'hbfb917a6bc29b5e3;
    end
  49: begin 
      a15=64'h3ffc0ff6c5b40000;
      b15=64'h401906c4fcbf1480;
      c15=64'hbfb787586a5d5cea;
    end
  50: begin 
      a15=64'h3ffa21b1aad00000;
      b15=64'h40190a46fc1d8e00;
      c15=64'hbfb5f6d00a9aa5f3;
    end
  51: begin 
      a15=64'h3ff8332c15cc0000;
      b15=64'h40190d8b32cf0c00;
      c15=64'hbfb4661179272242;
    end
  52: begin 
      a15=64'h3ff6446aca600000;
      b15=64'h4019109198c45d40;
      c15=64'hbfb2d52092ce1bb4;
    end
  53: begin 
      a15=64'h3ff455728cc80000;
      b15=64'h4019135a2686c680;
      c15=64'hbfb1440134d70b82;
    end
  54: begin 
      a15=64'h3ff2664824d00000;
      b15=64'h401915e4d537fdc0;
      c15=64'hbfaf656e79f824a3;
    end
  55: begin 
      a15=64'h3ff076f056b60000;
      b15=64'h401918319e9291e0;
      c15=64'hbfac428d12c0db49;
    end
  56: begin 
      a15=64'h3fed0edfce640000;
      b15=64'h40191a407ce9e220;
      c15=64'hbfa91f65f10ddb9e;
    end
  57: begin 
      a15=64'h3fe92f973ec00000;
      b15=64'h40191c116b29c480;
      c15=64'hbfa5fc00d290d0f1;
    end
  58: begin 
      a15=64'h3fe550108b600000;
      b15=64'h40191da464d71a60;
      c15=64'hbfa2d8657594599e;
    end
  59: begin 
      a15=64'h3fe1705541ba0000;
      b15=64'h40191ef9660f9320;
      c15=64'hbf9f693731d1d5e8;
    end
  60: begin 
      a15=64'h3fdb20dddba40000;
      b15=64'h401920106b89ee60;
      c15=64'hbf992155f7a36dac;
    end
  61: begin 
      a15=64'h3fd360ce48160000;
      b15=64'h401920e972958b78;
      c15=64'hbf92d936bbe31671;
    end
  62: begin 
      a15=64'h3fc7411dcc940000;
      b15=64'h40192184791af858;
      c15=64'hbf8921d1fcded6f9;
    end
  63: begin 
      a15=64'h3faf0196a1280000;
      b15=64'h401921e17d9baec6;
      c15=64'hbf7921f0fe671c73;
    end
  endcase
  case(vin[9:6])
    0: begin
        a=a0; b=b0; c=c0;
      end
    1: begin
        a=a1; b=b1; c=c1;
      end
    2: begin
        a=a2; b=b2; c=c2;
      end
    3: begin
        a=a3; b=b3; c=c3;
      end
    4: begin
        a=a4; b=b4; c=c4;
      end
    5: begin
        a=a5; b=b5; c=c5;
      end
    6: begin
        a=a6; b=b6; c=c6;
      end
    7: begin
        a=a7; b=b7; c=c7;
      end
    8: begin
        a=a8; b=b8; c=c8;
      end
    9: begin
        a=a9; b=b9; c=c9;
      end
    10: begin
        a=a10; b=b10; c=c10;
      end
    11: begin
        a=a11; b=b11; c=c11;
      end
    12: begin
        a=a12; b=b12; c=c12;
      end
    13: begin
        a=a13; b=b13; c=c13;
      end
    14: begin
        a=a14; b=b14; c=c14;
      end
    15: begin
        a=a15; b=b15; c=c15;
      end
  endcase

end
endmodule
//A sqrt(-2*ln(x)) table for randist
// The input is a 9 bit integer representing
// <input>/512  You need to denormalize the FP
// Value to get a correct answer from the lookup
// Multiply the difference from the <input> by the slope
// To get an interpolated value.
// get the delta from the floating version of the lookup value
// sin = A*delta*delta*delta+B*delta*delta+C*delta+D
//
// Answer should be good to about 1e-9 (8-10 digits)
// for over 98% of the region 0-1

module sqrtln(vin,A,B,C,D);
input [8:0] vin;
output [63:0] A,B,C,D;
reg [63:0] a,b,c,d;
assign A=a;
assign B=b;
assign C=c;
assign D=d;
reg [63:0] a0,b0,c0,d0;
reg [63:0] a1,b1,c1,d1;
reg [63:0] a2,b2,c2,d2;
reg [63:0] a3,b3,c3,d3;
reg [63:0] a4,b4,c4,d4;
reg [63:0] a5,b5,c5,d5;
reg [63:0] a6,b6,c6,d6;
reg [63:0] a7,b7,c7,d7;

always @(*) begin

  case(vin[5:0])
  0: begin 
      a0=64'hc2146447fb5b3e34;
      b0=64'h41920f32a4c21d9b;
      c0=64'hc0f2c7156c8fcd85;
      d0=64'h4038d7dc48136dfb;
    end
  1: begin 
      a0=64'hc14c5d9d98acc31c;
      b0=64'h40daae7e9e29a9fc;
      c0=64'hc061d309266b8857;
      d0=64'h400c41b365eb22f2;
    end
  2: begin 
      a0=64'hc1280af27f1e7288;
      b0=64'h40c01797f27aec77;
      c0=64'hc05326d260076fa0;
      d0=64'h400aa4404738a907;
    end
  3: begin 
      a0=64'hc111b1a6e0723d50;
      b0=64'h40aeac2d833fb221;
      c0=64'hc04a95091fa49d6f;
      d0=64'h4009a631c9d630f2;
    end
  4: begin 
      a0=64'hc100dd1ddc546f42;
      b0=64'h40a1f10759ab543a;
      c0=64'hc0448866167c2955;
      d0=64'h4008ebca90384d57;
    end
  5: begin 
      a0=64'hc0f2b3b609222a42;
      b0=64'h409795ab44981628;
      c0=64'hc040d26e872f920b;
      d0=64'h4008575d2de9cecc;
    end
  6: begin 
      a0=64'hc0e6eb33857d5849;
      b0=64'h4090b62afc34557c;
      c0=64'hc03c9bfbf5efb163;
      d0=64'h4007db697ea83e15;
    end
  7: begin 
      a0=64'hc0de26108f5489d7;
      b0=64'h4088f56db29debfa;
      c0=64'hc038f5dd32e60d79;
      d0=64'h4007709d5e787c0c;
    end
  8: begin 
      a0=64'hc0d4e84ba53d5a0b;
      b0=64'h40835f70c16256a1;
      c0=64'hc0363067c0e3f014;
      d0=64'h4007128ab7039c30;
    end
  9: begin 
      a0=64'hc0ce366887c349a4;
      b0=64'h407efae6118719f7;
      c0=64'hc034026e0e2b649d;
      d0=64'h4006be4d58ad1566;
    end
  10: begin 
      a0=64'hc0c68e81376cee10;
      b0=64'h40795c0d6704497b;
      c0=64'hc0323f8fe74f8baf;
      d0=64'h400671e693c28a6e;
    end
  11: begin 
      a0=64'hc0c14c336314a520;
      b0=64'h4075286bd21cf1c2;
      c0=64'hc030cb4c153cc01b;
      d0=64'h40062be6bae8fd53;
    end
  12: begin 
      a0=64'hc0bb2091b90cf2c5;
      b0=64'h4071eebee244ad7b;
      c0=64'hc02f24f16c3554a6;
      d0=64'h4005eb3c0104f9a1;
    end
  13: begin 
      a0=64'hc0b5acf767108923;
      b0=64'h406ecd9927d1f567;
      c0=64'hc02d0f6e9e7a7450;
      d0=64'h4005af14d66274a8;
    end
  14: begin 
      a0=64'hc0b199eb84a6c4e9;
      b0=64'h406ac17a6b1d6617;
      c0=64'hc02b42d3f067cf9e;
      d0=64'h400576cd2663d4b3;
    end
  15: begin 
      a0=64'hc0acfccf383efcd0;
      b0=64'h406777afaf75f614;
      c0=64'hc029b0eee9357513;
      d0=64'h400541e1fcb25a68;
    end
  16: begin 
      a0=64'hc0a829c624026c32;
      b0=64'h4064c237b51d54f2;
      c0=64'hc0284f08fe2971c8;
      d0=64'h40050fe91bc7cace;
    end
  17: begin 
      a0=64'hc0a45c214354474a;
      b0=64'h40627ff50b149f06;
      c0=64'hc02714e4e3ffa5f7;
      d0=64'h4004e08b18a26505;
    end
  18: begin 
      a0=64'hc0a151f94391be97;
      b0=64'h40609891d61372b6;
      c0=64'hc025fc11254058c2;
      d0=64'h4004b37f2049c107;
    end
  19: begin 
      a0=64'hc09db8d7c70b8ddd;
      b0=64'h405df3af3ba25589;
      c0=64'hc024ff70dd4b9d40;
      d0=64'h40048887de443d31;
    end
  20: begin 
      a0=64'hc099b2fbad14aae7;
      b0=64'h405b2bd7e958790a;
      c0=64'hc0241ae7d2332e5a;
      d0=64'h40045f712be9b851;
    end
  21: begin 
      a0=64'hc0966046fdfe79db;
      b0=64'h4058c43bed34fae3;
      c0=64'hc0234b1e3fc1fc72;
      d0=64'h4004380e4e5bd5f5;
    end
  22: begin 
      a0=64'hc0939b3f3a6e1076;
      b0=64'h4056ac2397fa0cc3;
      c0=64'hc0228d54dc701c71;
      d0=64'h400412389bbb98e2;
    end
  23: begin 
      a0=64'hc091477714c726d1;
      b0=64'h4054d6552f79b919;
      c0=64'hc021df44345cf066;
      d0=64'h4003edce6c5dd0fa;
    end
  24: begin 
      a0=64'hc08e9e33b887e4bc;
      b0=64'h4053383d5fe75058;
      c0=64'hc0213f04143ee802;
      d0=64'h4003cab244cc488a;
    end
  25: begin 
      a0=64'hc08b42656eb9943e;
      b0=64'h4051c9520d61efec;
      c0=64'hc020aaf8c82a217e;
      d0=64'h4003a8ca2ad1b730;
    end
  26: begin 
      a0=64'hc08860e57fdfbfab;
      b0=64'h4050829e1c85d892;
      c0=64'hc02021c4a097a8af;
      d0=64'h400387ff1b8cdec7;
    end
  27: begin 
      a0=64'hc085e49cac52d438;
      b0=64'h404ebcd4d7c5a21d;
      c0=64'hc01f447949c5c570;
      d0=64'h4003683c9b26528d;
    end
  28: begin 
      a0=64'hc083bcae8416df2d;
      b0=64'h404caff7ca64bd23;
      c0=64'hc01e56bf53f3bca2;
      d0=64'h4003497058a1b7ab;
    end
  29: begin 
      a0=64'hc081db83e49ec8f0;
      b0=64'h404ad6c1ffe365aa;
      c0=64'hc01d789e760e7f30;
      d0=64'h40032b89e19ba424;
    end
  30: begin 
      a0=64'hc080361304972db2;
      b0=64'h40492a9566176aa3;
      c0=64'hc01ca893d0fe3ae8;
      d0=64'h40030e7a62c0edeb;
    end
  31: begin 
      a0=64'hc07d86a8fd155090;
      b0=64'h4047a5dbf1361d7e;
      c0=64'hc01be54d5b020150;
      d0=64'h4002f23472866ac1;
    end
  32: begin 
      a0=64'hc07af7b211ea9bc7;
      b0=64'h404643d797ef52c0;
      c0=64'hc01b2da25ea24efe;
      d0=64'h4002d6abe433686d;
    end
  33: begin 
      a0=64'hc078b2ef5b277643;
      b0=64'h4045007c3821ea5f;
      c0=64'hc01a808d5250c3e1;
      d0=64'h4002bbd5a1ba6b21;
    end
  34: begin 
      a0=64'hc076ae1c62221f9c;
      b0=64'h4043d8511cd45bb1;
      c0=64'hc019dd26c28261ec;
      d0=64'h4002a1a78b2c17ce;
    end
  35: begin 
      a0=64'hc074e09e9e1ae94f;
      b0=64'h4042c85873622f16;
      c0=64'hc01942a117fba52a;
      d0=64'h400288185ace0ed2;
    end
  36: begin 
      a0=64'hc0734336e14ef7c6;
      b0=64'h4041cdfb65b651ab;
      c0=64'hc018b0450ff55bdc;
      d0=64'h40026f1f8d0f8792;
    end
  37: begin 
      a0=64'hc071cfc2f2121584;
      b0=64'h4040e6f9df5d99e6;
      c0=64'hc018256ec4d62734;
      d0=64'h400256b54bbb1947;
    end
  38: begin 
      a0=64'hc070810bb0a2c5ac;
      b0=64'h4040115d3c7e968e;
      c0=64'hc017a18b2d2ae93c;
      d0=64'h40023ed25be2c4c4;
    end
  39: begin 
      a0=64'hc06ea539c15a0540;
      b0=64'h403e96da997abde2;
      c0=64'hc0172415fbe1a602;
      d0=64'h400227700e1adf52;
    end
  40: begin 
      a0=64'hc06c814986bf8200;
      b0=64'h403d274e6dc582a3;
      c0=64'hc016ac97d0f51c6d;
      d0=64'h4002108830ab517b;
    end
  41: begin 
      a0=64'hc06a8fb33a1069d8;
      b0=64'h403bd16bc059925e;
      c0=64'hc0163aa4acf31ff8;
      d0=64'h4001fa15036dbf57;
    end
  42: begin 
      a0=64'hc068cac830b3298d;
      b0=64'h403a92d72065ab86;
      c0=64'hc015cdda9c5c4111;
      d0=64'h4001e4112d1b6f23;
    end
  43: begin 
      a0=64'hc0672d9b01bebb60;
      b0=64'h403969792e90fddd;
      c0=64'hc01565e091defde5;
      d0=64'h4001ce77b1d7b9ae;
    end
  44: begin 
      a0=64'hc065b3e225d99ebd;
      b0=64'h403853759337df50;
      c0=64'hc015026568113309;
      d0=64'h4001b943eacbf568;
    end
  45: begin 
      a0=64'hc06459df9d5526e2;
      b0=64'h40374f235406c0bc;
      c0=64'hc014a31f0494cf6c;
      d0=64'h4001a4717eb07f7b;
    end
  46: begin 
      a0=64'hc0631c4ca4c4d3b8;
      b0=64'h40365b064d562f91;
      c0=64'hc01447c997a229bc;
      d0=64'h40018ffc5b240e1f;
    end
  47: begin 
      a0=64'hc061f848a1f64484;
      b0=64'h403575c99de3ed71;
      c0=64'hc013f026f3c8d3e8;
      d0=64'h40017be0aeb70dbf;
    end
  48: begin 
      a0=64'hc060eb4aff6e3dff;
      b0=64'h40349e3adf3959d1;
      c0=64'hc0139bfdfa6b65fe;
      d0=64'h4001681ae3949d49;
    end
  49: begin 
      a0=64'hc05fe62e0419b19b;
      b0=64'h4033d34607a21031;
      c0=64'hc0134b1a1a07905d;
      d0=64'h400154a79ab5f0a3;
    end
  50: begin 
      a0=64'hc05e1b634bac7360;
      b0=64'h403313f1dd0b8149;
      c0=64'hc012fd4adbd55210;
      d0=64'h40014183a78f903d;
    end
  51: begin 
      a0=64'hc05c72b215da0daf;
      b0=64'h40325f5ce2166ded;
      c0=64'hc012b2637ea8bfd0;
      d0=64'h40012eac0c2a305d;
    end
  52: begin 
      a0=64'hc05ae8f9d1ddfd76;
      b0=64'h4031b4baa98a0f31;
      c0=64'hc0126a3a9d51d25e;
      d0=64'h40011c1df59ac568;
    end
  53: begin 
      a0=64'hc0597b70eb1829d8;
      b0=64'h4031135183ef3aa0;
      c0=64'hc01224a9defc9442;
      d0=64'h400109d6b8cf1b6c;
    end
  54: begin 
      a0=64'hc0582799a2c91f1a;
      b0=64'h40307a7876da2d60;
      c0=64'hc011e18db0477bae;
      d0=64'h4000f7d3cfa599d3;
    end
  55: begin 
      a0=64'hc056eb38ff08816f;
      b0=64'h402fd32aec1c89a4;
      c0=64'hc011a0c503f8e9aa;
      d0=64'h4000e612d6480b94;
    end
  56: begin 
      a0=64'hc055c44eabb5da58;
      b0=64'h402ec037a7be4353;
      c0=64'hc01162311a630732;
      d0=64'h4000d49188c248a4;
    end
  57: begin 
      a0=64'hc054b10def3b93f6;
      b0=64'h402dbb15c28acb08;
      c0=64'hc01125b54ea5af1d;
      d0=64'h4000c34dc0ce7cb5;
    end
  58: begin 
      a0=64'hc053afd8111afda7;
      b0=64'h402cc2d971b33a37;
      c0=64'hc010eb36e91cbd86;
      d0=64'h4000b24573d18868;
    end
  59: begin 
      a0=64'hc052bf36a47feb15;
      b0=64'h402bd6aa574c6447;
      c0=64'hc010b29cf65d93bd;
      d0=64'h4000a176b102a096;
    end
  60: begin 
      a0=64'hc051ddd742b934e3;
      b0=64'h402af5c19e0529c1;
      c0=64'hc0107bd0223f81fa;
      d0=64'h400090df9fb9e06c;
    end
  61: begin 
      a0=64'hc0510a87737adee5;
      b0=64'h402a1f684989e4ab;
      c0=64'hc01046ba967833f6;
      d0=64'h4000807e7de20005;
    end
  62: begin 
      a0=64'hc05044315ae8a903;
      b0=64'h402952f5b853d4d0;
      c0=64'hc0101347dc677941;
      d0=64'h400070519e89cf5f;
    end
  63: begin 
      a0=64'hc04f13b10896ca6b;
      b0=64'h40288fce4cf3a198;
      c0=64'hc00fc2c9836e701f;
      d0=64'h4000605768927488;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a1=64'hc04db52e506791c2;
      b1=64'h4027d5623c92d53b;
      c1=64'hc00f61fe7f04d844;
      d1=64'h4000508e5577c001;
    end
  1: begin 
      a1=64'hc04c6b380ea6398d;
      b1=64'h4027232c7fcb2070;
      c1=64'hc00f040cc77e9ef0;
      d1=64'h400040f4f030339a;
    end
  2: begin 
      a1=64'hc04b345031452896;
      b1=64'h402678b1dc43f29a;
      c1=64'hc00ea8d4795a9874;
      d1=64'h40003189d4229874;
    end
  3: begin 
      a1=64'hc04a0f1985fd6747;
      b1=64'h4025d5800a128c8c;
      c1=64'hc00e50378c296e93;
      d1=64'h4000224bac2f3a11;
    end
  4: begin 
      a1=64'hc048fa54f30164a9;
      b1=64'h4025392cef3c634c;
      c1=64'hc00dfa19b04dd056;
      d1=64'h4000133931cb0e12;
    end
  5: begin 
      a1=64'hc047f4dda3ed94d9;
      b1=64'h4024a355eba7f523;
      c1=64'hc00da6602fa98d8f;
      d1=64'h400004512c2b3cfd;
    end
  6: begin 
      a1=64'hc046fda7144eee2b;
      b1=64'h4024139f3a70a2dd;
      c1=64'hc00d54f1d0f22f16;
      d1=64'h3fffeb24deff4fe2;
    end
  7: begin 
      a1=64'hc04613bab3a31a99;
      b1=64'h402389b360d2ad6c;
      c1=64'hc00d05b6bd66604c;
      d1=64'h3fffcdf7b87652e6;
    end
  8: begin 
      a1=64'hc0453635a8ffe2e8;
      b1=64'h40230542aaa60332;
      c1=64'hc00cb89868ab1561;
      d1=64'h3fffb118bcd0de20;
    end
  9: begin 
      a1=64'hc044644729d8c2b1;
      b1=64'h40228602b3dada4f;
      c1=64'hc00c6d817a9d4244;
      d1=64'h3fff9485da14caac;
    end
  10: begin 
      a1=64'hc0439d2eac232b43;
      b1=64'h40220badfcc1fb26;
      c1=64'hc00c245dbae8fd09;
      d1=64'h3fff783d130e8fd9;
    end
  11: begin 
      a1=64'hc042e03a94e71357;
      b1=64'h40219603880be535;
      c1=64'hc00bdd19fe3a9f27;
      d1=64'h3fff5c3c7e3afb8f;
    end
  12: begin 
      a1=64'hc0422cc68ba22933;
      b1=64'h402124c6812ccc01;
      c1=64'hc00b97a414e6f6df;
      d1=64'h3fff408244c2fb37;
    end
  13: begin 
      a1=64'hc041823b29da7ef9;
      b1=64'h4020b7bded53c23b;
      c1=64'hc00b53eabae8f2aa;
      d1=64'h3fff250ca1880f99;
    end
  14: begin 
      a1=64'hc040e00b9bef50e0;
      b1=64'h40204eb45dfbf692;
      c1=64'hc00b11dd8911d71d;
      d1=64'h3fff09d9e04026b4;
    end
  15: begin 
      a1=64'hc04045b5d1ac2888;
      b1=64'h401fd2ef615376f9;
      c1=64'hc00ad16ce759aff8;
      d1=64'h3ffeeee85c9fb35a;
    end
  16: begin 
      a1=64'hc03f65820a774e02;
      b1=64'h401f0fb19e5ba87e;
      c1=64'hc00a928a002e780c;
      d1=64'h3ffed4368190f39d;
    end
  17: begin 
      a1=64'hc03e4d79edbaa8c1;
      b1=64'h401e5356eefa650d;
      c1=64'hc00a5526b4b1aba6;
      d1=64'h3ffeb9c2c8776e62;
    end
  18: begin 
      a1=64'hc03d42832efc6907;
      b1=64'h401d9d8c11474598;
      c1=64'hc00a193591cec6f0;
      d1=64'h3ffe9f8bb87ec5ef;
    end
  19: begin 
      a1=64'hc03c43db99f8c2ac;
      b1=64'h401cee02a420b5e5;
      c1=64'hc009dea9c61756e1;
      d1=64'h3ffe858fe5f40f67;
    end
  20: begin 
      a1=64'hc03b50ceea46feba;
      b1=64'h401c4470d1eeb0a4;
      c1=64'hc009a577185688f5;
      d1=64'h3ffe6bcdf1a8f18a;
    end
  21: begin 
      a1=64'hc03a68b4d6deca02;
      b1=64'h401ba090ff1a302e;
      c1=64'hc0096d91decb91e5;
      d1=64'h3ffe5244885fdaf3;
    end
  22: begin 
      a1=64'hc0398af0c1aae177;
      b1=64'h401b0221812f73d9;
      c1=64'hc00936eef6fea594;
      d1=64'h3ffe38f26240affd;
    end
  23: begin 
      a1=64'hc038b6efde875da8;
      b1=64'h401a68e458f73c3c;
      c1=64'hc0090183be22f6e4;
      d1=64'h3ffe1fd642555b98;
    end
  24: begin 
      a1=64'hc037ec29dfa83ee7;
      b1=64'h4019d49ef72335ad;
      c1=64'hc008cd4609fd2f60;
      d1=64'h3ffe06eef60dbbd1;
    end
  25: begin 
      a1=64'hc0372a1ecf59d05b;
      b1=64'h40194519fee04478;
      c1=64'hc0089a2c22402392;
      d1=64'h3ffdee3b54ca6b6e;
    end
  26: begin 
      a1=64'hc03670571f87d2bd;
      b1=64'h4018ba211287df29;
      c1=64'hc008682cba5affad;
      d1=64'h3ffdd5ba3f6df576;
    end
  27: begin 
      a1=64'hc035be62d125005a;
      b1=64'h40183382a14723c5;
      c1=64'hc008373eebacc839;
      d1=64'h3ffdbd6a9ff40737;
    end
  28: begin 
      a1=64'hc03513d90778e1ad;
      b1=64'h4017b10fb9e9abf7;
      c1=64'hc008075a3018378e;
      d1=64'h3ffda54b690e3e18;
    end
  29: begin 
      a1=64'hc034705766794b25;
      b1=64'h4017329be003f74c;
      c1=64'hc007d8765ceee13f;
      d1=64'h3ffd8d5b95c63553;
    end
  30: begin 
      a1=64'hc033d381dd7018f4;
      b1=64'h4016b7fce5cb6155;
      c1=64'hc007aa8b9e2eacdb;
      d1=64'h3ffd759a29247ede;
    end
  31: begin 
      a1=64'hc0333d0182bc8036;
      b1=64'h4016410ac5462013;
      c1=64'hc0077d927209e330;
      d1=64'h3ffd5e062ddc391f;
    end
  32: begin 
      a1=64'hc032ac851ff97d4d;
      b1=64'h4015cd9f814e6d90;
      c1=64'hc0075183a4b70e5c;
      d1=64'h3ffd469eb5faf800;
    end
  33: begin 
      a1=64'hc03221c05767b4d6;
      b1=64'h40155d9704eda079;
      c1=64'hc00726584c8121a4;
      d1=64'h3ffd2f62da9cbe35;
    end
  34: begin 
      a1=64'hc0319c6ae00930ad;
      b1=64'h4014f0cf043f315a;
      c1=64'hc006fc09c6135a95;
      d1=64'h3ffd1851bba3c72f;
    end
  35: begin 
      a1=64'hc0311c4151e21c6a;
      b1=64'h40148726e57f0c93;
      c1=64'hc006d291b100c642;
      d1=64'h3ffd016a7f73e7ec;
    end
  36: begin 
      a1=64'hc030a103706699e1;
      b1=64'h4014207fa299be6b;
      c1=64'hc006a9e9ec7be884;
      d1=64'h3ffceaac52b14f50;
    end
  37: begin 
      a1=64'hc0302a75906b73c2;
      b1=64'h4013bcbbb70b917e;
      c1=64'hc006820c9443d2e6;
      d1=64'h3ffcd41668027435;
    end
  38: begin 
      a1=64'hc02f70bda948f9d9;
      b1=64'h40135bbf04faecd4;
      c1=64'hc0065af3fdbad0ee;
      d1=64'h3ffcbda7f7d50120;
    end
  39: begin 
      a1=64'hc02e95131e61891c;
      b1=64'h4012fd6ec2c8a59f;
      c1=64'hc006349ab52a8b73;
      d1=64'h3ffca7604025923d;
    end
  40: begin 
      a1=64'hc02dc186dd30c1a0;
      b1=64'h4012a1b168e5c8ca;
      c1=64'hc0060efb7b2f03b6;
      d1=64'h3ffc913e844a1bc4;
    end
  41: begin 
      a1=64'hc02cf5b941a57ecc;
      b1=64'h4012486e9dd9ed46;
      c1=64'hc005ea114245f263;
      d1=64'h3ffc7b420cbed2fc;
    end
  42: begin 
      a1=64'hc02c315045d03cda;
      b1=64'h4011f18f26ad749f;
      c1=64'hc005c5d72c820246;
      d1=64'h3ffc656a26f57598;
    end
  43: begin 
      a1=64'hc02b73f68a3c474b;
      b1=64'h40119cfcd6ffcfc2;
      c1=64'hc005a248895dfdb7;
      d1=64'h3ffc4fb62526cdcf;
    end
  44: begin 
      a1=64'hc02abd5b5de644fd;
      b1=64'h40114aa282070d8b;
      c1=64'hc0057f60d3ae1fc4;
      d1=64'h3ffc3a255e2653eb;
    end
  45: begin 
      a1=64'hc02a0d325058448b;
      b1=64'h4010fa6bed164c83;
      c1=64'hc0055d1bafae94a9;
      d1=64'h3ffc24b72d37cfec;
    end
  46: begin 
      a1=64'hc0296333011698f4;
      b1=64'h4010ac45c2b12f1b;
      c1=64'hc0053b74e92c3852;
      d1=64'h3ffc0f6af1e6df75;
    end
  47: begin 
      a1=64'hc028bf190953eaf8;
      b1=64'h4010601d86857d6f;
      c1=64'hc0051a6871c6406a;
      d1=64'h3ffbfa400fe0461c;
    end
  48: begin 
      a1=64'hc02820a31b6230fc;
      b1=64'h401015e1893d60ac;
      c1=64'hc004f9f25f47b021;
      d1=64'h3ffbe535eeccf063;
    end
  49: begin 
      a1=64'hc0278793e1aa0184;
      b1=64'h400f9b01bebcb6d2;
      c1=64'hc004da0eea16f279;
      d1=64'h3ffbd04bfa2e91bf;
    end
  50: begin 
      a1=64'hc026f3b0e729914e;
      b1=64'h400f0dd6abb072a7;
      c1=64'hc004baba6bb99b81;
      d1=64'h3ffbbb81a13dc910;
    end
  51: begin 
      a1=64'hc02664c237e6223b;
      b1=64'h400e8422d136e6df;
      c1=64'hc0049bf15d6c38d1;
      d1=64'h3ffba6d656c9b712;
    end
  52: begin 
      a1=64'hc025da93509c48cc;
      b1=64'h400dfdc875fc0455;
      c1=64'hc0047db056cc7519;
      d1=64'h3ffb92499118f3ca;
    end
  53: begin 
      a1=64'hc02554f24ee9d702;
      b1=64'h400d7aab1ce7f197;
      c1=64'hc0045ff40c93f4b4;
      d1=64'h3ffb7ddac9cbd175;
    end
  54: begin 
      a1=64'hc024d3af24a7327d;
      b1=64'h400cfaaf73ff4c00;
      c1=64'hc00442b94f63b453;
      d1=64'h3ffb69897dbfdbf7;
    end
  55: begin 
      a1=64'hc024569cd66d380b;
      b1=64'h400c7dbb494c4bdd;
      c1=64'hc00425fd0a9f4083;
      d1=64'h3ffb55552cf48562;
    end
  56: begin 
      a1=64'hc023dd9002edf30a;
      b1=64'h400c03b578fa05d1;
      c1=64'hc00409bc43554124;
      d1=64'h3ffb413d5a70f01b;
    end
  57: begin 
      a1=64'hc023685f9a1b3376;
      b1=64'h400b8c85e2670829;
      c1=64'hc003edf417366b16;
      d1=64'h3ffb2d418c2ac966;
    end
  58: begin 
      a1=64'hc022f6e4cad5e550;
      b1=64'h400b18155c20060a;
      c1=64'hc003d2a1bb994d81;
      d1=64'h3ffb19614aee2694;
    end
  59: begin 
      a1=64'hc02288fa3976d1f3;
      b1=64'h400aa64da60a01e7;
      c1=64'hc003b7c27c896ec2;
      d1=64'h3ffb059c22465875;
    end
  60: begin 
      a1=64'hc0221e7c17b2445f;
      b1=64'h400a37195e9a3e4f;
      c1=64'hc0039d53bbe28f5a;
      d1=64'h3ffaf1f1a067a9a9;
    end
  61: begin 
      a1=64'hc021b749328ac967;
      b1=64'h4009ca63fc14cc5c;
      c1=64'hc0038352f0773729;
      d1=64'h3ffade615619fc0c;
    end
  62: begin 
      a1=64'hc0215340d80364ec;
      b1=64'h40096019bcd178d8;
      c1=64'hc00369bda53fa2bb;
      d1=64'h3ffacaead6a43b62;
    end
  63: begin 
      a1=64'hc020f2442b25893b;
      b1=64'h4008f827a17331e1;
      c1=64'hc003509178944c5a;
      d1=64'h3ffab78db7b89af5;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a2=64'hc0209435d9f299d4;
      b2=64'h4008927b639327c8;
      c2=64'hc00337cc1b7081a8;
      d2=64'h3ffaa449916194c0;
    end
  1: begin 
      a2=64'hc02038fa52be2f9f;
      b2=64'h40082f036e7eca1e;
      c2=64'hc0031f6b50be6ab2;
      d2=64'h3ffa911dfdefa1ab;
    end
  2: begin 
      a2=64'hc01fc0ec5429d4b0;
      b2=64'h4007cdaed2865580;
      c2=64'hc003076ceca99d30;
      d2=64'h3ffa7e0a99e7a1a2;
    end
  3: begin 
      a2=64'hc01f15204573257f;
      b2=64'h40076e6d43e2ce8f;
      c2=64'hc002efced3fbfcf2;
      d2=64'h3ffa6b0f03f1ec8a;
    end
  4: begin 
      a2=64'hc01e6e5ec2c2262a;
      b2=64'h4007112f0dd0b833;
      c2=64'hc002d88efb7f507b;
      d2=64'h3ffa582adcca03b3;
    end
  5: begin 
      a2=64'hc01dcc7a3bc6de3a;
      b2=64'h4006b5e5112954c4;
      c2=64'hc002c1ab67681d4e;
      d2=64'h3ffa455dc72edd30;
    end
  6: begin 
      a2=64'hc01d2f44dbb5d3a9;
      b2=64'h40065c80b8489499;
      c2=64'hc002ab222ac51127;
      d2=64'h3ffa32a767d3c1cb;
    end
  7: begin 
      a2=64'hc01c96945cbd59cd;
      b2=64'h400604f3f605bac6;
      c2=64'hc00294f166f69362;
      d2=64'h3ffa20076551b7a5;
    end
  8: begin 
      a2=64'hc01c023f0d28be6d;
      b2=64'h4005af313b86d476;
      c2=64'hc0027f174b2a8c06;
      d2=64'h3ffa0d7d6819730f;
    end
  9: begin 
      a2=64'hc01b721ee6e7e1cf;
      b2=64'h40055b2b77fa37a8;
      c2=64'hc002699213dfb707;
      d2=64'h3ff9fb091a65c7da;
    end
  10: begin 
      a2=64'hc01ae60cabc3971e;
      b2=64'h400508d60c16d598;
      c2=64'hc00254600a6bf61c;
      d2=64'h3ff9e8aa282e95c4;
    end
  11: begin 
      a2=64'hc01a5de60946dd30;
      b2=64'h4004b824cdcdd31b;
      c2=64'hc0023f7f848a9e79;
      d2=64'h3ff9d6603f1c2a81;
    end
  12: begin 
      a2=64'hc019d987d793a210;
      b2=64'h4004690bfc328a09;
      c2=64'hc0022aeee3ece90b;
      d2=64'h3ff9c42b0e7b14c2;
    end
  13: begin 
      a2=64'hc01958d08ce04869;
      b2=64'h40041b803ddde00a;
      c2=64'hc00216ac95d090f6;
      d2=64'h3ff9b20a473062fa;
    end
  14: begin 
      a2=64'hc018dba13919bf1f;
      b2=64'h4003cf769e73bb49;
      c2=64'hc00202b7129ace2a;
      d2=64'h3ff99ffd9bae4a00;
    end
  15: begin 
      a2=64'hc01861da35065f0a;
      b2=64'h400384e485d912f2;
      c2=64'hc001ef0cdd766b0d;
      d2=64'h3ff98e04bfe92eb7;
    end
  16: begin 
      a2=64'hc017eb5fab4a1a50;
      b2=64'h40033bbfba91726e;
      c2=64'hc001dbac83f784de;
      d2=64'h3ff97c1f694d0efa;
    end
  17: begin 
      a2=64'hc01778152a755c8e;
      b2=64'h4002f3fe58c76aea;
      c2=64'hc001c8949dc17743;
      d2=64'h3ff96a4d4eb345c5;
    end
  18: begin 
      a2=64'hc01707df81362a8a;
      b2=64'h4002ad96d00c182e;
      c2=64'hc001b5c3cc30f4c0;
      d2=64'h3ff9588e2858a6ea;
    end
  19: begin 
      a2=64'hc0169aa5474f2558;
      b2=64'h4002687fe2b5617a;
      c2=64'hc001a338ba0aa4a0;
      d2=64'h3ff946e1afd3ef0c;
    end
  20: begin 
      a2=64'hc016304d2acedcb1;
      b2=64'h400224b09e08bb8b;
      c2=64'hc00190f21b2aa9c7;
      d2=64'h3ff93547a00c83e6;
    end
  21: begin 
      a2=64'hc015c8c027085ee2;
      b2=64'h4001e2205c269e82;
      c2=64'hc0017eeeac3a1605;
      d2=64'h3ff923bfb5318265;
    end
  22: begin 
      a2=64'hc01563e64ec92602;
      b2=64'h4001a0c6bc375ac2;
      c2=64'hc0016d2d3264f6e4;
      d2=64'h3ff91249acb11702;
    end
  23: begin 
      a2=64'hc01501aa86530d07;
      b2=64'h4001609ba477bc9c;
      c2=64'hc0015bac7b150330;
      d2=64'h3ff900e545301dae;
    end
  24: begin 
      a2=64'hc014a1f701202f4c;
      b2=64'h400121973b22957c;
      c2=64'hc0014a6b5bad77c4;
      d2=64'h3ff8ef923e82064b;
    end
  25: begin 
      a2=64'hc01444b7a70b0b7b;
      b2=64'h4000e3b1e7422cc9;
      c2=64'hc0013968b14b2911;
      d2=64'h3ff8de5059a0fb84;
    end
  26: begin 
      a2=64'hc013e9d98cef35f6;
      b2=64'h4000a6e44d4f871f;
      c2=64'hc00128a36085adfd;
      d2=64'h3ff8cd1f58a648c7;
    end
  27: begin 
      a2=64'hc01391488aba1534;
      b2=64'h40006b2749d5a0be;
      c2=64'hc001181a55335377;
      d2=64'h3ff8bbfefec2fd95;
    end
  28: begin 
      a2=64'hc0133af2e248535d;
      b2=64'h40003073f4981637;
      c2=64'hc00107cc823034b0;
      d2=64'h3ff8aaef1038cb79;
    end
  29: begin 
      a2=64'hc012e6c818c39eff;
      b2=64'h3fffed87381c10a8;
      c2=64'hc000f7b8e1266a80;
      d2=64'h3ff899ef52531cab;
    end
  30: begin 
      a2=64'hc01294b631ebf72b;
      b2=64'h3fff7c1f80a8466c;
      c2=64'hc000e7de7257fdba;
      d2=64'h3ff888ff8b6060c4;
    end
  31: begin 
      a2=64'hc01244adce675264;
      b2=64'h3fff0ca42d271f63;
      c2=64'hc000d83c3c6c9f01;
      d2=64'h3ff8781f82ab8e5e;
    end
  32: begin 
      a2=64'hc011f69eee00ffcc;
      b2=64'h3ffe9f09066a668d;
      c2=64'hc000c8d14c3f7ccc;
      d2=64'h3ff8674f0075d6a7;
    end
  33: begin 
      a2=64'hc011aa7a65ed5f4b;
      b2=64'h3ffe3342325eb43e;
      c2=64'hc000b99cb4af734f;
      d2=64'h3ff8568dcdf089cd;
    end
  34: begin 
      a2=64'hc0116031b4320443;
      b2=64'h3ffdc944329e76b5;
      c2=64'hc000aa9d8e71bfab;
      d2=64'h3ff845dbb5372a3d;
    end
  35: begin 
      a2=64'hc01117b7329c6957;
      b2=64'h3ffd6103e005b852;
      c2=64'hc0009bd2f7e5239b;
      d2=64'h3ff835388149acc6;
    end
  36: begin 
      a2=64'hc010d0fd01a47eef;
      b2=64'h3ffcfa7664f1d0b9;
      c2=64'hc0008d3c14e76308;
      d2=64'h3ff824a3fe06e47f;
    end
  37: begin 
      a2=64'hc0108bf71c5b9f88;
      b2=64'h3ffc9591414e3b01;
      c2=64'hc0007ed80eac82aa;
      d2=64'h3ff8141df8271848;
    end
  38: begin 
      a2=64'hc01048975ebe39f8;
      b2=64'h3ffc324a3abc7acb;
      c2=64'hc00070a613961690;
      d2=64'h3ff803a63d36c0f6;
    end
  39: begin 
      a2=64'hc01006d333c28a6f;
      b2=64'h3ffbd0976b6f3a31;
      c2=64'hc00062a5570e6727;
      d2=64'h3ff7f33c9b916e41;
    end
  40: begin 
      a2=64'hc00f8d3cf6cdb7d8;
      b2=64'h3ffb706f3019ff20;
      c2=64'hc00054d511624a0a;
      d2=64'h3ff7e2e0e25cd181;
    end
  41: begin 
      a2=64'hc00f0fdb209633fa;
      b2=64'h3ffb11c82c593f62;
      c2=64'hc00047347f9e1b1e;
      d2=64'h3ff7d292e183ec5f;
    end
  42: begin 
      a2=64'hc00e956d32a66f70;
      b2=64'h3ffab49949ad1836;
      c2=64'hc00039c2e36b47d8;
      d2=64'h3ff7c25269b262ef;
    end
  43: begin 
      a2=64'hc00e1ddaf9b8ad27;
      b2=64'h3ffa58d9adff1ba8;
      c2=64'hc0002c7f82eeffab;
      d2=64'h3ff7b21f4c4fef27;
    end
  44: begin 
      a2=64'hc00da9120ed863cb;
      b2=64'h3ff9fe80c2fd35ce;
      c2=64'hc0001f69a8aa4722;
      d2=64'h3ff7a1f95b7bf545;
    end
  45: begin 
      a2=64'hc00d36ff8ba8489c;
      b2=64'h3ff9a5862e7c6bff;
      c2=64'hc0001280a35b3188;
      d2=64'h3ff791e06a093794;
    end
  46: begin 
      a2=64'hc00cc78ea273f9d2;
      b2=64'h3ff94de1cd6ae3f9;
      c2=64'hc00005c3c5de5233;
      d2=64'h3ff781d44b79a878;
    end
  47: begin 
      a2=64'hc00c5aadcb3e4093;
      b2=64'h3ff8f78bb983c18d;
      c2=64'hbffff264ce25c142;
      d2=64'h3ff771d4d3fa5a2e;
    end
  48: begin 
      a2=64'hc00bf04cb630f31e;
      b2=64'h3ff8a27c42bb5409;
      c2=64'hbfffd997c37bb4ed;
      d2=64'h3ff761e1d85f8a88;
    end
  49: begin 
      a2=64'hc00b8858e2dc2e3c;
      b2=64'h3ff84eabebd3ff14;
      c2=64'hbfffc11f28df5ca8;
      d2=64'h3ff751fb2e20ca78;
    end
  50: begin 
      a2=64'hc00b22c24aac6a92;
      b2=64'h3ff7fc136cb7983e;
      c2=64'hbfffa8f9c2d3c07f;
      d2=64'h3ff74220ab553fd0;
    end
  51: begin 
      a2=64'hc00abf795ce8a084;
      b2=64'h3ff7aaabae8fe442;
      c2=64'hbfff91265d0c0784;
      d2=64'h3ff7325226b000d4;
    end
  52: begin 
      a2=64'hc00a5e6cf4519582;
      b2=64'h3ff75a6dc810d8fb;
      c2=64'hbfff79a3ca3a2a53;
      d2=64'h3ff7228f777c8863;
    end
  53: begin 
      a2=64'hc009ff90731488bf;
      b2=64'h3ff70b53034da8df;
      c2=64'hbfff6270e3e105b9;
      d2=64'h3ff712d8759b4259;
    end
  54: begin 
      a2=64'hc009a2d31d0f1275;
      b2=64'h3ff6bd54d13b2843;
      c2=64'hbfff4b8c8a253ada;
      d2=64'h3ff7032cf97e2ed1;
    end
  55: begin 
      a2=64'hc0094828ad9e2c6a;
      b2=64'h3ff6706cd30cf7fb;
      c2=64'hbfff34f5a3a278a6;
      d2=64'h3ff6f38cdc259bfc;
    end
  56: begin 
      a2=64'hc008ef82d755d368;
      b2=64'h3ff62494d116908d;
      c2=64'hbfff1eab1d3fe6bc;
      d2=64'h3ff6e3f7f71cf599;
    end
  57: begin 
      a2=64'hc00898d48688c6e4;
      b2=64'h3ff5d9c6bd4e18e7;
      c2=64'hbfff08abea077889;
      d2=64'h3ff6d46e2477a970;
    end
  58: begin 
      a2=64'hc008441250c4324a;
      b2=64'h3ff58ffcb208e828;
      c2=64'hbffef2f702fddf9f;
      d2=64'h3ff6c4ef3ece201a;
    end
  59: begin 
      a2=64'hc007f12d82aeaad6;
      b2=64'h3ff54730eb912c32;
      c2=64'hbffedd8b66fb1c16;
      d2=64'h3ff6b57b213ac952;
    end
  60: begin 
      a2=64'hc007a01bed2bd444;
      b2=64'h3ff4ff5dcf891a57;
      c2=64'hbffec8681a8651ca;
      d2=64'h3ff6a611a7573b7c;
    end
  61: begin 
      a2=64'hc00750d22431245e;
      b2=64'h3ff4b87de635eef3;
      c2=64'hbffeb38c27b0edc9;
      d2=64'h3ff696b2ad396575;
    end
  62: begin 
      a2=64'hc0070343a1cf7e9a;
      b2=64'h3ff4728bd7b6956f;
      c2=64'hbffe9ef69df3096e;
      d2=64'h3ff6875e0f70d23a;
    end
  63: begin 
      a2=64'hc006b766e1536fca;
      b2=64'h3ff42d82712a837a;
      c2=64'hbffe8aa6920a78e7;
      d2=64'h3ff67813ab03fdf1;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a3=64'hc0066d31eb5e7049;
      b3=64'h3ff3e95c9f1f0915;
      c3=64'hbffe769b1dd91390;
      d3=64'h3ff668d35d6dbb7d;
    end
  1: begin 
      a3=64'hc0062498bfc8fb6f;
      b3=64'h3ff3a6156ad68f7a;
      c3=64'hbffe62d36044e540;
      d3=64'h3ff6599d049aaa78;
    end
  2: begin 
      a3=64'hc005dd92646e56d0;
      b3=64'h3ff363a7ff28f313;
      c3=64'hbffe4f4e7d19ba4a;
      d3=64'h3ff64a707ee6bcbd;
    end
  3: begin 
      a3=64'hc0059815a76bf360;
      b3=64'h3ff3220fa379b04d;
      c3=64'hbffe3c0b9ceab277;
      d3=64'h3ff63b4dab1acb41;
    end
  4: begin 
      a3=64'hc005541910cc0ae4;
      b3=64'h3ff2e147bb43c36e;
      c3=64'hbffe2909ecf55af3;
      d3=64'h3ff62c34686a3985;
    end
  5: begin 
      a3=64'hc005119438ef27c4;
      b3=64'h3ff2a14bc70e5a18;
      c3=64'hbffe16489f05f3bd;
      d3=64'h3ff61d249670a78f;
    end
  6: begin 
      a3=64'hc004d07dbe2b726d;
      b3=64'h3ff2621760471ac4;
      c3=64'hbffe03c6e95b4b2a;
      d3=64'h3ff60e1e152fb17b;
    end
  7: begin 
      a3=64'hc00490cce478db89;
      b3=64'h3ff223a63ad89568;
      c3=64'hbffdf184068d0a75;
      d3=64'h3ff5ff20c50cbca2;
    end
  8: begin 
      a3=64'hc004527a3caa99e0;
      b3=64'h3ff1e5f4254b7138;
      c3=64'hbffddf7f357211a7;
      d3=64'h3ff5f02c86ced1c2;
    end
  9: begin 
      a3=64'hc004157d90803600;
      b3=64'h3ff1a8fd05360212;
      c3=64'hbffdcdb7b906d163;
      d3=64'h3ff5e1413b9c83a7;
    end
  10: begin 
      a3=64'hc003d9d0133f43b4;
      b3=64'h3ff16cbcda2af3fc;
      c3=64'hbffdbc2cd856d268;
      d3=64'h3ff5d25ec4f9e24c;
    end
  11: begin 
      a3=64'hc0039f68a621b75b;
      b3=64'h3ff1312fb620300e;
      c3=64'hbffdaaddde62d365;
      d3=64'h3ff5c38504c67990;
    end
  12: begin 
      a3=64'hc0036641a7d684e1;
      b3=64'h3ff0f651c6d45288;
      c3=64'hbffd99ca1a0cc406;
      d3=64'h3ff5b4b3dd3b5bab;
    end
  13: begin 
      a3=64'hc0032e52b71d0d28;
      b3=64'h3ff0bc1f4b10f9ea;
      c3=64'hbffd88f0ddffd825;
      d3=64'h3ff5a5eb30e936b3;
    end
  14: begin 
      a3=64'hc002f795e6323677;
      b3=64'h3ff082949a1a68d2;
      c3=64'hbffd7851809c4a26;
      d3=64'h3ff5972ae2b67502;
    end
  15: begin 
      a3=64'hc002c2049e81b398;
      b3=64'h3ff049ae1dda7a7a;
      c3=64'hbffd67eb5be2280c;
      d3=64'h3ff58872d5dd680e;
    end
  16: begin 
      a3=64'hc0028d9819afeecf;
      b3=64'h3ff0116854a08c96;
      c3=64'hbffd57bdcd5d572f;
      d3=64'h3ff579c2edea7d70;
    end
  17: begin 
      a3=64'hc0025a49c4580623;
      b3=64'h3fefb37f9c6df320;
      c3=64'hbffd47c83611dd0e;
      d3=64'h3ff56b1b0eba7dff;
    end
  18: begin 
      a3=64'hc00228159346d60a;
      b3=64'h3fef456263baef0e;
      c3=64'hbffd3809fa69f2de;
      d3=64'h3ff55c7b1c78d64a;
    end
  19: begin 
      a3=64'hc001f6f37674ede6;
      b3=64'h3feed872643cdff6;
      c3=64'hbffd28828221cc78;
      d3=64'h3ff54de2fb9de886;
    end
  20: begin 
      a3=64'hc001c6ddb315e7c2;
      b3=64'h3fee6ca92dd5e328;
      c3=64'hbffd19313837b1d6;
      d3=64'h3ff53f5290ed676a;
    end
  21: begin 
      a3=64'hc00197d00171aa9a;
      b3=64'h3fee020073e2c677;
      c3=64'hbffd0a158ad9a502;
      d3=64'h3ff530c9c174b9f8;
    end
  22: begin 
      a3=64'hc00169c5163779b8;
      b3=64'h3fed987208db3f9f;
      c3=64'hbffcfb2eeb5512eb;
      d3=64'h3ff52248728967b9;
    end
  23: begin 
      a3=64'hc0013cb79af0a112;
      b3=64'h3fed2ff7df31e12c;
      c3=64'hbffcec7cce062232;
      d3=64'h3ff513ce89c78d20;
    end
  24: begin 
      a3=64'hc00110a0b95472bd;
      b3=64'h3fecc88c02a76589;
      c3=64'hbffcddfeaa47b6b6;
      d3=64'h3ff5055bed10581f;
    end
  25: begin 
      a3=64'hc000e57f643c0953;
      b3=64'h3fec6228ad9c978d;
      c3=64'hbffccfb3fa65c08c;
      d3=64'h3ff4f6f082888c84;
    end
  26: begin 
      a3=64'hc000bb4a6365ff51;
      b3=64'h3febfcc821274272;
      c3=64'hbffcc19c3b8b2b98;
      d3=64'h3ff4e88c30970f99;
    end
  27: begin 
      a3=64'hc0009200125f099d;
      b3=64'h3feb9864ce5156f9;
      c3=64'hbffcb3b6edb6f323;
      d3=64'h3ff4da2edde37ba9;
    end
  28: begin 
      a3=64'hc000699b70b0c38c;
      b3=64'h3feb34f939089452;
      c3=64'hbffca60393abb689;
      d3=64'h3ff4cbd87154ba0f;
    end
  29: begin 
      a3=64'hc00042172fdb052b;
      b3=64'h3fead27ffe809618;
      c3=64'hbffc9881b2e2b3e4;
      d3=64'h3ff4bd88d20fa496;
    end
  30: begin 
      a3=64'hc0001b6ff70a201e;
      b3=64'h3fea70f3dad61b27;
      c3=64'hbffc8b30d37f061d;
      d3=64'h3ff4af3fe775ad5a;
    end
  31: begin 
      a3=64'hbfffeb4182011dbf;
      b3=64'h3fea104f9fa1441e;
      c3=64'hbffc7e10804060af;
      d3=64'h3ff4a0fd99238d4c;
    end
  32: begin 
      a3=64'hbfffa14e216514a7;
      b3=64'h3fe9b08e3bd52faa;
      c3=64'hbffc71204676bd04;
      d3=64'h3ff492c1ceeff8f6;
    end
  33: begin 
      a3=64'hbfff58fbcb535b99;
      b3=64'h3fe951aab0608a8a;
      c3=64'hbffc645fb5f60e01;
      d3=64'h3ff4848c70ea5b60;
    end
  34: begin 
      a3=64'hbfff12455f7b5d8d;
      b3=64'h3fe8f3a01b5b3ae6;
      c3=64'hbffc57ce610afd91;
      d3=64'h3ff4765d67599701;
    end
  35: begin 
      a3=64'hbffecd1fb7e5c77e;
      b3=64'h3fe89669a89a1a1f;
      c3=64'hbffc4b6bdc6e8344;
      d3=64'h3ff468349abacc56;
    end
  36: begin 
      a3=64'hbffe89887a906de8;
      b3=64'h3fe83a02a5622149;
      c3=64'hbffc3f37bf3c6c97;
      d3=64'h3ff45a11f3c02645;
    end
  37: begin 
      a3=64'hbffe477454ec2079;
      b3=64'h3fe7de66683c91c0;
      c3=64'hbffc3331a2e6fd13;
      d3=64'h3ff44bf55b4fabbd;
    end
  38: begin 
      a3=64'hbffe06df2bd8a379;
      b3=64'h3fe78390644ee3c9;
      c3=64'hbffc2759232d9cae;
      d3=64'h3ff43ddeba8216ca;
    end
  39: begin 
      a3=64'hbffdc7c2a3aee98e;
      b3=64'h3fe7297c1f813052;
      c3=64'hbffc1badde12a022;
      d3=64'h3ff42fcdfaa1b0b6;
    end
  40: begin 
      a3=64'hbffd8a16ec1be2d2;
      b3=64'h3fe6d0252ecc989f;
      c3=64'hbffc102f73d0a9e6;
      d3=64'h3ff421c305293315;
    end
  41: begin 
      a3=64'hbffd4dd6eb2dd0b3;
      b3=64'h3fe677873df1695d;
      c3=64'hbffc04dd86d22f9f;
      d3=64'h3ff413bdc3c2adcd;
    end
  42: begin 
      a3=64'hbffd12fddcf343ff;
      b3=64'h3fe61f9e0bcdcdc1;
      c3=64'hbffbf9b7bba7e29d;
      d3=64'h3ff405be204671aa;
    end
  43: begin 
      a3=64'hbffcd9845a35ff93;
      b3=64'h3fe5c865641cef4d;
      c3=64'hbffbeebdb8ff6392;
      d3=64'h3ff3f7c404b9ff88;
    end
  44: begin 
      a3=64'hbffca16588b8a596;
      b3=64'h3fe571d926a861d7;
      c3=64'hbffbe3ef279ad61d;
      d3=64'h3ff3e9cf5b4efbe0;
    end
  45: begin 
      a3=64'hbffc6a9c0ed516c0;
      b3=64'h3fe51bf544c12719;
      c3=64'hbffbd94bb2491755;
      d3=64'h3ff3dbe00e6226ab;
    end
  46: begin 
      a3=64'hbffc35232bc94f1d;
      b3=64'h3fe4c6b5bd436f5e;
      c3=64'hbffbced305dc5da5;
      d3=64'h3ff3cdf6087a5745;
    end
  47: begin 
      a3=64'hbffc00f5430b6372;
      b3=64'h3fe47216a02f4f8a;
      c3=64'hbffbc484d1234de3;
      d3=64'h3ff3c01134477c6c;
    end
  48: begin 
      a3=64'hbffbce0d2abc7d04;
      b3=64'h3fe41e140b5ab20b;
      c3=64'hbffbba60c4e11b17;
      d3=64'h3ff3b2317ca1a02d;
    end
  49: begin 
      a3=64'hbffb9c678d3858b4;
      b3=64'h3fe3caaa2d42fa49;
      c3=64'hbffbb06693c5e027;
      d3=64'h3ff3a456cc87ef75;
    end
  50: begin 
      a3=64'hbffb6bfeea9fd067;
      b3=64'h3fe377d540e74c1a;
      c3=64'hbffba695f267d0a6;
      d3=64'h3ff396810f1fc54b;
    end
  51: begin 
      a3=64'hbffb3ccd967be0bb;
      b3=64'h3fe325918c321b27;
      c3=64'hbffb9cee973b8be3;
      d3=64'h3ff388b02fb3b9af;
    end
  52: begin 
      a3=64'hbffb0ed23f2a22b5;
      b3=64'h3fe2d3db6a46e150;
      c3=64'hbffb93703a8efc55;
      d3=64'h3ff37ae419b2b3c5;
    end
  53: begin 
      a3=64'hbffae2071529f75d;
      b3=64'h3fe282af3aca0ed6;
      c3=64'hbffb8a1a9680bd3b;
      d3=64'h3ff36d1cb8aeff56;
    end
  54: begin 
      a3=64'hbffab66803b9f970;
      b3=64'h3fe232096e078cf1;
      c3=64'hbffb80ed66fb93ec;
      d3=64'h3ff35f59f85d657f;
    end
  55: begin 
      a3=64'hbffa8bf0902b5c27;
      b3=64'h3fe1e1e67d028aa2;
      c3=64'hbffb77e869af1e52;
      d3=64'h3ff3519bc4944884;
    end
  56: begin 
      a3=64'hbffa629d1b9739f7;
      b3=64'h3fe19242eef795c3;
      c3=64'hbffb6f0b5e0afc64;
      d3=64'h3ff343e2094ac291;
    end
  57: begin 
      a3=64'hbffa3a6d532caec1;
      b3=64'h3fe1431b5b14396b;
      c3=64'hbffb66560539139f;
      d3=64'h3ff3362cb297c75b;
    end
  58: begin 
      a3=64'hbffa1359f91def73;
      b3=64'h3fe0f46c577c9294;
      c3=64'hbffb5dc822169535;
      d3=64'h3ff3287bacb14898;
    end
  59: begin 
      a3=64'hbff9ed6043ed274c;
      b3=64'h3fe0a6328c692e9a;
      c3=64'hbffb55617930945e;
      d3=64'h3ff31acee3eb5d0f;
    end
  60: begin 
      a3=64'hbff9c87e12edb506;
      b3=64'h3fe0586aab6fc577;
      c3=64'hbffb4d21d0be2856;
      d3=64'h3ff30d2644b76a50;
    end
  61: begin 
      a3=64'hbff9a4b1b1bf355c;
      b3=64'h3fe00b1171091383;
      c3=64'hbffb4508f09badcc;
      d3=64'h3ff2ff81bba350f2;
    end
  62: begin 
      a3=64'hbff981f494f3526e;
      b3=64'h3fdf7c473951e367;
      c3=64'hbffb3d16a245a371;
      d3=64'h3ff2f1e135589b15;
    end
  63: begin 
      a3=64'hbff960458462ff25;
      b3=64'h3fdee33bf9559040;
      c3=64'hbffb354ab0d4dcfb;
      d3=64'h3ff2e4449e9bad51;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a4=64'hbff93fa40d632709;
      b4=64'h3fde4afad2130a05;
      c4=64'hbffb2da4e8f9c0ed;
      d4=64'h3ff2d6abe44af9d0;
    end
  1: begin 
      a4=64'hbff92009cabe7b0a;
      b4=64'h3fddb37d7436a8e4;
      c4=64'hbffb262518f7d47c;
      d4=64'h3ff2c916f35e359a;
    end
  2: begin 
      a4=64'hbff901785a896fc7;
      b4=64'h3fdd1cbdb509c603;
      c4=64'hbffb1ecb10a28606;
      d4=64'h3ff2bb85b8e58fc9;
    end
  3: begin 
      a4=64'hbff8e3e917da557a;
      b4=64'h3fdc86b56105926b;
      c4=64'hbffb1796a158212d;
      d4=64'h3ff2adf82208ead9;
    end
  4: begin 
      a4=64'hbff8c75bacb0dccb;
      b4=64'h3fdbf15e671cccf9;
      c4=64'hbffb10879dffcb68;
      d4=64'h3ff2a06e1c0717c7;
    end
  5: begin 
      a4=64'hbff8abce3b443061;
      b4=64'h3fdb5cb2ba46bf4e;
      c4=64'hbffb099ddb045846;
      d4=64'h3ff292e7943512ea;
    end
  6: begin 
      a4=64'hbff8913e59a50c91;
      b4=64'h3fdac8ac5e4359c1;
      c4=64'hbffb02d92e523506;
      d4=64'h3ff2856477fd42a7;
    end
  7: begin 
      a4=64'hbff877a96aed79e1;
      b4=64'h3fda35455dd2340f;
      c4=64'hbffafc396f536575;
      d4=64'h3ff277e4b4deb7ad;
    end
  8: begin 
      a4=64'hbff85f0f4f4347f8;
      b4=64'h3fd9a277d9aab352;
      c4=64'hbffaf5be76ed38ee;
      d4=64'h3ff26a68386c6eb9;
    end
  9: begin 
      a4=64'hbff8476d69c07f61;
      b4=64'h3fd9103df4faa238;
      c4=64'hbffaef681f7cb1ee;
      d4=64'h3ff25ceef04c93db;
    end
  10: begin 
      a4=64'hbff830c0849b0d58;
      b4=64'h3fd87e91d98be97f;
      c4=64'hbffae93644d3ded8;
      d4=64'h3ff24f78ca37c731;
    end
  11: begin 
      a4=64'hbff81b0883282cbe;
      b4=64'h3fd7ed6dc70fa866;
      c4=64'hbffae328c4384cd3;
      d4=64'h3ff24205b3f862d6;
    end
  12: begin 
      a4=64'hbff80645a1ecd30d;
      b4=64'h3fd75ccc0404e0e9;
      c4=64'hbffadd3f7c5f95d7;
      d4=64'h3ff234959b69c21a;
    end
  13: begin 
      a4=64'hbff7f272fd1d60b7;
      b4=64'h3fd6cca6d35a2a6e;
      c4=64'hbffad77a4d6d1051;
      d4=64'h3ff227286e7789e9;
    end
  14: begin 
      a4=64'hbff7df90b4940615;
      b4=64'h3fd63cf88d2ed725;
      c4=64'hbffad1d918f09099;
      d4=64'h3ff219be1b1cf242;
    end
  15: begin 
      a4=64'hbff7cda11f238370;
      b4=64'h3fd5adbb959f42a1;
      c4=64'hbffacc5bc1e428b5;
      d4=64'h3ff20c568f6410bd;
    end
  16: begin 
      a4=64'hbff7bc9d8e53e74e;
      b4=64'h3fd51eea4129bd9b;
      c4=64'hbffac7022ca94f0b;
      d4=64'h3ff1fef1b96523e8;
    end
  17: begin 
      a4=64'hbff7ac8687ecc992;
      b4=64'h3fd4907efc04500b;
      c4=64'hbffac1cc3f08b14c;
      d4=64'h3ff1f18f8745dfad;
    end
  18: begin 
      a4=64'hbff79d5f5b3396e4;
      b4=64'h3fd402743f8ca72c;
      c4=64'hbffabcb9e0303e3f;
      d4=64'h3ff1e42fe738ba4a;
    end
  19: begin 
      a4=64'hbff78f222f196e92;
      b4=64'h3fd374c4734e5b5e;
      c4=64'hbffab7caf8b0ef0b;
      d4=64'h3ff1d6d2c77c3a44;
    end
  20: begin 
      a4=64'hbff781cfef53500a;
      b4=64'h3fd2e76a12037a68;
      c4=64'hbffab2ff727e6eac;
      d4=64'h3ff1c978165a44c2;
    end
  21: begin 
      a4=64'hbff775692b3714e3;
      b4=64'h3fd25a5f9dc0f74f;
      c4=64'hbffaae5738ee483b;
      d4=64'h3ff1bc1fc2276cb6;
    end
  22: begin 
      a4=64'hbff769eb78d5796f;
      b4=64'h3fd1cd9f8fbb061a;
      c4=64'hbffaa9d238b5bc30;
      d4=64'h3ff1aec9b942424f;
    end
  23: begin 
      a4=64'hbff75f5981d22213;
      b4=64'h3fd1412472efa43a;
      c4=64'hbffaa5705fea526a;
      d4=64'h3ff1a175ea12a302;
    end
  24: begin 
      a4=64'hbff755af0803377f;
      b4=64'h3fd0b4e8c3c8326f;
      c4=64'hbffaa1319dffed1a;
      d4=64'h3ff19424430909e3;
    end
  25: begin 
      a4=64'hbff74cef7db7c1f3;
      b4=64'h3fd028e7105ef88e;
      c4=64'hbffa9d15e3c96f07;
      d4=64'h3ff186d4b29de050;
    end
  26: begin 
      a4=64'hbff7451859264d5e;
      b4=64'h3fcf3a33b932d4aa;
      c4=64'hbffa991d23778767;
      d4=64'h3ff179872750ceb9;
    end
  27: begin 
      a4=64'hbff73e2b023d2f62;
      b4=64'h3fce22f768bb8b2a;
      c4=64'hbffa95475098fd8b;
      d4=64'h3ff16c3b8fa80db9;
    end
  28: begin 
      a4=64'hbff738263da5efab;
      b4=64'h3fcd0c0e3775ee80;
      c4=64'hbffa9194601a0c42;
      d4=64'h3ff15ef1da2fb726;
    end
  29: begin 
      a4=64'hbff7330b669136e8;
      b4=64'h3fcbf56d3fd6a482;
      c4=64'hbffa8e044845603d;
      d4=64'h3ff151a9f579171a;
    end
  30: begin 
      a4=64'hbff72edb888e34de;
      b4=64'h3fcadf0991e36ed6;
      c4=64'hbffa8a9700c34655;
      d4=64'h3ff14463d019fd0a;
    end
  31: begin 
      a4=64'hbff72b94f26bf187;
      b4=64'h3fc9c8d82e99523c;
      c4=64'hbffa874c829a7aca;
      d4=64'h3ff1371f58ac0c92;
    end
  32: begin 
      a4=64'hbff72936c203af2a;
      b4=64'h3fc8b2ce1333243f;
      c4=64'hbffa8424c8308584;
      d4=64'h3ff129dc7dcc0e33;
    end
  33: begin 
      a4=64'hbff727c5db210d55;
      b4=64'h3fc79ce058b89345;
      c4=64'hbffa811fcd4b765a;
      d4=64'h3ff11c9b2e193fb6;
    end
  34: begin 
      a4=64'hbff727409950c0f4;
      b4=64'h3fc68703ec5249d4;
      c4=64'hbffa7e3d8f10abed;
      d4=64'h3ff10f5b5834a410;
    end
  35: begin 
      a4=64'hbff727a82e5b00a1;
      b4=64'h3fc5712dc0265471;
      c4=64'hbffa7b7e0c074cfb;
      d4=64'h3ff1021ceac05317;
    end
  36: begin 
      a4=64'hbff728fd72d84860;
      b4=64'h3fc45b52bae26d50;
      c4=64'hbffa78e14418e09a;
      d4=64'h3ff0f4dfd45ec87a;
    end
  37: begin 
      a4=64'hbff72b40bcc8e78e;
      b4=64'h3fc34567bae8dd9d;
      c4=64'hbffa76673892b477;
      d4=64'h3ff0e7a403b23244;
    end
  38: begin 
      a4=64'hbff72e74662f09ac;
      b4=64'h3fc22f61924bf2b7;
      c4=64'hbffa740fec2716cf;
      d4=64'h3ff0da69675bbeb1;
    end
  39: begin 
      a4=64'hbff73298b84d5127;
      b4=64'h3fc1193503c24aaf;
      c4=64'hbffa71db62ef24e8;
      d4=64'h3ff0cd2fedfae939;
    end
  40: begin 
      a4=64'hbff737ae822df84c;
      b4=64'h3fc002d6c0c5bcad;
      c4=64'hbffa6fc9a26c0228;
      d4=64'h3ff0bff7862cc6bb;
    end
  41: begin 
      a4=64'hbff73db896dd1592;
      b4=64'h3fbdd876ecd01799;
      c4=64'hbffa6ddab189acd8;
      d4=64'h3ff0b2c01e8b50fa;
    end
  42: begin 
      a4=64'hbff744b83e6ece3e;
      b4=64'h3fbbaaaf77865b89;
      c4=64'hbffa6c0e98a02fcf;
      d4=64'h3ff0a589a5acb0d2;
    end
  43: begin 
      a4=64'hbff74cacf64af5a4;
      b4=64'h3fb97c4005e11c14;
      c4=64'hbffa6a656175acf3;
      d4=64'h3ff098540a22879e;
    end
  44: begin 
      a4=64'hbff7559b42ae9a43;
      b4=64'h3fb74d119c58b3ef;
      c4=64'hbffa68df174216b6;
      d4=64'h3ff08b1f3a79374c;
    end
  45: begin 
      a4=64'hbff75f83f5d361a8;
      b4=64'h3fb51d0cdc3fba9d;
      c4=64'hbffa677bc6b01d1d;
      d4=64'h3ff07deb25372957;
    end
  46: begin 
      a4=64'hbff76a692078d4eb;
      b4=64'h3fb2ec1a4f9499b4;
      c4=64'hbffa663b7de0d299;
      d4=64'h3ff070b7b8dc1445;
    end
  47: begin 
      a4=64'hbff7764c60b368a8;
      b4=64'h3fb0ba224b95f7ed;
      c4=64'hbffa651e4c6e90e6;
      d4=64'h3ff06384e3e04001;
    end
  48: begin 
      a4=64'hbff783308cbe9e93;
      b4=64'h3fad0e19e77bab81;
      c4=64'hbffa6424436f6fe1;
      d4=64'h3ff0565294b3c864;
    end
  49: begin 
      a4=64'hbff7911801cc0d6d;
      b4=64'h3fa8a58476e1c0be;
      c4=64'hbffa634d757969cb;
      d4=64'h3ff04920b9bdde73;
    end
  50: begin 
      a4=64'hbff7a005b920d27d;
      b4=64'h3fa43a53be824bae;
      c4=64'hbffa6299f6a522c7;
      d4=64'h3ff03bef415c07b6;
    end
  51: begin 
      a4=64'hbff7affa61ecf7b8;
      b4=64'h3f9f98ad0314d138;
      c4=64'hbffa6209dc915cdf;
      d4=64'h3ff02ebe19e15bf9;
    end
  52: begin 
      a4=64'hbff7c0fad66ddafa;
      b4=64'h3f96b6b6e2891023;
      c4=64'hbffa619d3e67df19;
      d4=64'h3ff0218d3195c10d;
    end
  53: begin 
      a4=64'hbff7d3090129fe85;
      b4=64'h3f8b9cc1633666dd;
      c4=64'hbffa615434e015a9;
      d4=64'h3ff0145c76b524af;
    end
  54: begin 
      a4=64'hbff7e626accdb446;
      b4=64'h3f737d14a6b1e2d3;
      c4=64'hbffa612eda445191;
      d4=64'h3ff0072bd76eb442;
    end
  55: begin 
      a4=64'hbff7fa5ac7854e6a;
      b4=64'hbf705c0583e55082;
      c4=64'hbffa612d4a764ac0;
      d4=64'h3feff3f683c824f9;
    end
  56: begin 
      a4=64'hbff80fa3d31688ad;
      b4=64'hbf8a29b68fd4f46e;
      c4=64'hbffa614fa2f23ee1;
      d4=64'h3fefd99548511557;
    end
  57: begin 
      a4=64'hbff8260a1c0dc927;
      b4=64'hbf961ab06e8835e0;
      c4=64'hbffa619602d64272;
      d4=64'h3fefbf33d88083a9;
    end
  58: begin 
      a4=64'hbff83d8ccd01ff12;
      b4=64'hbf9f28eba7e8a7c1;
      c4=64'hbffa62008ae4b58c;
      d4=64'h3fefa4d2103eca1b;
    end
  59: begin 
      a4=64'hbff8563287ad6ef4;
      b4=64'hbfa41ffbedef458c;
      c4=64'hbffa628f5d8bb8fa;
      d4=64'h3fef8a6fcb52ab01;
    end
  60: begin 
      a4=64'hbff86ffcd3d89ec5;
      b4=64'hbfa8b02123357bfb;
      c4=64'hbffa63429ee92f4d;
      d4=64'h3fef700ce55fa306;
    end
  61: begin 
      a4=64'hbff88af3059d483d;
      b4=64'hbfad451c451a4ea6;
      c4=64'hbffa641a74d20828;
      d4=64'h3fef55a939e43633;
    end
  62: begin 
      a4=64'hbff8a716b4b10982;
      b4=64'hbfb0ef92bf7e3478;
      c4=64'hbffa651706d66691;
      d4=64'h3fef3b44a4383671;
    end
  63: begin 
      a4=64'hbff8c46e62f3f6c0;
      b4=64'hbfb33f3aaa918cf4;
      c4=64'hbffa66387e4998bb;
      d4=64'h3fef20deff8b047c;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a5=64'hbff8e2fd4c8ef935;
      b5=64'hbfb591a2bc6366ee;
      c5=64'hbffa677f0647587b;
      d5=64'h3fef067826e1ca15;
    end
  1: begin 
      a5=64'hbff902c7ec30dda7;
      b5=64'hbfb7e6e82486edb8;
      c5=64'hbffa68eacbbb9949;
      d5=64'h3feeec0ff515adab;
    end
  2: begin 
      a5=64'hbff923d3e4c265c9;
      b5=64'hbfba3f2883f6ba1f;
      c5=64'hbffa6a7bfd68ed25;
      d5=64'h3feed1a644d1ff15;
    end
  3: begin 
      a5=64'hbff946267ffc98b2;
      b5=64'hbfbc9a8200c7fee5;
      c5=64'hbffa6c32cbeff9b0;
      d5=64'h3feeb73af0925d27;
    end
  4: begin 
      a5=64'hbff969c4ee1d239a;
      b5=64'hbfbef9132cc37e8c;
      c5=64'hbffa6e0f69d78b46;
      d5=64'h3fee9ccdd2a0d3a5;
    end
  5: begin 
      a5=64'hbff98eb492586778;
      b5=64'hbfc0ad7d9665f228;
      c5=64'hbffa70120b93b687;
      d5=64'h3fee825ec513f197;
    end
  6: begin 
      a5=64'hbff9b4fc3b008622;
      b5=64'hbfc1e02ccace91d9;
      c5=64'hbffa723ae78ed7a5;
      d5=64'h3fee67eda1ccd778;
    end
  7: begin 
      a5=64'hbff9dca0099491c8;
      b5=64'hbfc314a754cf5f81;
      c5=64'hbffa748a36319069;
      d5=64'h3fee4d7a42753d07;
    end
  8: begin 
      a5=64'hbffa05a8b6ed2e83;
      b5=64'hbfc44afd84763cc7;
      c5=64'hbffa770031ec2c08;
      d5=64'h3fee3304807d6e56;
    end
  9: begin 
      a5=64'hbffa301a0b59b3ed;
      b5=64'hbfc5834014acf19d;
      c5=64'hbffa799d173ee8dc;
      d5=64'h3fee188c351a3fe3;
    end
  10: begin 
      a5=64'hbffa5bfcafc5adf1;
      b5=64'hbfc6bd7ff0e6b96a;
      c5=64'hbffa7c6124c4dbb2;
      d5=64'h3fedfe113942f956;
    end
  11: begin 
      a5=64'hbffa8957859fc1cc;
      b5=64'hbfc7f9ce63c89ee9;
      c5=64'hbffa7f4c9b3ca577;
      d5=64'h3fede39365af366e;
    end
  12: begin 
      a5=64'hbffab8302ca145f2;
      b5=64'hbfc9383d0eac4675;
      c5=64'hbffa825fbd9344bf;
      d5=64'h3fedc91292d4bdda;
    end
  13: begin 
      a5=64'hbffae88f4a865b13;
      b5=64'hbfca78dde122b85a;
      c5=64'hbffa859ad0eea803;
      d5=64'h3fedae8e98e54dc5;
    end
  14: begin 
      a5=64'hbffb1a7d94f83a0a;
      b5=64'hbfcbbbc3228b9b89;
      c5=64'hbffa88fe1cb8d8e4;
      d5=64'h3fed94074fcc5d64;
    end
  15: begin 
      a5=64'hbffb4e0124ba2440;
      b5=64'hbfcd00ff85014f77;
      c5=64'hbffa8c89eaaafdb4;
      d5=64'h3fed797c8f2cd330;
    end
  16: begin 
      a5=64'hbffb83240dd56678;
      b5=64'hbfce48a609ef9c8e;
      c5=64'hbffa903e86d9dce5;
      d5=64'h3fed5eee2e5eafca;
    end
  17: begin 
      a5=64'hbffbb9ee0d808d31;
      b5=64'hbfcf92ca26c14c04;
      c5=64'hbffa941c3fc15cbe;
      d5=64'h3fed445c046cac7c;
    end
  18: begin 
      a5=64'hbffbf2678cf2c3a1;
      b5=64'hbfd06fbfd95d904d;
      c5=64'hbffa9823665207af;
      d5=64'h3fed29c5e811cd61;
    end
  19: begin 
      a5=64'hbffc2c9b1c6eacba;
      b5=64'hbfd1176d74eae2b9;
      c5=64'hbffa9c544dfdd336;
      d5=64'h3fed0f2bafb6e683;
    end
  20: begin 
      a5=64'hbffc6891e7780112;
      b5=64'hbfd1c0783ffe6d2d;
      c5=64'hbffaa0af4cc5ea8d;
      d5=64'h3fecf48d31701385;
    end
  21: begin 
      a5=64'hbffca65585deb73c;
      b5=64'hbfd26aeacd41b64e;
      c5=64'hbffaa534bb48c5e0;
      d5=64'h3fecd9ea42fa215f;
    end
  22: begin 
      a5=64'hbffce5ef85e48418;
      b5=64'hbfd316cfecfec69e;
      c5=64'hbffaa9e4f4d0f990;
      d5=64'h3fecbf42b9b7e9c4;
    end
  23: begin 
      a5=64'hbffd276cf4d7d1b8;
      b5=64'hbfd3c432a5cd8ead;
      c5=64'hbffaaec05764ae4a;
      d5=64'h3feca4966aaf9f82;
    end
  24: begin 
      a5=64'hbffd6ad78403f091;
      b5=64'hbfd4731e47ba1115;
      c5=64'hbffab3c743d4b563;
      d5=64'h3fec89e52a880b1f;
    end
  25: begin 
      a5=64'hbffdb039cd39c54c;
      b5=64'hbfd5239e634275b4;
      c5=64'hbffab8fa1dcd85c2;
      d5=64'h3fec6f2ecd85b7d4;
    end
  26: begin 
      a5=64'hbffdf7a1ccac24a2;
      b5=64'hbfd5d5bec8b124dd;
      c5=64'hbffabe594be81a97;
      d5=64'h3fec547327880fa8;
    end
  27: begin 
      a5=64'hbffe4119d2e950d1;
      b5=64'hbfd6898b98586b89;
      c5=64'hbffac3e537bb33b5;
      d5=64'h3fec39b20c06663d;
    end
  28: begin 
      a5=64'hbffe8cb1078d7eb5;
      b5=64'hbfd73f1132676e09;
      c5=64'hbffac99e4dee1560;
      d5=64'h3fec1eeb4e0cf1c7;
    end
  29: begin 
      a5=64'hbffeda7161f735f6;
      b5=64'hbfd7f65c50d5e93f;
      c5=64'hbffacf84fe4aa095;
      d5=64'h3fec041ec039b16a;
    end
  30: begin 
      a5=64'hbfff2a6cad07795a;
      b5=64'hbfd8af79eb762c02;
      c5=64'hbffad599bbd21649;
      d5=64'h3febe94c34b94096;
    end
  31: begin 
      a5=64'hbfff7caec773e793;
      b5=64'hbfd96a775f428dba;
      c5=64'hbffadbdcfccfc012;
      d5=64'h3febce737d439630;
    end
  32: begin 
      a5=64'hbfffd146135cbce0;
      b5=64'hbfda276257647e4f;
      c5=64'hbffae24f3aef5a28;
      d5=64'h3febb3946b18af23;
    end
  33: begin 
      a5=64'hc0001420ea84799f;
      b5=64'hbfdae648d6fd8581;
      c5=64'hbffae8f0f3526279;
      d5=64'h3feb98aecefd23a5;
    end
  34: begin 
      a5=64'hc00040da250250f9;
      b5=64'hbfdba7393756c232;
      c5=64'hbffaefc2a6a703bb;
      d5=64'h3feb7dc27936a63b;
    end
  35: begin 
      a5=64'hc0006ed61208bf0f;
      b5=64'hbfdc6a423d4369d2;
      c5=64'hbffaf6c4d93eb6e6;
      d5=64'h3feb62cf39886b87;
    end
  36: begin 
      a5=64'hc0009e1dc9fef90c;
      b5=64'hbfdd2f7308c3f661;
      c5=64'hbffafdf81327765d;
      d5=64'h3feb47d4df2f7a71;
    end
  37: begin 
      a5=64'hc000ceb8ebd910af;
      b5=64'hbfddf6db27970275;
      c5=64'hbffb055ce04495b4;
      d5=64'h3feb2cd338dee35a;
    end
  38: begin 
      a5=64'hc00100b25aaa8d0f;
      b5=64'hbfdec08a8638d7c8;
      c5=64'hbffb0cf3d0694743;
      d5=64'h3feb11ca14bbddb8;
    end
  39: begin 
      a5=64'hc0013412c28e6551;
      b5=64'hbfdf8c918bd175d9;
      c5=64'hbffb14bd7773316e;
      d5=64'h3feaf6b94059cad5;
    end
  40: begin 
      a5=64'hc00168e43abd5177;
      b5=64'hbfe02d808675df6f;
      c5=64'hbffb1cba6d67396c;
      d5=64'h3feadba088b61d2b;
    end
  41: begin 
      a5=64'hc0019f31b3088585;
      b5=64'hbfe095f529324425;
      c5=64'hbffb24eb4e8ea629;
      d5=64'h3feac07fba34229a;
    end
  42: begin 
      a5=64'hc001d7042a5bdcc4;
      b5=64'hbfe0ffaf9749850e;
      c5=64'hbffb2d50bb94e552;
      d5=64'h3feaa556a098b13b;
    end
  43: begin 
      a5=64'hc00210687647eca2;
      b5=64'hbfe16ab8f0efc7ab;
      c5=64'hbffb35eb59a85bbe;
      d5=64'h3fea8a250705b4d4;
    end
  44: begin 
      a5=64'hc0024b69803f12ab;
      b5=64'hbfe1d71a9efde57b;
      c5=64'hbffb3ebbd29a1bb0;
      d5=64'h3fea6eeab7f59c69;
    end
  45: begin 
      a5=64'hc0028813fac848b8;
      b5=64'hbfe244de4cb4b178;
      c5=64'hbffb47c2d5005fbf;
      d5=64'h3fea53a77d36a63b;
    end
  46: begin 
      a5=64'hc002c672b2ab2737;
      b5=64'hbfe2b40df324b38a;
      c5=64'hbffb5101145989b1;
      d5=64'h3fea385b1fe60923;
    end
  47: begin 
      a5=64'hc00306945679f80f;
      b5=64'hbfe324b3ce0cee55;
      c5=64'hbffb5a774931b520;
      d5=64'h3fea1d05686af9eb;
    end
  48: begin 
      a5=64'hc00348860b66c996;
      b5=64'hbfe396da6bc7b6c4;
      c5=64'hbffb642631481de5;
      d5=64'h3fea01a61e718b00;
    end
  49: begin 
      a5=64'hc0038c556ae67434;
      b5=64'hbfe40a8cabe6080b;
      c5=64'hbffb6e0e8fb7228c;
      d5=64'h3fe9e63d08e5656a;
    end
  50: begin 
      a5=64'hc003d2114e8b6981;
      b5=64'hbfe47fd5c0ce3fbb;
      c5=64'hbffb78312d1d8fad;
      d5=64'h3fe9cac9edec591c;
    end
  51: begin 
      a5=64'hc00419c8e450b4d3;
      b5=64'hbfe4f6c1355b3edd;
      c5=64'hbffb828ed7c97726;
      d5=64'h3fe9af4c92e0c335;
    end
  52: begin 
      a5=64'hc004638becb6a652;
      b5=64'hbfe56f5aee5e1dfe;
      c5=64'hbffb8d2863e53cd0;
      d5=64'h3fe993c4bc4bc882;
    end
  53: begin 
      a5=64'hc004af6a632ace04;
      b5=64'hbfe5e9af3226b156;
      c5=64'hbffb97feaba54a55;
      d5=64'h3fe978322ddf624c;
    end
  54: begin 
      a5=64'hc004fd765d6886bb;
      b5=64'hbfe665caa497e05a;
      c5=64'hbffba3128f79838e;
      d5=64'h3fe95c94aa703bdc;
    end
  55: begin 
      a5=64'hc0054dc0ba9bd3d5;
      b5=64'hbfe6e3ba56451f3d;
      c5=64'hbffbae64f63e7b30;
      d5=64'h3fe940ebf3ef5e9f;
    end
  56: begin 
      a5=64'hc005a05c9418b3d6;
      b5=64'hbfe7638bbe677911;
      c5=64'hbffbb9f6cd72bbfb;
      d5=64'h3fe92537cb63aad8;
    end
  57: begin 
      a5=64'hc005f55d4616f133;
      b5=64'hbfe7e54cc558e523;
      c5=64'hbffbc5c9096ce0c3;
      d5=64'h3fe90977f0e31add;
    end
  58: begin 
      a5=64'hc0064cd6bc242ffe;
      b5=64'hbfe8690bc727b495;
      c5=64'hbffbd1dca594ed27;
      d5=64'h3fe8edac238bceab;
    end
  59: begin 
      a5=64'hc006a6def0f5e7bf;
      b5=64'hbfe8eed79775c9a4;
      c5=64'hbffbde32a49f16e9;
      d5=64'h3fe8d1d4217cdd41;
    end
  60: begin 
      a5=64'hc007038a1af41491;
      b5=64'hbfe976bf8d1e88e1;
      c5=64'hbffbeacc10c99a99;
      d5=64'h3fe8b5efa7cee98c;
    end
  61: begin 
      a5=64'hc00762f0d1ba2572;
      b5=64'hbfea00d37b269af4;
      c5=64'hbffbf7a9fc1da1cd;
      d5=64'h3fe899fe728c7859;
    end
  62: begin 
      a5=64'hc007c529b0d83952;
      b5=64'hbfea8d23c3ea6202;
      c5=64'hbffc04cd80b1e6ea;
      d5=64'h3fe87e003caa044d;
    end
  63: begin 
      a5=64'hc0082a4de26f0405;
      b5=64'hbfeb1bc156c8c1e0;
      c5=64'hbffc1237c0f0c929;
      d5=64'h3fe861f4bffdcd5d;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a6=64'hc0089277c8c64675;
      b6=64'hbfebacbdb6749730;
      c6=64'hbffc1fe9e7e20301;
      d6=64'h3fe845dbb53760c5;
    end
  1: begin 
      a6=64'hc008fdc1f4555478;
      b6=64'hbfec402b04bbd666;
      c6=64'hbffc2de529764af0;
      d6=64'h3fe829b4d3d6d618;
    end
  2: begin 
      a6=64'hc0096c497436fe97;
      b6=64'hbfecd61c03a190c5;
      c6=64'hbffc3c2ac2d76509;
      d6=64'h3fe80d7fd223be83;
    end
  3: begin 
      a6=64'hc009de2b8c147ec3;
      b6=64'hbfed6ea42093eb2c;
      c6=64'hbffc4abbfabb35c3;
      d6=64'h3fe7f13c6523c266;
    end
  4: begin 
      a6=64'hc00a538793860340;
      b6=64'hbfee09d779d12f1b;
      c6=64'hbffc599a21bafa9e;
      d6=64'h3fe7d4ea4090ea38;
    end
  5: begin 
      a6=64'hc00acc7ce223ba52;
      b6=64'hbfeea7caeafa2204;
      c6=64'hbffc68c692ad7c66;
      d6=64'h3fe7b88916cf8dff;
    end
  6: begin 
      a6=64'hc00b492e74cb8e3f;
      b6=64'hbfef48940bdaf83f;
      c6=64'hbffc7842b3073c37;
      d6=64'h3fe79c1898e3e85f;
    end
  7: begin 
      a6=64'hc00bc9bea121eb6e;
      b6=64'hbfefec4945fb7365;
      c6=64'hbffc880ff33c7a62;
      d6=64'h3fe77f9876674801;
    end
  8: begin 
      a6=64'hc00c4e540483574e;
      b6=64'hbff04980e7e1570a;
      c6=64'hbffc982fcf2aa064;
      d6=64'h3fe763085d7cdbd6;
    end
  9: begin 
      a6=64'hc00cd71440aa3fb0;
      b6=64'hbff09e6ae320d7b7;
      c6=64'hbffca8a3ce837259;
      d6=64'h3fe74667fac6146c;
    end
  10: begin 
      a6=64'hc00d6428cdf5cc8d;
      b6=64'hbff0f4ef14d18041;
      c6=64'hbffcb96d85406dfc;
      d6=64'h3fe729b6f956967e;
    end
  11: begin 
      a6=64'hc00df5bb1ffe0506;
      b6=64'hbff14d1a79c93a13;
      c6=64'hbffcca8e94190962;
      d6=64'h3fe70cf502a7b881;
    end
  12: begin 
      a6=64'hc00e8bf91d1330ec;
      b6=64'hbff1a6fa8bb988ab;
      c6=64'hbffcdc08a9006a50;
      d6=64'h3fe6f021be8b8651;
    end
  13: begin 
      a6=64'hc00f27116aa2ba33;
      b6=64'hbff2029d4c107b1d;
      c6=64'hbffceddd7fa80c15;
      d6=64'h3fe6d33cd31f44d1;
    end
  14: begin 
      a6=64'hc00fc734d6bd382c;
      b6=64'hbff2601149514beb;
      c6=64'hbffd000ee208f15d;
      d6=64'h3fe6b645e4bd6f6d;
    end
  15: begin 
      a6=64'hc010364ba778b321;
      b6=64'hbff2bf65a471269d;
      c6=64'hbffd129ea8f42191;
      d6=64'h3fe6993c95ef28df;
    end
  16: begin 
      a6=64'hc0108bb77caf22b8;
      b6=64'hbff320aa19b5d3df;
      c6=64'hbffd258ebca97a81;
      d6=64'h3fe67c20875d1863;
    end
  17: begin 
      a6=64'hc010e3fa3fc6ba1f;
      b6=64'hbff383ef0823487f;
      c6=64'hbffd38e11576c430;
      d6=64'h3fe65ef157bfac25;
    end
  18: begin 
      a6=64'hc0113f31eb8f4951;
      b6=64'hbff3e9457950e368;
      c6=64'hbffd4c97bc5dd764;
      d6=64'h3fe641aea3ceb8b3;
    end
  19: begin 
      a6=64'hc0119d7e3ec02e52;
      b6=64'hbff450bf296a37b7;
      c6=64'hbffd60b4cbc47081;
      d6=64'h3fe6245806306df8;
    end
  20: begin 
      a6=64'hc011feffff3ec37b;
      b6=64'hbff4ba6e92e16f22;
      c6=64'hbffd753a702b8267;
      d6=64'h3fe606ed17679860;
    end
  21: begin 
      a6=64'hc01263d9fa21aa8a;
      b6=64'hbff52666f5b99852;
      c6=64'hbffd8a2ae8f14b88;
      d6=64'h3fe5e96d6dc12555;
    end
  22: begin 
      a6=64'hc012cc30ec99032a;
      b6=64'hbff594bc62cf4766;
      c6=64'hbffd9f88891cc451;
      d6=64'h3fe5cbd89d40e128;
    end
  23: begin 
      a6=64'hc013382b6677cb09;
      b6=64'hbff60583c6dedaf7;
      c6=64'hbffdb555b8340b18;
      d6=64'h3fe5ae2e378d641e;
    end
  24: begin 
      a6=64'hc013a7f20ab41959;
      b6=64'hbff678d2f65a1f1e;
      c6=64'hbffdcb94f31e0834;
      d6=64'h3fe5906dcbdb2362;
    end
  25: begin 
      a6=64'hc0141bb01e570b03;
      b6=64'hbff6eec0b88dad58;
      c6=64'hbffde248cd106fde;
      d6=64'h3fe57296e6d69a5c;
    end
  26: begin 
      a6=64'hc01493920fd57a0e;
      b6=64'hbff76764d90d653b;
      c6=64'hbffdf973f089b799;
      d6=64'h3fe554a9128d7fdf;
    end
  27: begin 
      a6=64'hc0150fc8745060f7;
      b6=64'hbff7e2d82e71b850;
      c6=64'hbffe1119205aa3e9;
      d6=64'h3fe536a3d656f9fe;
    end
  28: begin 
      a6=64'hc01590855594bcc3;
      b6=64'hbff86134b16b8f52;
      c6=64'hbffe293b38bbb726;
      d6=64'h3fe51886b6bac239;
    end
  29: begin 
      a6=64'hc01615fdb4b704c3;
      b6=64'hbff8e29587c87c51;
      c6=64'hbffe41dd3074c3c1;
      d6=64'h3fe4fa5135572b29;
    end
  30: begin 
      a6=64'hc016a06a914126db;
      b6=64'hbff9671715227f1b;
      c6=64'hbffe5b021a1386b4;
      d6=64'h3fe4dc02d0c5f797;
    end
  31: begin 
      a6=64'hc0173006bbc83955;
      b6=64'hbff9eed7123e9174;
      c6=64'hbffe74ad2533bcd3;
      d6=64'h3fe4bd9b047ff1e2;
    end
  32: begin 
      a6=64'hc017c5118e4b6f3a;
      b6=64'hbffa79f49a1b6a0e;
      c6=64'hbffe8ee19fdb9457;
      d6=64'h3fe49f1948bf3163;
    end
  33: begin 
      a6=64'hc0185fcddd757d4e;
      b6=64'hbffb089042a630b4;
      c6=64'hbffea9a2f7ea9ba6;
      d6=64'h3fe4807d125ffa69;
    end
  34: begin 
      a6=64'hc01900822df6de45;
      b6=64'hbffb9acc3288d27e;
      c6=64'hbffec4f4bc9f0f90;
      d6=64'h3fe461c5d2c023ff;
    end
  35: begin 
      a6=64'hc019a7798b869922;
      b6=64'hbffc30cc37f552ef;
      c6=64'hbffee0daa0322a5a;
      d6=64'h3fe442f2f79ced0a;
    end
  36: begin 
      a6=64'hc01a55036bd18eb6;
      b6=64'hbffccab5e2cb9d52;
      c6=64'hbffefd58798cef89;
      d6=64'h3fe42403eaef2917;
    end
  37: begin 
      a6=64'hc01b09742ab3cfcf;
      b6=64'hbffd68b0a004e721;
      c6=64'hbfff1a724617678a;
      d6=64'h3fe404f812c5ab40;
    end
  38: begin 
      a6=64'hc01bc52599288967;
      b6=64'hbffe0ae5d617e9b7;
      c6=64'hbfff382c2ba471cb;
      d6=64'h3fe3e5ced11dd3cb;
    end
  39: begin 
      a6=64'hc01c8876ea936ea5;
      b6=64'hbffeb18106373d59;
      c6=64'hbfff568a7a7b4b1b;
      d6=64'h3fe3c68783ba230a;
    end
  40: begin 
      a6=64'hc01d53cd7377ed93;
      b6=64'hbfff5cafec398c4b;
      c6=64'hbfff7591af82e5fa;
      d6=64'h3fe3a72183f6b24e;
    end
  41: begin 
      a6=64'hc01e2794d47956d4;
      b6=64'hc0000651527e5b1b;
      c6=64'hbfff9546768eda3f;
      d6=64'h3fe3879c269b70a6;
    end
  42: begin 
      a6=64'hc01f04406446d63a;
      b6=64'hc00060c5e9116e19;
      c6=64'hbfffb5adacd3c048;
      d6=64'h3fe367f6bbabff8b;
    end
  43: begin 
      a6=64'hc01fea4a2c68bc88;
      b6=64'hc000bdd064561c4f;
      c6=64'hbfffd6cc63823b29;
      d6=64'h3fe348308e3507b0;
    end
  44: begin 
      a6=64'hc0206d1a7f6394ae;
      b6=64'hc0011d8cdd2476fd;
      c6=64'hbffff8a7e28fae09;
      d6=64'h3fe32848e416dc92;
    end
  45: begin 
      a6=64'hc020ea462521fb11;
      b6=64'hc0018018f45b1852;
      c6=64'hc0000da2d5d640c6;
      d6=64'h3fe3083efdcd40b4;
    end
  46: begin 
      a6=64'hc0216cf265c13acf;
      b6=64'hc001e593ed283566;
      c6=64'hc0001f55beb72367;
      d6=64'h3fe2e812163419d6;
    end
  47: begin 
      a6=64'hc021f56eff3205a0;
      b6=64'hc0024e1ec88ff5d3;
      c6=64'hc000316fab586455;
      d6=64'h3fe2c7c16248e044;
    end
  48: begin 
      a6=64'hc02284111167a602;
      b6=64'hc002b9dc65fda7ed;
      c6=64'hc00043f3bd18ce22;
      d6=64'h3fe2a74c10e88ff4;
    end
  49: begin 
      a6=64'hc0231933e49fd29e;
      b6=64'hc00328f1a3194a17;
      c6=64'hc00056e53936bdb0;
      d6=64'h3fe286b14a89ddaa;
    end
  50: begin 
      a6=64'hc023b5392d454bc1;
      b6=64'hc0039b8581405aed;
      c6=64'hc0006a478ae0ee16;
      d6=64'h3fe265f030f36d2f;
    end
  51: begin 
      a6=64'hc0245889e7b7c29a;
      b6=64'hc00411c14bd54981;
      c6=64'hc0007e1e456d8943;
      d6=64'h3fe24507deedc018;
    end
  52: begin 
      a6=64'hc02503969c616d61;
      b6=64'hc0048bd0c3a42073;
      c6=64'hc000926d26ba07ca;
      d6=64'h3fe223f767f08e3f;
    end
  53: begin 
      a6=64'hc025b6d87b334f52;
      b6=64'hc00509e24c9e7bbd;
      c6=64'hc000a73819b7883f;
      d6=64'h3fe202bdd7cb32b8;
    end
  54: begin 
      a6=64'hc02672d1bf94fd2b;
      b6=64'hc0058c2720f9732c;
      c6=64'hc000bc833927b540;
      d6=64'h3fe1e15a3247d011;
    end
  55: begin 
      a6=64'hc027380e9620b38d;
      b6=64'hc00612d387e11ea0;
      c6=64'hc000d252d28e643c;
      d6=64'h3fe1bfcb72c8c6d7;
    end
  56: begin 
      a6=64'hc02807261ca6a207;
      b6=64'hc0069e1f11a6f14f;
      c6=64'hc000e8ab695ca46a;
      d6=64'h3fe19e108be01058;
    end
  57: begin 
      a6=64'hc028e0bb89cdfbe4;
      b6=64'hc0072e44d87c7328;
      c6=64'hc000ff91ba5ad6a1;
      d6=64'h3fe17c2866e00544;
    end
  58: begin 
      a6=64'hc029c57ef68c36cf;
      b6=64'hc007c383c95c6338;
      c6=64'hc001170abf56bd7f;
      d6=64'h3fe15a11e3650ce7;
    end
  59: begin 
      a6=64'hc02ab62ef5a7b247;
      b6=64'hc0085e1ef13a3b9e;
      c6=64'hc0012f1bb31d59c6;
      d6=64'h3fe137cbd6d7a5dd;
    end
  60: begin 
      a6=64'hc02bb399b8295d29;
      b6=64'hc008fe5dd398b9b0;
      c6=64'hc00147ca15c654ff;
      d6=64'h3fe115550be62ab1;
    end
  61: begin 
      a6=64'hc02cbe9eddcefa00;
      b6=64'hc009a48cc880ff3f;
      c6=64'hc001611bb159d5e1;
      d6=64'h3fe0f2ac41f5a6ad;
    end
  62: begin 
      a6=64'hc02dd830d49cfb1a;
      b6=64'hc00a50fd64a9dd81;
      c6=64'hc0017b169ed9327a;
      d6=64'h3fe0cfd02c88fd92;
    end
  63: begin 
      a6=64'hc02f01573214d346;
      b6=64'hc00b0406eab860e6;
      c6=64'hc00195c14bb4aa15;
      d6=64'h3fe0acbf729d96d7;
    end
  endcase

  case(vin[5:0])
  0: begin 
      a7=64'hc0301d983c739813;
      b7=64'hc00bbe06c9b9a291;
      c7=64'hc001b1227fb8ca9f;
      d7=64'h3fe08978adfca7b6;
    end
  1: begin 
      a7=64'hc030c37a89ceeb36;
      b7=64'hc00c7f6126b691e6;
      c7=64'hc001cd4163804688;
      d7=64'h3fe065fa6a80202b;
    end
  2: begin 
      a7=64'hc03172fcbf51c70e;
      b7=64'hc00d48817743b7b7;
      c7=64'hc001ea2587779d53;
      d7=64'h3fe04243254a2501;
    end
  3: begin 
      a7=64'hc0322cd8d3885cfb;
      b7=64'hc00e19db2a9cc5ea;
      c7=64'hc00207d6eb827dd5;
      d7=64'h3fe01e514bede37b;
    end
  4: begin 
      a7=64'hc032f1da3956b524;
      b7=64'hc00ef3ea65a0d94d;
      c7=64'hc002265e07543754;
      d7=64'h3fdff4467710d4ca;
    end
  5: begin 
      a7=64'hc033c2dfaa8b8501;
      b7=64'hc00fd734d4e17dfb;
      c7=64'hc00245c3d38e9e04;
      d7=64'h3fdfab6e7f901e9b;
    end
  6: begin 
      a7=64'hc034a0dda69d276d;
      b7=64'hc010622549c67243;
      c7=64'hc0026611d3be45f7;
      d7=64'h3fdf621723c17946;
    end
  7: begin 
      a7=64'hc0358ce0ce437dd1;
      b7=64'hc010dde397ff2074;
      c7=64'hc0028752214c3c66;
      d7=64'h3fdf183caed6acf2;
    end
  8: begin 
      a7=64'hc0368810b61e1928;
      b7=64'hc0115f2966731d4d;
      c7=64'hc002a98f7782a2ca;
      d7=64'h3fdecddb425c5c14;
    end
  9: begin 
      a7=64'hc03793b33df032bd;
      b7=64'hc011e651b2a55ffe;
      c7=64'hc002ccd540c3bd98;
      d7=64'h3fde82eed3987e88;
    end
  10: begin 
      a7=64'hc038b1306f08fbc0;
      b7=64'hc01273bf1b3d8602;
      c7=64'hc002f12fa5192845;
      d7=64'h3fde377328b15e2d;
    end
  11: begin 
      a7=64'hc039e21670128541;
      b7=64'hc01307dcacf4a6c0;
      c7=64'hc00316ab9a43d3f6;
      d7=64'h3fddeb63d5976383;
    end
  12: begin 
      a7=64'hc03b281ed5c281e4;
      b7=64'hc013a31ec6fc6fa5;
      c7=64'hc0033d56f57ea083;
      d7=64'h3fdd9ebc38ab4f63;
    end
  13: begin 
      a7=64'hc03c8533cc532f34;
      b7=64'hc01446041f22e73f;
      c7=64'hc00365407f28b35f;
      d7=64'h3fdd51777719add3;
    end
  14: begin 
      a7=64'hc03dfb773b6fd96d;
      b7=64'hc014f116e50f0565;
      c7=64'hc0038e780898d957;
      d7=64'h3fdd039078e365b2;
    end
  15: begin 
      a7=64'hc03f8d49b54683d2;
      b7=64'hc015a4ee0fae4817;
      c7=64'hc003b90e8460bae0;
      d7=64'h3fdcb501e48a3509;
    end
  16: begin 
      a7=64'hc0409ea9cbe5800c;
      b7=64'hc016622ed52fceb4;
      c7=64'hc003e51621563142;
      d7=64'h3fdc65c61a56b31e;
    end
  17: begin 
      a7=64'hc04187479086569a;
      b7=64'hc017298e58c8a62e;
      c7=64'hc00412a268c3178b;
      d7=64'h3fdc15d72f2c0455;
    end
  18: begin 
      a7=64'hc042822a339a3ca0;
      b7=64'hc017fbd394e080a5;
      c7=64'hc00441c8602dcc82;
      d7=64'h3fdbc52ee6dbc712;
    end
  19: begin 
      a7=64'hc0439133926b7925;
      b7=64'hc018d9d98d517402;
      c7=64'hc004729eaf3e1e8d;
      d7=64'h3fdb73c6adead645;
    end
  20: begin 
      a7=64'hc044b683a1dbd7fa;
      b7=64'hc019c491d3e6c39a;
      c7=64'hc004a53dca5a7eed;
      d7=64'h3fdb219792b540b0;
    end
  21: begin 
      a7=64'hc045f4820f437947;
      b7=64'hc01abd076ffd4743;
      c7=64'hc004d9c022b2104f;
      d7=64'h3fdace9a3ddd352b;
    end
  22: begin 
      a7=64'hc0474de9b1c1e553;
      b7=64'hc01bc4623951e708;
      c7=64'hc00510425c8a4f99;
      d7=64'h3fda7ac6e9ed8e36;
    end
  23: begin 
      a7=64'hc048c5d62d8d98b9;
      b7=64'hc01cdbeabbc32acd;
      c7=64'hc00548e38ccd1d5a;
      d7=64'h3fda26155a15046c;
    end
  24: begin 
      a7=64'hc04a5fd42b9a17d7;
      b7=64'hc01e050ebe299c58;
      c7=64'hc00583c57f02f79d;
      d7=64'h3fd9d07ccfdabfd5;
    end
  25: begin 
      a7=64'hc04c1ff4d7b44a50;
      b7=64'hc01f41668b11041a;
      c7=64'hc005c10d051f6fb8;
      d7=64'h3fd979f3ffa7e140;
    end
  26: begin 
      a7=64'hc04e0ae54d40b059;
      b7=64'hc020495d915e1c2b;
      c7=64'hc00600e252cb0577;
      d7=64'h3fd9227103fb7f3a;
    end
  27: begin 
      a7=64'hc05013057830b2ba;
      b7=64'hc020fd86c29e2094;
      c7=64'hc0064371662c8eda;
      d7=64'h3fd8c9e94f173caf;
    end
  28: begin 
      a7=64'hc0513bd2fca0a187;
      b7=64'hc021be4fa7b74e59;
      c7=64'hc00688ea809e89ae;
      d7=64'h3fd870519ae9cbe8;
    end
  29: begin 
      a7=64'hc052837dbcdf40b7;
      b7=64'hc0228cfe7a64a3b9;
      c7=64'hc006d182b2406bc6;
      d7=64'h3fd8159dd6f1fffe;
    end
  30: begin 
      a7=64'hc053ee44abf50b5d;
      b7=64'hc0236b04f7c7e271;
      c7=64'hc0071d747bf9ac9c;
      d7=64'h3fd7b9c113c8111a;
    end
  31: begin 
      a7=64'hc05581231450b9d4;
      b7=64'hc0245a07aeabfef0;
      c7=64'hc0076d008c5276a3;
      d7=64'h3fd75cad6bead4af;
    end
  32: begin 
      a7=64'hc05741f87b33ea95;
      b7=64'hc0255be6cb7603d6;
      c7=64'hc007c06e9c8c9a93;
      d7=64'h3fd6fe53e95b22f0;
    end
  33: begin 
      a7=64'hc05937ba707b64f1;
      b7=64'hc02672c8c00c493b;
      c7=64'hc008180e74b3a3f7;
      d7=64'h3fd69ea467777ce7;
    end
  34: begin 
      a7=64'hc05b6ab3754a6675;
      b7=64'hc027a1273e770850;
      c7=64'hc00874391f05f7fe;
      d7=64'h3fd63d8d706bf923;
    end
  35: begin 
      a7=64'hc05de4d2cae40ee2;
      b7=64'hc028e9df21c0f3f5;
      c7=64'hc008d552553fba18;
      d7=64'h3fd5dafc1564da95;
    end
  36: begin 
      a7=64'hc06059095839bfc7;
      b7=64'hc02a50440ef29ca8;
      c7=64'hc0093bca351c4b29;
      d7=64'h3fd576dbc082bb19;
    end
  37: begin 
      a7=64'hc061f07e306cca3f;
      b7=64'hc02bd838d860ced7;
      c7=64'hc009a81f4d10c27f;
      d7=64'h3fd51115ff52e169;
    end
  38: begin 
      a7=64'hc063c1a9fc144fcc;
      b7=64'hc02d864e05ecbfda;
      c7=64'hc00a1ae1171d3ac8;
      d7=64'h3fd4a99244411383;
    end
  39: begin 
      a7=64'hc065d77d59478420;
      b7=64'hc02f5fe85be7ddd9;
      c7=64'hc00a94b2fe16074b;
      d7=64'h3fd440359d146699;
    end
  40: begin 
      a7=64'hc0683f8dcd95bf5c;
      b7=64'hc030b5b8f31da98b;
      c7=64'hc00b1650128cb1bd;
      d7=64'h3fd3d4e25c066c9b;
    end
  41: begin 
      a7=64'hc06b0adfe950e839;
      b7=64'hc031d84c7d7d86d0;
      c7=64'hc00ba08fa082d361;
      d7=64'h3fd36777b058d164;
    end
  42: begin 
      a7=64'hc06e4efa688f4bb5;
      b7=64'hc0331c51001780fb;
      c7=64'hc00c346ae7a7ebd4;
      d7=64'h3fd2f7d12a699285;
    end
  43: begin 
      a7=64'hc07113b0d559040c;
      b7=64'hc03487695a651592;
      c7=64'hc00cd3044f206ce2;
      d7=64'h3fd285c626134e63;
    end
  44: begin 
      a7=64'hc0735bd5589c047b;
      b7=64'hc03620804ff551de;
      c7=64'hc00d7db08ed684af;
      d7=64'h3fd21129148559db;
    end
  45: begin 
      a7=64'hc07617371290c1ad;
      b7=64'hc037f0284fabb14d;
      c7=64'hc00e360277f0ec83;
      d7=64'h3fd199c69c7e653a;
    end
  46: begin 
      a7=64'hc07964c65a68467e;
      b7=64'hc03a011e19d62f15;
      c7=64'hc00efdda4bdd1105;
      d7=64'h3fd11f6484ac24b9;
    end
  47: begin 
      a7=64'hc07d6e3d39f3cfe0;
      b7=64'hc03c60fdc30144df;
      c7=64'hc00fd779f9a54b1b;
      d7=64'h3fd0a1c05773773c;
    end
  48: begin 
      a7=64'hc081366edce7d292;
      b7=64'hc03f2141d8bfbd2f;
      c7=64'hc01062d01c21058f;
      d7=64'h3fd0208da8e06414;
    end
  49: begin 
      a7=64'hc08458623dcd3be2;
      b7=64'hc0412c58fc2e8674;
      c7=64'hc010e5d6b62e8a93;
      d7=64'h3fcf36e7bbb77901;
    end
  50: begin 
      a7=64'hc088564314d7fe58;
      b7=64'hc04312be74341752;
      c7=64'hc01176eb69ff8593;
      d7=64'h3fce24168a6f30c1;
    end
  51: begin 
      a7=64'hc08d84177771e672;
      b7=64'hc0455830d8901217;
      c7=64'hc01218b77ebe4fd0;
      d7=64'h3fcd07b2793be629;
    end
  52: begin 
      a7=64'hc092305c983bf663;
      b7=64'hc04818c8e6771eda;
      c7=64'hc012cea76f9a2658;
      d7=64'h3fcbe095ef290a11;
    end
  53: begin 
      a7=64'hc096d91e1a86976e;
      b7=64'hc04b7c3cfe2c2270;
      c7=64'hc0139d393e0746b7;
      d7=64'h3fcaad5c87d63027;
    end
  54: begin 
      a7=64'hc09d5d4018968e9d;
      b7=64'hc04fbc4f6591a80b;
      c7=64'hc0148a74f57b5711;
      d7=64'h3fc96c4e855b2e12;
    end
  55: begin 
      a7=64'hc0a3678b6ae526fb;
      b7=64'hc05297f0efe62eda;
      c7=64'hc0159ead314c93e8;
      d7=64'h3fc81b42b567bcdf;
    end
  56: begin 
      a7=64'hc0aa8f35c810d4e6;
      b7=64'hc0562f7f29283a62;
      c7=64'hc016e5c0c948f848;
      d7=64'h3fc6b770bb8f6f7d;
    end
  57: begin 
      a7=64'hc0b303db1b22d80d;
      b7=64'hc05b149d14084c20;
      c7=64'hc01871528f9f418f;
      d7=64'h3fc53d288f845720;
    end
  58: begin 
      a7=64'hc0bcebea4b8c8a5d;
      b7=64'hc061051e64e42540;
      c7=64'hc01a5cfa96e8a139;
      d7=64'h3fc3a7590e6725bc;
    end
  59: begin 
      a7=64'hc0c7f20cf4557a07;
      b7=64'hc0663ef5513355f3;
      c7=64'hc01cd6f0592c35ce;
      d7=64'h3fc1eeb60010ab4d;
    end
  60: begin 
      a7=64'hc0d68cecf1f07355;
      b7=64'hc06eacf7d71a2444;
      c7=64'hc0201a23302a687b;
      d7=64'h3fc0080b14bb6457;
    end
  61: begin 
      a7=64'hc0ea715deba21cde;
      b7=64'hc076bd18fc3b8626;
      c7=64'hc02294da05ed266c;
      d7=64'h3fbbc0f7305521cb;
    end
  62: begin 
      a7=64'hc108b11af741dbc8;
      b7=64'hc08175c5f82fadde;
      c7=64'hc026d7069c5030c1;
      d7=64'h3fb6a6a76ef201dc;
    end
  63: begin 
      a7=64'hc16602fdb6541196;
      b7=64'h40d567d40f02d1a6;
      c7=64'hc03d7f04f2c90e55;
      d7=64'h3fb05449680a4a54;
    end
  endcase
  case(vin[8:6])
    0: begin
        a=a0; b=b0; c=c0; d=d0;
      end
    1: begin
        a=a1; b=b1; c=c1; d=d1;
      end
    2: begin
        a=a2; b=b2; c=c2; d=d2;
      end
    3: begin
        a=a3; b=b3; c=c3; d=d3;
      end
    4: begin
        a=a4; b=b4; c=c4; d=d4;
      end
    5: begin
        a=a5; b=b5; c=c5; d=d5;
      end
    6: begin
        a=a6; b=b6; c=c6; d=d6;
      end
    7: begin
        a=a7; b=b7; c=c7; d=d7;
      end
  endcase

end
endmodule
//
// This is a simple version of a 64 bit floating point multiplier 
// used in EE287 as a homework problem.
// This is a reduced complexity floating point.  There is no NaN
// overflow, underflow, or infinity values processed.
//
// Inspired by IEEE 754-2008 (Available from the SJSU library to students)
//
// 63  62:52 51:0
// S   Exp   Fract (assumed high order 1)
// 
// Note: all zero exp and fract is a zero 
// 
//

module fpmul(clk,rst,pushin,a,b,c,pushout,r);
input clk,rst;
input pushin; 	        // A valid a,b,c
input [63:0] a,b,c;	// the a,b and c inputs
output pushout;		// indicates we have an answer this cycle
output [63:0] r;	// the results from this multiply

wire sA,sB,sC;		// the signs of the a and b inputs
reg sA_p1,sB_p1,sC_p1;		// the signs of the a and b inputs
reg sA_p2,sB_p2,sC_p2;		// the signs of the a and b inputs
reg sA_p3,sB_p3,sC_p3;		// the signs of the a and b inputs
reg sA_p4,sB_p4,sC_p4;		// the signs of the a and b inputs
reg sA_p5,sB_p5,sC_p5;		// the signs of the a and b inputs
reg sA_p6,sB_p6,sC_p6;		// the signs of the a and b inputs
reg sA_p7,sB_p7,sC_p7;		// the signs of the a and b inputs
reg sA_p8,sB_p8,sC_p8;		// the signs of the a and b inputs
reg sA_p9,sB_p9,sC_p9;		// the signs of the a and b inputs
/*reg*/ wire [10:0] expA, expB, expC;		// the exponents of each
/*reg*/ wire [52:0] fractA, fractB, fractC;	// the fraction of A and B  present
/*reg*/ wire zeroA,zeroB,zeroC;	// a zero operand (special case for later)
reg  [10:0] expA_p1, expB_p1, expC_p1;		// the exponents of each
reg  zeroA_p1,zeroB_p1,zeroC_p1;	// a zero operand (special case for later)
reg  [10:0] expA_p2, expB_p2, expC_p2;		// the exponents of each
reg  zeroA_p2,zeroB_p2,zeroC_p2;	// a zero operand (special case for later)
reg  [10:0] expA_p3, expB_p3, expC_p3;		// the exponents of each
reg  zeroA_p3,zeroB_p3,zeroC_p3;	// a zero operand (special case for later)
reg  [10:0] expA_p4, expB_p4, expC_p4;		// the exponents of each
reg  zeroA_p4,zeroB_p4,zeroC_p4;	// a zero operand (special case for later)
reg  [10:0] expA_p5, expB_p5, expC_p5;		// the exponents of each
reg  zeroA_p5,zeroB_p5,zeroC_p5;	// a zero operand (special case for later)
reg  [10:0] expA_p6, expB_p6, expC_p6;		// the exponents of each
reg  zeroA_p6,zeroB_p6,zeroC_p6;	// a zero operand (special case for later)
reg  [10:0] expA_p7, expB_p7, expC_p7;		// the exponents of each
reg  zeroA_p7,zeroB_p7,zeroC_p7;	// a zero operand (special case for later)
reg  [10:0] expA_p8, expB_p8, expC_p8;		// the exponents of each
reg  zeroA_p8,zeroB_p8,zeroC_p8;	// a zero operand (special case for later)
reg  [10:0] expA_p9, expB_p9, expC_p9;		// the exponents of each
reg  zeroA_p9,zeroB_p9,zeroC_p9;	// a zero operand (special case for later)
// result of the multiplication, rounded result, rounding constant
reg [159:0] rres,rconstant;	
wire [105:0] mres_p4;
reg [105:0] mres_p5;
wire [158:0] mres_p9;
reg [52:0] fractC_p1;
reg [52:0] fractC_p2;
reg [52:0] fractC_p3;
reg [52:0] fractC_p4;
reg [52:0] fractC_p5;
reg signres;		// sign of the result
reg [10:0] expres;	// the exponent result
reg [63:0] resout;	// the output value from the always block
reg pushout_p1,pushout_p2,pushout_p3,pushout_p4,pushout_p5,pushout_p6,pushout_p7,pushout_p8,pushout_p9;

assign r=resout;
assign pushout=pushout_p9;


// latch the inputs...

//
// give the fields a name for convience
//
assign  sA = a[63];
assign  sB = b[63];
assign  sC = c[63];
assign  expA = a[62:52];
assign  expB = b[62:52];
assign  expC = c[62:52];
assign  fractA = { 1'b1, a[51:0]};
assign  fractB = { 1'b1, b[51:0]};
assign  fractC = { 1'b1, c[51:0]};
assign  zeroA = (a[62:0]==0)?1:0;
assign  zeroB = (b[62:0]==0)?1:0;
assign  zeroC = (c[62:0]==0)?1:0;

DW02_mult_5_stage # (53,53)  inst_mult_ip_1 (fractA,fractB,1'b0,clk,mres_p4);


always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    mres_p5 <= #1 'b0;
  end else begin
    mres_p5 <= #1 mres_p4;
  end
end

DW02_mult_5_stage # (106,53) inst_mult_ip_2  (mres_p5[105:0],fractC_p5,1'b0,clk,mres_p9);

always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    pushout_p1 <= #1 'b0;
    pushout_p2 <= #1 'b0;
    pushout_p3 <= #1 'b0;
    pushout_p4 <= #1 'b0;
    pushout_p5 <= #1 'b0;
    pushout_p6 <= #1 'b0;
    pushout_p7 <= #1 'b0;
    pushout_p8 <= #1 'b0;
    pushout_p9 <= #1 'b0;
    sA_p1 <= #1 'b0;
    sA_p2 <= #1 'b0;
    sA_p3 <= #1 'b0;
    sA_p4 <= #1 'b0;
    sA_p5 <= #1 'b0;
    sA_p6 <= #1 'b0;
    sA_p7 <= #1 'b0;
    sA_p8 <= #1 'b0;
    sA_p9 <= #1 'b0;
    sB_p1 <= #1 'b0;
    sB_p2 <= #1 'b0;
    sB_p3 <= #1 'b0;
    sB_p4 <= #1 'b0;
    sB_p5 <= #1 'b0;
    sB_p6 <= #1 'b0;
    sB_p7 <= #1 'b0;
    sB_p8 <= #1 'b0;
    sB_p9 <= #1 'b0;
    sC_p1 <= #1 'b0;
    sC_p2 <= #1 'b0;
    sC_p3 <= #1 'b0;
    sC_p4 <= #1 'b0;
    sC_p5 <= #1 'b0;
    sC_p6 <= #1 'b0;
    sC_p7 <= #1 'b0;
    sC_p8 <= #1 'b0;
    sC_p9 <= #1 'b0;
    expA_p1 <= #1 'b0;
    expA_p2 <= #1 'b0;
    expA_p3 <= #1 'b0;
    expA_p4 <= #1 'b0;
    expA_p5 <= #1 'b0;
    expA_p6 <= #1 'b0;
    expA_p7 <= #1 'b0;
    expA_p8 <= #1 'b0;
    expA_p9 <= #1 'b0;
    expB_p1 <= #1 'b0;
    expB_p2 <= #1 'b0;
    expB_p3 <= #1 'b0;
    expB_p4 <= #1 'b0;
    expB_p5 <= #1 'b0;
    expB_p6 <= #1 'b0;
    expB_p7 <= #1 'b0;
    expB_p8 <= #1 'b0;
    expB_p9 <= #1 'b0;
    expC_p1 <= #1 'b0;
    expC_p2 <= #1 'b0;
    expC_p3 <= #1 'b0;
    expC_p4 <= #1 'b0;
    expC_p5 <= #1 'b0;
    expC_p6 <= #1 'b0;
    expC_p7 <= #1 'b0;
    expC_p8 <= #1 'b0;
    expC_p9 <= #1 'b0;
    zeroA_p1 <= #1 'b0;
    zeroA_p2 <= #1 'b0;
    zeroA_p3 <= #1 'b0;
    zeroA_p4 <= #1 'b0;
    zeroA_p5 <= #1 'b0;
    zeroA_p6 <= #1 'b0;
    zeroA_p7 <= #1 'b0;
    zeroA_p8 <= #1 'b0;
    zeroA_p9 <= #1 'b0;
    zeroB_p1 <= #1 'b0;
    zeroB_p2 <= #1 'b0;
    zeroB_p3 <= #1 'b0;
    zeroB_p4 <= #1 'b0;
    zeroB_p5 <= #1 'b0;
    zeroB_p6 <= #1 'b0;
    zeroB_p7 <= #1 'b0;
    zeroB_p8 <= #1 'b0;
    zeroB_p9 <= #1 'b0;
    zeroC_p1 <= #1 'b0;
    zeroC_p2 <= #1 'b0;
    zeroC_p3 <= #1 'b0;
    zeroC_p4 <= #1 'b0;
    zeroC_p5 <= #1 'b0;
    zeroC_p6 <= #1 'b0;
    zeroC_p7 <= #1 'b0;
    zeroC_p8 <= #1 'b0;
    zeroC_p9 <= #1 'b0;
    fractC_p1 <= #1 'b0;
    fractC_p2 <= #1 'b0;
    fractC_p3 <= #1 'b0;
    fractC_p4 <= #1 'b0;
    fractC_p5 <= #1 'b0;
  end else begin
    pushout_p1 <= #1  pushin;
    pushout_p2 <= #1  pushout_p1;
    pushout_p3 <= #1  pushout_p2;
    pushout_p4 <= #1  pushout_p3;
    pushout_p5 <= #1  pushout_p4;
    pushout_p6 <= #1  pushout_p5;
    pushout_p7 <= #1  pushout_p6;
    pushout_p8 <= #1  pushout_p7;
    pushout_p9 <= #1  pushout_p8;
    sA_p1 <= #1 sA;
    sA_p2 <= #1 sA_p1;
    sA_p3 <= #1 sA_p2;
    sA_p4 <= #1 sA_p3;
    sA_p5 <= #1 sA_p4;
    sA_p6 <= #1 sA_p5;
    sA_p7 <= #1 sA_p6;
    sA_p8 <= #1 sA_p7;
    sA_p9 <= #1 sA_p8;
    sB_p1 <= #1 sB;
    sB_p2 <= #1 sB_p1;
    sB_p3 <= #1 sB_p2;
    sB_p4 <= #1 sB_p3;
    sB_p5 <= #1 sB_p4;
    sB_p6 <= #1 sB_p5;
    sB_p7 <= #1 sB_p6;
    sB_p8 <= #1 sB_p7;
    sB_p9 <= #1 sB_p8;
    sC_p1 <= #1 sC;
    sC_p2 <= #1 sC_p1;
    sC_p3 <= #1 sC_p2;
    sC_p4 <= #1 sC_p3;
    sC_p5 <= #1 sC_p4;
    sC_p6 <= #1 sC_p5;
    sC_p7 <= #1 sC_p6;
    sC_p8 <= #1 sC_p7;
    sC_p9 <= #1 sC_p8;
    expA_p1 <= #1 expA;
    expA_p2 <= #1 expA_p1;
    expA_p3 <= #1 expA_p2;
    expA_p4 <= #1 expA_p3;
    expA_p5 <= #1 expA_p4;
    expA_p6 <= #1 expA_p5;
    expA_p7 <= #1 expA_p6;
    expA_p8 <= #1 expA_p7;
    expA_p9 <= #1 expA_p8;
    expB_p1 <= #1 expB;
    expB_p2 <= #1 expB_p1;
    expB_p3 <= #1 expB_p2;
    expB_p4 <= #1 expB_p3;
    expB_p5 <= #1 expB_p4;
    expB_p6 <= #1 expB_p5;
    expB_p7 <= #1 expB_p6;
    expB_p8 <= #1 expB_p7;
    expB_p9 <= #1 expB_p8;
    expC_p1 <= #1 expC;
    expC_p2 <= #1 expC_p1;
    expC_p3 <= #1 expC_p2;
    expC_p4 <= #1 expC_p3;
    expC_p5 <= #1 expC_p4;
    expC_p6 <= #1 expC_p5;
    expC_p7 <= #1 expC_p6;
    expC_p8 <= #1 expC_p7;
    expC_p9 <= #1 expC_p8;
    zeroA_p1 <= #1 zeroA;
    zeroA_p2 <= #1 zeroA_p1;
    zeroA_p3 <= #1 zeroA_p2;
    zeroA_p4 <= #1 zeroA_p3;
    zeroA_p5 <= #1 zeroA_p4;
    zeroA_p6 <= #1 zeroA_p5;
    zeroA_p7 <= #1 zeroA_p6;
    zeroA_p8 <= #1 zeroA_p7;
    zeroA_p9 <= #1 zeroA_p8;
    zeroB_p1 <= #1 zeroB;
    zeroB_p2 <= #1 zeroB_p1;
    zeroB_p3 <= #1 zeroB_p2;
    zeroB_p4 <= #1 zeroB_p3;
    zeroB_p5 <= #1 zeroB_p4;
    zeroB_p6 <= #1 zeroB_p5;
    zeroB_p7 <= #1 zeroB_p6;
    zeroB_p8 <= #1 zeroB_p7;
    zeroB_p9 <= #1 zeroB_p8;
    zeroC_p1 <= #1 zeroC;
    zeroC_p2 <= #1 zeroC_p1;
    zeroC_p3 <= #1 zeroC_p2;
    zeroC_p4 <= #1 zeroC_p3;
    zeroC_p5 <= #1 zeroC_p4;
    zeroC_p6 <= #1 zeroC_p5;
    zeroC_p7 <= #1 zeroC_p6;
    zeroC_p8 <= #1 zeroC_p7;
    zeroC_p9 <= #1 zeroC_p8;
    fractC_p1 <= #1 fractC;
    fractC_p2 <= #1 fractC_p1;
    fractC_p3 <= #1 fractC_p2;
    fractC_p4 <= #1 fractC_p3;
    fractC_p5 <= #1 fractC_p4;
  end
end


always @(*) begin
    signres = sA_p9^sB_p9^sC_p9;
    expres = expA_p9+expB_p9+expC_p9-11'd2045;
    rconstant=0;
    if (mres_p9[158]==1) 
      rconstant[105] =  1; 
    else if(mres_p9[157]==1'b1) 
      rconstant[104]=  1; 
    else rconstant[103]=  1;
    rres =   mres_p9 + rconstant;
    if((zeroA_p9==1) || (zeroB_p9==1) || (zeroC_p9 == 1)) begin // sets a zero result to a true 0
      rres =   0;
      expres =   0;
      signres =   0;
      resout =   64'b0;
    end else begin
      if(rres[158]==1'b1) begin
        expres=  expres+1;
        resout=  {signres,expres,rres[157:106]};
      end else if(rres[157]==1'b0) begin // less than 1/2
        expres=  expres-1;
        resout=  {signres,expres,rres[155:104]};
      end else begin 
        resout=  {signres,expres,rres[156:105]};
      end
    end
end

endmodule
//
// This is a simple version of a 64 bit floating point multiplier 
// used in EE287 as a homework problem.
// This is a reduced complexity floating point.  There is no NaN
// overflow, underflow, or infinity values processed.
//
// Inspired by IEEE 754-2008 (Available from the SJSU library to students)
//
// 63  62:52 51:0
// S   Exp   Fract (assumed high order 1)
// 
// Note: all zero exp and fract is a zero 
// 
//
module fpadd(clk,rst,pushin,a,b,pushout,r);
input clk,rst;
input pushin;
input [63:0] a,b;	// the a and b inputs
output reg [63:0] r;	// the results from this multiply
output reg pushout;		// indicates we have an answer this cycle

parameter fbw=104;

reg sA,sB,sA_p1,sB_p1,sA_p2,sB_p2,sA_p3,sB_p3;		// the signs of the a and b inputs
reg [10:0] expA, expB,expR,expA_p1,expB_p1,expR_p1,expA_p2,expB_p2,expR_p2,expA_p3,expB_p3;		// the exponents of each
reg [fbw:0] fractA, fractB,fractR,fractAdd,fractPreRound,denormB,
	f2,d2,fractA_p1,fractB_p1,fractR_p1,fractA_p2,fractB_p2,fractR_p2,fractA_p3,fractB_p3,fractB_p1_net;	
	// the fraction of A and B  present
wire [105:0] fractR_add_ip_net,fractR_sub_ip_net;
reg [105:0] fractR_add_ip_reg, fractR_sub_ip_reg;
reg zeroA,zeroB;	// a zero operand (special case for later)
	
reg [fbw:0] fractR_p5_net,fractR_p5,fractR_p4_net,fractR_p4,fractR_p6;
reg [10:0] expR_p5_net,expR_p4,expR_p4_net,expR_p5,expR_p6;
reg signres_p5_net,signres_p4_net,signres_p4,signres_p5,signres_p6;

reg signres;		// sign of the result
reg [10:0] expres;	// the exponent result
wire [63:0] resout;	// the output value from the always block
integer iea,ieb,ied,ied_p1,ied_p2,ied_p3,ied_p4,ied_p5;	// exponent stuff for difference...
integer renorm,renorm_p5_net,renorm_p5;		// How much to renormalize...
parameter [fbw:0] zero=0;
reg stopinside;
reg pushout_p1,pushout_p2,pushout_p3,pushout_p4,pushout_p5,pushout_p6;

//register the outputs
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    r <= #1 'b0;
    pushout_p1 <= #1 'b0;
    pushout_p2 <= #1 'b0;
    pushout_p3 <= #1 'b0;
    pushout_p4 <= #1 'b0;
    pushout_p5 <= #1 'b0;
    pushout_p6 <= #1 'b0;
    pushout <= #1 'b0;
  end else begin
    r <= #1  resout;
    pushout_p1 <= #1 pushin;
    pushout_p2 <= #1 pushout_p1;
    pushout_p3 <= #1 pushout_p2;
    pushout_p4 <= #1 pushout_p3;
    pushout_p5 <= #1 pushout_p4;
    pushout_p6 <= #1 pushout_p5;
    pushout <= #1 pushout_p6;
  end
end


//
// give the fields a name for convience
//

//0th stage
always @(*) begin
  zeroA = (a[62:0]==0)?1:0;
  zeroB = (b[62:0]==0)?1:0;
  if( b[62:0] > a[62:0] ) begin
    expA = b[62:52];
    expB = a[62:52];
    sA = b[63];
    sB = a[63];
    fractA = (zeroB)?0:{ 2'b1, b[51:0],zero[fbw:54]};
    fractB = (zeroA)?0:{ 2'b1, a[51:0],zero[fbw:54]};
  end else begin
    sA = a[63];
    sB = b[63];
    expA = a[62:52];
    expB = b[62:52];
    fractA = (zeroA)?0:{ 2'b1, a[51:0],zero[fbw:54]};
    fractB = (zeroB)?0:{ 2'b1, b[51:0],zero[fbw:54]};
  end
end

//1st stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    expA_p1 <= #1 'b0;
    expB_p1 <= #1 'b0;
    fractB_p1_net <= #1 'b0;
  end else begin
    expA_p1 <= #1 expA;
    expB_p1 <= #1 expB;
    fractB_p1_net <= #1 fractB;
  end
end

always @(*) begin
  iea=expA_p1;
  ieb=expB_p1;
  ied=expA_p1-expB_p1;
  fractB_p1 = fractB_p1_net;
  if(ied < 61) begin
    fractB_p1=(ied[5])?{32'b0,fractB_p1[fbw:32]}: {fractB_p1};
    fractB_p1=(ied[4])?{16'b0,fractB_p1[fbw:16]}: {fractB_p1};
    fractB_p1=(ied[3])?{ 8'b0,fractB_p1[fbw:8 ]}: {fractB_p1};
    fractB_p1=(ied[2])?{ 4'b0,fractB_p1[fbw:4 ]}: {fractB_p1};
    fractB_p1=(ied[1])?{ 2'b0,fractB_p1[fbw:2 ]}: {fractB_p1};
    fractB_p1=(ied[0])?{ 1'b0,fractB_p1[fbw:1 ]}: {fractB_p1};
  end
end

//2nd stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    sA_p1 <= #1 'b0;
    sB_p1 <= #1 'b0;
    fractA_p1 <= #1 'b0;
    fractR_p1 <= #1 'b0;
    expR_p1 <= #1 'b0;
    sA_p2 <= #1 'b0;
    sB_p2 <= #1 'b0;
    expA_p2 <= #1 'b0;
    expB_p2 <= #1 'b0;
    fractA_p2 <= #1 'b0;
    fractB_p2 <= #1 'b0;
    fractR_p2 <= #1 'b0;
    expR_p2 <= #1 'b0;
  end else begin
    sA_p1       <= #1  sA;
    sB_p1       <= #1  sB;
    fractA_p1   <= #1  fractA;
    fractR_p1   <= #1  fractR;
    expR_p1     <= #1  expR;
    sA_p2       <= #1  sA_p1;
    sB_p2       <= #1  sB_p1;
    expA_p2     <= #1  expA_p1;
    expB_p2     <= #1  expB_p1;
    fractA_p2   <= #1  fractA_p1;
    fractB_p2   <= #1  fractB_p1;
    fractR_p2   <= #1  fractR_p1;
    expR_p2     <= #1  expR_p1;
  end
end

//3rd stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    sA_p3 <= #1 'b0;
    sB_p3 <= #1 'b0;
    expA_p3 <= #1 'b0;
    expB_p3 <= #1 'b0;
    fractA_p3 <= #1 'b0;
    fractR_add_ip_reg <= #1 'b0;
    fractR_sub_ip_reg <= #1 'b0;
  end else begin
    sA_p3       <= #1 sA_p2     ; 
    sB_p3       <= #1 sB_p2     ; 
    expA_p3     <= #1 expA_p2   ; 
    expB_p3     <= #1 expB_p2   ; 
    fractA_p3   <= #1 fractA_p2 ; 
    fractR_add_ip_reg <= #1 fractA_p2+fractB_p2;
    fractR_sub_ip_reg <= #1 fractA_p2-fractB_p2;
  end
end


always @(*) begin
  signres = sA_p3;
  ied_p3 = expA_p3-expB_p3;
  if(ied_p3 > 60) begin
    expR=expA_p3;
    fractR=fractA_p3;
  end else begin
    expR=expA_p3;
    if(sA_p3 == sB_p3) fractR=fractR_add_ip_reg; else fractR=fractR_sub_ip_reg;
  end
end


//4th stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    ied_p4    <= #1 'b0;
    fractR_p4_net <= #1 'b0;
    expR_p4_net   <= #1 'b0;
    signres_p4_net <= #1 'b0;
  end
  else begin
    ied_p4    <= #1 ied_p3;
    fractR_p4_net <= #1 fractR;
    expR_p4_net   <= #1 expR;
    signres_p4_net <= #1 signres;
  end
end

always @(*) begin
    renorm=0;
    fractR_p4 = fractR_p4_net;
    expR_p4 = expR_p4_net;
    signres_p4 = signres_p4_net;
  if(ied_p4 < 61) begin
    if(fractR_p4[fbw]) begin
      fractR_p4={1'b0,fractR_p4[fbw:1]};
      expR_p4=expR_p4+1;
    end
    if(fractR_p4[fbw-1:fbw-32]==0) begin 
	    renorm[5]=1; fractR_p4={ 1'b0,fractR_p4[fbw-33:0],32'b0 }; 
    end
    if(fractR_p4[fbw-1:fbw-16]==0) begin 
	    renorm[4]=1; fractR_p4={ 1'b0,fractR_p4[fbw-17:0],16'b0 }; 
    end
    if(fractR_p4[fbw-1:fbw-8]==0) begin 
	    renorm[3]=1; fractR_p4={ 1'b0,fractR_p4[fbw-9:0], 8'b0 }; 
    end
    if(fractR_p4[fbw-1:fbw-4]==0) begin 
	    renorm[2]=1; fractR_p4={ 1'b0,fractR_p4[fbw-5:0], 4'b0 }; 
    end
    if(fractR_p4[fbw-1:fbw-2]==0) begin 
	    renorm[1]=1; fractR_p4={ 1'b0,fractR_p4[fbw-3:0], 2'b0 }; 
    end
    if(fractR_p4[fbw-1   ]==0) begin 
	    renorm[0]=1; fractR_p4={ 1'b0,fractR_p4[fbw-2:0], 1'b0 }; 
    end
    fractPreRound=fractR_p4;
  end
end

//5th stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    ied_p5    <= #1 'b0;
    renorm_p5_net <= #1 'b0;
    fractR_p5_net <= #1 'b0;
    expR_p5_net   <= #1 'b0;
    signres_p5_net <= #1 'b0;
  end
  else begin
    ied_p5    <= #1 ied_p4;
    renorm_p5_net <= #1 renorm;
    fractR_p5_net <= #1 fractR_p4;
    expR_p5_net   <= #1 expR_p4;
    signres_p5_net <= #1 signres_p4;
  end
end


always @(*) begin
    renorm_p5 = renorm_p5_net;
    fractR_p5 = fractR_p5_net;
    expR_p5 = expR_p5_net;
    signres_p5 = signres_p5_net;
  if(ied_p5 < 61) begin
    if(fractR_p5 != 0) begin
      if(fractR_p5[fbw-55:0]==0 && fractR_p5[fbw-54]==1) begin
	      if(fractR_p5[fbw-53]==1) fractR_p5=fractR_p5+{1'b1,zero[fbw-54:0]};
      end else begin
        if(fractR_p5[fbw-54]==1) fractR_p5=fractR_p5+{1'b1,zero[fbw-54:0]};
      end
      expR_p5=expR_p5-renorm_p5;
      if(fractR_p5[fbw-1]==0) begin
       expR_p5=expR_p5+1;
       fractR_p5={1'b0,fractR_p5[fbw-1:1]};
      end
    end else begin
      expR_p5=0;
      signres_p5=0;
    end
  end
end

//6th stage
always @(posedge(clk) or posedge(rst)) begin
  if(rst) begin
    fractR_p6 <= #1 'b0;
    expR_p6   <= #1 'b0;
    signres_p6 <= #1 'b0;
  end
  else begin
    fractR_p6 <= #1 fractR_p5;
    expR_p6   <= #1 expR_p5;
    signres_p6 <= #1 signres_p5;
  end
end


assign resout={signres_p6,expR_p6,fractR_p6[fbw-2:fbw-53]};


endmodule

module reg_5stage (
  input clk,rst,pushin,
  input [63:0] datain,
  output reg pushout,
  output reg [63:0] dataout
  );

reg push_r1, push_r2, push_r3, push_r4;
reg [63:0] data_r1, data_r2, data_r3, data_r4;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    push_r1 <= #1 1'b0; 
    push_r2 <= #1 1'b0; 
    push_r3 <= #1 1'b0; 
    push_r4 <= #1 1'b0; 
    pushout <= #1 1'b0;
  end
  else begin
    push_r1 <= #1  pushin;
    push_r2 <= #1  push_r1;
    push_r3 <= #1  push_r2;
    push_r4 <= #1  push_r3;
    pushout <= #1  push_r4;
  end
end

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    data_r1 <= #1 64'b0; 
    data_r2 <= #1 64'b0; 
    data_r3 <= #1 64'b0; 
    data_r4 <= #1 64'b0; 
    dataout <= #1 64'b0;
  end
  else begin
    data_r1 <= #1  datain;
    data_r2 <= #1  data_r1;
    data_r3 <= #1  data_r2;
    data_r4 <= #1  data_r3;
    dataout <= #1  data_r4;
  end
end

endmodule
module reg_7stage (
  input clk,rst,pushin,
  input [63:0] datain,
  output reg pushout,
  output reg [63:0] dataout
  );

reg push_r1, push_r2, push_r3, push_r4, push_r5, push_r6;
reg [63:0] data_r1, data_r2, data_r3, data_r4, data_r5, data_r6;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    push_r1 <= #1 1'b0; 
    push_r2 <= #1 1'b0; 
    push_r3 <= #1 1'b0; 
    push_r4 <= #1 1'b0; 
    push_r5 <= #1 1'b0; 
    push_r6 <= #1 1'b0; 
    pushout <= #1 1'b0;
  end
  else begin
    push_r1 <= #1  pushin;
    push_r2 <= #1  push_r1;
    push_r3 <= #1  push_r2;
    push_r4 <= #1  push_r3;
    push_r5 <= #1  push_r4;
    push_r6 <= #1  push_r5;
    pushout <= #1  push_r6;
  end
end

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    data_r1 <= #1 64'b0; 
    data_r2 <= #1 64'b0; 
    data_r3 <= #1 64'b0; 
    data_r4 <= #1 64'b0; 
    data_r5 <= #1 64'b0; 
    data_r6 <= #1 64'b0; 
    dataout <= #1 64'b0;
  end
  else begin
    data_r1 <= #1  datain;
    data_r2 <= #1  data_r1;
    data_r3 <= #1  data_r2;
    data_r4 <= #1  data_r3;
    data_r5 <= #1  data_r4;
    data_r6 <= #1  data_r5;
    dataout <= #1  data_r6;
  end
end

endmodule
module reg_9stage (
  input clk,rst,pushin,
  input [63:0] datain,
  output reg pushout,
  output reg [63:0] dataout
  );

reg push_r1, push_r2, push_r3, push_r4, push_r5, push_r6, push_r7, push_r8;
reg [63:0] data_r1, data_r2, data_r3, data_r4, data_r5, data_r6, data_r7, data_r8;

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    push_r1 <= #1 1'b0; 
    push_r2 <= #1 1'b0; 
    push_r3 <= #1 1'b0; 
    push_r4 <= #1 1'b0; 
    push_r5 <= #1 1'b0; 
    push_r6 <= #1 1'b0; 
    push_r7 <= #1 1'b0; 
    push_r8 <= #1 1'b0; 
    pushout <= #1 1'b0;
  end
  else begin
    push_r1 <= #1  pushin;
    push_r2 <= #1  push_r1;
    push_r3 <= #1  push_r2;
    push_r4 <= #1  push_r3;
    push_r5 <= #1  push_r4;
    push_r6 <= #1  push_r5;
    push_r7 <= #1  push_r6;
    push_r8 <= #1  push_r7;
    pushout <= #1  push_r8;
  end
end

always @ (posedge clk or posedge rst)
begin
  if (rst) begin
    data_r1 <= #1 64'b0; 
    data_r2 <= #1 64'b0; 
    data_r3 <= #1 64'b0; 
    data_r4 <= #1 64'b0; 
    data_r5 <= #1 64'b0; 
    data_r6 <= #1 64'b0; 
    data_r7 <= #1 64'b0; 
    data_r8 <= #1 64'b0; 
    dataout <= #1 64'b0;
  end
  else begin
    data_r1 <= #1  datain;
    data_r2 <= #1  data_r1;
    data_r3 <= #1  data_r2;
    data_r4 <= #1  data_r3;
    data_r5 <= #1  data_r4;
    data_r6 <= #1  data_r5;
    data_r7 <= #1  data_r6;
    data_r8 <= #1  data_r7;
    dataout <= #1  data_r8;
  end
end

endmodule
//This code shall denormalize the input random numbers to get vin
//and then normalize the difference to get delta

//module definition
module vin_delta_sqrtln # (
  //parameter which sets u1 or u2
  parameter u1_u2 = "u1"
  )
  (
  input pushin,
  input [63:0] rand_in,
  output reg [9:0] vin,
  output reg [63:0] delta,
  output pushout
  );


//declaration of signals
reg s;
reg [10:0] e,diff,norm_e;
reg [51:0] f, denorm;
reg [63:0] norm_f;

//no stage
assign pushout = pushin;

//conbinational block
always @ (*)
begin
  //split the random number into IEEE components
  s = rand_in[63];
  e = rand_in[62:52];
  f = {1'b1,rand_in[51:1]};
  
  //calcuate the exponent difference without bias
  diff = 11'd1022 - e;
  
  //right shift fraction with diff for denormalized value
  if (diff > 0)
    denorm = f >> diff;
  else
    denorm = f;
  
  //assign the most significant 10 bits to vin if u2 else 9 bits if u1 
  if (u1_u2 == "u2") 
    vin = denorm[51:42]; 
  else 
    vin = {1'b0,denorm[51:43]};
  
  //delta's fraction calculation by subtracting vin from denorm. 
  if (u1_u2 == "u2")
    norm_f = {10'b0,denorm[41:0],12'b0};
  else
    norm_f = {9'b0,denorm[42:0],12'b0};

  //re normalize delta's fraction
  norm_e = 11'b0;
  if (norm_f[63:32] == 0) begin
    norm_e[5] = 1;
    norm_f = {norm_f[31:0],32'b0};
  end
  if (norm_f[63:48] == 0) begin
    norm_e[4] = 1;
    norm_f = {norm_f[47:0],16'b0};
  end
  if (norm_f[63:56] == 0) begin
    norm_e[3] = 1;
    norm_f = {norm_f[55:0],8'b0};
  end
  if (norm_f[63:60] == 0) begin
    norm_e[2] = 1;
    norm_f = {norm_f[59:0],4'b0};
  end
  if (norm_f[63:62] == 0) begin
    norm_e[1] = 1;
    norm_f = {norm_f[61:0],2'b0};
  end
  if (norm_f[63] == 0) begin
    norm_e[0] = 1;
    norm_f = {norm_f[62:0],1'b0};
  end

  //calculate delta's exp
  norm_e = 11'd1022 - norm_e;

  //combining all to form the delta
  delta = {s,norm_e,norm_f[62:11]};
end

endmodule 

//This code shall denormalize the input random numbers to get vin
//and then normalize the difference to get delta

//module definition
module vin_delta_sine # (
  //parameter which sets u1 or u2
  parameter u1_u2 = "u2"
  )
  (
  input pushin,
  input [63:0] rand_in,
  output reg [9:0] vin,
  output reg [63:0] delta,
  output pushout
  );


//declaration of signals
reg s;
reg [10:0] e,diff,norm_e;
reg [51:0] f, denorm;
reg [63:0] norm_f;

//no stage
assign pushout = pushin;

//conbinational block
always @ (*)
begin
  //split the random number into IEEE components
  s = rand_in[63];
  e = rand_in[62:52];
  f = {1'b1,rand_in[51:1]};
  
  //calcuate the exponent difference without bias
  diff = 11'd1022 - e;
  
  //right shift fraction with diff for denormalized value
  if (diff > 0)
    denorm = f >> diff;
  else
    denorm = f;
  
  //assign the most significant 10 bits to vin if u2 else 9 bits if u1 
  if (u1_u2 == "u2") 
    vin = denorm[51:42]; 
  else 
    vin = {1'b0,denorm[51:43]};
  
  //delta's fraction calculation by subtracting vin from denorm. 
  if (u1_u2 == "u2")
    norm_f = {10'b0,denorm[41:0],12'b0};
  else
    norm_f = {9'b0,denorm[42:0],12'b0};

  //re normalize delta's fraction
  norm_e = 11'b0;
  if (norm_f[63:32] == 0) begin
    norm_e[5] = 1;
    norm_f = {norm_f[31:0],32'b0};
  end
  if (norm_f[63:48] == 0) begin
    norm_e[4] = 1;
    norm_f = {norm_f[47:0],16'b0};
  end
  if (norm_f[63:56] == 0) begin
    norm_e[3] = 1;
    norm_f = {norm_f[55:0],8'b0};
  end
  if (norm_f[63:60] == 0) begin
    norm_e[2] = 1;
    norm_f = {norm_f[59:0],4'b0};
  end
  if (norm_f[63:62] == 0) begin
    norm_e[1] = 1;
    norm_f = {norm_f[61:0],2'b0};
  end
  if (norm_f[63] == 0) begin
    norm_e[0] = 1;
    norm_f = {norm_f[62:0],1'b0};
  end

  //calculate delta's exp
  norm_e = 11'd1022 - norm_e;

  //combining all to form the delta
  delta = {s,norm_e,norm_f[62:11]};
end

endmodule 
