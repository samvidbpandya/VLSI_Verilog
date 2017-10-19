module noc(nocif n, crc_if c);

//parameter for state machine one

  parameter IDLE 	    = 7'd00;  
  parameter Source_ID_state  = 7'd01;  
  parameter address_state_1  = 7'd02;  
  parameter address_state_2 = 7'd03;  
  parameter address_state_3 = 7'd04;  
  parameter address_state_4 = 7'd05;  
  parameter length_state = 7'd06;  
  parameter state_write_data_1 = 7'd07;  
  parameter state_write_data_2 = 7'd08;  
  parameter state_write_data_3 = 7'd09;  
  parameter state_write_data_4 = 7'd10;  
  parameter sam_state = 7'd11;  

// parameter for state machine two

  parameter IDLE_2 = 7'd00;  
  parameter Read_State_1 = 7'd01;  
  parameter Read_State_2 = 7'd02;  
  parameter Read_State_3  = 7'd03;  
  parameter response_state_read_code= 7'd04;  
  parameter response_state_read_returnid= 7'd05;  
  parameter response_state_read_flop1_data1= 7'd06;  
  parameter response_state_read_flop1_data2 = 7'd07;  
  parameter response_state_read_flop1_data3 = 7'd08;  
  parameter response_state_read_flop1_data4 = 7'd09;  
  parameter response_state_read_flop2_data1 = 7'd10;  
  parameter response_state_read_flop2_data2 = 7'd11;  
  parameter response_state_read_flop2_data3 = 7'd12;  
  parameter response_state_read_flop2_data4 = 7'd13;  
  parameter response_state_read_flop3_data1   = 7'd14;  
  parameter response_state_read_flop3_data2   = 7'd15;  
  parameter response_state_read_flop3_data3   = 7'd16;
  parameter response_state_read_flop3_data4   = 7'd17;
  parameter END_READ= 7'd18;
  parameter Write_State	= 7'd19;
  parameter Write_Response_Code= 7'd20;
  parameter Write_Response_Return_ID= 7'd21;

//----------------------bus_master states-------------------------
  parameter BM_code= 7'd22;
  parameter BM_Source_ID= 7'd23;
  parameter BM_Address_1= 7'd24;
  parameter BM_Address_2= 7'd25;
  parameter BM_Address_3= 7'd26;
  parameter BM_Address_4= 7'd27;
  parameter BM_Len= 7'd28;
  parameter BM_Read_Source_ID= 7'd29;

  parameter BM_Link_1= 7'd30;
  parameter BM_Link_2= 7'd31;
  parameter BM_Link_3= 7'd32;
  parameter BM_Link_4= 7'd33;

  parameter BM_Seed_1= 7'd34;
  parameter BM_Seed_2= 7'd35;
  parameter BM_Seed_3= 7'd36;
  parameter BM_Seed_4= 7'd37;

  parameter BM_Ctrl_1= 7'd38;
  parameter BM_Ctrl_2= 7'd39;
  parameter BM_Ctrl_3= 7'd40;
  parameter BM_Ctrl_4= 7'd41;

  parameter BM_Polynomial_1= 7'd42;
  parameter BM_Polynomial_2= 7'd43;
  parameter BM_Polynomial_3= 7'd44;
  parameter BM_Polynomial_4= 7'd45;

  parameter BM_Data_1= 7'd46;
  parameter BM_Data_2= 7'd47;
  parameter BM_Data_3= 7'd48;
  parameter BM_Data_4= 7'd49;

  parameter BM_Len_1 = 7'd50;
  parameter BM_Len_2 = 7'd51;
  parameter BM_Len_3 = 7'd52;
  parameter BM_Len_4 = 7'd53;

  parameter BM_Result_1 = 7'd54;
  parameter BM_Result_2 = 7'd55;
  parameter BM_Result_3 = 7'd56;  
  parameter BM_Result_4 = 7'd57;  

  parameter BM_Message_1 = 7'd58;  
  parameter BM_Message_2= 7'd59;  
  parameter BM_Message_3 = 7'd60;  
  parameter BM_Message_4 = 7'd61;  

  parameter write_crc_start_BM= 7'd62;  
  parameter CRC_SEED_Write= 7'd63;  
  parameter CRC_CTRL_Write= 7'd64;  
  parameter CRC_POLY_Write= 7'd65;  

  parameter BM_code_2= 7'd66;  
  parameter BM_Source_ID_2= 7'd67;  
  parameter BM_Address_1_2= 7'd68;  
  parameter BM_Address_2_2= 7'd69;  
  parameter BM_Address_3_2= 7'd70;  
  parameter BM_Address_4_2= 7'd71;
  parameter BM_Len2= 7'd72;

  parameter Cycle_Code_1 = 7'd73;   
  parameter Cycle_Source_ID	= 7'd74;	
  parameter CRC_INPUT_1= 7'd75;   
  parameter CRC_INPUT_2= 7'd76;   
  parameter CRC_INPUT_3= 7'd77;   
  parameter CRC_INPUT_4= 7'd78;   
  
  parameter BM_CRC_Check = 7'd79; 

  parameter BM_Result_Send_1= 7'd80;
  parameter BM_Result_Send_2= 7'd81;
  parameter BM_Result_Send_3= 7'd82;
  parameter BM_Result_Send_4= 7'd83;
  parameter BM_Result_Send_5= 7'd84;
  parameter BM_Result_Send_6= 7'd85;

  parameter BM_send_len= 7'd86;
  parameter BM_CRC_Check_Send_1 = 7'd87;
  parameter BM_CRC_Check_Send_2 = 7'd88;
  parameter BM_CRC_Check_Send_3 = 7'd89;
  parameter BM_CRC_Check_Send_4 = 7'd90;

  parameter BM_Link_Check= 7'd91;

  parameter BM_Code_Message= 7'd92;
  parameter BM_Send_Message_1= 7'd93;
  parameter BM_Send_Message_2= 7'd94;
  parameter BM_Send_Message_3= 7'd95;
  parameter BM_Send_Message_4= 7'd96;

