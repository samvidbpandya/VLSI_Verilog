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

module fpadd(clk,rst,pushin,a,b,pushout,r);
input pushin;
input clk,rst;
input [63:0] a,b;	// the a and b inputs
output [63:0] r;	// the results from this multiply
output pushout;		// indicates we have an answer this cycle

parameter fbw=104;

reg sA,sB;		// the signs of the a and b inputs
reg [10:0] expA, expB,expR;		// the exponents of each
reg [fbw:0] fractA, fractB,fractR,fractAdd,fractPreRound,denormB,
	f2,d2;	
	// the fraction of A and B  present
reg zeroA,zeroB;	// a zero operand (special case for later)
	

reg signres;		// sign of the result
reg [10:0] expres;	// the exponent result
reg [63:0] resout;	// the output value from the always block
integer iea,ieb,ied;	// exponent stuff for difference...
integer renorm;		// How much to renormalize...
parameter [fbw:0] zero=0;
//reg stopinside;



//--------------------------------------------------defined by me
//stage-1 variables
integer renorm1,renorm11;
reg [10:0] expA1,expA11;
reg sA1,sB1,sA11,sB11;
reg [fbw:0] fractA1, fractB1,fractA11, fractB11;
reg signres1,signres11;
integer ied1,ied11;
reg pushin1;


//stage-2 variables
integer renorm2,renorm22;
reg sA2,sB2,sA22,sB22;
reg [fbw:0] fractA2, fractB2,fractR2,fractA22, fractB22,fractR22;
reg signres2,signres22;
integer ied2,ied22;
reg pushin2;
reg [10:0] expR2,expR22;
// stage-3
integer renorm3,renorm33;
reg signres3,signres33;
integer ied3,ied33;
reg [10:0] expR3,expR33;
reg pushin3;
reg [fbw:0] fractR3,fractR33;
//stage-4 variables
integer renorm4,renorm44;
reg signres4,signres44;
integer ied4,ied44;
reg [10:0] expR4,expR44;
reg pushin4;
reg [fbw:0] fractR4,fractR44;

//////////////////////////////////////////////////////////////////
assign r=resout;
assign pushout=pushin4;
//
// give the fields a name for convience
//


always@(posedge clk or posedge rst)
  begin
    if(rst) 
      begin
//----------------------------------stage-1
        renorm1<=0;
        expA1<=0;
        sA1<=0;
        sB1<=0;
        fractA1<=0;
        fractB1<=0;
        signres1<=0;
        ied1<=0;
        pushin1<=0; 
//---------------------------------stage-2
        renorm2<=0;
        sA2<=0;
        sB2<=0;
        fractA2<=0;
        fractB2<=0;
        signres2<=0;
        ied2<=0;
        expR2<=0;
        fractR2<=0;
        pushin2<=0;
//---------------------------------stage-3
        renorm3<=0;
        signres3<=0;
        ied3<=0;
        expR3<=0;
        fractR3<=0;
        pushin3<=0;
//---------------------------------stage-4
        renorm4<=0;
        signres4<=0;
        ied4<=0;
        fractR4<=0;
        expR4<=0;
        pushin4<=0;
      end
    else
      begin
//----------------------------------stage-1
        renorm1<= #1 renorm;
        expA1<= #1 expA;
        sA1<= #1 sA;
        sB1<= #1 sB;
        fractA1<= #1 fractA;
        fractB1<= #1 fractB;
        signres1<= #1 signres;
        ied1<= #1 ied;
        pushin1<= #1 pushin; 
//----------------------------------stage-2
        renorm2<= #1 renorm11;
        sA2<= #1 sA11;
        sB2<= #1 sB11;
        fractA2<= #1 fractA11;
        fractB2<= #1 fractB11;
        signres2<= #1 signres11;
        ied2<= #1 ied11;
        expR2<= #1 expR;
        fractR2<= #1 fractR;
        pushin2<= #1 pushin1;
//---------------------------------stage-3
        renorm3<= #1 renorm22;
        signres3<= #1 signres22;
        ied3<= #1 ied22;
        expR3<= #1 expR22;
        fractR3<= #1 fractR22;
        pushin3<= #1 pushin2;
//---------------------------------stage-4
        renorm4<= #1 renorm33;
        signres4<= #1 signres33;
        ied4<= #1 ied33;
        fractR4<= #1 fractR33;
        expR4<=  #1 expR33;
        pushin4<= #1 pushin3;
      end
  end


