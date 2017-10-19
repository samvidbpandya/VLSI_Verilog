`timescale 1ns/10ps

//1 bit fulladder
module FA(sum_fa, cout_fa, op1_fa, op2_fa, cin);
output sum_fa, cout_fa;
input op1_fa, op2_fa, cin;

assign sum_fa = op1_fa ^ op2_fa ^ cin;
assign cout_fa = ((op1_fa ^ op2_fa) & cin) | (op1_fa & op2_fa);

endmodule

