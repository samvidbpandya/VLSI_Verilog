//*****************Arbitrator*****************
// **************Bidding Arbiter**************
// 32'hFFEF_S2M0. S stands for Slave and M stands for Master. S is 0 to 3 and M is also 0 to 3.

module arb (bmif.mstrR bm0,bmif.mstrR bm1, bmif.mstrR bm2, bmif.mstrR bm3, svif.slvR sl0,svif.slvR sl1, svif.slvR sl2, svif.slvR sl3, input integer bid, input integer clk_interval, input integer bid_max_amount ); // bmif bus master interface svif slave interface

integer balance_0,balance_0_2; // Balance Master 0
integer time_0,time_0_2;       // Timer  Master 0
integer balance_1,balance_1_2; // Balance Master 1
integer time_1,time_1_2;       // Timer  Master 1
integer balance_2,balance_2_2; // Balance Master 1
integer time_2,time_2_2;       // Timer  Master 2
integer balance_3,balance_3_2; // Balance Master 1
integer time_3,time_3_2;       // Timer  Master 3
integer counter,counter_main;  // counter to check the clk interval given in top.sv
logic[1:0] check_0,check_1,check_2,check_3;// Flags to check masters


always @ (*)
begin
    if (bm0.rst)// All Slaves are in Reset condition
        begin
            sl0.sel = 0;
            sl1.sel = 0;
            sl2.sel = 0;
            sl3.sel = 0;
        end
    else
        begin	
            if (bm0.grant == 1) // Master Zero is bus controller. Slave is decided through Address available in bm0.addr 32'HFFEF_S200
                begin
                    case (bm0.addr)
                        32'hFFEF0200: begin // Slave 0 is Selected... 32'hFFEF_S2M0 : Slave 0 and Master 0 
                                        sl0.sel = 1;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl0.RW = bm0.RW;
                                        sl0.addr = bm0.addr;
                                        sl0.DataToSlave = bm0.DataToSlave;
                                        bm0.DataFromSlave = sl0.DataFromSlave;
                                      end
                        32'hFFEF1200: begin // Slave 1 is Selected... 32'hFFEF_S2M0 : Slave 1 and Master 0
                                        sl0.sel = 0;
                                        sl1.sel = 1;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl1.RW = bm0.RW;
                                        sl1.addr = bm0.addr;
                                        sl1.DataToSlave = bm0.DataToSlave;
                                        bm0.DataFromSlave = sl1.DataFromSlave;
                                      end
                        32'hFFEF2200: begin // Slave 2 is Selected... 32'hFFEF_S2M0 : Slave 2 and Master 0
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 1;
                                        sl3.sel = 0;
                                        sl2.RW = bm0.RW;
                                        sl2.addr = bm0.addr;
                                        sl2.DataToSlave = bm0.DataToSlave;
                                        bm0.DataFromSlave = sl2.DataFromSlave;
                                      end
                        32'hFFEF3200: begin // Slave 3 is Selected... 32'hFFEF_S2M0 : Slave 3 and Master 0
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 1;
                                        sl3.RW = bm0.RW;
                                        sl3.addr = bm0.addr;
                                        sl3.DataToSlave = bm0.DataToSlave;
                                        bm0.DataFromSlave = sl3.DataFromSlave;
                                      end		
                        default : begin
                                        sl0.sel =0;
                                        sl1.sel =0;
                                        sl2.sel =0;
                                        sl3.sel =0;
                                  end	
                    endcase		
                end
            if (bm1.grant == 1) // Master One is bus controller. Slave is decided through Address available in bm1.addr 32'HFFEF_S210
                begin
                    case (bm1.addr)
                        32'hFFEF0210: begin // Slave 0 is Selected... 32'hFFEF_S2M0 : Slave 0 and Master 1
                                        sl0.sel = 1;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl0.RW = bm1.RW;
                                        sl0.addr = bm1.addr;
                                        sl0.DataToSlave = bm1.DataToSlave;
                                        bm1.DataFromSlave = sl0.DataFromSlave;
                                      end
                        32'hFFEF1210: begin // Slave 1 is Selected... 32'hFFEF_S2M0 : Slave 1 and Master 1
                                        sl0.sel = 0;
                                        sl1.sel = 1;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl1.RW = bm1.RW;
                                        sl1.addr = bm1.addr;
                                        sl1.DataToSlave = bm1.DataToSlave;
                                        bm1.DataFromSlave = sl1.DataFromSlave;
                                      end
                        32'hFFEF2210: begin // Slave 2 is Selected... 32'hFFEF_S2M0 : Slave 2 and Master 1
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 1;
                                        sl3.sel = 0;
                                        sl2.RW = bm1.RW;
                                        sl2.addr = bm1.addr;
                                        sl2.DataToSlave = bm1.DataToSlave;
                                        bm1.DataFromSlave = sl2.DataFromSlave;
                                      end
                        32'hFFEF3210: begin // Slave 3 is Selected... 32'hFFEF_S2M0 : Slave 3 and Master 1
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 1;
                                        sl3.RW = bm1.RW;
                                        sl3.addr = bm1.addr;
                                        sl3.DataToSlave = bm1.DataToSlave;
                                        bm1.DataFromSlave = sl3.DataFromSlave;
                                      end		
                        default : begin
                                        sl0.sel =0;
                                        sl1.sel =0;
                                        sl2.sel =0;
                                        sl3.sel =0;
                                  end			
                    endcase	
                end
            if (bm2.grant == 1) // Master Two is bus controller. Slave is decided through Address available in bm2.addr 32'HFFEF_S220
                begin
                    case (bm2.addr)
                        32'hFFEF0220: begin // Slave 0 is Selected... 32'hFFEF_S2M0 : Slave 0 and Master 2
                                        sl0.sel = 1;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl0.RW = bm2.RW;
                                        sl0.addr = bm2.addr;
                                        sl0.DataToSlave = bm2.DataToSlave;
                                        bm2.DataFromSlave = sl0.DataFromSlave;
                                      end
                        32'hFFEF1220: begin // Slave 1 is Selected... 32'hFFEF_S2M0 : Slave 1 and Master 2
                                        sl0.sel = 0;
                                        sl1.sel = 1;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl1.RW = bm2.RW;
                                        sl1.addr = bm2.addr;
                                        sl1.DataToSlave = bm2.DataToSlave;
                                        bm2.DataFromSlave = sl1.DataFromSlave;
                                      end
                        32'hFFEF2220: begin // Slave 2 is Selected... 32'hFFEF_S2M0 : Slave 2 and Master 2
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 1;
                                        sl3.sel = 0;
                                        sl2.RW = bm2.RW;
                                        sl2.addr = bm2.addr;
                                        sl2.DataToSlave = bm2.DataToSlave;
                                        bm2.DataFromSlave = sl2.DataFromSlave;
                                      end
                        32'hFFEF3220: begin // Slave 3 is Selected... 32'hFFEF_S2M0 : Slave 3 and Master 2
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 1;
                                        sl3.RW = bm2.RW;
                                        sl3.addr = bm2.addr;
                                        sl3.DataToSlave = bm2.DataToSlave;
                                        bm2.DataFromSlave = sl3.DataFromSlave;
                                      end	
                        default : begin
                                        sl0.sel =0;
                                        sl1.sel =0;
                                        sl2.sel =0;
                                        sl3.sel =0;
                                  end				
                    endcase	
                end
            if (bm3.grant == 1) // Master Three is bus controller. Slave is decided through Address available in bm3.addr 32'HFFEF_S200
                begin
                    case (bm3.addr)
                        32'hFFEF0230: begin // Slave 0 is Selected... 32'hFFEF_S2M0 : Slave 0 and Master 3
                                        sl0.sel = 1;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl0.RW = bm3.RW;
                                        sl0.addr = bm3.addr;
                                        sl0.DataToSlave = bm3.DataToSlave;
                                        bm3.DataFromSlave = sl0.DataFromSlave;
                                      end
                        32'hFFEF1230: begin // Slave 1 is Selected... 32'hFFEF_S2M0 : Slave 1 and Master 3
                                        sl0.sel = 0;
                                        sl1.sel = 1;
                                        sl2.sel = 0;
                                        sl3.sel = 0;
                                        sl1.RW = bm3.RW;
                                        sl1.addr = bm3.addr;
                                        sl1.DataToSlave = bm3.DataToSlave;
                                        bm3.DataFromSlave = sl1.DataFromSlave;
                                      end
                        32'hFFEF2230: begin // Slave 2 is Selected... 32'hFFEF_S2M0 : Slave 2 and Master 3
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 1;
                                        sl3.sel = 0;
                                        sl2.RW = bm3.RW;
                                        sl2.addr = bm3.addr;
                                        sl2.DataToSlave = bm3.DataToSlave;
                                        bm3.DataFromSlave = sl2.DataFromSlave;
                                      end
                        32'hFFEF3230: begin // Slave 3 is Selected... 32'hFFEF_S2M0 : Slave 3 and Master 3
                                        sl0.sel = 0;
                                        sl1.sel = 0;
                                        sl2.sel = 0;
                                        sl3.sel = 1;
                                        sl3.RW = bm3.RW;
                                        sl3.addr = bm3.addr;
                                        sl3.DataToSlave = bm3.DataToSlave;
                                        bm3.DataFromSlave = sl3.DataFromSlave;
                                      end
                        default : begin
                                        sl0.sel =0;
                                        sl1.sel =0;
                                        sl2.sel =0;
                                        sl3.sel =0;
                                  end				
                    endcase	
                end 
        end
