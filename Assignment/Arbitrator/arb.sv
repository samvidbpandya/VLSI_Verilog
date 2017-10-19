module arb (bmif.mstrR a0,bmif.mstrR a1, bmif.mstrR a2, bmif.mstrR a3, svif.slvR b0,svif.slvR b1, svif.slvR b2, svif.slvR b3, input integer amount, input integer numclk, input integer max );

//******This is balace for each master**********

int bal0; //a0 master
int bal1; //a1 master
int bal2; // a2 master
int bal3; //a3 master

//***********************************************

//We need to set some flag which will save the priority

logic [1:0] priority_req_flag_m1=0,
            priority_req_flag_m2=0,
            priority_req_flag_m3=0,
            priority_req_flag_m4=0;

//***************************************************

reg[7:0] num_array[4];
reg[7:0] num_array_out[4];
reg[7:0] temp;

//debug**************************************************
bit q=0;

//**********************************************************
event my_debug;
integer count;      //counter is used to count #of clock as after numclk all the balance will add up with amount value

integer debug;




always @ (posedge a0.clk)
begin
    if (a0.rst)
    begin
            //initial priority
            priority_req_flag_m1=0;
            priority_req_flag_m2=1;
            priority_req_flag_m3=2;
            priority_req_flag_m4=3;

        
        count=0;
        //set initial balance to maximum value
        bal0 <= max;
		bal1 <= max;	
		bal2 <= max;
		bal3 <= max;
		
		//set all grant to masters are zero as no grant initially
		a0.grant <= 0;
        a1.grant <= 0;
        a2.grant <= 0;
        a3.grant <= 0;
        
        //initially all sel signal to slave are set to zero
        b0.sel <= 0;
        b1.sel <= 0;
        b2.sel <= 0;
        b3.sel <= 0;
        
    end 
    
    else
    begin
    
        count <= count + 1;     //This count adds up at every clock.
        
        // Logic for updating balace with required amount according to condition 
        
        if(a0.grant==1 && bal0!=1)
        begin 
            bal0 <= bal0 - a0.req;
            
            if ((bal0 - a0.req)<1 || bal0==1 || bal0==0)
            begin 	
                bal0 = 1;
                //debug=1;
            end 
        end 
        
        
         if(a1.grant==1)
        begin 
            bal1 <= bal1 - a1.req;
            
            if ((bal1 - a1.req)<1 || bal1==1 || bal1==0)
            begin 	
                bal1 = 1;
                //debug=1;
            end 
        end 
        
         if(a2.grant==1)
        begin 
            bal2 <= bal2 - a2.req;
            
            if ((bal2 - a2.req)<1 || bal2==1 || bal2==0)
            begin 	
                bal2 = 1;
                //debug=1;
            end 
        end 
        
         if(a3.grant==1)
        begin 
            bal3 <= bal3 - a3.req;
            
            if ((bal3 - a3.req)<1 || bal3==1 || bal3==0)
            begin 	
                bal3 = 1;
                //debug=1;
            end 
        end 
        if (count == numclk)
        begin
            count<=0;
            
            //Balance of master 1
            if ((bal0 + amount) < max)
				bal0 <= bal0 + amount;
			else
				bal0 <= max;
				
			//Balance of master 2
            if ((bal1 + amount) < max)
				bal1 <= bal1 + amount;
			else
				bal1 <= max;
				
			//Balance of master 3
            if ((bal2 + amount) < max)
				bal2 <= bal2 + amount;
			else
				bal2 <= max;	
			
			//Balance of master 4
            if ((bal3 + amount) < max)
				bal3 <= bal3 + amount;
			else
				bal3 <= max;
        end 
            //xfr signal shows active bus
        if (a0.xfr == 0)
            a0.grant <= 0;
        else if (a1.xfr == 0)
            a1.grant <= 0;
        else if (a2.xfr == 0)
            a2.grant <=0;
        else if (a3.xfr == 0)
            a3.grant <= 0;
           //*********************************************     
        
        //@(posedge a0.clk) ->>my_debug;
        
        
        
    end      //end of (!reset)

end     
//



always @(*)
begin 
//MASTER 1 HAVE HIGHER PRIORITY
if(bal0==0)
    bal0=1;
if(bal1==0)
    bal1=1;
    
