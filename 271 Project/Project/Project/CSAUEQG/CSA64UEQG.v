
`timescale 1ns/10ps

//64 bit Unequal Group CSA

module CSA64UEQG(sum, crout, op1, op2, clock, reset);
output [63:0]sum;
output crout;
input [63:0]op1;
input [63:0]op2;
input clock, reset;
reg [63:0]sum;
reg crout;
reg [63:0]op1f;
reg [63:0]op2f;
wire [63:0]sumf;
wire C1, C2, C3, C4, C5, C6, croutf; 

assign Cin = 0;

CSA4 P1(.sum_4(sumf[3:0]), .cout_4(C1), .op1_4(op1f[3:0]), .op2_4(op2f[3:0]), .cin_4(Cin));
CSA4 P2(.sum_4(sumf[7:4]), .cout_4(C2), .op1_4(op1f[7:4]), .op2_4(op2f[7:4]), .cin_4(C1));

CSA5 P3(.s(sumf[12:8]), .co(C3), .a(op1f[12:8]), .b(op2f[12:8]), .in(C2));

CSA6 P4(.s6(sumf[18:13]), .co6(C4), .a6(op1f[18:13]), .b6(op2f[18:13]), .in6(C3));
CSA7 P5(.s7(sumf[25:19]), .co7(C5), .a7(op1f[25:19]), .b7(op2f[25:19]), .in7(C4));


CSA8 P6(.s8(sumf[33:26]), .co8(C6), .a8(op1f[33:26]), .b8(op2f[33:26]), .in8(C5));
CSA9 P7(.s9(sumf[42:34]), .co9(C7), .a9(op1f[42:34]), .b9(op2f[42:34]), .in9(C6));

CSA10 P8(.s10(sumf[52:43]), .co10(C8), .a10(op1f[52:43]), .b10(op2f[52:43]), .in10(C7));

CSA11 P9(.s11(sumf[63:53]), .co11(croutf), .a11(op1f[63:53]), .b11(op2f[63:53]), .in11(C8));

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
$display ("op1f= %h",croutf);
end
end
endmodule









