//
// This is a simple version of a 64 bit floating point multiplier 
// used in EE287 as a homework problem.
// This is a reduced complexity floating point.  There is no NaN
// overflow, underflow, or infinity values processed.
//
// Inspired by IEEE 754-2008 (Available from the SJSU library to students)
//
// 63  62:52 51:0
// S   Exp   Fract (assumed high order 1)
// 
// Note: all zero exp and fract is a zero 
// 
//


module fpmul(clk,rst,pushin,a,b,c,pushout,r);
input clk,rst;
input pushin; 	        // A valid a,b,c
input [63:0] a,b,c;	// the a,b and c inputs
output [63:0] r;	// the results from this multiply
output pushout;		// indicates we have an answer this cycle

reg sA,sB,sC,sA_1,sB_1,sC_1,sA_2,sB_2,sC_2,sA_3,sB_3,sC_3,sA_4,sB_4,sC_4,sA_5,sB_5,sC_5;		// the signs of the a and b inputs
reg [10:0] expA, expB, expC, expA_1, expB_1, expC_1, expA_2, expB_2, expC_2, expA_3, expB_3, expC_3, expA_4, expB_4, expC_4, expA_5, expB_5, expC_5;		// the exponents of each
reg [52:0] fractA, fractB, fractC, fractA_1, fractB_1, fractC_1, fractC_2, fractC_3, fractC_4, fractC_5; 
reg zeroA, zeroB, zeroC, zeroA_1, zeroB_1, zeroC_1, zeroA_2, zeroB_2, zeroC_2, zeroA_3, zeroB_3, zeroC_3, zeroA_4, zeroB_4, zeroC_4, zeroA_5, zeroB_5, zeroC_5;
reg zeroA_6, zeroB_6, zeroC_6, zeroA_7, zeroB_7, zeroC_7, zeroA_8, zeroB_8, zeroC_8, zeroA_9, zeroB_9, zeroC_9, zeroA_10, zeroB_10, zeroC_10, zeroA_11, zeroB_11, zeroC_11;// a zero operand (special case for later)

reg [159:0] rres,rconstant;
reg [159:0] rconstant_1, rconstant_2, rconstant_3, rconstant_4, rconstant_5, rconstant_6, rconstant_7, rconstant_8, rconstant_9, rconstant_10, rconstant_11;
reg pushout_1, pushout_2, pushout_3, pushout_4, pushout_5, pushout_6, pushout_7, pushout_8, pushout_9, pushout_10, pushout_11;

wire [105:0] mres;
reg [105:0] mres_1;
wire [158:0] mres_2;

reg [159:0] mres_3, mres_4;
reg [10:0] expres, expres_1, expres_2, expres_3, expres_4, expres_5, expres_6;
reg signres, signres_1, signres_2, signres_3, signres_4, signres_5, signres_6;


reg [63:0] resout;


assign r=resout;
assign pushout=pushout_11;


