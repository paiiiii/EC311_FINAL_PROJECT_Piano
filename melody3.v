
module melody(
    input clk,
	 input [7:0]switch,
	 output reg speaker
    );
  reg [5:0]count1;
  reg [30:0] count2;
  reg clk_1mhz;
  reg [12:0] origin;
  reg carry;
  reg [12:0]divider;
  reg [7:0] s_200;
  reg [7:0] s_o;
  
	initial begin
		count1<=0;
		carry<=0;
		clk_1mhz<=0;
		origin<=0;
		carry<=0;
		divider<=0;
	end	
   
	always@(posedge clk)
	    begin
		    if(s_o==switch)
			    begin
				    if(count2<=25000000)
					    begin
							 count2<=count2+1;
							 s_200<=switch;
						 end
                else
                   begin
                      s_200<=0;
							 count2<=count2+1;
						 end
             end	
          else
             begin
                s_o<=switch;
                count2<=0;
             end
      end			
	
	
	always@(posedge clk)
	  begin
		  if(count1<25)
			  begin
				  count1<=count1+1;
			  end
		  else
			  begin
				  count1<=0;
				  clk_1mhz<=~clk_1mhz;
			  end
	  end
	  
  
	 
   always@(posedge clk_1mhz)
         begin
            if(divider<2000)
               begin
                  divider<=divider+1;
                  carry<=0;
               end
            else if(divider==2000)
               begin
                  carry<=1;
                  divider<=origin;
               end
				else	
				   begin  
					  carry<=1;
					  divider<=0;
					end  
         end
   
   always@(posedge carry) 
      begin
		      if(origin>2000)
				   speaker<=0;
				else
               speaker<=~speaker;
      end
		
		
   always@(*)
      begin
         case(s_200)
		   8'b00010101:origin=92;    //Q -- do
		   8'b00011101:origin=300;   //W -- rai
		   8'b00100100:origin=485;   //E -- mi
		   8'b00101101:origin=567;   //R -- fa
           8'b00101100:origin=724;   //T  --  so
           8'b00110101:origin=864;   //Y  --  la
           8'b00111100:origin=988;   //U  --  xi			  
           8'b00011100:origin=1044;   //A  --  do
           8'b00011011:origin=1150;   //S  --  rai
           8'b00100011:origin=1240;  //D  --  mi
           8'b00101011:origin=1284;  //F  --  fa
		   8'b00110100:origin=1362;  //G  --  so
		   8'b00110011:origin=1432;  //H  --  la
		   8'b00111011:origin=1494;  //J  --  xi
		   8'b00011010:origin=1522;  //Z  --  do
		   8'b00100010:origin=1574;  //X  --  rai
		   8'b00100001:origin=1621;  //C  --  mi
		   8'b00101010:origin=1640;  //V  --  fa 
		   8'b00110010:origin=1681;  //B  --  so
		   8'b00110001:origin=1716;  //N  --  la
		   8'b00111010:origin=1746;  //M  --  xi
			  default:origin=3000;
         endcase
      end
	 
endmodule
