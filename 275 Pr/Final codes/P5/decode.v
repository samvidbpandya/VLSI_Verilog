module decode (/*----------output ports------------*/
               // to execution unit (passed through DFF)
               branch_taken,
               dec_fetch_br_PC,
               stallfetch,
               dec_exe_ctrl_sgs,  //reg_wr-mem_wr-mem_rd-alu_ctrl
               dec_exe_reg_data,  //64bit data1 and data2
               dec_exe_mem_wr_data,
               dec_exe_reg_wr_add,  // 5 bit
               // for hazard unit
               exe_reg_add,
               mem_reg_add,
               /*----input ports----*/
               clk,
               rst,
               fetch_dec_instruction,
               wb_dec_reg_wr_en,
               wb_dec_reg_wr_add,
               wb_dec_reg_wr_data
               );
output reg [4:0] dec_exe_ctrl_sgs, dec_exe_reg_wr_add;
output reg [63:0] dec_exe_reg_data;
output reg [31:0] dec_exe_mem_wr_data, dec_fetch_br_PC;
output reg branch_taken, stallfetch;
input rst, clk, wb_dec_reg_wr_en;
input [31:0] fetch_dec_instruction, wb_dec_reg_wr_data;
input [4:0] wb_dec_reg_wr_add;
input [4:0] exe_reg_add, mem_reg_add;
reg [4:0] _dec_exe_ctrl_sgs, _dec_exe_reg_wr_add, rA, rB, rC, reg_wr_add;
reg [63:0] _dec_exe_reg_data;
reg [31:0] _dec_exe_PC, _dec_exe_mem_wr_data, data1, data2, mem_wr_data, PC_br;
reg [5:0] opcode;
reg [15:0] imm16;
reg [10:0] opx;
reg reg_wr,mem_wr,mem_rd;
reg [1:0] alu_ctrl, exe_mux2_hctrl, exe_mux1_hctrl;
reg [7:0] memory_rd_add, memory_wr_add;
wire [31:0] reg_rd_data1,reg_rd_data2;
reg Itype, Jtype, Rtype, stall;
parameter ADD = 2'b00;
parameter OR = 2'b01;
parameter MUL = 2'b10;
parameter  PASS_DATA = 2'b11;

always @(posedge clk or posedge rst) begin : decode_stage_flipflop
  if (rst) begin
    dec_exe_ctrl_sgs    <= #1 0;
    dec_exe_reg_data    <= #1 0;
    dec_exe_mem_wr_data <= #1 0;
    dec_exe_reg_wr_add  <= #1 0;
  end else begin
    if (stall) begin
      dec_exe_ctrl_sgs    <= #1 0;
    dec_exe_reg_data    <= #1 0;
    dec_exe_mem_wr_data <= #1 0;
    dec_exe_reg_wr_add  <= #1 0;
   end else begin
    dec_exe_ctrl_sgs    <= #1 _dec_exe_ctrl_sgs;
    dec_exe_reg_data    <= #1 _dec_exe_reg_data;
    dec_exe_mem_wr_data <= #1 _dec_exe_mem_wr_data;
    dec_exe_reg_wr_add  <= #1 _dec_exe_reg_wr_add;
  end
end
end

always @(*) begin : decode_stage_signals
  opcode                  = fetch_dec_instruction[5:0];
  rA                      = fetch_dec_instruction[31:27];
  rB                      = fetch_dec_instruction[26:22];
  rC                      = fetch_dec_instruction[21:17];
  imm16                   = fetch_dec_instruction[21:6];
  opx                     = fetch_dec_instruction[16:6];
  _dec_exe_reg_data        = {data1,data2};
  _dec_exe_ctrl_sgs        = {reg_wr,mem_wr,mem_rd,alu_ctrl};
  _dec_exe_reg_wr_add      = reg_wr_add;
  dec_fetch_br_PC          = PC_br;
  stallfetch = stall;
end

register_file register_unit (reg_rd_data1, reg_rd_data2, clk, rst, wb_dec_reg_wr_en, wb_dec_reg_wr_add, wb_dec_reg_wr_data, rB, rA);

