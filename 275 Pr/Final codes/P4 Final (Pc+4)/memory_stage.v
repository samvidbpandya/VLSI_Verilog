module memory (mem_wb_memory_data, 
               mem_wb_reg_wr_data, 
               mem_wb_reg_wr_en,
               mem_wb_rm_data_sel,                    
               mem_wb_reg_wr_add,
               mem_exe_reslt_data,
               mem_hctrl_reg_wr_add,
               clk, 
               rst,
               exe_mem_wr_data,
               exe_mem_reg_wr_add,
               exe_mem_reslt_data_out, 
               exe_mem_ctrl_sgs);

output reg [31:0] mem_wb_memory_data, mem_wb_reg_wr_data;
output reg [4:0] mem_wb_reg_wr_add, mem_hctrl_reg_wr_add;
output reg mem_wb_reg_wr_en, mem_wb_rm_data_sel;
output [31:0] mem_exe_reslt_data;

input clk, rst;
input [2:0] exe_mem_ctrl_sgs;
input [31:0] exe_mem_wr_data, exe_mem_reslt_data_out;
input [4:0] exe_mem_reg_wr_add;

reg [7:0] data_memory [0:4095];
wire reg_wr, mem_wr, mem_rd;
wire [31:0] memdata;

initial begin
  $readmemh("main_memory.txt",data_memory,0,4095);
end
assign reg_wr = exe_mem_ctrl_sgs[2];
assign mem_wr = exe_mem_ctrl_sgs[1];
assign mem_rd = exe_mem_ctrl_sgs[0];
assign memdata = {data_memory[exe_mem_reslt_data_out+3],data_memory[exe_mem_reslt_data_out+2],data_memory[exe_mem_reslt_data_out+1],data_memory[exe_mem_reslt_data_out]};
assign mem_exe_reslt_data = (mem_rd)?memdata:exe_mem_reslt_data_out;

always @(*) begin
  mem_hctrl_reg_wr_add       = exe_mem_reg_wr_add;
end
always @(posedge clk or posedge rst) begin : memory_stage_flipflop
  if(rst) begin
    mem_wb_reg_wr_data <= #1 0;
    mem_wb_reg_wr_en   <= #1 0;
    mem_wb_reg_wr_add  <= #1 0;
    mem_wb_rm_data_sel <= #1 0;
  end else begin
    mem_wb_reg_wr_data <= #1 exe_mem_reslt_data_out;
    mem_wb_reg_wr_en   <= #1 reg_wr;
    mem_wb_reg_wr_add  <= #1 exe_mem_reg_wr_add;
    mem_wb_rm_data_sel <= #1 mem_rd;
    end
end

always @(posedge clk) begin : memory_write_port
    if(mem_wr)begin
      data_memory[exe_mem_reslt_data_out] <= exe_mem_wr_data[7:0];
      data_memory[exe_mem_reslt_data_out+1] <= exe_mem_wr_data[15:8];
      data_memory[exe_mem_reslt_data_out+2] <= exe_mem_wr_data[23:16];
      data_memory[exe_mem_reslt_data_out+3] <= exe_mem_wr_data[31:24];
    end
end

always @(posedge clk) begin : memory_read_port
    if(mem_rd)
      mem_wb_memory_data <= #1 {data_memory[exe_mem_reslt_data_out+3],data_memory[exe_mem_reslt_data_out+2],data_memory[exe_mem_reslt_data_out+1],data_memory[exe_mem_reslt_data_out]};
    else
      mem_wb_memory_data <= #1 0;
end

endmodule