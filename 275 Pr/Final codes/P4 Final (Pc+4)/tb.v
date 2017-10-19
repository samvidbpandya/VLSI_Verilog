module tb();

reg [7:0] main_memory [0:4095];
wire reg_wr, mem_wr, mem_rd;
reg [31:0] memdata;
integer i,j;
initial begin
  $readmemh("main_memory.txt",main_memory,0,4095);
  i = 8;
  j = 32;
  memdata = 0;
  repeat(6) begin
   $display(main_memory[i]);
  $display(main_memory[j]);
   memdata = memdata + main_memory[i] * main_memory[j];
   $display(memdata);
   i = i + 4;
   j = j + 4;
  end
   $display(memdata);
  $finish();
end

10
22
00
c0
00c00022

endmodule
