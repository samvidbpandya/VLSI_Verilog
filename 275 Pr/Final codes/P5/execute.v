module execute (exe_mem_wr_data,
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
                dec_exe_reg_wr_add
                );
output reg [31:0] exe_mem_wr_data;
output reg [31:0] exe_mem_reslt_data_out;
output reg [4:0] exe_hctrl_reg_wr_add_st, exe_mem_reg_wr_add;
output reg [2:0] exe_mem_ctrl_sgs;
input clk, rst;
input [4:0] dec_exe_ctrl_sgs, dec_exe_reg_wr_add;
input [63:0] dec_exe_reg_data;
input [31:0] dec_exe_mem_wr_data;

reg [31:0]  _exe_mem_wr_data, _exe_mem_reslt_data_out, _exe_mem_memory_rd_wr_add;
reg [2:0] _exe_mem_ctrl_sgs;
reg [1:0] alu_ctrl; 
reg [31:0] data2, data1;

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
  {data1,data2}           = dec_exe_reg_data;  
  alu_ctrl                = dec_exe_ctrl_sgs[1:0];
end

/*----------- ALU -------------------*/
always @(*) begin : ALU 
  case(alu_ctrl)
    0 : _exe_mem_reslt_data_out = data1 + data2;   // add
    1 : _exe_mem_reslt_data_out = data1 | data2;   // or
    2 : _exe_mem_reslt_data_out = data1 * data2;   // mul
    3 : _exe_mem_reslt_data_out = data2;           // used for store operation
    default : _exe_mem_reslt_data_out = 0;         // default
  endcase
end
endmodule

    
