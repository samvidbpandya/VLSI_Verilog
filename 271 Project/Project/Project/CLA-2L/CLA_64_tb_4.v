`timescale 1 ns/ 10 ps
module CLA_64_tb_4();
  
  reg [63:0]op1;
  reg [63:0]op2;
  reg clock;
  reg reset;
  wire [63:0]sum;
  wire crout;
  CLA_64 A (sum,crout,op1,op2,clock,reset);
  
  initial begin
    
    op1= 64'b0;
    op2= 64'b0;
    clock= 1'b0;
    
    #5;
    op1= 64'h1234_5678_90ab_cdef;
    op2= 64'h5555_5555_5555_dddd;
   
  end
  initial begin
    reset= 1'b1;
    #6;
    reset= 1'b0;
    
  end
  
  initial begin
    forever #4 clock=~clock;
  end
  initial begin 
    #30;
    $finish;
  end
  initial begin
   $dumpfile("CLA_64_4.vcd");
   $dumpvars(0,CLA_64_tb_4);
  end
endmodule
