module execute (exe_dec_reslt_data,
                exe_mem_wr_data,
                exe_mem_reg_wr_add,
                exe_mem_reslt_data_out, 
                exe_mem_ctrl_sgs,
                exe_hctrl_reg_wr_add_st,  
                /*-----input ports-----*/
                clk, 
                rst,
                dec_exe_mem_wr_data,                
                dec_exe_ctrl_sgs,
                dec_exe_reg_data,       
                dec_exe_reg_wr_add,
                //mem_exe_memory_data,
                mem_exe_reslt_data,
                wb_exe_reslt_data,
                wb_dec_exe_reslt_data,
                // hazard control signals
                mux2_hctr,
                mux1_hctr
                );
output reg [31:0] exe_mem_wr_data, exe_dec_reslt_data;
output reg [31:0] exe_mem_reslt_data_out;
output reg [4:0] exe_hctrl_reg_wr_add_st, exe_mem_reg_wr_add;
output reg [2:0] exe_mem_ctrl_sgs;
input clk, rst;
input [4:0] dec_exe_ctrl_sgs, dec_exe_reg_wr_add;
input [63:0] dec_exe_reg_data;
input [31:0] wb_exe_reslt_data,dec_exe_mem_wr_data, mem_exe_reslt_data, wb_dec_exe_reslt_data;
input [1:0] mux2_hctr, mux1_hctr;

reg [31:0]  _exe_mem_wr_data, _exe_mem_reslt_data_out, _exe_mem_memory_rd_wr_add;
reg [2:0] _exe_mem_ctrl_sgs;
reg [1:0] alu_ctrl; 
reg [31:0] data1_reg, data2_reg, reslt_data_out, data2, data1;

always @(posedge clk or posedge rst) begin : execution_stage_flipflop
  if(rst) begin
    exe_mem_wr_data          <= #1 0;
    exe_mem_reg_wr_add       <= #1 0;
    exe_mem_reslt_data_out   <= #1 0; 
    exe_mem_ctrl_sgs         <= #1 0;
  end else begin
    exe_mem_wr_data          <= #1 _exe_mem_wr_data;
    exe_mem_reg_wr_add       <= #1 dec_exe_reg_wr_add;
    exe_mem_reslt_data_out   <= #1 _exe_mem_reslt_data_out; 
    exe_mem_ctrl_sgs         <= #1 _exe_mem_ctrl_sgs;
  end
end

always @(*) begin : execution_stage_signals
  _exe_mem_wr_data        = dec_exe_mem_wr_data;
  _exe_mem_ctrl_sgs       = dec_exe_ctrl_sgs[4:2];
  exe_hctrl_reg_wr_add_st = dec_exe_reg_wr_add;
  {data1_reg,data2_reg}   = dec_exe_reg_data;  
  alu_ctrl                = dec_exe_ctrl_sgs[1:0];
  exe_dec_reslt_data = reslt_data_out;
end

always @(*) begin : hazard_control_mux1
  case(mux2_hctr)
    0: data2 = data2_reg;
    1: data2 = mem_exe_reslt_data;
    2: data2 = wb_exe_reslt_data;
    3: data2 = wb_dec_exe_reslt_data;
    default: data2 = data2_reg;
  endcase
end
always @(*) begin : hazard_control_mux2
  case(mux1_hctr)
    0: data1 = data1_reg;
    1: data1 = mem_exe_reslt_data;
    2: data1 = wb_exe_reslt_data;
    3: data1 = wb_dec_exe_reslt_data;
    default: data1 = data1_reg;
  endcase
end
/*----------- ALU -------------------*/
always @(*) begin : ALU 
  case(alu_ctrl)
    0 : reslt_data_out = data1 + data2;   // add
    1 : reslt_data_out = data1 | data2;   // or
    2 : reslt_data_out = data1 * data2;   // mul
    3 : reslt_data_out = data2;           // used for store operation
    default : reslt_data_out = 0;         // default
  endcase
  _exe_mem_reslt_data_out       = reslt_data_out;
end
endmodule

    
