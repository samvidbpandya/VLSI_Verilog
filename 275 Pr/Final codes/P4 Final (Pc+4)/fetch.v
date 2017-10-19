
module fetch(PC,instruction, clk, rst, jump_in, offset);

output reg [31:0] PC;
output reg [31:0] instruction;
input clk, rst, jump_in;
input [31:0] offset;
reg [7:0] instruction_memory [0:4096];
reg [31:0] pc, _PC, PC_d, instruction_d;
/*
initial begin
$readmemh("instruction.txt",instruction_memory,0,79);
end
*/
always @(posedge clk or posedge rst) begin : fetch_stage_flipflop
  if (rst) begin
    _PC <= #1 32'hfffffffc;
    instruction <= #1 0;
    PC <= #1 0;
  end else begin
    _PC <= #1 PC_d;
    instruction <= #1 instruction_d;
    PC <= #1 PC_d;
  end
end

always @(*) begin : fetch_stage_program_counter
  PC_d = 0;
  PC_d = (jump_in)?(_PC+4+offset):(_PC + 4);
  instruction_d = {instruction_memory[PC_d+3],instruction_memory[PC_d+2],instruction_memory[PC_d+1],instruction_memory[PC_d]};
end
endmodule