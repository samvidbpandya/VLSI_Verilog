module register_file (rd_data1, rd_data2, clk, rst, wr_en, wr_address, wr_data, rd_address1, rd_address2);
output reg [31:0] rd_data1, rd_data2;
input clk, rst, wr_en;
input [4:0] wr_address, rd_address1, rd_address2;
input [31:0] wr_data;
reg [31:0] register_file [0:31];
integer i;
always @(posedge clk or posedge rst) begin :register_file_write_port
  if(rst) begin
    register_file[0] <= #1 32'b0;
    register_file[1] <= #1 32'b0;
    register_file[2] <= #1 32'b0;
    register_file[3] <= #1 32'b0;
    register_file[4] <= #1 32'b0;
    register_file[5] <= #1 32'b0;
    register_file[6] <= #1 32'b0;
    register_file[7] <= #1 32'b0;
    register_file[8] <= #1 32'b0;
    register_file[9] <= #1 32'b0;
    register_file[10] <= #1 32'b0;
    register_file[11] <= #1 32'b0;
    register_file[12] <= #1 32'b0;
    register_file[13] <= #1 32'b0;
    register_file[14] <= #1 32'b0;
    register_file[15] <= #1 32'b0;
    register_file[16] <= #1 32'b0;
    register_file[17] <= #1 32'b0;
    register_file[18] <= #1 32'b0;
    register_file[19] <= #1 32'b0;
    register_file[20] <= #1 32'b0;
    register_file[21] <= #1 32'b0;
    register_file[22] <= #1 32'b0;
    register_file[23] <= #1 32'b0;
    register_file[24] <= #1 32'b0;
    register_file[25] <= #1 32'b0;
    register_file[26] <= #1 32'b0;
    register_file[27] <= #1 32'b0;
    register_file[28] <= #1 32'b0;
    register_file[29] <= #1 32'b0;
    register_file[30] <= #1 32'b0;
    register_file[31] <= #1 32'b0;
  end else begin
    if(wr_en)
      register_file[wr_address] <= wr_data;
  end
end
always @(negedge clk or posedge rst) begin : register_file_read_port
  if (rst) begin
    rd_data1 <= #1 0;
    rd_data2 <= #1 0;
  end else begin
    rd_data1 = register_file[rd_address1];
    rd_data2 = register_file[rd_address2];
  end
end
endmodule
      