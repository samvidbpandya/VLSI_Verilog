`timescale 1 ns/ 10 ps
module CLA_64_tb_1();
  
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
    op1= 64'h1010_1010_1199_ffff;
    op2= 64'habcd_1100_1100_dddd;
    
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
   $dumpfile("CLA_64_1.vcd");
   $dumpvars(0,CLA_64_tb_1);
  end
endmodule