end
always @ (posedge bm0.clk)
begin
        balance_0 <= #1 balance_0_2;
        balance_1 <= #1 balance_1_2;
        balance_2 <= #1 balance_2_2;
        balance_3 <= #1 balance_3_2;
        counter <= #1 counter_main;
        time_0 <= #1 time_0_2;
        time_1 <= #1 time_1_2;
        time_2 <= #1 time_2_2;
        time_3 <= #1 time_3_2;
end
always @ (*)
begin
    if (bm0.rst)
        begin
            // Check Bits
            check_0 = 0;
            check_1 = 1;
            check_2 = 2;
            check_3 = 3;
            // Balances will be maximum at Reset
            balance_0_2 = bid_max_amount;
            balance_1_2 = bid_max_amount;	
            balance_2_2 = bid_max_amount;
            balance_3_2 = bid_max_amount;
            // Counter is zero
            counter_main = 0;
            // No grant to any Master
            bm0.grant = 0;
            bm1.grant = 0;
            bm2.grant = 0;
            bm3.grant = 0;
            // Timer is zero for all
            time_0_2 = 0;
            time_1_2 = 0;
            time_2_2 = 0;
            time_3_2 = 0;
        end
    else
        begin
            counter_main = counter + 1;
            if (counter == clk_interval) // Check the bidding amount in each master after each clk_interval
                begin
                    counter_main = 0;
                    if ((balance_0 + bid) < bid_max_amount)
                        begin
                            balance_0_2 = balance_0 + bid; // Bid is added.....
                        end	
                    else
                        begin
                            balance_0_2 = bid_max_amount;	
                        end
                    if ((balance_1 + bid) < bid_max_amount)
                        begin
                            balance_1_2 = balance_1 + bid;
                        end	
                    else
                        begin
                            balance_1_2 = bid_max_amount;	
                        end
                    if ((balance_2 + bid) < bid_max_amount)
                        begin
                            balance_2_2 = balance_2 + bid;
                        end	
                    else
                        begin
                            balance_2_2 = bid_max_amount;	
                        end
                    if ((balance_3 + bid) < bid_max_amount)
                        begin
                            balance_3_2 = balance_3 + bid;
                        end	
                    else
                        begin
                            balance_3_2 = bid_max_amount;	
                        end
                end 
            
            if (bm0.xfr == 0)
                bm0.grant = 0;
            else if (bm1.xfr == 0)
                bm1.grant = 0;
            else if (bm2.xfr == 0)
                bm2.grant = 0;
            else if (bm3.xfr == 0)
                bm3.grant = 0;

            if ((( balance_1 == 1 ? 1 : bm0.req >= bm1.req ) && (balance_2 ==1? 1 :bm0.req >= bm2.req) && (balance_3 ==1? 1:bm0.req >= bm3.req) && bm0.xfr == 1 && (balance_0 ==1?0:1))||time_0 == 59||((balance_1==1 | bm1.req == 0) && (balance_2==1 | bm2.req == 0) && (balance_3==1 | bm3.req == 0) && bm0.req != 0)&& time_1 < 59 && time_2 <59 && time_3 <59) //Checking for the req amt for Master...
                begin 
                    if (check_0 != 3)
                        begin
                            check_0 = 3;
                            if (check_3>check_2 && check_3>check_1 && check_2>check_1)
                                begin 
                                    check_3 = 2; 
                                    check_2 = 1; 
                                    check_1 = 0;
                                end
                            else if (check_2>check_1 && check_2>check_3 && check_3>check_1) 
                                begin 
                                    check_3 = 1;
                                    check_2 = 2;
                                    check_1 = 0; 
                                end
                            else if (check_3>check_2 && check_3>check_1 && check_1>check_2) 
                                begin 
                                    check_3 = 2;
                                    check_2 = 0; 
                                    check_1 = 1; 
                                end
                            else if (check_2>check_1 && check_2>check_3 && check_1>check_3) 
                                begin 
                                    check_3 = 0;
                                    check_2 = 2;
                                    check_1 = 1; 
                                end
                            else if (check_1>check_2 && check_1>check_3 && check_3>check_2)
                                begin
                                    check_3 = 1;
                                    check_2 = 0;
                                    check_1 = 2;
                                end
                            else if (check_1>check_2 && check_1>check_3 && check_2>check_3) 
                                begin
                                    check_3 = 0;
                                    check_2 = 1;
                                    check_1 = 2;
                                end
                        end
                    time_0_2 = 0;
                    time_1_2 = time_1+1;
                    time_2_2 = time_2+1;
                    time_3_2 = time_3+1;
                    bm0.grant = 1; // Bus is Granted to Master Zero
                    bm1.grant = 0;
                    bm2.grant = 0;
                    bm3.grant = 0;
                    if ((balance_0 - bm0.req)<=0 | (balance_0 - bm0.req > bid_max_amount))
                        balance_0_2 = 1;
                    else
                        balance_0_2 = balance_0 - bm0.req;
                end 
                
            if ((( balance_0 == 1 ? 1 : bm1.req >= bm0.req ) && (balance_2 ==1 ? 1: bm1.req >= bm2.req) && (balance_3 ==1? 1:bm1.req >= bm3.req) && bm1.xfr == 1  && (balance_1==1?0:1))||(time_1 == 59))
                begin
                    if (check_1 != 3)
                        begin
                            check_1 = 3;
                            if (check_3>check_2 && check_3>check_0 && check_2>check_0) 
                                begin
                                    check_3 = 2;
                                    check_2 = 1;
                                    check_0 = 0;
                                end
                            else if (check_2>check_0 && check_2>check_3 && check_3>check_0) 
                                begin 
                                    check_3 = 1; 
                                    check_2 = 2;
                                    check_0 = 0;
                                end
                            else if (check_3>check_2 && check_3>check_0 && check_0>check_2) 
                                begin
                                    check_3 = 2;
                                    check_2 = 0;
                                    check_0 = 1;
                                end
                            else if (check_2>check_0 && check_2>check_3 && check_0>check_3) 
                                begin 
                                    check_3 = 0; 
                                    check_2 = 2; 
                                    check_0 = 1; 
                                end
                            else if (check_0>check_2 && check_0>check_3 && check_3>check_2) 
                                begin 
                                    check_3 = 1;
                                    check_2 = 0;
                                    check_0 = 2; 
                                end
                            else if (check_0>check_2 && check_0>check_3 && check_2>check_3) 
                                begin 
                                    check_3 = 0;
                                    check_2 = 1;
                                    check_0 = 2;
                                end
                end
                    time_0_2 = time_0+1;
                    time_1_2 = 0;
                    time_2_2 = time_2+1;
                    time_3_2 = time_3+1;
                    bm0.grant = 0;
                    bm1.grant = 1; // Master One is now Controlling the BUS.... Grant To Master 1
                    bm2.grant = 0;
                    bm3.grant = 0;
                    if ((balance_1 - bm1.req)<=0 | (balance_1 - bm1.req > bid_max_amount))
                        balance_1_2 = 1;
                    else
                        balance_1_2 = balance_1 - bm1.req;
                end
    
            if ((( balance_0 == 1 ? 1 : bm2.req >= bm0.req ) && (balance_1 ==1? 1:bm2.req >= bm1.req) && (balance_3 ==1? 1:bm2.req >= bm3.req) && bm2.xfr == 1 && (balance_2==1?0:1))||(time_2 == 59))
                begin
                    if (check_2 != 3)
                        begin
                            check_2 = 3;
                            if (check_3>check_0 && check_3>check_1 && check_0>check_1) 
                                begin 
                                    check_3 = 2;
                                    check_0 = 1;
                                    check_1 = 0; 
                                end
                            else if (check_0>check_1 && check_0>check_3 && check_3>check_1)
                                begin 
                                    check_3 = 1;
                                    check_0 = 2;
                                    check_1 = 0;
                                end
                            else if (check_3>check_0 && check_3>check_1 && check_1>check_0)
                                begin 
                                    check_3 = 2;
                                    check_0 = 0;
                                    check_1 = 1; 
                                end
                            else if (check_0>check_1 && check_0>check_3 && check_1>check_3)
                                begin 
                                    check_3 = 0;
                                    check_0 = 2;
                                    check_1 = 1;
                                end
                            else if (check_1>check_0 && check_1>check_3 && check_3>check_0)
                                begin 
                                    check_3 = 1;
                                    check_0 = 0; 
                                    check_1 = 2; 
                                end
                            else if (check_1>check_0 && check_1>check_3 && check_0>check_3)
                                begin 
                                    check_3 = 0;
                                    check_0 = 1; 
                                    check_1 = 2; 
                                end
                        end
                    time_0_2 = time_0+1;
                    time_1_2 = time_1+1;
                    time_2_2 = 0;
                    time_3_2 = time_3+1;
                    bm0.grant = 0;
                    bm1.grant = 0;
                    bm2.grant = 1; // Bus access is granted to Master 2... Master is Controlling the BUS now.
                    bm3.grant = 0;	
                    if ((balance_2 - bm2.req)<=0 | (balance_2 - bm2.req > bid_max_amount))
                        balance_2_2 = 1;
                    else
                        balance_2_2 = balance_2 - bm2.req;
                end
            if ((( balance_0 == 1 ? 1 : bm3.req >= bm0.req ) && (balance_1 ==1? 1:bm3.req >= bm1.req) && (balance_2 ==1? 1:bm3.req >= bm2.req) && bm3.xfr == 1 && (balance_3==1?0:1))||(time_3 == 59))
                begin
                    if (check_3 != 3)
                        begin
                            check_3 = 3;
                            if (check_0>check_2 && check_0>check_1 && check_2>check_1)
                                begin 
                                    check_0 = 2;
                                    check_2 = 1;
                                    check_1 = 0; 
                                end
                            else if (check_2>check_1 && check_2>check_0 && check_0>check_1)
                                begin 
                                    check_0 = 1;
                                    check_2 = 2;
                                    check_1 = 0; 
                                end
                            else if (check_0>check_2 && check_0>check_1 && check_1>check_2)
                                begin 
                                    check_0 = 2;
                                    check_2 = 0; 
                                    check_1 = 1;
                                end
                            else if (check_2>check_1 && check_2>check_0 && check_1>check_0)
                                begin 
                                    check_0 = 0;
                                    check_2 = 2;
                                    check_1 = 1;
                                end
                            else if (check_1>check_2 && check_1>check_0 && check_0>check_2)
                                begin 
                                    check_0 = 1;
                                    check_2 = 0;
                                    check_1 = 2;
                                end
                            else if (check_1>check_2 && check_1>check_0 && check_2>check_0)
                                begin 
                                    check_0 = 0;
                                    check_2 = 1; 
                                    check_1 = 2;
                                end
                        end
                    time_0_2 = time_0+1;
                    time_1_2 = time_1+1;
                    time_2_2 = time_2+1;
                    time_3_2 = 0;
                    bm0.grant = 0;
                    bm1.grant = 0;
                    bm2.grant = 0;
                    bm3.grant = 1;// Bus is now controlled by Master Three. Master Three grant.
                    if ((balance_3 - bm3.req)<=0 | (balance_3 - bm3.req > bid_max_amount))
                        balance_3_2 = 1;
                    else
                        balance_3_2 = balance_3 - bm3.req;
                end 
	end
end

endmodule : arb