always @(*) begin
  pushout_1<=pushin;
  rconstant<=0;
  sA <= a[63];
  sB <= b[63];
  sC <= c[63];
  expA <= a[62:52];
  expB <= b[62:52];
  expC <= c[62:52];
  fractA <= { 1'b1, a[51:0]};
  fractB <= { 1'b1, b[51:0]};
  fractC <= { 1'b1, c[51:0]};
  zeroA <= (a[62:0]==0)?1:0;
  zeroB <= (b[62:0]==0)?1:0;
  zeroC <= (c[62:0]==0)?1:0;
end

DW02_mult_5_stage #(53,53) d1(.A(fractA), .B(fractB), .TC(1'b0), .CLK(clk), .PRODUCT(mres));

always @(posedge clk or posedge rst) begin
if(rst) begin 

pushout_2 <= 0;
pushout_3 <= 0;
pushout_4 <= 0;
pushout_5 <= 0;

rconstant_1 <= 0;
rconstant_2 <= 0;
rconstant_3 <= 0;
rconstant_4 <= 0;
rconstant_5 <= 0;

sA_1 <= 0;
sB_1 <= 0;
sC_1 <= 0;
sA_2 <= 0;
sB_2 <= 0;
sC_2 <= 0;
sA_3 <= 0;
sB_3 <= 0;
sC_3 <= 0;
sA_4 <= 0;
sB_4 <= 0;
sC_4 <= 0;
sA_5 <= 0;
sB_5 <= 0;
sC_5 <= 0;


expA_1 <= 0;
expB_1 <= 0;
expC_1 <= 0;
expA_2 <= 0;
expB_2 <= 0;
expC_2 <= 0;
expA_3 <= 0;
expB_3 <= 0;
expC_3 <= 0;
expA_4 <= 0;
expB_4 <= 0;
expC_4 <= 0;
expA_5 <= 0;
expB_5 <= 0;
expC_5 <= 0;

fractC_1 <= 0;
fractC_2 <= 0;
fractC_3 <= 0;
fractC_4 <= 0;
fractC_5 <= 0;

zeroA_1 <= 0;
zeroB_1 <= 0;
zeroC_1 <= 0;
zeroA_2 <= 0;
zeroB_2 <= 0;
zeroC_2 <= 0;
zeroA_3 <= 0;
zeroB_3 <= 0;
zeroC_3 <= 0;
zeroA_4 <= 0;
zeroB_4 <= 0;
zeroC_4 <= 0;
zeroA_5 <= 0;
zeroB_5 <= 0;
zeroC_5 <= 0;

mres_1 <= 0;
end 

else begin

pushout_2 <= #1 pushout_1;
pushout_3 <= #1 pushout_2;
pushout_4 <= #1 pushout_3;
pushout_5 <= #1 pushout_4;

rconstant_1 <= #1 rconstant;
rconstant_2 <= #1 rconstant_1;
rconstant_3 <= #1 rconstant_2;
rconstant_4 <= #1 rconstant_3;
rconstant_5 <= #1 rconstant_4;

sA_1 <= #1 sA;
sB_1 <= #1 sB;
sC_1 <= #1 sC;
sA_2 <= #1 sA_1;
sB_2 <= #1 sB_1;
sC_2 <= #1 sC_1;
sA_3 <= #1 sA_2;
sB_3 <= #1 sB_2;
sC_3 <= #1 sC_2;
sA_4 <= #1 sA_3;
sB_4 <= #1 sB_3;
sC_4 <= #1 sC_3;
sA_5 <= #1 sA_4;
sB_5 <= #1 sB_4;
sC_5 <= #1 sC_4;

expA_1 <= #1 expA;
expB_1 <= #1 expB;
expC_1 <= #1 expC;
expA_2 <= #1 expA_1;
expB_2 <= #1 expB_1;
expC_2 <= #1 expC_1;
expA_3 <= #1 expA_2;
expB_3 <= #1 expB_2;
expC_3 <= #1 expC_2;
expA_4 <= #1 expA_3;
expB_4 <= #1 expB_3;
expC_4 <= #1 expC_3;
expA_5 <= #1 expA_4;
expB_5 <= #1 expB_4;
expC_5 <= #1 expC_4;

fractC_1 <= #1 fractC;
fractC_2 <= #1 fractC_1;
fractC_3 <= #1 fractC_2;
fractC_4 <= #1 fractC_3;
fractC_5 <= #1 fractC_4;

zeroA_1 <= #1 zeroA;
zeroB_1 <= #1 zeroB;
zeroC_1 <= #1 zeroC;
zeroA_2 <= #1 zeroA_1;
zeroB_2 <= #1 zeroB_1;
zeroC_2 <= #1 zeroC_1;
zeroA_3 <= #1 zeroA_2;
zeroB_3 <= #1 zeroB_2;
zeroC_3 <= #1 zeroC_2;
zeroA_4 <= #1 zeroA_3;
zeroB_4 <= #1 zeroB_3;
zeroC_4 <= #1 zeroC_3;
zeroA_5 <= #1 zeroA_4;
zeroB_5 <= #1 zeroB_4;
zeroC_5 <= #1 zeroC_4;

mres_1 <= #1 mres;
 
end
end 



always @(*)
begin

expres = expA_5+expB_5+expC_5-11'd2045;
signres= sA_5^sB_5^sC_5;
end

DW02_mult_5_stage_1 #(106,53) d2(.A(mres_1), .B(fractC_5), .TC(1'b0), .CLK(clk), .PRODUCT(mres_2));

always @(posedge clk or posedge rst) begin 
if(rst) begin
pushout_6 <= 0;
pushout_7 <= 0;
pushout_8 <= 0;
pushout_9 <= 0;
pushout_10 <= 0;
pushout_11 <= 0;

zeroA_6 <= 0;
zeroB_6 <= 0;
zeroC_6 <= 0;
zeroA_7 <= 0;
zeroB_7 <= 0;
zeroC_7 <= 0;
zeroA_8 <= 0;
zeroB_8 <= 0;
zeroC_8 <= 0;
zeroA_9 <= 0;
zeroB_9 <= 0;
zeroC_9 <= 0;
zeroA_10 <= 0;
zeroB_10 <= 0;
zeroC_10 <= 0;

rconstant_6 <= 0;
rconstant_7 <= 0;
rconstant_8 <= 0;
rconstant_9 <= 0;
rconstant_10 <= 0;

expres_1 <= 0;
expres_2 <= 0;
expres_3 <= 0;
expres_4 <= 0;
expres_5 <= 0;

signres_1 <= 0;
signres_2 <= 0;
signres_3 <= 0;
signres_4 <= 0;
signres_5 <= 0;

mres_3 <= 0;

end

else begin
pushout_6 <= #1 pushout_5;
pushout_7 <= #1 pushout_6;
pushout_8 <= #1 pushout_7;
pushout_9 <= #1 pushout_8;
pushout_10 <= #1 pushout_9;
pushout_11 <= #1 pushout_10;

zeroA_6 <= #1 zeroA_5;
zeroB_6 <= #1 zeroB_5;
zeroC_6 <= #1 zeroC_5;
zeroA_7 <= #1 zeroA_6;
zeroB_7 <= #1 zeroB_6;
zeroC_7 <= #1 zeroC_6;
zeroA_8 <= #1 zeroA_7;
zeroB_8 <= #1 zeroB_7;
zeroC_8 <= #1 zeroC_7;
zeroA_9 <= #1 zeroA_8;
zeroB_9 <= #1 zeroB_8;
zeroC_9 <= #1 zeroC_8;
zeroA_10 <= #1 zeroA_9;
zeroB_10 <= #1 zeroB_9;
zeroC_10 <= #1 zeroC_9;

rconstant_6 <= #1 rconstant_5;
rconstant_7 <= #1 rconstant_6;
rconstant_8 <= #1 rconstant_7;
rconstant_9 <= #1 rconstant_8;
rconstant_10 <= #1 rconstant_9;

expres_1 <= #1 expres;
expres_2 <= #1 expres_1;
expres_3 <= #1 expres_2;
expres_4 <= #1 expres_3;
expres_5 <= #1 expres_4;

signres_1 <= #1 signres;
signres_2 <= #1 signres_1;
signres_3 <= #1 signres_2;
signres_4 <= #1 signres_3;
signres_5 <= #1 signres_4;

mres_3 <= #1 mres_2;

end 
end 


always @(*) begin
  
  mres_4 = mres_3;
  rconstant_11 = rconstant_10;
  expres_6 = expres_5;
  signres_6 = signres_5;
  zeroA_11 = zeroA_10;
  zeroB_11 = zeroB_10;
  zeroC_11 = zeroC_10;
  
  if (mres_4[158]==1) rconstant_11[105]=1; else if(mres_4[157]==1'b1) rconstant_11[104]=1; else rconstant_11[103]=1;
  rres=mres_4+rconstant_11;
  if((zeroA_11==1) || (zeroB_11==1) || (zeroC_11 == 1)) begin // sets a zero result to a true 0
    rres = 0;
    expres_6 = 0;
    signres_6=0;// do something
    resout=64'b0;
  end else begin
    if(rres[158]==1'b1) begin
      expres_6 = expres_6+1;
      resout = {signres_6,expres_6,rres[157:106]};
    end else if(rres[157]==1'b0) begin // less than 1/2
      expres_6 = expres_6-1;
      resout = {signres_6,expres_6,rres[155:104]};
    end else begin 
      resout = {signres_6,expres_6,rres[156:105]};
    end
  end
end



endmodule 
