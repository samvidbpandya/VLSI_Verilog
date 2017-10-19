`timescale 1ns/10ps

//mux for carry
module mux_carry(cout, cout0, cout1, Cin);
output cout;
input cout0, cout1, Cin;

assign cout = Cin ? cout1 : cout0;

endmodule
