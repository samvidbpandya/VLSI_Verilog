//......
//... Bidding Arbitrator......
//......
//FFEF_S2M0 - S- slave 0 to 3 and M- Master 0 to 3


module arb(bmif.mstrR bm0,bmif.mstrR bm1,bmif.mstrR bm2,bmif.mstrR bm3,svif.slvR sl0,svif.slvR sl1,svif.slvR sl2,svif.slvR sl3, input integer bid, input integer interval, input integer maxamount);

typedef enum reg [2:0] {IDLE,master_0, master_1, master_2, master_3}state_machine;

state_machine current_state/*, next_state*/;

//logic [31:0] master_address_0, master_address_1, master_address_2,master_address_3;
//logic [31:0] DFS_0, DFS_1, DFS_2, DFS_3;
logic [31:0] DTS_0, DTS_1, DTS_2, DTS_3;
always @(posedge bm0.clk or posedge bm0.rst)
begin
    if (bm0.rst)
        begin
            //... Arbiter to Bus Masters
            
            bm0.DataFromSlave = 0;
            bm1.DataFromSlave = 0;
            bm2.DataFromSlave = 0;
            bm3.DataFromSlave = 0;
            current_state = IDLE;
            //next_state = current_state;
            
            //.... Arbiter to slaves

            sl0.DataToSlave = 0;
            sl1.DataToSlave = 0;
            sl2.DataToSlave = 0;
            sl3.DataToSlave = 0;
        end
    else 
        begin
         case(current_state)
         
          IDLE:begin
                    sl0.sel=0;
                    sl1.sel=0;
                    sl2.sel=0;
                    sl3.sel=0;
                    $display("IDLE");
                    // Master Selection
                if(bm0.req > bm1.req && bm0.req > bm2.req && bm0.req > bm3.req) // Grant request to Bus Master 0
                    begin
                        bm0.grant = 1;
                        //current_state = master_0;
                        case(bm0.addr)
                            32'hFFEF_0200:begin
                                            sl0.sel = 1;
                                            $display("Sel is %b", sl0.sel);
                                            sl0.addr = bm0.addr;
                                            
                                            sl0.DataToSlave = bm0.DataToSlave;
                                            //sl0.RW = 0;
                                          end
                            32'hFFEF_1200:begin
                                            sl1.sel = 1;
                                            //sl0.sel = 0;
                                            sl1.addr = bm0.addr;
                                            sl1.DataToSlave = bm0.DataToSlave;
                                            //sl1.RW = 0;
                                          end
                            32'hFFEF_2200:begin
                                            sl2.sel = 1;
                                            //sl0.sel = 0;
                                            sl2.addr = bm0.addr;
                                            sl2.DataToSlave = bm0.DataToSlave;
                                            //sl2.RW = 0;
                                         end
                            32'hFFEF_3200:begin
                                            sl3.sel = 1;
                                            $display("Sel3 is %b", sl3.sel);
                                            //sl0.sel = 0;
                                            sl3.addr = bm0.addr;
                                            sl3.DataToSlave = bm0.DataToSlave;
                                            //sl3.RW = 0;
                                  end
                     endcase
                        
                        
                    end
                else if(bm1.req > bm0.req && bm1.req > bm2.req && bm1.req > bm3.req) // Grant request to Bus Master 1
                    begin
                        bm1.grant = 1;
                        current_state = master_1;
                        //DTS_1 = bm1.DataToSlave;
                        
                    end
                else if(bm2.req > bm0.req && bm2.req > bm1.req && bm2.req > bm3.req)// Grant request to Bus Master 2
                    begin
                        bm2.grant = 1;
                        current_state = master_2;
                        //DTS_2 = bm2.DataToSlave;
                        
                    end
                else if(bm3.req > bm1.req && bm3.req > bm2.req && bm3.req > bm0.req)// Grant request to Bus Master 3
                    begin
                        bm3.grant = 1;
                        current_state = master_3;
                        //DTS_3 = bm3.DataToSlave;
                    
                    end
                else
                    begin
                        current_state = IDLE;
                    end
               end
            /*master_0:begin // Master Zero is Selected
                        //bm0.grant = 1;
                        //DTS_0 = bm0.DataToSlave;
                        $display("Master 0 Grant");
                     case(bm0.addr)
                            32'hFFEF_0200:begin
                                            sl0.sel = 1;
                                            $display("Sel is %b", sl0.sel);
                                            sl0.addr = bm0.addr;
                                            
                                            sl0.DataToSlave = bm0.DataToSlave;
                                            //sl0.RW = 0;
                                          end
                            32'hFFEF_1200:begin
                                            sl1.sel = 1;
                                            //sl0.sel = 0;
                                            sl1.addr = bm0.addr;
                                            sl1.DataToSlave = bm0.DataToSlave;
                                            //sl1.RW = 0;
                                          end
                            32'hFFEF_2200:begin
                                            sl2.sel = 1;
                                            //sl0.sel = 0;
                                            sl2.addr = bm0.addr;
                                            sl2.DataToSlave = bm0.DataToSlave;
                                            //sl2.RW = 0;
                                         end
                            32'hFFEF_3200:begin
                                            sl3.sel = 1;
                                            $display("Sel3 is %b", sl3.sel);
                                            //sl0.sel = 0;
                                            sl3.addr = bm0.addr;
                                            sl3.DataToSlave = bm0.DataToSlave;
                                            //sl3.RW = 0;
                                  end
                     endcase
                        current_state = IDLE;
                        bm0.grant = 0;
                     end
            master_1:begin // Master One is Selected
                        //bm1.grant = 0;
                        DTS_1 = bm1.DataToSlave;
                     case(bm1.addr)
            
                            32'hFFEF_0210:begin
                                            sl0.sel = 1;
                                            sl0.sel = 0;
                                            sl0.addr = bm1.addr;
                                          end
                            32'hFFEF_1210:begin
                                            sl1.sel = 1;
                                            sl0.sel = 0;
                                            sl1.addr = bm1.addr;
                                          end
                            32'hFFEF_2210:begin
                                            sl2.sel = 1;
                                            sl0.sel = 0;
                                            sl2.addr = bm1.addr;
                                         end
                            32'hFFEF_3210:begin
                                            sl3.sel = 1;
                                            sl0.sel = 0;
                                            sl3.addr = bm1.addr;
                                  end
                     endcase
                        current_state = IDLE;
                        bm1.grant = 0;
                     end
            master_2:begin // Master Two is Selected
                        //bm2.grant = 0;
                        DTS_2 = bm2.DataToSlave;
                     case(bm2.addr)
            
                            32'hFFEF_0220:begin
                                            sl0.sel = 1;
                                            sl0.addr = bm2.addr;
                                          end
                            32'hFFEF_1220:begin
                                            sl1.sel = 1;
                                            sl1.addr = bm2.addr;
                                          end
                            32'hFFEF_2220:begin
                                            sl2.sel = 1;
                                            sl2.addr = bm2.addr;
                                         end
                            32'hFFEF_3220:begin
                                            sl3.sel = 1;
                                            sl3.addr = bm2.addr;
                                  end
                     endcase
                        current_state = IDLE;
                        bm2.grant = 0;
                     end
            master_3:begin // Master 3 is Selected
                        bm3.grant = 0;
                        DTS_3 = bm3.DataToSlave;
                     case(bm3.addr)
            
                            32'hFFEF_0230:begin
                                            sl0.sel = 1;
                                            sl0.addr = bm3.addr;
                                          end
                            32'hFFEF_1230:begin
                                            sl1.sel = 1;
                                            sl1.addr = bm3.addr;
                                          end
                            32'hFFEF_2230:begin
                                            sl2.sel = 1;
                                            sl2.addr = bm3.addr;
                                         end
                            32'hFFEF_3230:begin
                                            sl3.sel = 1;
                                            sl3.addr = bm3.addr;
                                  end
                     endcase
                        current_state = IDLE;
                        bm3.grant = 0;
                     end
         endcase
        end
end
/*always @(posedge clk)
begin






end*/
endmodule: arb

/*case(bm0.addr)
            
                    32'hFFEF_0200:begin
                                        //DTS_0 = bm0.DataToSlave;
                                        sl0.sel = 1;
                                        sl0.addr = bm0.addr;
            
                                  end
                    32'hFFEF_1200:begin
                                        //DTS_0 = bm0.DataToSlave;
                                        sl0.sel = 1;
                                        sl0.addr = bm0.addr;
                                  end
                    32'hFFEF_2200:begin
                                        //DTS_0 = bm0.DataToSlave;
                                        sl0.sel = 1;
                                        sl0.addr = bm0.addr;
                                  end
                    32'hFFEF_3200:begin
                                        //DTS_0 = bm0.DataToSlave;
                                        sl0.sel = 1;
                                        sl0.addr = bm0.addr;
                                  end
            endcase*/
//sl0.sel = 1; master_address_0 = bm0.addr; // First IF in IDLE
