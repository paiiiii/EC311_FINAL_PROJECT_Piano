
module top_final(
     input  clk,        //Basys2 clock 50MHz
	 input  PS2C,       //PS2 clock
	 input  PS2D,       //PS2 data
	 output  [6:0] seg,  //7_seg    
	 output  [7:0] an,   
	 output speaker,  
	 output UART_TXD       
    );
	 wire [31:0]key_code;
	 
    PS2Receiver(
	 .clk(clk),
	 .kclk(PS2C),
	 .kdata(PS2D),
	 .keycodeout(key_code)
	 );
	 
	 melody(
	 .clk(clk),
	 .switch(key_code[7:0]),
	 .speaker(speaker)
	 );
	 

	 
	 seg7decimal sevenSeg (
    .x(key_code[31:0]),
    .clk(clk),
    .seg(seg[6:0]),
    .an(an[7:0]),
    .dp(DP) 
    );
	 
	 endmodule
