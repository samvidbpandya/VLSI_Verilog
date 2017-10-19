//This code shall denormalize the input random numbers to get vin
//and then normalize the difference to get delta

//timescale
`timescale 1ns/10ps

//module definition
module vin_delta # (
  //parameter which sets u1 or u2
  parameter u1_u2 = "u1"
  )
  (
  input pushin,
  input [63:0] rand_in,
  output reg [9:0] vin,
  output reg [63:0] delta,
  output pushout
  );


//declaration of signals
reg s;
reg [10:0] e,diff,norm_e;
reg [51:0] f, denorm;
reg [63:0] norm_f;

//no stage
assign pushout = pushin;

//conbinational block
always @ (*)
begin
  //split the random number into IEEE components
  s = rand_in[63];
  e = rand_in[62:52];
  f = {1'b1,rand_in[51:1]};
  
  //calcuate the exponent difference without bias
  diff = 11'd1022 - e;
  
  //right shift fraction with diff for denormalized value
  if (diff > 0)
    denorm = f >> diff;
  else
    denorm = f;
  
  //assign the most significant 10 bits to vin if u2 else 9 bits if u1 
  if (u1_u2 == "u2") 
    vin = denorm[51:42]; 
  else 
    vin = {1'b0,denorm[51:43]};
  
  //delta's fraction calculation by subtracting vin from denorm. 
  if (u1_u2 == "u2")
    norm_f = {10'b0,denorm[41:0],12'b0};
  else
    norm_f = {9'b0,denorm[42:0],12'b0};

  //re normalize delta's fraction
  norm_e = 11'b0;
  if (norm_f[63:32] == 0) begin
    norm_e[5] = 1;
    norm_f = {norm_f[31:0],32'b0};
  end
  if (norm_f[63:48] == 0) begin
    norm_e[4] = 1;
    norm_f = {norm_f[47:0],16'b0};
  end
  if (norm_f[63:56] == 0) begin
    norm_e[3] = 1;
    norm_f = {norm_f[55:0],8'b0};
  end
  if (norm_f[63:60] == 0) begin
    norm_e[2] = 1;
    norm_f = {norm_f[59:0],4'b0};
  end
  if (norm_f[63:62] == 0) begin
    norm_e[1] = 1;
    norm_f = {norm_f[61:0],2'b0};
  end
  if (norm_f[63] == 0) begin
    norm_e[0] = 1;
    norm_f = {norm_f[62:0],1'b0};
  end

  //calculate delta's exp
  norm_e = 11'd1022 - norm_e;

  //combining all to form the delta
  delta = {s,norm_e,norm_f[62:11]};
end

endmodule 
