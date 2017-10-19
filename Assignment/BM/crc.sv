
module crc(crc_if m);

logic [31:0] data_in, control_reg, polynomial; // data register, polynmial register and control register
logic [31:0] trans_out, seed, seed_in1, seed_in, trans_outr, fxor_data;// other bits 
logic [1:0] TOT,TOTR;
logic FXOR,TCRC,WAS;




always @(posedge m.clk)
begin 
        if(m.rst) begin 
            data_in = 32'hffff_ffff;
            polynomial = 32'h0000_1021;
            control_reg = 32'h0000_0000;
            seed = 32'hffff_ffff; 
        end // end
        else begin 
            if(m.RW) begin 
            case(m.addr)
                32'h4003_2000 : data_in = m.data_wr;
                
                32'h4003_2004 : polynomial = m.data_wr;
                                    
                32'h4003_2008 : control_reg = m.data_wr;
                               
            endcase//case ended
            end 
             
            TOT= control_reg [31:30];
            TOTR= control_reg [29:28];
            FXOR= control_reg[26];
            WAS= control_reg[25];
            TCRC = control_reg[24];
//..... Transpose Of Data......//    Data Write Transpose        
        case(TOT)
                                   
            0 : trans_out = data_in;    // No Transpose             
            
            1 : trans_out = { {data_in[24], data_in[25], data_in[26], data_in[27], data_in[28], data_in[29],                                       data_in[30],data_in[31]}, {data_in[16], data_in[17], data_in[18], data_in[19], data_in[20], data_in[21], data_in[22], data_in[23]}, {data_in[8], data_in[9], data_in[10], data_in[11], data_in[12], data_in[13], data_in[14], data_in[15]}, {data_in[0], data_in[1], data_in[2], data_in[3], data_in[4], data_in[5], data_in[6], data_in[7]}}; // Bits in a byte transposed
            
            2 : trans_out = {data_in[0], data_in[1], data_in[2], data_in[3], data_in[4], data_in[5], data_in[6], data_in[7], data_in[8], data_in[9], data_in[10], data_in[11], data_in[12], data_in[13], data_in[14], data_in[15], data_in[16], data_in[17], data_in[18], data_in[19], data_in[20], data_in[21], data_in[22], data_in[23], data_in[24], data_in[25], data_in[26], data_in[27], data_in[28], data_in[29], data_in[30], data_in[31]}; // Bits and Bytes both Transposed
            
            3 : trans_out = {{data_in[7], data_in[6], data_in[5], data_in[4], data_in[3], data_in[2], data_in[1], data_in[0]}, {data_in[15], data_in[14], data_in[13], data_in[12], data_in[11], data_in[10], data_in[9], data_in[8]}, {data_in[23], data_in[22], data_in[21], data_in[20], data_in[19], data_in[18], data_in[17], data_in[16]}, {data_in[31], data_in[30], data_in[29], data_in[28], data_in[27], data_in[26], data_in[25], data_in[24]}};// Bytes Transposed and 
        endcase 
        
         
    
       
