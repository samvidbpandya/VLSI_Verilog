`timescale 1 ns/ 10 ps
module CSA64EQG_tb_5();
  
  reg [63:0]op1;
  reg [63:0]op2;
  reg clock;
  reg reset;
  wire [63:0]sum;
  wire crout;
  CSA64EQG A (sum,crout,op1,op2,clock,reset);
  
  initial begin
    
    op1= 64'b0;
    op2= 64'b0;
    clock= 1'b1;
    
     #4;
    op1= 64'h1234_ffff_dfff_eeee;
    op2= 64'hdddd_dddd_dddd_dddd;

  end
  initial begin
    reset= 1'b1;
    #4;
    reset= 1'b0;
    
  end
  
  initial begin
    forever #3 clock=~clock;
  end
  initial begin 
    #30;
    $finish;
  end
  initial begin
   $dumpfile("CSA64EQG_5.vcd");
   $dumpvars(0,CSA64EQG_tb_5);
  end
endmodule
