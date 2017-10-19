`timescale 1ns/10ps

//mux for sum;
module mux_sum(sum, sum0, sum1, Cin);
output [3:0]sum;
input [3:0]sum0, sum1;
input Cin;

assign sum = Cin ? sum1 : sum0;

endmodule 