if(bal2==0)
    bal2=1;
if(bal3==0)
    bal3=1;

if(a0.req!=0 || a1.req!=0 || a2.req!=0 || a3.req!=0 )
begin
        num_array[0]={priority_req_flag_m1,2'b00,a0.req}; 
        num_array[1]={priority_req_flag_m2,2'b01,a1.req}; 
        num_array[2]={priority_req_flag_m3,2'b10,a2.req}; 
        num_array[3]={priority_req_flag_m4,2'b11,a3.req}; 
        
        //foreach (num_array[j])
       // $display("master %h has request %h",num_array_out[j][5:4],num_array_out[j][3:0]);
        for(int i=0;i<4;i++)
        begin 
            for(int j=0;j<3;j++)
            begin 
                if(num_array[j][3:0]<num_array[j+1][3:0])
                begin
                    temp=num_array[j];
                    num_array[j]=num_array[j+1];
                    num_array[j+1]=temp;
                end 
            
            end 
        
        end 

        
        if(q==1)
        begin 
        num_array_out<=num_array;
        q=0;
        
        end 
        
   

//if(a0.req!=0 && a1.req==0 && a2.req==0 && a3.req)    
    
    
if(num_array[0][3:0]!=num_array[1][3:0])
begin
    //a wins
    case(num_array[0][5:4])
    2'b00:
    begin
        if(bal0!=1 && bal0>=num_array[0][3:0] || num_array[1][3:0]==0 )
        begin
                 
            a0.grant <= 1;
            a1.grant <= 0;
            a2.grant <= 0;
            a3.grant <= 0;
           
        end 
        
        
        else
        begin
            
            if(num_array[1][3:0]!=num_array[2][3:0])
            begin //a wins but no enough balance thu
                
                case(num_array[1][5:4])
                2'b00:
                begin
                        if(bal0!=1 && bal0>=num_array[0][3:0])
                        begin
                            a0.grant <= 1;
                            a1.grant <= 0;
                            a2.grant <= 0;
                            a3.grant <= 0;
                           
                        end
                        
                        else
                        begin
                            if(num_array[2][3:0]!=num_array[3][3:0])
                            begin
                                case(num_array[2][5:4])
                                    2'b00:
                                    begin
                                        if(bal0!=1 && bal0>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 1;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                           
                                        end
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                        if(priority_req_flag_m1==0)
                                                        begin 
                                                            a0.grant <= 1;
                                                            a1.grant <= 0;
                                                            a2.grant <= 0;
                                                            a3.grant <= 0;
                                                            
                                                        end 
                                                        
                                                        else if(priority_req_flag_m1==0)
                                                        begin 
                                                            a0.grant <= 0;
                                                            a1.grant <= 1;
                                                            a2.grant <= 0;
                                                            a3.grant <= 0;
                                                            
                                                        end 
                                                        
                                                        else if(priority_req_flag_m3==0)
                                                        begin
                                                            a0.grant <= 0;
                                                            a1.grant <= 0;
                                                            a2.grant <= 1;
                                                            a3.grant <= 0;
                                                           
                                                        
                                                        end 
                                                        
                                                        else if(priority_req_flag_m4==0)
                                                        begin
                                                            a0.grant <= 0;
                                                            a1.grant <= 0;
                                                            a2.grant <= 0;
                                                            a3.grant <= 1;
                                                           
                                                        end 
                                                            
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end 
                                    end 
                                    2'b01:
                                    begin
                                        if(bal1!=1 && bal1>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 1;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                    
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end//my end 
                                            endcase 
                                        
                                        end
                                                    
                                            
                                    
                                    end 
                                    
                                    2'b10:
                                    begin
                                        if(bal2!=1 && bal2>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 1;
                                            a3.grant <= 0;
                                           
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    
                                    end 
                                    
                                    2'b11:
                                    begin 
                                        if(bal3!=1 && bal3>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 1;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    end 
                                
                                endcase 
                                
                            
                            end
                            
                            else     //HERE c==d
                            begin 
                            
                            end 
                        
                        
                        end 
                end
                
                2'b01:
                begin
                    if(bal1!=1 && bal1>=num_array[1][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 1;
                            a2.grant <= 0;
                            a3.grant <= 0;
                            
                        end
                        
                        else
                        begin
                            if(num_array[2][3:0]!=num_array[3][3:0])
                            begin
                                case(num_array[2][5:4])
                                    2'b00:
                                    begin
                                        if(bal0!=1 && bal0>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 1;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                           
                                        end
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                      
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                     
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end 
                                    end 
                                    2'b01:
                                    begin
                                        if(bal1!=1 && bal1>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 1;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                           
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end//my end 
                                            endcase 
                                        
                                        end
                                                    
                                            
                                    
                                    end 
                                    
                                    2'b10:
                                    begin
                                        if(bal2!=1 && bal2>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 1;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                      
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    
                                    end 
                                    
                                    2'b11:
                                    begin 
                                        if(bal3!=1 && bal3>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 1;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                       
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    end 
                                
                                endcase 
                                
                            
                            end
                            
                            else     //HERE c==d
                            begin 
                            
                            end 
                        
                        
                        end
                
                end   //my end for num_array[1]==01
                
                2'b10:
                begin
                    if(bal2!=1 && bal2>=num_array[1][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 1;
                            a3.grant <= 0;
                             
                        end
                        
                        else
                        begin
                            if(num_array[2][3:0]!=num_array[3][3:0])
                            begin
                                case(num_array[2][5:4])
                                    2'b00:
                                    begin
                                        if(bal0!=1 && bal0>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 1;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                            
                                        end
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end 
                                    end 
                                    2'b01:
                                    begin
                                        if(bal1!=1 && bal1>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 1;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end//my end 
                                            endcase 
                                        
                                        end
                                                    
                                            
                                    
                                    end 
                                    
                                    2'b10:
                                    begin
                                        if(bal2!=1 && bal2>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 1;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    
                                    end 
                                    
                                    2'b11:
                                    begin 
                                        if(bal3!=1 && bal3>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 1;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    end 
                                
                                endcase 
                                
                            
                            end
                            
                            else     //HERE c==d
                            begin 
                            
                            end 
                        
                        
                        end
                end //my end for num_array[1]==10
                
                2'b11:
                begin
                    if(bal3!=1 && bal3>=num_array[1][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 0;
                            a3.grant <= 1;
                            
                        end
                        
                        else if(num_array[2][3:0]==0)
                        begin 
                            if(priority_req_flag_m4<priority_req_flag_m1)
                            begin 
                                a0.grant <= 0;
                                a1.grant <= 0;
                                a2.grant <= 0;
                                a3.grant <= 1;
                            
                            end 
                             
                        
                        end 
                        
                        else
                        begin
                            if(num_array[2][3:0]!=num_array[3][3:0])
                            begin
                                case(num_array[2][5:4])
                                    2'b00:
                                    begin
                                        if(bal0!=1 && bal0>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 1;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                            
                                        end
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end 
                                    end 
                                    2'b01:
                                    begin
                                        if(bal1!=1 && bal1>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 1;
                                            a2.grant <= 0;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                         
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end//my end 
                                            endcase 
                                        
                                        end
                                                    
                                            
                                    
                                    end 
                                    
                                    2'b10:
                                    begin
                                        if(bal2!=1 && bal2>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 1;
                                            a3.grant <= 0;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    
                                    end 
                                    
                                    2'b11:
                                    begin 
                                        if(bal3!=1 && bal3>=num_array[2][3:0])
                                        begin
                                            a0.grant <= 0;
                                            a1.grant <= 0;
                                            a2.grant <= 0;
                                            a3.grant <= 1;
                                            
                                        end
                                        
                                        else if(num_array[3][3:0]!=0)
                                        begin 
                                            case(num_array[3][5:4])
                                            2'b00:
                                            begin
                                                    if(bal0!=1 && bal0>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 1;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end 
                                            2'b01:
                                            begin
                                            if(bal1!=1 && bal1>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 1;
                                                        a2.grant <= 0;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 
                                                    
                                            end  
                                            2'b10:
                                            begin
                                                if(bal2!=1 && bal2>=a2.req[3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 1;
                                                        a3.grant <= 0;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            
                                            end
                                            2'b11:
                                            begin
                                                if(bal3!=1 && bal3>=num_array[3][3:0])
                                                    begin
                                                        a0.grant <= 0;
                                                        a1.grant <= 0;
                                                        a2.grant <= 0;
                                                        a3.grant <= 1;
                                                        
                                                    end
                                                    
                                                    else   //give grant to the master whose flag is zero and that should be         requesting as well
                                                    begin
                                                    
                                                    
                                                    end 

                                            end
                                            endcase 
                                        
                                        end
                                    end 
                                
                                endcase 
                                
                            
                            end
                            
                            else     //HERE c==d
                            begin 
                            
                            end 
                        
                        
                        end
                
                end 
                
                endcase
                
            end
            
            else   //b==c
            begin 
                case(num_array[1][5:4])
                    2'b00:
                    begin 
                        if(bal0!=1 && bal0>=num_array[0][3:0])
                        begin
                            a0.grant <= 1;
                            a1.grant <= 0;
                            a2.grant <= 0;
                            a3.grant <= 0;
                           
                        end
                        
                        else
                        begin 
                            case(num_array[2][5:4])
                                2'b00:
                                begin
                                    if(bal0!=1 && bal0>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 1;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                    
                                end 
                                
                                2'b01:
                                begin
                                    if(bal1!=1 && bal1>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 1;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b10:
                                begin
                                    if(bal2!=1 && bal2>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 1;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b11:
                                begin
                                    if(bal3!=1 && bal3>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 1;
                                         
                                    end
                                end 
                            endcase
                        end 
                    
                    end 
                    
                    2'b01:
                    begin
                        if(bal1!=1 && bal1>=num_array[1][3:0] )
                        begin
                            a0.grant <= 0;
                            a1.grant <= 1;
                            a2.grant <= 0;
                            a3.grant <= 0;
                            
                        end
                        
                        else
                        begin 
                            case(num_array[2][5:4])
                                2'b00:
                                begin
                                    if(bal0!=1 && bal0>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 1;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                    
                                end 
                                
                                2'b01:
                                begin
                                    if(bal1!=1 && bal1>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 1;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b10:
                                begin
                                    if(bal2!=1 && bal2>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 1;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b11:
                                begin
                                    if(bal3!=1 && bal3>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 1;
                                         
                                    end
                                end 
                            endcase
                        end
                    
                    end 
                    
                    2'b10:
                    begin
                        if(bal2!=1 && bal2>=num_array[0][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 1;
                            a3.grant <= 0;
                            
                        end
                        
                        else
                        begin 
                            case(num_array[2][5:4])
                                2'b00:
                                begin
                                    if(bal0!=1 && bal0>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 1;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                         
                                    end
                                    
                                end 
                                
                                2'b01:
                                begin
                                    if(bal1!=1 && bal1>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 1;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b10:
                                begin
                                    if(bal2!=1 && bal2>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 1;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b11:
                                begin
                                    if(bal3!=1 && bal3>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 1;
                                        
                                    end
                                end 
                            endcase
                        end
                    
                    end 
                    
                    2'b11:
                    begin 
                        if(bal3!=1 && bal3>=num_array[0][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 0;
                            a3.grant <= 1;
                             
                        end
                        
                        else
                        begin 
                            case(num_array[2][5:4])
                                2'b00:
                                begin
                                    if(bal0!=1 && bal0>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 1;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                    
                                end 
                                
                                2'b01:
                                begin
                                    if(bal1!=1 && bal1>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 1;
                                        a2.grant <= 0;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b10:
                                begin
                                    if(bal2!=1 && bal2>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 1;
                                        a3.grant <= 0;
                                        
                                    end
                                end 
                                
                                2'b11:
                                begin
                                    if(bal3!=1 && bal3>=num_array[2][3:0])
                                    begin
                                        a0.grant <= 0;
                                        a1.grant <= 0;
                                        a2.grant <= 0;
                                        a3.grant <= 1;
                                        
                                    end
                                end 
                            endcase
                        end
                    end 
                endcase 
            end 
        
        end
    end 
    2'b01:
    begin
    
    end 
    2'b10:
    begin
    end 
    2'b11:
    begin
    end 
    endcase
end

else//a==b 
begin
    if(num_array[1][3:0]!=num_array[2][3:0])
    begin
        case(num_array[0][5:4])
        2'b00:
        begin
            if(bal0!=1 && bal0>=num_array[0][3:0])
            begin
                a0.grant <= 1;
                a1.grant <= 0;
                a2.grant <= 0;
                a3.grant <= 0;
                 
            end
            else 
            begin 
                case(num_array[1][5:4])
                    2'b11:
                    begin
                        if(bal3!=1 && bal3>=num_array[1][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 0;
                            a3.grant <= 1;
                             
                        end
                    end 
                    
                    2'b10:
                    begin 
                        if(bal3!=1 && bal3>=num_array[1][3:0])
                        begin
                            a0.grant <= 0;
                            a1.grant <= 0;
                            a2.grant <= 1;
                            a3.grant <= 0;
                             
                        end
                    
                    end 
                endcase 
            
            end 
        
        
        end 
        
         
    endcase
    
    end //end for a==b
        
    else  //a==b==c
    begin 
        case(num_array[0][5:4])
        2'b00:
        begin
            //$display("Debuf status flag");
            case(num_array[1][5:4])
                2'b10:
                begin 
                    if(priority_req_flag_m3<priority_req_flag_m4)
                    begin
                        a0.grant <= 0;
                        a1.grant <= 0;
                        a2.grant <= 1;
                        a3.grant <= 0;

                    end 

                    //else
                    //begin 
                      //  a0.grant <= 0;
                       // a1.grant <= 0;
                       // a2.grant <= 0;
                       // a3.grant <= 1;

                   // end
                end 
                
                2'b11:
                begin
                    if(priority_req_flag_m3<priority_req_flag_m4)
                    begin
                        a0.grant <= 0;
                        a1.grant <= 0;
                        a2.grant <= 1;
                        a3.grant <= 0;

                    end 

                    else
                    begin 
                        a0.grant <= 0;
                        a1.grant <= 0;
                        a2.grant <= 0;
                        a3.grant <= 1;

                    end
                end 
                
            endcase
        end 
        endcase 
        
        
        
    
    end //else a==b==c end
    
    
end

end

end 

always @(*)
begin 
    if (a0.grant == 1 && a0.xfr==1 && a0.addr!=0)
    begin
        if(priority_req_flag_m1!=3)
        begin
            case(priority_req_flag_m1)
                0:
                begin
                    priority_req_flag_m1=3;
                    priority_req_flag_m2--;
                    priority_req_flag_m3--;
                    priority_req_flag_m4--;
                end 
                1:
                begin
                    priority_req_flag_m1=3;
                    if(priority_req_flag_m2==2 || priority_req_flag_m2==3) priority_req_flag_m2--;
                    if(priority_req_flag_m3==2 || priority_req_flag_m3==3) priority_req_flag_m3--;
                    if(priority_req_flag_m4==2 || priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
                2:
                begin
                    priority_req_flag_m1=3;
                    if(priority_req_flag_m2==3) priority_req_flag_m2--;
                    if(priority_req_flag_m3==3) priority_req_flag_m3--;
                    if(priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
            endcase 
        end 
        else
        begin
            //no change in flag status 
        end 
    
    
        case (a0.addr[15:12])
            
            4'h0: begin
              //  $display("Master 0 get the grant");
                    b0.sel <= 1;
                    b1.sel <= 0;
                    b2.sel  <= 0;
                    b3.sel <= 0;
                    b0.RW <= a0.RW;
                    b0.addr <= a0.addr;
                    b0.DataToSlave <= a0.DataToSlave;
                #1	a0.DataFromSlave <= b0.DataFromSlave;
                    end
            4'h1: begin
           // $display("Master 0 get the grant");
            
                    b0.sel <= 0;
                    b1.sel <= 1;
                    b2.sel <= 0;
                    b3.sel <= 0;
                    b1.RW <= a0.RW;
                    b1.addr <= a0.addr;
                    b1.DataToSlave <= a0.DataToSlave;
                #1	a0.DataFromSlave <= b1.DataFromSlave;
                    end
            4'h2: begin
             //      $display("Master 0 get the grant");
                   b0.sel <= 0;
                    b1.sel <= 0;
                    b2.sel <= 1;
                    b3.sel <= 0;
                    b2.RW <= a0.RW;
                    b2.addr <= a0.addr;
                    b2.DataToSlave <= a0.DataToSlave;
                #1	a0.DataFromSlave <= b2.DataFromSlave;
                    end
            4'h3: begin //$display("Master 0 get the grant");
                    b0.sel <= 0;
                    b1.sel <= 0;
                    b2.sel <= 0;
                    b3.sel <= 1;
                    b3.RW <= a0.RW;
                    b3.addr <= a0.addr;
                    b3.DataToSlave <= a0.DataToSlave;
                #1	a0.DataFromSlave <= b3.DataFromSlave;
                    end
            default:begin
                    b0.sel = 0;
                    b1.sel = 0;
                    b2.sel = 0;
                    b3.sel = 0;
            end 
             

        endcase		
    end

    
    if (a1.grant == 1 && a1.xfr==1 && a1.addr!=0)
		begin
            if(priority_req_flag_m2!=3)
            begin
            case(priority_req_flag_m2)
                0:
                begin
                    priority_req_flag_m2=3;
                    priority_req_flag_m1--;
                    priority_req_flag_m3--;
                    priority_req_flag_m4--;
                end 
                1:
                begin
                    priority_req_flag_m2=3;
                    if(priority_req_flag_m1==2 || priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m3==2 || priority_req_flag_m3==3) priority_req_flag_m3--;
                    if(priority_req_flag_m4==2 || priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
                2:
                begin
                    priority_req_flag_m2=3;
                    if(priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m3==3) priority_req_flag_m3--;
                    if(priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
            endcase 
            end 
            else
            begin
            //no change in flag status 
            end 

			case (a1.addr[15:12])
				4'h0: begin
						b0.sel <= 1;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 0;
						b0.RW <= a1.RW;
						b0.addr <= a1.addr;
						b0.DataToSlave <= a1.DataToSlave;
					#1	a1.DataFromSlave <= b0.DataFromSlave;
					   end
				4'h1: begin
						b0.sel <= 0;
						b1.sel <= 1;
						b2.sel <= 0;
						b3.sel <= 0;
						b1.RW <= a1.RW;
						b1.addr <= a1.addr;
						b1.DataToSlave <= a1.DataToSlave;
					#1	a1.DataFromSlave <= b1.DataFromSlave;
					   end
				4'h2: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 1;
						b3.sel <= 0;
						b2.RW <= a1.RW;
						b2.addr <= a1.addr;
						b2.DataToSlave <= a1.DataToSlave;
					#1	a1.DataFromSlave <= b2.DataFromSlave;
					   end
				4'h3: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 1;
						b3.RW <= a1.RW;
						b3.addr <= a1.addr;
						b3.DataToSlave <= a1.DataToSlave;
					#1	a1.DataFromSlave <= b3.DataFromSlave;
					   end
                default:begin
                    b0.sel = 0;
                    b1.sel = 0;
                    b2.sel = 0;
                    b3.sel = 0;
                    end 
			endcase	
		end
    if (a2.grant == 1 && a2.xfr ==1 && a2.addr!=0)
		begin
            if(priority_req_flag_m3!=3)
            begin
            case(priority_req_flag_m3)
                0:
                begin
                    priority_req_flag_m3=3;
                    priority_req_flag_m1--;
                    priority_req_flag_m2--;
                    priority_req_flag_m4--;
                end 
                1:
                begin
                    priority_req_flag_m3=3;
                    if(priority_req_flag_m2==2 || priority_req_flag_m2==3 ) priority_req_flag_m2--;
                    if(priority_req_flag_m1==2 ||priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m4==2 || priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
                2:
                begin
                    priority_req_flag_m3=3;
                    if(priority_req_flag_m2==3) priority_req_flag_m2--;
                    if(priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m4==3) priority_req_flag_m4--;
                end 
            endcase 
            end 
            else
            begin
            //no change in flag status 
            end
			case (a2.addr[15:12])
				4'h0: begin
						b0.sel <= 1;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 0;
						b0.RW <= a2.RW;
						b0.addr <= a2.addr;
						b0.DataToSlave <= a2.DataToSlave;
					#1	a2.DataFromSlave <= b0.DataFromSlave;
					   end
				4'h1: begin
						b0.sel <= 0;
						b1.sel <= 1;
						b2.sel <= 0;
						b3.sel <= 0;
						b1.RW <= a2.RW;
						b1.addr <= a2.addr;
						b1.DataToSlave <= a2.DataToSlave;
					#1	a2.DataFromSlave <= b1.DataFromSlave;
					   end
				4'h2: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 1;
						b3.sel <= 0;
						b2.RW <= a2.RW;
						b2.addr <= a2.addr;
						b2.DataToSlave <= a2.DataToSlave;
					#1	a2.DataFromSlave <= b2.DataFromSlave;
					   end
				4'h3: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 1;
						b3.RW <= a2.RW;
						b3.addr <= a2.addr;
						b3.DataToSlave <= a2.DataToSlave;
					#1	a2.DataFromSlave <= b3.DataFromSlave;
					   end
                default:begin
                    b0.sel = 0;
                    b1.sel = 0;
                    b2.sel = 0;
                    b3.sel = 0;
                    end 
			endcase	
		end
		if (a3.grant == 1 && a3.xfr==1 && a3.addr!=0)
		begin
            if(priority_req_flag_m4!=3)
            begin
            case(priority_req_flag_m4)
                0:
                begin
                    priority_req_flag_m4=3;
                    priority_req_flag_m1--;
                    priority_req_flag_m2--;
                    priority_req_flag_m3--;
                end 
                1:
                begin
                    priority_req_flag_m4=3;
                    if(priority_req_flag_m2==2 || priority_req_flag_m2==3) priority_req_flag_m2--;
                    if(priority_req_flag_m1==2 || priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m3==2 || priority_req_flag_m3==3)  priority_req_flag_m3--;
                end 
                2:
                begin
                    priority_req_flag_m4=3;
                    if(priority_req_flag_m2==3) priority_req_flag_m2--;
                    if(priority_req_flag_m1==3) priority_req_flag_m1--;
                    if(priority_req_flag_m3==3) priority_req_flag_m3--;
                end 
            endcase 
            end 
            else
            begin
            //no change in flag status 
            end
			case (a3.addr[15:12])
				4'h0: begin
						b0.sel <= 1;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 0;
						b0.RW <= a3.RW;
						b0.addr <= a3.addr;
						b0.DataToSlave <= a3.DataToSlave;
					#1	a3.DataFromSlave <= b0.DataFromSlave;
					   end
				4'h1: begin
						b0.sel <= 0;
						b1.sel <= 1;
						b2.sel <= 0;
						b3.sel <= 0;
						b1.RW <= a3.RW;
						b1.addr <= a3.addr;
						b1.DataToSlave <= a3.DataToSlave;
					#1	a3.DataFromSlave <= b1.DataFromSlave;
					   end
				4'h2: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 1;
						b3.sel <= 0;
						b2.RW <= a3.RW;
						b2.addr <= a3.addr;
						b2.DataToSlave <= a3.DataToSlave;
					#1	a3.DataFromSlave <= b2.DataFromSlave;
					   end
				4'h3: begin
						b0.sel <= 0;
						b1.sel <= 0;
						b2.sel <= 0;
						b3.sel <= 1;
						b3.RW <= a3.RW;
						b3.addr <= a3.addr;
						b3.DataToSlave <= a3.DataToSlave;
					#1	a3.DataFromSlave <= b3.DataFromSlave;
					   end	
					   
                default:begin
                    b0.sel = 0;
                    b1.sel = 0;
                    b2.sel = 0;
                    b3.sel = 0;
                    end 
			endcase	
		end
    

end 






//I need four registers to store request value
logic[3:0] req_m1_reg,
           req_m2_reg,
           req_m3_reg,
           req_m4_reg,
           req_temp;

            
//**************************************************************************************************            
            
logic bal_one_flag_m1,
      bal_one_flag_m2,
      bal_one_flag_m3,
      bal_one_flag_m4;

always @(*)
begin 
    if(bal0==1)
        bal_one_flag_m1=1;
    if(bal1==1)
        bal_one_flag_m2=1;
    if(bal2==1)
        bal_one_flag_m3=1;
    if(bal3==1)
        bal_one_flag_m4=1;
end 
//***************************************************************************************************

always @ (posedge a0.clk)
begin
        req_m1_reg<=a0.req;
        req_m2_reg<=a1.req;
        req_m3_reg<=a2.req;
        req_m4_reg<=a3.req;
        
end 


always @(*)
begin
     
        


end     //end  of always @(*)



endmodule 