always @(*) begin : decode_control_logic
  Itype       = 0;
  Jtype       = 0;
  Rtype       = 0;
  data2       = 0;
  data1       = 0;
  reg_wr_add  = 0;
  alu_ctrl    = 0;
  reg_wr      = 0;
  mem_wr      = 0;
  mem_rd      = 0;
  mem_wr_data = 0;
  PC_br       = 0;
  branch_taken = 0;
  case(opcode)
    4  : begin //addi
           data2         = reg_rd_data2;
           data1         = {{16{imm16[15]}},imm16};
           reg_wr_add    = rB;
           reg_wr        = 1;
           alu_ctrl      = ADD;
           Itype         = 1;
         end
    6  : begin //br
           PC_br  = {{32{imm16[15]}},imm16};
           branch_taken = 1;
         end
    14 : begin //ori
           data2         = reg_rd_data2;
           data1         = {{16{1'b0}},imm16};
           reg_wr_add    = rB;
           alu_ctrl      = OR;
           reg_wr        = 1;
           Itype         = 1;
         end
    21 : begin //stw   //use eparate data path for memory data write (to avoid adder to calculate effective address)
           data2         = reg_rd_data2;
           data1         = {{16{imm16[15]}},imm16};
           reg_wr_add    = rB;
           alu_ctrl      = ADD;
           mem_wr        = 1;
           mem_wr_data   = reg_rd_data1;
           Itype       = 1;
         end
    22 : begin //blt
           PC_br  = {{32{imm16[15]}},imm16};
           if (reg_rd_data2 < reg_rd_data1)
             branch_taken = 1;
           else
             branch_taken = 0;
         end
    23 : begin // ldw
           data2         = reg_rd_data2;
           data1         = {{16{imm16[15]}},imm16};
           reg_wr_add    = rB;
           alu_ctrl      = ADD;
           reg_wr        = 1;
           mem_rd        = 1;
           Itype       = 1;
         end   
    34 : begin //orhi
           data2         = reg_rd_data2;
           data1         = {imm16,{16{1'b0}}};
           reg_wr_add    = rB;
           alu_ctrl      = OR;
           reg_wr        = 1;
           Itype         = 1;
         end
    58 : begin
           if(opx == 49) begin
             data1         = reg_rd_data1;
             data2         = reg_rd_data2;
             reg_wr_add    = rC;
             alu_ctrl      = ADD;
             reg_wr        = 1;
             Jtype = 1;
           end else begin 
             if (opx == 39) begin
               data1         = reg_rd_data1;
               data2         = reg_rd_data2;
               reg_wr_add    = rC;
               alu_ctrl      = MUL;
               reg_wr        = 1;
               Jtype = 1;
             end
           end
         end
    default : begin
                Itype       = 0;
                Jtype       = 0;
                Rtype       = 0;
                data2       = 0;
                data1       = 0;
                reg_wr_add  = 0;
                alu_ctrl    = 0;
                reg_wr      = 0;
                mem_wr      = 0;
                mem_rd      = 0;
                mem_wr_data = 0;
                PC_br       = 0;
                branch_taken = 0;
              end
    endcase
    _dec_exe_mem_wr_data = mem_wr_data;
 end

always @(*) begin : decode_hazard_logic
  stall = 0;
  case({Jtype,Itype})
    0: stall = 0;
    1: begin //Itype
         if(rA != 0) begin
         if (exe_reg_add == rA || mem_reg_add == rA || wb_dec_reg_wr_add == rA)
           stall = 1;
         else
           stall = 0;
          end
       end
    2: begin // Rtype
         if(rA != 0 || rB != 0) begin
         if (exe_reg_add == rA || mem_reg_add == rA || wb_dec_reg_wr_add == rA)
           stall = 1;
         else
           stall = 0;
           if (exe_reg_add == rB || mem_reg_add == rB || wb_dec_reg_wr_add == rB)
           stall = 1;
         else
           stall = 0;
           end
       end
    default: begin 
               stall = 0;
             end
  endcase
end

endmodule
 
