`timescale 1ns / 1ps

module seg7decimal(

	input [31:0] x,
    input clk,
    output reg [6:0] seg,
    output reg [7:0] an,
    output wire dp 
	 );
	 
	 
wire [2:0] s;	 
reg [3:0] digit;
wire [7:0] aen;
reg [19:0] clkdiv;
reg [31:0] display;

assign dp = 1;
assign s = clkdiv[19:17];
assign aen = 8'b11111111; // all turned off initially

// quad 4to1 MUX.


always @(posedge clk)// or posedge clr)
	
	case(s)
	0:digit = display[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
	1:digit = display[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
	2:digit = display[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
	3:digit = display[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]
	4:digit = display[19:16]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to x[3:0]
    5:digit = display[23:20]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to x[7:4]
    6:digit = display[27:24]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to x[11:8
    7:digit = display[31:28]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to x[15:12]

	default:digit = display[3:0];
	
	endcase

always@(*)
       case(x[7:0])
		      8'b00010101:display[7:0]<=8'h11;   
			  8'b00011101:display[7:0]<=8'h12;   
			  8'b00100100:display[7:0]<=8'h13;  
			  8'b00101101:display[7:0]<=8'h14;   
              8'b00101100:display[7:0]<=8'h15;   
              8'b00110101:display[7:0]<=8'h16;   
              8'b00111100:display[7:0]<=8'h17; 		  
              8'b00011100:display[7:0]<=8'h21; 
              8'b00011011:display[7:0]<=8'h22; 
              8'b00100011:display[7:0]<=8'h23; 
              8'b00101011:display[7:0]<=8'h24; 
			  8'b00110100:display[7:0]<=8'h25; 
			  8'b00110011:display[7:0]<=8'h26; 
			  8'b00111011:display[7:0]<=8'h27; 
			  8'b00011010:display[7:0]<=8'h31; 
			  8'b00100010:display[7:0]<=8'h32; 
			  8'b00100001:display[7:0]<=8'h33; 
			  8'b00101010:display[7:0]<=8'h34; 
			  8'b00110010:display[7:0]<=8'h35; 
			  8'b00110001:display[7:0]<=8'h36; 
			  8'b00111010:display[7:0]<=8'h37; 
			  default:display[7:0]<=8'h00;
	   endcase	
always@(*)	   
	   case(x[15:8])
		      8'b00010101:display[15:8]<=8'h11;  
			  8'b00011101:display[15:8]<=8'h12;  
			  8'b00100100:display[15:8]<=8'h13;  
			  8'b00101101:display[15:8]<=8'h14;  
              8'b00101100:display[15:8]<=8'h15;  
              8'b00110101:display[15:8]<=8'h16;  
              8'b00111100:display[15:8]<=8'h17;  	  
              8'b00011100:display[15:8]<=8'h21;  
              8'b00011011:display[15:8]<=8'h22;  
              8'b00100011:display[15:8]<=8'h23; 
              8'b00101011:display[15:8]<=8'h24; 
			  8'b00110100:display[15:8]<=8'h25;  
			  8'b00110011:display[15:8]<=8'h26;  
			  8'b00111011:display[15:8]<=8'h27;  
			  8'b00011010:display[15:8]<=8'h31;  
			  8'b00100010:display[15:8]<=8'h32;  
			  8'b00100001:display[15:8]<=8'h33;  
			  8'b00101010:display[15:8]<=8'h34;  
			  8'b00110010:display[15:8]<=8'h35; 
			  8'b00110001:display[15:8]<=8'h36; 
			  8'b00111010:display[15:8]<=8'h37; 
			  default:display[15:8]<=8'h00;
	   endcase	

always@(*)	   
	   case(x[23:16])
		      8'b00010101:display[23:16]<=8'h11;  //Q -- do     
			  8'b00011101:display[23:16]<=8'h12;  //W -- rai    
			  8'b00100100:display[23:16]<=8'h13;  //E -- mi     
			  8'b00101101:display[23:16]<=8'h14;  //R -- fa     
              8'b00101100:display[23:16]<=8'h15;  //T  -- 
              8'b00110101:display[23:16]<=8'h16;  //Y  -- 
              8'b00111100:display[23:16]<=8'h17;  //U  -- 	  
              8'b00011100:display[23:16]<=8'h21;   //A  --
              8'b00011011:display[23:16]<=8'h22;   //S  --
              8'b00100011:display[23:16]<=8'h23;  //D  -- 
              8'b00101011:display[23:16]<=8'h24;  //F  -- 
			  8'b00110100:display[23:16]<=8'h25;  //G  --  so   
			  8'b00110011:display[23:16]<=8'h26;  //H  --  la   
			  8'b00111011:display[23:16]<=8'h27;  //J  --  xi   
			  8'b00011010:display[23:16]<=8'h31;  //Z  --  do   
			  8'b00100010:display[23:16]<=8'h32;  //X  --  rai  
			  8'b00100001:display[23:16]<=8'h33;  //C  --  mi   
			  8'b00101010:display[23:16]<=8'h34;  //V  --  fa   
			  8'b00110010:display[23:16]<=8'h35;  //B  --  so   
			  8'b00110001:display[23:16]<=8'h36;  //N  --  la   
			  8'b00111010:display[23:16]<=8'h37;  //M  --  xi   
			  default:display[23:16]<=8'h00;
	   endcase		
	
always@(*)	   
	   case(x[31:24])
		      8'b00010101:display[31:24]<=8'h11;  //Q -- do     
			  8'b00011101:display[31:24]<=8'h12;  //W -- rai     
			  8'b00100100:display[31:24]<=8'h13;  //E -- mi     
			  8'b00101101:display[31:24]<=8'h14;  //R -- fa     
              8'b00101100:display[31:24]<=8'h15;    //T  -- 
              8'b00110101:display[31:24]<=8'h16;    //Y  -- 
              8'b00111100:display[31:24]<=8'h17;    //U  --   
              8'b00011100:display[31:24]<=8'h21;    //A  --
              8'b00011011:display[31:24]<=8'h22;    //S  --
              8'b00100011:display[31:24]<=8'h23;   //D  -- 
              8'b00101011:display[31:24]<=8'h24;   //F  -- 
			  8'b00110100:display[31:24]<=8'h25;  //G  --  so    
			  8'b00110011:display[31:24]<=8'h26;  //H  --  la    
			  8'b00111011:display[31:24]<=8'h27;  //J  --  xi    
			  8'b00011010:display[31:24]<=8'h31;  //Z  --  do    
			  8'b00100010:display[31:24]<=8'h32;  //X  --  rai  
			  8'b00100001:display[31:24]<=8'h33;  //C  --  mi   
			  8'b00101010:display[31:24]<=8'h34;  //V  --  fa   
			  8'b00110010:display[31:24]<=8'h35;  //B  --  so   
			  8'b00110001:display[31:24]<=8'h36;  //N  --  la   
			  8'b00111010:display[31:24]<=8'h37;  //M  --  xi   
			  default:display[31:24]<=8'h00;
	   endcase		
	   
	   
	//decoder or truth-table for 7seg display values
always @(*)

case(digit)


//////////<---MSB-LSB<---
//////////////gfedcba////////////////////////////////////////////          
0:seg = 7'b1000000;////0000															
1:seg = 7'b1111001;////0001									 
2:seg = 7'b0100100;////0010									
//                                                                      
3:seg = 7'b0110000;////0011										 	 
4:seg = 7'b0011001;////0100										       
5:seg = 7'b0010010;////0101                                              
6:seg = 7'b0000010;////0110
7:seg = 7'b1111000;////0111
8:seg = 7'b0000000;////1000
9:seg = 7'b0010000;////1001
'hA:seg = 7'b0001000; 
'hB:seg = 7'b0000011; 
'hC:seg = 7'b1000110;
'hD:seg = 7'b0100001;
'hE:seg = 7'b0000110;
'hF:seg = 7'b0001110;

default: seg = 7'b0000000; // U

endcase


always @(*)begin
an=8'b11111111;
if(aen[s] == 1)
an[s] = 0;
end


//clkdiv

always @(posedge clk) begin
clkdiv <= clkdiv+1;
end


endmodule
