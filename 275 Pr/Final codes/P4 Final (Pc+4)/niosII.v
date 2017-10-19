
module niosII(clk, rst);
input clk, rst;

/*--------   Fetch Stage   -------------*/
wire [31:0] PC, fetch_dec_instruction, offset;
wire jump_in;

/*--------   Deocde Stage  -------------*/
wire [63:0] dec_exe_reg_data;
wire [31:0] dec_exe_mem_wr_data, dec_exe_wb_reg_wr_data, exe_dec_reslt_data;
wire [4:0] dec_exe_ctrl_sgs, dec_exe_reg_wr_add;
wire [1:0] dec_exe_mux2_hctrl, dec_exe_mux1_hctrl;

/*-------- Execution stage -------------*/
wire [31:0]  exe_mem_wr_data, exe_mem_reslt_data_out;
wire [2:0] exe_mem_ctrl_sgs;
wire [4:0] exe_mem_reg_wr_add, exe_hctrl_reg_wr_add_st;

/*--------  Memory Stage   ------------*/
wire [31:0] mem_wb_memory_data, mem_exe_reslt_data, mem_wb_reg_wr_data; 
wire [4:0] mem_wb_reg_wr_add,  mem_hctrl_reg_wr_add;
wire mem_wb_reg_wr_en, mem_wb_rm_data_sel;

/*-------- Write Back Stage -----------*/
wire [31:0] wb_exe_reslt_data, wb_dec_reg_wr_data;
wire [4:0] wb_dec_reg_wr_add;
wire wb_dec_reg_wr_en;

fetch fetch_unit (PC, 
                  fetch_dec_instruction, 
                  clk, 
                  rst, 
                  jump_in,                
                  offset);

decode dec_unit (jump_in,
                 offset, 
                 dec_exe_mux1_hctrl,
                 dec_exe_mux2_hctrl, 
                 dec_exe_ctrl_sgs, 
                 dec_exe_reg_data, 
                 dec_exe_mem_wr_data, 
                 dec_exe_reg_wr_add,
                 dec_exe_wb_reg_wr_data,
                 exe_hctrl_reg_wr_add_st, 
                 mem_hctrl_reg_wr_add, 
                 clk, 
                 rst, 
                 fetch_dec_instruction, 
                 wb_dec_reg_wr_en, 
                 wb_dec_reg_wr_add, 
                 wb_dec_reg_wr_data,
                 exe_dec_reslt_data);

execute exe_unit ( exe_dec_reslt_data,
                  exe_mem_wr_data, 
                  exe_mem_reg_wr_add, 
                  exe_mem_reslt_data_out, 
                  exe_mem_ctrl_sgs,
                  exe_hctrl_reg_wr_add_st, 
                  clk,
                  rst, 
                  dec_exe_mem_wr_data,
                  dec_exe_ctrl_sgs, 
                  dec_exe_reg_data, 
                  dec_exe_reg_wr_add,
                  mem_exe_reslt_data, 
                  wb_exe_reslt_data, 
                  dec_exe_wb_reg_wr_data, 
                  dec_exe_mux2_hctrl,
                  dec_exe_mux1_hctrl);

memory mem_unit (mem_wb_memory_data, 
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
                       
writeback wb_unit ( wb_dec_reg_wr_data, 
                    wb_exe_reslt_data, 
                    wb_dec_reg_wr_en, 
                    wb_dec_reg_wr_add,
                    mem_wb_memory_data, 
                    mem_wb_reg_wr_data, 
                    mem_wb_reg_wr_en, 
                    mem_wb_rm_data_sel, 
                    mem_wb_reg_wr_add);

endmodule





