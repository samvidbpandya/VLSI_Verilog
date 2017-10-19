`timescale 1ns/10ps
// prints out the state values
//
module dut(intf.idut ix);
int bug_cnt=1;
default clocking @(posedge(ix.clk));

endclocking

always @(posedge(ix.clk)) begin
  $display(ix.state);

    assert property (ix.state == 9 |=> ix.state == 0) $display ("DUT Passed at 0");
    else $display("Bad Assert = %d , wrong choice 0, bug_cnt = %d", ix.state, bug_cnt++);
    
    
    
    assert property(disable iff (ix.rst) ix.state==0  |=> ix.state == 1) $display("DUT Passed at 1");
    else $display("Bad Assert = %d, wrong choice 1, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==1  |=> ix.state inside{2,4}) $display("DUT Passed at 2 or 4");
     else $display("Bad Assert = %d ,wrong choice 2 or 4, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==2  |=> ix.state==3) $display("DUT Passed at 3");
    else $display("Bad Assert = %d , wrong choice 3, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==3  |=> ix.state inside{1,5}) $display("DUT Passed at 1 or 5");
     else $display("Bad Assert = %d ,wrong choice 1 or 5, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==4  |=> ix.state==5) $display("DUT Passed at 5");
     else $display("Bad Assert = %d , wrong choice 5, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==5  |=> ix.state inside{1,6}) $display("DUT Passed at 1 or 6");
     else $display("Bad Assert = %d ,wrong choice 1 or 6, bug_cnt = %d", ix.state, bug_cnt++);

     assert property(disable iff (ix.rst) ix.state==6  |=> ix.state==7) $display("DUT Passed at 7");
     else $display("Bad Assert = %d , wrong choice 7, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==7  |=> ix.state inside{0,8}) $display("DUT Passed at 0 or 8");
     else $display("Bad Assert = %d ,wrong choice 0 or 8, bug_cnt = %d", ix.state, bug_cnt++);

     assert property(disable iff (ix.rst) ix.state==8  |=> ix.state inside{2,4,14,9}) $display("DUT Passed at 2 or 4 or 9 or 14");
     else $display("Bad Assert = %d ,wrong choice 2 or 4 or 9 or 14, bug_cnt = %d", ix.state, bug_cnt++);

     assert property(disable iff (ix.rst) ix.state>14   |=> ix.state==4) $display("DUT Passed at 4");
     else $display("Bad Assert = %d , wrong choice 4, bug_cnt = %d", ix.state, bug_cnt++);
    
    assert property(disable iff (ix.rst) ix.state==10   |=> ix.state==4) $display("DUT Passed at 4");
     else $display("Bad Assert = %d , wrong choice 4, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==11   |=> ix.state==4) $display("DUT Passed at 4");
     else $display("Bad Assert = %d , wrong choice 4, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==12   |=> ix.state==4) $display("DUT Passed at 4");
     else $display("Bad Assert = %d , wrong choice 4, bug_cnt = %d", ix.state, bug_cnt++);

    assert property(disable iff (ix.rst) ix.state==13   |=> ix.state==4) $display("DUT Passed at 4");
     else $display("Bad Assert = %d , wrong choice 4, bug_cnt = %d", ix.state, bug_cnt++);
     //assert property(disable iff (ix.rst) ix.state==9  |=> ix.state==8) $display("DUT Passed at 8");
     //else $display("Bad Assert = %d , wrong choice 8", ix.state);

    assert property(disable iff (ix.rst) ix.state==14  |=> ix.state==0) $display("DUT Passed at 0");
     else $display("Bad Assert = %d , wrong choice 0, bug_cnt = %d", ix.state, bug_cnt++);
    

end
endmodule
