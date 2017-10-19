module writeback( wb_dec_reg_wr_data, 
                  wb_exe_reslt_data, 
                  wb_dec_reg_wr_en, 
                  wb_dec_reg_wr_add,
                  mem_wb_memory_data, 
                  mem_wb_reg_wr_data, 
                  mem_wb_reg_wr_en, 
                  mem_wb_rm_data_sel, 
                  mem_wb_reg_wr_add);
                  
output [31:0] wb_dec_reg_wr_data, wb_exe_reslt_data;
output wb_dec_reg_wr_en;
output [4:0] wb_dec_reg_wr_add;

input [31:0] mem_wb_memory_data, mem_wb_reg_wr_data;
input mem_wb_reg_wr_en, mem_wb_rm_data_sel;
input [4:0] mem_wb_reg_wr_add;

assign wb_dec_reg_wr_data = (mem_wb_rm_data_sel)?mem_wb_memory_data:mem_wb_reg_wr_data;
assign wb_exe_reslt_data = wb_dec_reg_wr_data;
assign wb_dec_reg_wr_en = mem_wb_reg_wr_en;
assign wb_dec_reg_wr_add = mem_wb_reg_wr_add;
endmodule