//--------------------------------------

  parameter send_data_state		= 7'd108;

// Variable  for state machine one

  logic [99:0] FIFO_in, FIFO_out;
  logic [31:0] address;
  logic [31:0] data_write;
  logic [7:0]  data_length;
  logic [7:0]  DataW;
  logic [7:0]  controller, controller_flop;
  logic [7:0]  Source_ID;
  logic [3:0]  state_machine, state_new;
  bit          len;
  bit 	       write_en, read_en;



// Variable  for state machine two

  logic [6:0]  state_machine_2, state_new_2;
  logic [7:0]  Source_ID_2, return_id_2;
  logic [7:0]  controller_2;
  logic [31:0] address_2, address_2_flop;
  logic [31:0] data_2;
  logic [7:0]  data_length_2;
  logic [31:0] flop1, flop2, flop3, flop4;

// Variable  for state machine bus_master
  logic [31:0] chain, start_chain;
  logic [31:0] Link, Seed, Ctrl, Polynomial,Data_bm, Data_2, Len, Len_2, Result, Message, crc_data_write_back, crc_data_write_back_2;
  logic [7:0] counter_crc, counter_crc_flop;
  logic [31:0] CRC_Check;
  bit master_mode, Chain_Bit, Test_Bit;

// FIFO Instance //

  FIFO f1 (n.clk, n.rst, write_en, FIFO_in, read_en, FIFO_out, fifo_full, fifo_empty);

  

  always@(posedge n.clk or posedge n.rst)
    begin
      if(n.rst)
        begin
	  DataW	 	  = 0;
	  controller_flop  = 0;
	  address_2_flop     = 0;
	  Len_2	  = 0;
	  Data_2	  = 0;
	  counter_crc_flop  = 0;
	  crc_data_write_back_2  = 0;
	  state_machine   = IDLE;
	  state_machine_2 = IDLE_2;
	end
      else
	begin
	  DataW 	  = n.DataW;
	  
	  controller_flop  = controller;
	  address_2_flop     = address_2;
	  state_machine   = state_new;
	  state_machine_2 = state_new_2;
	  return_id_2	  = Source_ID_2;  
	  Len_2	  = Len;
	  Data_2	  = Data_bm;
	  counter_crc_flop  = counter_crc;
  	  crc_data_write_back_2  = crc_data_write_back;
	end
    end



