module tb_niosII();
reg clk, rst;
reg [31:0] PC;
integer i,j,f,k,result;
reg [31:0] dot_product;
reg [31:0] r2, r3, r4, r5, r6, r7, r8, product, sum;

niosII dut (clk,rst);

always #5 clk = ~clk;

initial begin
  f = $fopen("output.txt","w");
  $fwrite(f,"status   Processor cycles   PC     Instruction            R2         R3        R4         R5         R6         R7         R8 dotproduct_summation N \n");
  clk = 0;
  rst = 1;
  i = 0;
  j = 0;
  sum = 0;
  product = 0;
  dot_product = 0;
  result = 131;
  #104
  rst = 0;
end

always @(posedge clk or posedge rst) begin
     if (rst) begin
       i = 0;
     end
     else begin
     PC = dut.PC;
     r2 = dut.dec_unit.register_unit.register_file[2];
     r3 = dut.dec_unit.register_unit.register_file[3];
     r4 = dut.dec_unit.register_unit.register_file[4];
     r5 = dut.dec_unit.register_unit.register_file[5];
     r6 = dut.dec_unit.register_unit.register_file[6];
     r7 = dut.dec_unit.register_unit.register_file[7];
     r8 = dut.dec_unit.register_unit.register_file[8];
     i = i + 1;
     case(PC)
       0 : begin 
            $fwrite(f,"running %d %d   orhi r2, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       4: begin
            $fwrite(f,"running %d %d   ori r2, r2,(8)  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
       8: begin
            $fwrite(f,"running %d %d   orhi r3, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
         end
       12: begin
            $fwrite(f,"running %d %d   ori r3, r3,(32) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       16: begin
            $fwrite(f,"running %d %d   orhi r4, r0,(0) %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       20: begin
            $fwrite(f,"running %d %d   ori r4, r0,(6)  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       24: begin
            $fwrite(f,"running %d %d   ldw r4, 0(r4)   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       28: begin
            $fwrite(f,"running %d %d   add r5, r0, r0  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       32: begin
            $fwrite(f,"running %d %d Loop:ldw r6, 0(r2)%d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
           end
       36: begin
            $fwrite(f,"running %d %d   ldw r7, 0(r3))  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      40: begin
         $fwrite(f,"running %d %d  mul r8, r6, r7   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      44: begin
          $fwrite(f,"running %d %d  add r5, r5, r8   %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      48: begin
          $fwrite(f,"running %d %d  addi r2, r2, 4   %d %d %d %d %d %d %d\n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      52: begin
          $fwrite(f,"running %d %d  addi r3, r3, 4   %d %d %d %d %d %d %d\n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          sum = r5;
          end
      56: begin
          $fwrite(f,"running %d %d  addi r4, r4, -1  %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      60: begin
          product = sum + r6 * r7;
          $fwrite(f,"running %d %d  blt r0, r4, Loop %d %d %d %d %d %d %d %d %d\n",i,PC,r2, r3, r4, r5, r6, r7, r8,product,dut.exe_dec_reslt_data);
          end
      64: begin
          $fwrite(f,"running %d %d  stw r5, 0(r0)    %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      68: begin
          $fwrite(f,"running %d %d  stop: br stop    %d %d %d %d %d %d %d \n",i,PC,r2, r3, r4, r5, r6, r7, r8);
          end
      default: $display("Reset -> system off");
    endcase
    if (PC >= 68 && dut.dec_unit.register_unit.register_file[4]==0) begin
       dot_product = dut.dec_unit.register_unit.register_file[5];
       if(dot_product == result) begin
         $display(" Correct!!");
         $display("dot product = %d ",dut.dec_unit.register_unit.register_file[5]);
         $display("your processor working correctly");
         $display("simulation finished");
         $fwrite(f," Correct !! \n dot product = %d \n Your processor is working correctly \n Simulation finished \n",dut.dec_unit.register_unit.register_file[5]);
       end else begin
         $display(" Error!!!!!");
         $display(" Expecting = %d got = %d",result,dut.dec_unit.register_unit.register_file[5]);
         $fwrite(f," Error!!! \n Expecting = %d got = %d",result,dut.dec_unit.register_unit.register_file[5]);
        end
        #40
      $fclose(f);
      $finish();
    end
end
end
endmodule
