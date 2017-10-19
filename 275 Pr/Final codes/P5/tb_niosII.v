module tb_niosII();
reg clk, rst;
reg [31:0] PC;
integer i,j,f;
reg debug;
reg [31:0] r2, r3, r4, r5, r6, r7, r8;
/*--------   Fetch Stage   -------------*/
wire [31:0] fetch_dec_PC, fetch_dec_instruction, offset;
wire jump_in,stall;
/*--------   Deocde Stage  -------------*/
wire [63:0] dec_exe_reg_data;
wire [31:0] dec_exe_PC, dec_exe_mem_wr_data, dec_exe_wb_reg_wr_data, exe_dec_reslt_data;
wire [4:0] dec_exe_ctrl_sgs, dec_exe_reg_wr_add;
wire [1:0] dec_exe_mux2_hctrl, dec_exe_mux1_hctrl;
/*-------- Execution stage -------------*/
wire [31:0]  exe_mem_wr_data, exe_mem_reslt_data_out, exe_mem_memory_rd_wr_add, exe_fetch_PC_out;
wire [2:0] exe_mem_ctrl_sgs;
wire [4:0] exe_mem_reg_wr_add, exe_hctrl_reg_wr_add_st;
/*--------  Memory Stage   ------------*/
wire [31:0] mem_wb_memory_data, mem_exe_reslt_data, mem_wb_reg_wr_data; 
wire [4:0] mem_wb_reg_wr_add,  mem_hctrl_reg_wr_add;
wire mem_wb_reg_wr_en, mem_wb_rm_data_sel;
/*-------- Write Back Stage -----------*/
wire [31:0] wb_exe_reslt_data, wb_dec_reg_wr_data;

fetch fetch_unit (fetch_dec_PC, 
                  fetch_dec_instruction, 
                  clk, 
                  rst,
                  jump_in, 
                  stall,                  
                  offset);

decode dec_unit (jump_in,
                 offset,
                 stall,
                 dec_exe_ctrl_sgs, 
                 dec_exe_reg_data, 
                 dec_exe_mem_wr_data, 
                 dec_exe_reg_wr_add,
                 exe_hctrl_reg_wr_add_st, 
                 mem_hctrl_reg_wr_add, 
                 clk, 
                 rst, 
                 fetch_dec_instruction, 
                 mem_wb_reg_wr_en, 
                 mem_wb_reg_wr_add, 
                 wb_dec_reg_wr_data);

execute exe_unit (
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
                  dec_exe_reg_wr_add);

memory_stage mem_unit (mem_wb_memory_data, 
                       mem_wb_reg_wr_data, 
                       mem_wb_reg_wr_en, 
                       mem_wb_rm_data_sel, 
                       mem_wb_reg_wr_add, 
                       mem_hctrl_reg_wr_add, 
                       clk, 
                       rst,  
                       exe_mem_wr_data, 
                       exe_mem_reg_wr_add, 
                       exe_mem_reslt_data_out, 
                       exe_mem_ctrl_sgs);

assign wb_dec_reg_wr_data = (mem_wb_rm_data_sel)?mem_wb_memory_data:mem_wb_reg_wr_data;
assign wb_exe_reslt_data = wb_dec_reg_wr_data;


always #5 clk = ~clk;

initial begin
  f = $fopen("output.txt","w");
 // $display("  status    Processor cycles        PC       Instruction           R4         R2        R3         R8        R5");
  $fwrite(f,"status   Processor cycles   PC     Instruction            R2         R3        R4         R5         R6         R7         R8 \n");
  clk = 0;
  rst = 1;
  debug = 1;
  i = 0;
  j = 0;
  #104
  rst = 0;
end

always @(posedge clk or posedge rst) begin
     if (rst) begin
       i = 0;
      // $display("reset             0                 0              0");
       //$fwrite(f,"reset %d %d %d   reset  %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
     end
     else begin
     PC = fetch_dec_PC;
     r2 = dec_unit.register_unit.register_file[2];
     r3 = dec_unit.register_unit.register_file[3];
     r4 = dec_unit.register_unit.register_file[4];
     r5 = dec_unit.register_unit.register_file[5];
     r6 = dec_unit.register_unit.register_file[6];
     r7 = dec_unit.register_unit.register_file[7];
     r8 = dec_unit.register_unit.register_file[8];
     i = i + 1;
     case(PC)
       0 : begin 
           //$display("running %d        %d          orhi r2, r0,(0) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   orhi r2, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       4: begin
          //$display("running %d        %d           ori r2, r2,(8) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   ori r2, r2,(8)  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
       8: begin
            //$display("running %d        %d          orhi r3, r0,(0) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   orhi r3, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
         end
       12: begin
           // $display("running %d        %d          ori r3, r3,(32) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   ori r3, r3,(32) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       16: begin
            $display("running %d        %d          orhi r4, r0,(0) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   orhi r4, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       20: begin
            $display("running %d        %d           ori r4, r0,(6) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   ori r4, r0,(6)  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       24: begin
            $display("running %d        %d            ldw r4, 0(r4) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   ldw r4, 0(r4)   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       28: begin
            $display("running %d        %d          add r5, r0, r0 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   add r5, r0, r0  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       32: begin
            $display("running %d        %d           ldw r6, 0(r2) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d Loop:ldw r6, 0(r2)%d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       36: begin
            $display("running %d        %d           ldw r7, 0(r3) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
            $fwrite(f,"running %d %d   ldw r7, 0(r3))  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      40: begin
         $display("running %d        %d          mul r8, r6, r7  %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
         $fwrite(f,"running %d %d  mul r8, r6, r7   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      44: begin
          $display("running %d        %d           add r5, r5, r8 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  add r5, r5, r8   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      48: begin
          $display("running %d        %d           addi r2, r2, 4 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  addi r2, r2, 4   %d %d %d %d %d %d %d\n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      52: begin
          $display("running %d        %d           addi r3, r3, 4 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  addi r3, r3, 4   %d %d %d %d %d %d %d\n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      56: begin
          $display("running %d        %d          addi r4, r4, -1 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  addi r4, r4, -1  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      60: begin
          $display("running %d        %d         blt r0, r4, (-32) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  blt r0, r4, Loop %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      64: begin
          $display("running %d        %d             stw r5, 0(r0) %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  stw r5, 0(r0)    %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      68: begin
          $display("running %d        %d                   br -4 %d %d %d %d %d %d %d",i,PC,r2, r3, r4, r5, r6, r7, r8);
          $fwrite(f,"running %d %d  stop: br stop    %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      //32'hx: $display("   reset %d        %d     system off",i,PC); 
      default: $display("system off   PC = %d",PC);
    endcase
    if (PC >= 68 && dec_unit.register_unit.register_file[4]==0) begin
      $display("dot product = %d ",dec_unit.register_unit.register_file[5]);
      $display("simulation finished");
      $fwrite(f,"dot product = %d \n",dec_unit.register_unit.register_file[5]);
      $fwrite(f,"simulation finished");
      $fclose("output.txt");
      //$finish();
    end
end
end
endmodule