//..... CRC Engine.....//

    if(WAS == 1 && m.RW == 1 && m.Sel == 1 && m.addr == 32'h4003_2000)
        begin 
                seed = trans_out;
                seed_in = seed;
        
        end
     else if(TCRC == 1 && WAS == 0 && m.RW == 1 && m.Sel == 1 && m.addr == 32'h4003_2000) // 32-bit CRC Engine
      begin   
            seed_in = seed;    
             
            for(int i = 32; i > 0; i = i-1) begin 
                       
                        if(seed_in[31] == 0) begin 
                            seed_in = seed_in << 1;
                            seed_in = {seed_in[31:1], trans_out[31]};
                            trans_out = trans_out << 1;
                        end 
                        else if(seed_in[31] == 1) begin 
                            seed_in = seed_in << 1;
                            seed_in = {seed_in[31:1], trans_out[31]};
                            seed_in =  seed_in ^ polynomial;
                            trans_out = trans_out << 1;
                        
                        end 
                    
                        
                  end 
                    
                    seed_in1 = seed_in;
                    
                   
                    seed = seed_in1;
                    
                    
                end 
        
        else if(TCRC == 0 && WAS == 0 && m.RW == 1 && m.Sel == 1 && m.addr == 32'h4003_2000) // 16-bit CRC Engine
        begin
        
         seed_in = seed;    
            
            for(int i = 32; i > 0; i = i-1) begin 
                       
                        if(seed_in[15] == 0) begin 
                            seed_in = seed_in << 1;
                            seed_in = {seed_in[15:1], trans_out[31]};
                            trans_out = trans_out << 1;
                        end 
                        else if(seed_in[15] == 1) begin 
                            seed_in = seed_in << 1;
                            seed_in[15:0] = {seed_in[15:1], trans_out[31]};
                            seed_in[15:0] =  seed_in[15:0] ^ polynomial;
                            trans_out = trans_out << 1;
                        
                            
                        end 
                    
                        
                  end 
                    
                    seed_in1 = {16'b0, seed_in[15:0]};
                    
                   
                    seed = seed_in1;
                    
                  
        
        end 
        
       
//Complement of data in FXOR block         
        if (FXOR == 1) // complement the data if the FXOR is 1 
        begin
            if (TCRC==1)
                begin
                    fxor_data = seed ^ 32'hffff_ffff;
                end
            else if(TCRC==0)
                begin
                    case(TOTR)
                        2'b00:fxor_data = seed ^ 32'h0000ffff;
                        2'b01:fxor_data = seed ^ 32'h0000ffff;
                        2'b10:fxor_data = seed ^ 32'h0000ffff;
                        2'b11:fxor_data = seed ^ 32'h0000ffff;
                    endcase 
                end
        end
       else if(FXOR == 0) begin
        fxor_data = seed;
        end
        
//..... Transpose of Data READ.....//    
        case(TOTR)
                                   
            0: trans_outr = fxor_data;                 
            
            1 : trans_outr = { {fxor_data[24], fxor_data[25], fxor_data[26], fxor_data[27], fxor_data[28], fxor_data[29],                                       fxor_data[30],fxor_data[31]}, {fxor_data[16], fxor_data[17], fxor_data[18], fxor_data[19], fxor_data[20], fxor_data[21], fxor_data[22], fxor_data[23]}, {fxor_data[8], fxor_data[9], fxor_data[10], fxor_data[11], fxor_data[12], fxor_data[13], fxor_data[14], fxor_data[15]}, {fxor_data[0], fxor_data[1], fxor_data[2], fxor_data[3], fxor_data[4], fxor_data[5], fxor_data[6], fxor_data[7]}};
            
            2 : trans_outr = {fxor_data[0], fxor_data[1], fxor_data[2], fxor_data[3], fxor_data[4], fxor_data[5], fxor_data[6], fxor_data[7], fxor_data[8], fxor_data[9], fxor_data[10], fxor_data[11], fxor_data[12], fxor_data[13], fxor_data[14], fxor_data[15], fxor_data[16], fxor_data[17], fxor_data[18], fxor_data[19], fxor_data[20], fxor_data[21], fxor_data[22], fxor_data[23], fxor_data[24], fxor_data[25], fxor_data[26], fxor_data[27], fxor_data[28], fxor_data[29], fxor_data[30], fxor_data[31]}; 
            
            3 : trans_outr = {{fxor_data[7], fxor_data[6], fxor_data[5], fxor_data[4], fxor_data[3], fxor_data[2], fxor_data[1], fxor_data[0]}, {fxor_data[15], fxor_data[14], fxor_data[13], fxor_data[12], fxor_data[11], fxor_data[10], fxor_data[9], fxor_data[8]}, {fxor_data[23], fxor_data[22], fxor_data[21], fxor_data[20], fxor_data[19], fxor_data[18], fxor_data[17], fxor_data[16]}, {fxor_data[31], fxor_data[30], fxor_data[29], fxor_data[28], fxor_data[27], fxor_data[26], fxor_data[25], fxor_data[24]}};
        endcase 
    
    
    end 
end 
    
        
always @(*) begin 
      
      
        if (m.addr == 32'h4003_2000)
        begin
           m.data_rd = trans_outr;
        end
        
        else if (m.addr == 32'h4003_2004)
        begin
            m.data_rd = polynomial;
        end
        
        else if (m.addr == 32'h4003_2008)
        begin
            m.data_rd = control_reg;
        end
        
        else m.data_rd = 32'h12345678;
   
     
end 
       
       
    
endmodule 
                
