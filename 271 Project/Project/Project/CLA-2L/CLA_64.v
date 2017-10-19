`timescale 1ns/10ps

module CLA_64(sum, crout, op1, op2, clock, reset);
output [63:0]sum;
output crout;
input [63:0]op1;
input [63:0]op2;
input clock, reset;
reg [63:0]sum;
reg crout;
reg [63:0]op1_f;
reg [63:0]op2_f;
wire c1, c2, c3, croutf; 
wire [63:0]sum_f;

CLA16 A1(.sum_4(sum_f[15:0]), .crout(c1), .op1_4(op1_f[15:0]), .op2_4(op2_f[15:0]));
CLA16_2 A2(.sum_16(sum_f[31:16]), .crout_16(c2), .op1_16(op1_f[31:16]), .op2_16(op2_f[31:16]), .Cin(c1));
CLA16_2 A3(.sum_16(sum_f[47:32]), .crout_16(c3), .op1_16(op1_f[47:32]), .op2_16(op2_f[47:32]), .Cin(c2));
CLA16_2 A4(.sum_16(sum_f[63:48]), .crout_16(croutf), .op1_16(op1_f[63:48]), .op2_16(op2_f[63:48]), .Cin(c3));

always @(posedge clock or posedge reset)
begin
if(reset == 1)
begin
op1_f <= 64'b0;
op2_f <= 64'b0;
sum <= 64'b0;

crout <= 64'b0;
end

else 
begin 
op1_f <= op1;
$display ("op1_f= %h",op1_f);
op2_f <= op2;
$display ("op2_f= %h",op2_f);
sum <= sum_f;
$display ("sumf= %h",sum_f);
crout <= croutf;
$display ("croutf= %h",croutf);
end
end


endmodule
