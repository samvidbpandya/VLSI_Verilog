`timescale 1ns/10ps

//half adder block
module HA(sum_ha, cout_ha, op1_ha, op2_ha);
output sum_ha, cout_ha;
input op1_ha, op2_ha;
assign sum_ha = op1_ha ^ op2_ha;
assign cout_ha = op1_ha & op2_ha;

endmodule

//1 bit full adder block

module FA_1bit(sum_fa1, cout_fa1, op1_fa1, op2_fa1, cin);
output sum_fa1, cout_fa1;
input op1_fa1, op2_fa1, cin;
wire s1, c1, c2;

HA h1(.sum_ha(s1), .cout_ha(c1), .op1_ha(op1_fa1), .op2_ha(op2_fa1));
HA h2(.sum_ha(sum_fa1), .cout_ha(c2), .op1_ha(s1), .op2_ha(cin));

assign cout_fa1 = c1 | c2;

endmodule

//4 bit fulladder 1st block

module FA_4bit_1 (sum_fa4, cout_fa4, op1_fa4, op2_fa4);
output [3:0]sum_fa4;
output cout_fa4;
input [3:0]op1_fa4;
input [3:0]op2_fa4;
wire cin1, cin2, cin3;

HA h1(.sum_ha(sum_fa4[0]), .cout_ha(cin1), .op1_ha(op1_fa4[0]), .op2_ha(op2_fa4[0]));
FA_1bit f1(.sum_fa1(sum_fa4[1]), .cout_fa1(cin2), .op1_fa1(op1_fa4[1]), .op2_fa1(op2_fa4[1]), .cin(cin1));
FA_1bit f2(.sum_fa1(sum_fa4[2]), .cout_fa1(cin3), .op1_fa1(op1_fa4[2]), .op2_fa1(op2_fa4[2]), .cin(cin2));
FA_1bit f3(.sum_fa1(sum_fa4[3]), .cout_fa1(cout_fa4), .op1_fa1(op1_fa4[3]), .op2_fa1(op2_fa4[3]), .cin(cin3));

endmodule

//4 bit fulladder 2nd block

module FA_4bit_2(sum_fa4_2, cout_fa4_2, op1_fa4_2, op2_fa4_2, cin_fa4);
output [3:0]sum_fa4_2;
output cout_fa4_2;
input [3:0]op1_fa4_2;
input [3:0]op2_fa4_2;
input cin_fa4;
wire cin1, cin2, cin3;

FA_1bit f1(.sum_fa1(sum_fa4_2[0]), .cout_fa1(cin1), .op1_fa1(op1_fa4_2[0]), .op2_fa1(op2_fa4_2[0]), .cin(cin_fa4));
FA_1bit f2(.sum_fa1(sum_fa4_2[1]), .cout_fa1(cin2), .op1_fa1(op1_fa4_2[1]), .op2_fa1(op2_fa4_2[1]), .cin(cin1));
FA_1bit f3(.sum_fa1(sum_fa4_2[2]), .cout_fa1(cin3), .op1_fa1(op1_fa4_2[2]), .op2_fa1(op2_fa4_2[2]), .cin(cin2));
FA_1bit f4(.sum_fa1(sum_fa4_2[3]), .cout_fa1(cout_fa4_2), .op1_fa1(op1_fa4_2[3]), .op2_fa1(op2_fa4_2[3]), .cin(cin3));

endmodule

//64 bit fulladder

module RCA64 (sum, crout, op1, op2, clock, reset);
output [63:0]sum;
output crout;
input [63:0]op1;
input [63:0]op2;
input clock, reset;
reg [63:0]sum;
reg crout;
reg [63:0]op1f;
reg [63:0]op2f;
wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, croutf;
wire [63:0]sumf;

FA_4bit_1 F1(.sum_fa4(sumf[3:0]), .cout_fa4(c1), .op1_fa4(op1f[3:0]), .op2_fa4(op2f[3:0]));
FA_4bit_2 F2(.sum_fa4_2(sumf[7:4]), .cout_fa4_2(c2), .op1_fa4_2(op1f[7:4]), .op2_fa4_2(op2f[7:4]), .cin_fa4(c1));
FA_4bit_2 F3(.sum_fa4_2(sumf[11:8]), .cout_fa4_2(c3), .op1_fa4_2(op1f[11:8]), .op2_fa4_2(op2f[11:8]), .cin_fa4(c2));
FA_4bit_2 F4(.sum_fa4_2(sumf[15:12]), .cout_fa4_2(c4), .op1_fa4_2(op1f[15:12]), .op2_fa4_2(op2f[15:12]), .cin_fa4(c3));
FA_4bit_2 F5(.sum_fa4_2(sumf[19:16]), .cout_fa4_2(c5), .op1_fa4_2(op1f[19:16]), .op2_fa4_2(op2f[19:16]), .cin_fa4(c4));
FA_4bit_2 F6(.sum_fa4_2(sumf[23:20]), .cout_fa4_2(c6), .op1_fa4_2(op1f[23:20]), .op2_fa4_2(op2f[23:20]), .cin_fa4(c5));
FA_4bit_2 F7(.sum_fa4_2(sumf[27:24]), .cout_fa4_2(c7), .op1_fa4_2(op1f[27:24]), .op2_fa4_2(op2f[27:24]), .cin_fa4(c6));
FA_4bit_2 F8(.sum_fa4_2(sumf[31:28]), .cout_fa4_2(c8), .op1_fa4_2(op1f[31:28]), .op2_fa4_2(op2f[31:28]), .cin_fa4(c7));
FA_4bit_2 F9(.sum_fa4_2(sumf[35:32]), .cout_fa4_2(c9), .op1_fa4_2(op1f[35:32]), .op2_fa4_2(op2f[35:32]), .cin_fa4(c8));
FA_4bit_2 F10(.sum_fa4_2(sumf[39:36]), .cout_fa4_2(c10), .op1_fa4_2(op1f[39:36]), .op2_fa4_2(op2f[39:36]), .cin_fa4(c9));
FA_4bit_2 F11(.sum_fa4_2(sumf[43:40]), .cout_fa4_2(c11), .op1_fa4_2(op1f[43:40]), .op2_fa4_2(op2f[43:40]), .cin_fa4(c10));
FA_4bit_2 F12(.sum_fa4_2(sumf[47:44]), .cout_fa4_2(c12), .op1_fa4_2(op1f[47:44]), .op2_fa4_2(op2f[47:44]), .cin_fa4(c11));
FA_4bit_2 F13(.sum_fa4_2(sumf[51:48]), .cout_fa4_2(c13), .op1_fa4_2(op1f[51:48]), .op2_fa4_2(op2f[51:48]), .cin_fa4(c12));
FA_4bit_2 F14(.sum_fa4_2(sumf[55:52]), .cout_fa4_2(c14), .op1_fa4_2(op1f[55:52]), .op2_fa4_2(op2f[55:52]), .cin_fa4(c13));
FA_4bit_2 F15(.sum_fa4_2(sumf[59:56]), .cout_fa4_2(c15), .op1_fa4_2(op1f[59:56]), .op2_fa4_2(op2f[59:56]), .cin_fa4(c14));
FA_4bit_2 F16(.sum_fa4_2(sumf[63:60]), .cout_fa4_2(croutf), .op1_fa4_2(op1f[63:60]), .op2_fa4_2(op2f[63:60]), .cin_fa4(c15));

always @(posedge clock or posedge reset)
begin
if(reset == 1)
begin
op1f <= 64'b0;
op2f <= 64'b0;
sum <= 64'b0;
crout <= 64'b0;
end

else 
begin 
op1f <= op1;
$display ("op1f= %h",op1f);
op2f <= op2;
$display ("op2f= %h",op2f);
sum <= sumf;
$display ("sumf= %h",sumf);
crout <= croutf;
$display ("croutf= %h",croutf);
end
end
endmodule