//-----------------------------------------------------
  always@(*)
    begin
      case(state_machine)
      IDLE:		
	begin
	  if(n.CmdW == 1)
	    begin
	      controller = DataW;

	      if	(DataW[7:5] == 3'b000) state_new = IDLE;
	      else 
		begin
		  state_new 	= Source_ID_state;
		  len	     	= DataW[4];
	      	end
	    end

	  write_en		= 0; 
	  //read_en			= 1;
	end

      Source_ID_state:	
	begin
	  Source_ID	= DataW;
	  state_new	= address_state_1;
	end

      address_state_1:	
	begin
	  if(controller[3:0] == 4'b1000)
	    begin
	      address[7:0] 	= DataW;
	      address[31:8]	= 24'hffffff;

	      state_new	= length_state;
	    end
	  else
	    begin
	      address[7:0]		= DataW;
	      state_new	= address_state_2;
	    end
	end

      address_state_2:
	begin
	  address[15:8]	= DataW;
	  state_new	= address_state_3;
	end

      address_state_3:	
	begin
	  address[23:16]	= DataW;
	  state_new	= address_state_4;
	end

      address_state_4:	
	begin
	  address[31:24]	= DataW;
	  state_new	= length_state;
	end

      length_state:		
	begin
	  data_length	= DataW;

	    if      	(controller_flop[7:5] == 3'b001)		// READ
	      begin
	 	write_en	        = 1;
		
		FIFO_in	= {12'b0, controller, Source_ID, address, data_length, 32'b0};
		state_new     	= IDLE;
	      end
	    else if	(controller_flop[7:5] == 3'b011)		// WRITE
	      begin
		state_new     = state_write_data_1;
	      end
		else 
		state_new     = IDLE;

	end

      state_write_data_1:		
	begin
	  if		(address == 32'hffff_fff0)
	    begin
	      chain[7:0]		= DataW;
	    end
  	  else if	(address == 32'hffff_fff4)
	    begin
	      start_chain[7:0]		= DataW;
	    end
	  else
	    begin
	      data_write[7:0]		= DataW;
	    end
	  state_new		= state_write_data_2;
	end

      state_write_data_2:		
	begin
	  if		(address == 32'hffff_fff0)
	    begin
	      chain[15:8]		= DataW;
	    end
  	  else if	(address == 32'hffff_fff4)
	    begin
	      start_chain[15:8]		= DataW;
	    end
	  else
	    begin
	      data_write[15:8]		= DataW;
	    end

	  state_new		= state_write_data_3;
	end

      state_write_data_3:		
	begin
	  if		(address == 32'hffff_fff0)
	    begin
	      chain[23:16]		= DataW;
	    end
  	  else if	(address == 32'hffff_fff4)
	    begin
	      start_chain[23:16]	= DataW;
	    end
	  else
	    begin
	      data_write[23:16]		= DataW;
	    end

	  state_new		= state_write_data_4;
	end

      state_write_data_4:		
	begin
	  if		(address == 32'hffff_fff0)
	    begin
	      chain[31:24]		= DataW;
	      Chain_Bit	= 0;
	    end
	  else if	(address == 32'hffff_fff4)
	    begin
	      start_chain[31:24]	= DataW;
	    end
	  else
	    begin
	      data_write[31:24]	= DataW;
	      write_en			= 1;
	      //read_en 			= 0;  
	      FIFO_in	  	= {12'b0, controller, Source_ID, address, data_length, data_write};
	    
	    end

	  state_new		= IDLE;
	end


      endcase
    end
// Third State Machine.... Bus Master....//


  always@(*)
    begin
      case(state_machine_2)
	IDLE_2:		
	  begin
	    
	    if(start_chain!=0)
	      begin
		
		n.CmdR  	= 1;

	  	n.DataR 	= 8'h00;
		state_new_2 	= BM_Link_Check;
	      end
	    else
	      begin
		master_mode = 0;	
		if(!fifo_empty) read_en			= 1;
	    	else read_en = 0;
	    
	    	c.RW		= 0; 
	    	c.Sel		= 0;  

	    	n.CmdR = 1;
	    	n.DataR = 0;

	    	controller_2    	= FIFO_out[87:80];		
	    	Source_ID_2    	= FIFO_out[79:72];	
	    	address_2         	= FIFO_out[71:40];
	    	data_length_2	= FIFO_out[39:32];
	    	data_2	   	= FIFO_out[31:0];
	    
	    	if		(controller_2[7:5] == 3'b001 && fifo_empty == 0) state_new_2 = Read_State_1;	
	    	else if		(controller_2[7:5] == 3'b011 && fifo_empty == 0) state_new_2 = Write_State;	
	    	else 				     	     state_new_2 = IDLE_2;		

	    	
	      	end
	    
	  end
	BM_Link_Check:			
	  begin
	    if((Chain_Bit==0)?chain : Link !=0) begin
	      state_new_2	= BM_code;
	    end
	    else  if((Chain_Bit==0)?chain : Link ==0) begin
	      start_chain	= 0;
	      state_new_2	= IDLE_2;
	    end
	
	  end

	BM_code:
	  begin
	    master_mode 	= 1;	

	    n.CmdR 		= 1;
	    n.DataR  		= 8'h23;

	    state_new_2  	= BM_Source_ID;
	  end

	BM_Source_ID:
	  begin
	    n.CmdR		= 0;
	    n.DataR		= 8'h01;

	    state_new_2	= BM_Address_1;
	  end

	BM_Address_1:
	  begin
	    n.DataR		= (Chain_Bit==0)?chain[7:0] : Link[7:0];

	    state_new_2	= BM_Address_2;
	  end

	BM_Address_2:
	  begin
	    n.DataR		= (Chain_Bit==0)?chain[15:8] : Link[15:8];

	    state_new_2	= BM_Address_3;
	  end

	BM_Address_3:
	  begin
	    n.DataR		= (Chain_Bit==0)?chain[23:16] : Link[23:16];

	    state_new_2	= BM_Address_4;
	  end

	BM_Address_4:
	  begin
	    n.DataR		= (Chain_Bit==0)?chain[31:24] : Link[31:24];

	    state_new_2	= BM_Len;
	  end

	BM_Len:		
	  begin
	    n.DataR		= 8'h20;

	    state_new_2	= BM_Read_Source_ID;
	  end

	BM_Read_Source_ID:	
	  begin
	    n.CmdR		= 1;
	    n.DataR		= 8'h00;

	    if(DataW == 8'h01)
	      begin
		state_new_2	= BM_Link_1;
	      end
	    else
	      begin
		state_new_2	= BM_Read_Source_ID;
	      end
	  end

	BM_Link_1:		
	  begin
	    Link[7:0]	= DataW;

	    state_new_2	= BM_Link_2;
	  end

	BM_Link_2:		
	  begin
	    Link[15:8]	= DataW;

	    state_new_2	= BM_Link_3;
	  end

	BM_Link_3:		
	  begin
	    Link[23:16]	= DataW;

	    state_new_2	= BM_Link_4;
	  end

	BM_Link_4:		
	  begin
	    Link[31:24]	= DataW;
	    Chain_Bit	= 1;
	    state_new_2	= BM_Seed_1;
	  end

	BM_Seed_1:		
	  begin
	    Seed[7:0]	= DataW;

	    state_new_2	= BM_Seed_2;
	  end

	BM_Seed_2:		
	  begin
	    Seed[15:8]	= DataW;

	    state_new_2	= BM_Seed_3;
	  end

	BM_Seed_3:		
	  begin
	    Seed[23:16]	= DataW;

	    state_new_2	= BM_Seed_4;
	  end

	BM_Seed_4:		
	  begin
	    Seed[31:24]	= DataW;

	    state_new_2	= BM_Ctrl_1;
	  end

	BM_Ctrl_1:
	  begin
	    Ctrl[7:0]	= DataW;

	    state_new_2	= BM_Ctrl_2;
	  end

	BM_Ctrl_2:
	  begin
	    Ctrl[15:8]	= DataW;

	    state_new_2	= BM_Ctrl_3;
	  end

	BM_Ctrl_3:
	  begin
	    Ctrl[23:16]	= DataW;

	    state_new_2	= BM_Ctrl_4;
	  end

	BM_Ctrl_4:
	  begin
	    Ctrl[31:24]	= DataW;

	    state_new_2	= BM_Polynomial_1;
	  end

	BM_Polynomial_1:
	  begin
	    Polynomial[7:0]	= DataW;

	    state_new_2	= BM_Polynomial_2;
	  end

	BM_Polynomial_2:
	  begin
	    Polynomial[15:8]	= DataW;

	    state_new_2	= BM_Polynomial_3;
	  end

	BM_Polynomial_3:
	  begin
	    Polynomial[23:16]	= DataW;

	    state_new_2	= BM_Polynomial_4;
	  end

	BM_Polynomial_4:
	  begin
	    Polynomial[31:24]	= DataW;

	    state_new_2	= BM_Data_1;
	  end

	BM_Data_1:
	  begin
	    Data_bm[7:0]	= DataW;

	    state_new_2	= BM_Data_2;
	  end

	BM_Data_2:
	  begin
	    Data_bm[15:8]	= DataW;

	    state_new_2	= BM_Data_3;
	  end

	BM_Data_3:
	  begin
	    Data_bm[23:16]	= DataW;

	    state_new_2	= BM_Data_4;
	  end

	BM_Data_4:
	  begin
	    Data_bm[31:24]	= DataW;

	    state_new_2	= BM_Len_1;
	  end

	BM_Len_1:
	  begin
	    Len[7:0]		= DataW;

	    state_new_2	= BM_Len_2;
	  end

	BM_Len_2:
	  begin
	    Len[15:8]	= DataW;

	    state_new_2	= BM_Len_3;
	  end

	BM_Len_3:
	  begin
	    Len[23:16]	= DataW;

	    state_new_2	= BM_Len_4;
	  end

	BM_Len_4:
	  begin
	    Len[31:24]	= DataW;

	    state_new_2	= BM_Result_1;
	    //state_new_2	= IDLE_2;
	  end

	BM_Result_1:
	  begin
	    Result[7:0]	= DataW;

	    state_new_2	= BM_Result_2;
	  end

	BM_Result_2:
	  begin
	    Result[15:8]	= DataW;

	    state_new_2	= BM_Result_3;
	  end

	BM_Result_3:
	  begin
	    Result[23:16]	= DataW;

	    state_new_2	= BM_Result_4;
	  end

	BM_Result_4:
	  begin
	    Result[31:24]	= DataW;

	    state_new_2	= BM_Message_1;
	  end

	BM_Message_1:
	  begin
	    Message[7:0]	= DataW;

	    state_new_2	= BM_Message_2;
	  end

	BM_Message_2:
	  begin
	    Message[15:8]	= DataW;

	    state_new_2	= BM_Message_3;
	  end

	BM_Message_3:
	  begin
	    Message[23:16]	= DataW;

	    state_new_2	= BM_Message_4;
	  end

	BM_Message_4:
	  begin
	    Message[31:24]	= DataW;

	    state_new_2	= write_crc_start_BM;
	  end

	write_crc_start_BM:
	  begin
	    c.addr		= 32'h4003_2008;
	    c.Sel		= 1;
	    c.RW		= 1;
	    c.data_wr		= (Ctrl | 32'h0200_0000);
	    
	    state_new_2	= CRC_SEED_Write;
	  end

	CRC_SEED_Write:
	  begin
	    c.addr		= 32'h4003_2000;
	    c.data_wr		= Seed;

	    state_new_2	= CRC_CTRL_Write;
	  end

	CRC_CTRL_Write:
	  begin
	    c.addr		= 32'h4003_2008;
	    c.data_wr		= Ctrl & 32'hfdff_ffff;

	    state_new_2	= CRC_POLY_Write;
	  end

	CRC_POLY_Write:		
	  begin
	    c.addr		= 32'h4003_2004;
	    c.data_wr		= Polynomial;

	    //state_new_2	= IDLE_2;
	    state_new_2	= BM_code_2;
	    
	  end



	BM_code_2:
	  begin
	    n.CmdR		= 1;
	    n.DataR		= 8'h23;

	    c.Sel		= 0;
	    c.RW		= 0;

	    
	   
	     
	    state_new_2	= BM_Source_ID_2;
	  end	

	BM_Source_ID_2:		
	  begin
	    n.CmdR		= 0;
	    n.DataR		= 8'h01;

	    state_new_2	= BM_Address_1_2;
	  end


	BM_Address_1_2:
	begin
	    n.CmdR		= 0;
	    n.DataR		= Data_bm[7:0];

	    state_new_2	= BM_Address_2_2;
	end

	BM_Address_2_2:
	  begin
	    n.DataR		= Data_bm[15:8];

	    state_new_2	= BM_Address_3_2;
	  end

	BM_Address_3_2:
	  begin
	    n.DataR		= Data_bm[23:16];

	    state_new_2	= BM_Address_4_2;
	  end

	BM_Address_4_2:
	  begin
	    n.DataR		= Data_bm[31:24];

	    state_new_2	= BM_Len2;
	  end

	BM_Len2:				
	  begin
	    if(Len_2>8'h80)
	      begin
		counter_crc	= 8'h80;
		//Len  	= Len_2 - 8'h80;
		
		n.DataR      	= 8'h80;
	      end
	    else
	      begin
	        counter_crc	= Len_2;
	        n.DataR		= Len_2;
	      end

	    state_new_2	= Cycle_Code_1;
	  end

	Cycle_Code_1: 		
	  begin
	    n.CmdR		= 1;
	    n.DataR		= 8'h00;
	    state_new_2	= Cycle_Source_ID;
	  end

	Cycle_Source_ID:			
	  begin
	    state_new_2    	= CRC_INPUT_1;
	  end

	CRC_INPUT_1:			
	  begin
	    n.CmdR = 1;
	    n.DataR = 8'h0;

	    c.Sel		= 0;
	    c.RW		= 0;

	    crc_data_write_back[7:0]	= DataW; 
	    state_new_2	= CRC_INPUT_2; 
	  end

	CRC_INPUT_2:		
	  begin
	    n.CmdR = 1;
	    n.DataR = 8'h0;

	    crc_data_write_back[15:8]	= DataW; 
	    state_new_2	= CRC_INPUT_3; 
	  end

	CRC_INPUT_3:		
	  begin
	    n.CmdR = 1;
	    n.DataR = 8'h0;

	    crc_data_write_back[23:16]	= DataW;
	    state_new_2	= CRC_INPUT_4; 
	  end

	CRC_INPUT_4:		
	  begin
	    n.CmdR = 1;
	    n.DataR = 8'h0;
	    Test_Bit = 1;

	    c.Sel		= 1;
	    c.RW		= 1;

	    crc_data_write_back[31:24]	= DataW; 

	    c.addr		= 32'h4003_2000;
	    c.data_wr		= crc_data_write_back;	

	    counter_crc		= counter_crc_flop - 8'h04;
	    Len		= Len_2 - 8'h04;

	    if(Len != 32'h0)
	      begin
	        if(counter_crc !=0)
	          begin
		    state_new_2	= CRC_INPUT_1;
	          end
	        else if(counter_crc ==0)
	          begin
		     Data_bm = Data_2 + 8'h80;
		    state_new_2	= BM_code_2;
	          end
	      end
	    else if(Len == 32'h0)
	      begin
		state_new_2		= BM_CRC_Check;
	      end
	  end

	BM_CRC_Check:			
	  begin
	    c.Sel 			= 1;
	    c.RW 			= 0;
	    c.addr			= 32'h4003_2000;

	    CRC_Check 			= c.data_rd;

	    state_new_2		= BM_Result_Send_1;
	  end

	BM_Result_Send_1:  
	  begin
	    c.Sel			= 0;
     	    c.RW			= 0;

	    n.CmdR			= 1;
	    n.DataR			= 8'h63;

	    state_new_2		= BM_Result_Send_2;
	  end

	BM_Result_Send_2:		
	  begin
	    n.CmdR			= 0;
	    n.DataR			= 8'h01;

	    state_new_2	= BM_Result_Send_3;
	  end

	BM_Result_Send_3:		
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Result[7:0];

	    state_new_2	= BM_Result_Send_4;
	  end

	BM_Result_Send_4:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Result[15:8];

	    state_new_2	= BM_Result_Send_5;
	  end

	BM_Result_Send_5:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Result[23:16];

	    state_new_2	= BM_Result_Send_6;
       	  end

	BM_Result_Send_6:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Result[31:24];

	    state_new_2		= BM_send_len;
       	  end

	BM_send_len:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= 8'h04; 

	    state_new_2	= BM_CRC_Check_Send_1;
       	  end

	BM_CRC_Check_Send_1:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= CRC_Check[7:0]; 

	    state_new_2		= BM_CRC_Check_Send_2;
       	  end

	BM_CRC_Check_Send_2:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= CRC_Check[15:8]; 

	    state_new_2		= BM_CRC_Check_Send_3;
       	  end

	BM_CRC_Check_Send_3:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= CRC_Check[23:16]; 

	    state_new_2		= BM_CRC_Check_Send_4;
       	  end

	BM_CRC_Check_Send_4:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= CRC_Check[31:24]; 

	    //state_new_2		= IDLE_2;
	    state_new_2		= BM_Code_Message;
       	  end

	BM_Code_Message:
	  begin
	    n.CmdR			= 1;
	    n.DataR			= 8'hc4;

	    state_new_2		= BM_Send_Message_1;
	  end

	BM_Send_Message_1:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Message[7:0];

	    state_new_2		= BM_Send_Message_2;
	  end

	BM_Send_Message_2:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Message[15:8];

	    state_new_2		= BM_Send_Message_3;
	  end

	BM_Send_Message_3:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Message[23:16];

	    state_new_2		= BM_Send_Message_4;
	  end

	BM_Send_Message_4:
	  begin
	    n.CmdR			= 0;
	    n.DataR			= Message[31:24];

	    state_new_2		= IDLE_2;
	  end


//-------------------------


	Read_State_1:			
	  begin
	    read_en			= 0;
	    c.RW		= 0;
	    c.Sel		= 1;
	    c.addr 		= address_2_flop;
	    flop1		= c.data_rd;

	    if (data_length_2 == 8'h04)	state_new_2 = response_state_read_code;
	    else
	      begin
		address_2		= address_2_flop + 4;
	 	state_new_2 	= Read_State_2;
	      end
	  end

	Read_State_2:			
	  begin
	    c.addr		= address_2_flop;
	    flop2		= c.data_rd;

	    if (data_length_2 == 8'h08)	state_new_2 = response_state_read_code;
	    else
	      begin
		address_2		= address_2_flop + 4;
		state_new_2	= Read_State_3;
	      end
	  end

	Read_State_3:			
	begin
	    c.addr		= address_2_flop;
	    flop3		= c.data_rd;
	
	    //state_new_2	= IDLE_2;
	    state_new_2	= response_state_read_code;
	  end


	response_state_read_code:		
	  begin
	    c.Sel 	 	= 1'b0; 

	    n.CmdR  		= 1'b1;
	    n.DataR 		= 8'h40;
            
	    //state_new_2	= IDLE_2;
   	    state_new_2 	= response_state_read_returnid;
	  end

	response_state_read_returnid:		
	  begin
	    n.CmdR 		= 1'b0;
	    n.DataR		= return_id_2;
	
	    state_new_2	= response_state_read_flop1_data1;
	  end

	response_state_read_flop1_data1:	
	  begin
	    //n.CmdR		= 1'b0;   
	    n.DataR		= flop1[7:0];

	    state_new_2	= response_state_read_flop1_data2;
	  end

	response_state_read_flop1_data2:	
	  begin
	    //n.CmdR		= 1'b0;	   
	    n.DataR		= flop1[15:8];

	    state_new_2	= response_state_read_flop1_data3;
	  end

	response_state_read_flop1_data3:	
	  begin
	    //n.CmdR		= 1'b0;   
	    n.DataR		= flop1[23:16];

	    state_new_2	= response_state_read_flop1_data4;
	  end

	response_state_read_flop1_data4:	
	  begin
	    //n.CmdR		= 1'b0;	 
	    n.DataR		= flop1[31:24];

	    if(data_length_2 == 8'h04)  state_new_2 =  END_READ;	
	    else
	      begin
		state_new_2	= response_state_read_flop2_data1;	
	      end
	  end

	response_state_read_flop2_data1:	
	  begin
	    //n.CmdR		= 1'b0;
	    n.DataR		= flop2[7:0];

	    state_new_2	= response_state_read_flop2_data2;
	  end

	response_state_read_flop2_data2:	
	  begin
	   
	    n.DataR		= flop2[15:8];

	    state_new_2	= response_state_read_flop2_data3;
	  end

	response_state_read_flop2_data3:	
	  begin
	    
	    n.DataR		= flop2[23:16];

	    state_new_2	= response_state_read_flop2_data4;
	  end

	response_state_read_flop2_data4:	
	  begin
	   
	    n.DataR		= flop2[31:24];

	    if(data_length_2 == 8'h08)  state_new_2 =  END_READ;	
	    else
	      begin
		state_new_2	= response_state_read_flop3_data1;	
	      end
	  end

	response_state_read_flop3_data1:	
	  begin
	   
	    n.DataR		= flop3[7:0];

	    state_new_2	= response_state_read_flop3_data2;
	  end

	response_state_read_flop3_data2:	
	  begin
	   
	    n.DataR		= flop3[15:8];

	    state_new_2	= response_state_read_flop3_data3;
	  end

	response_state_read_flop3_data3:	
	  begin
	   
	    n.DataR		= flop3[23:16];

	    state_new_2	= response_state_read_flop3_data4;
	  end

	response_state_read_flop3_data4:	
	  begin
	    //n.CmdR		= 1'b0;
	    n.DataR		= flop3[31:24];

	    //state_new_2	= IDLE_2;
	    state_new_2	= END_READ;
	  end

	END_READ:  
	  begin
	    //c.Sel		= 0; 
	    n.CmdR		= 1'b1;
	    n.DataR		= 8'hE0;   

	    state_new_2	= IDLE_2;
	  end

	Write_State:			
  	  begin
	    read_en		   = 0; 
	    c.addr	   = address_2_flop;
	    c.RW	   = 1;
	    c.Sel	   = 1;
	    c.data_wr	   = data_2;

	    state_new_2   = Write_Response_Code;
	  end

	Write_Response_Code:		
	  begin
	    c.Sel	   	= 0;
	    c.RW 	   	= 0;

	    n.CmdR  	= 1'b1;
	    n.DataR 		= 8'h80;

	    state_new_2	= Write_Response_Return_ID;
	  end

	Write_Response_Return_ID:	
	  begin
	    n.CmdR 		= 1'b0;
	    n.DataR		= return_id_2;
	
	    state_new_2	= IDLE_2;
	  end

      endcase
    end

endmodule :noc

// FIFO // 
module FIFO(clk, rst, write_en, data_in, read_en ,data_out , fifo_full, fifo_empty);

input bit clk, rst, write_en, read_en ;        
input  logic [99:0] data_in;
output logic [99:0] data_out;
output bit fifo_full, fifo_empty;


logic [11:0] write_address;
logic [11:0] read_address;
logic [11:0] fifo_count;

always @(posedge clk or posedge rst)

if (rst)
    write_address <= #1 'b0;  
else
    if (write_en == 1'b1 && (!fifo_full))                   
        write_address <= #1 write_address + 1'b1;

always @(posedge clk or posedge rst)
if (rst)
    read_address <= #1 'b0; 
else
    if (read_en == 1'b1 && (!fifo_empty))                   
        read_address <= #1 read_address +1'b1;

always@(posedge clk or posedge rst)
if (rst)
    fifo_count <= #1 'b0;   
else
    if (write_en== 1'b1 && read_en == 1'b0 && (!fifo_full))
        fifo_count <= #1 (fifo_count + 1);        
else
    if (write_en== 1'b0 && read_en == 1'b1 && (!fifo_empty))               
        fifo_count <= #1 (fifo_count - 1);



assign fifo_full  =  (read_address == write_address+1)? 1'b1:1'b0; 
assign fifo_empty =   (read_address == write_address) ? 1'b1:1'b0; 



mem32x64 mem1 (clk,write_address,data_in,write_en,read_address,data_out);

endmodule : FIFO

// Memory //
module mem32x64(input bit clk,input logic [11:0] waddress,
    input logic [99:0] wdata, input bit write,
    input logic [11:0] raddress, output logic [99:0] rdata);

logic [99:0] mem[0:4096];

logic [99:0] rdatax;

//logic [99:0] w0,w1,w2,w3,w4,w5,w6,w7;

assign rdata = rdatax;

always @(*) begin
  rdatax <= #2 mem[raddress];
end

always @(posedge(clk)) begin
  if(write) begin
    mem[waddress]<=#2 wdata;
  end
end

endmodule : mem32x64