always @(*) begin
  zeroA = (a[62:0]==0)?1:0;
  zeroB = (b[62:0]==0)?1:0;
  renorm=0;
  if( b[62:0] > a[62:0] ) begin
    expA = b[62:52];
    expB = a[62:52];
    sA = b[63];
    sB = a[63];
    fractA = (zeroB)?0:{ 2'b1, b[51:0],zero[fbw:54]};
    fractB = (zeroA)?0:{ 2'b1, a[51:0],zero[fbw:54]};
    signres=sA;
  end else begin
    sA = a[63];
    sB = b[63];
    expA = a[62:52];
    expB = b[62:52];
    fractA = (zeroA)?0:{ 2'b1, a[51:0],zero[fbw:54]};
    fractB = (zeroB)?0:{ 2'b1, b[51:0],zero[fbw:54]};
    signres=sA;
  end
  iea=expA;
  ieb=expB;
  ied=expA-expB;
end
//--------------------------------------------------------------------------
always@(*) begin
  renorm11=renorm1;
  expA11=expA1;
  sA11=sA1;
  sB11=sB1;
  fractA11=fractA1;
  fractB11=fractB1;
  //fractR_22=fractR_1;
  signres11=signres1;
  ied11=ied1;
 // expR_22=expR_2;

  if(ied11 > 60) begin
    expR=expA11;
    fractR=fractA11;
  end else begin
    fractR=0;
    expR=expA11;
    denormB=0;
    fractB11=(ied11[5])?{32'b0,fractB11[fbw:32]}: {fractB11};
    fractB11=(ied11[4])?{16'b0,fractB11[fbw:16]}: {fractB11};
    fractB11=(ied11[3])?{ 8'b0,fractB11[fbw:8 ]}: {fractB11};
    fractB11=(ied11[2])?{ 4'b0,fractB11[fbw:4 ]}: {fractB11};
    fractB11=(ied11[1])?{ 2'b0,fractB11[fbw:2 ]}: {fractB11};
    fractB11=(ied11[0])?{ 1'b0,fractB11[fbw:1 ]}: {fractB11};
end
end
//--------------------------------------------------------------------------
always@(*) begin
  renorm22=renorm2;
  sA22=sA2;
  sB22=sB2;
  fractA22=fractA2;
  fractB22=fractB2;
  fractR22=fractR2;
  signres22=signres2;
  ied22=ied2;
  expR22=expR2;


 if(ied22<61) begin
    if(sA22 == sB22) fractR22=fractA22+fractB22; else fractR22=fractA22-fractB22;
    fractAdd=fractR22;
    renorm22=0;
    if(fractR22[fbw]) begin
      fractR22={1'b0,fractR22[fbw:1]};
      expR22=expR22+1;
    end
end
end

//---------------------------------------------------------------------------
always@(*) begin
  renorm33=renorm3;
  signres33=signres3;
  ied33=ied3;
  fractR33=fractR3;
  expR33=expR3;

 if(ied33<61) begin
    if(fractR33[fbw-1:fbw-32]==0) begin 
	renorm33[5]=1; fractR33={ 1'b0,fractR33[fbw-33:0],32'b0 }; 
    end
    if(fractR33[fbw-1:fbw-16]==0) begin 
	renorm33[4]=1; fractR33={ 1'b0,fractR33[fbw-17:0],16'b0 }; 
    end
    if(fractR33[fbw-1:fbw-8]==0) begin 
	renorm33[3]=1; fractR33={ 1'b0,fractR33[fbw-9:0], 8'b0 }; 
    end
    if(fractR33[fbw-1:fbw-4]==0) begin 
	renorm33[2]=1; fractR33={ 1'b0,fractR33[fbw-5:0], 4'b0 }; 
    end
    if(fractR33[fbw-1:fbw-2]==0) begin 
	renorm33[1]=1; fractR33={ 1'b0,fractR33[fbw-3:0], 2'b0 }; 
    end
    if(fractR33[fbw-1   ]==0) begin 
	renorm33[0]=1; fractR33={ 1'b0,fractR33[fbw-2:0], 1'b0 }; 
    end
end
end
//-----------------------------------------------------------------------
always@(*) begin
  renorm44=renorm4;
  signres44=signres4;
  ied44=ied4;
  fractR44=fractR4;
  expR44=expR4;

  if(ied44<61) begin
   // fractPreRound=fractR;
    if(fractR44 != 0) begin
      if(fractR44[fbw-55:0]==0 && fractR44[fbw-54]==1) begin
	if(fractR44[fbw-53]==1) fractR44=fractR44+{1'b1,zero[fbw-54:0]};
      end else begin
        if(fractR44[fbw-54]==1) fractR44=fractR44+{1'b1,zero[fbw-54:0]};
      end
      expR44=expR44-renorm44;
      if(fractR4[fbw-1]==0) begin
       expR44=expR44+1;
       fractR44={1'b0,fractR44[fbw-1:1]};
      end
    end else begin
      expR44=0;
      signres44=0;
    end
  end
 //end

  resout={signres44,expR44,fractR44[fbw-2:fbw-53]};

end


endmodule
