`timescale 1ns/10ps
// prints out the state values
//
module dut(intf.idut ix);

default clocking @(posedge(ix.clk));

endclocking

property p0 ;
   ##1 ix.state==1 ;
endproperty
property p1 ;
   ##1 (ix.state==2 || ix.state==4) ;
endproperty
property p2 ;
   ##1 ix.state==3 ;
endproperty

always @(posedge(ix.clk)) begin
  $display(ix.state);
end

  assert property( if(ix.state==1) p1 ) else $info("  -- 1-(2,4) error");
  assert property (if(ix.state==0 && ix.rst==0) p0) else $warning("  --> 0-1 error"); 
  assert property( if(ix.state==2) p2) else $warning("  --> 2-3 error");
  assert property( if(ix.state==3) ##1 (ix.state==5 || ix.state==1) ) else $warning("  --> 3-(1,5) error");
  assert property( if(ix.state==4) ##1 ix.state==5) else $warning("  --> 4-5 error");
  assert property( if(ix.state==5) ##1 (ix.state==1 || ix.state==6)) else $warning("  --> 5-(1,6) error");
  assert property( if(ix.state==6) ##1 ix.state==7 ) else $warning("  --> 6-7 error");
  assert property( if(ix.state==7) ##1 ix.state==0 || ix.state==5) else $warning("  --> 7-(0,5) error");


endmodule
