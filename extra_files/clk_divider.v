`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Module Name:    clk_divider 

// Dependencies: Generates a clock with period X ms, from 40 MHz input clock, T=2.5E-5 ms
//						A counter counts till toggle_value = 'b111111111111111111111

// You have to decide what should be the value of toggle_value to be able make the slow down
// the clock to 1 Hz. X ms will be depend on your toggle_value choice.
//////////////////////////////////////////////////////////////////////////////////
/*
module clk_divider(
	input clk_in,
	input rst,
	input [2:0] speed_count,
	output reg divided_clk
    );
    
   localparam [24:0] initial_speed = 25'b1001100010010110100000000;
	 
	 
//parameter toggle_value = 26'b10011000100101101000000000; //40 million -> 1 secs  --< correct
//parameter toggle_value = 2'b11; //40 million -> 1 secs 
parameter toggle_value = 25'b1001100010010110100000000; 

	 
reg[24:0] cnt;


always@(posedge clk_in or posedge rst)
begin
	if (rst==1) begin
		cnt <= 0;
		divided_clk <= 0;
	end
	else begin
	   
		if (cnt==toggle_value) begin
			cnt <= 0;
			divided_clk <= ~divided_clk;
		end
		else begin
			cnt <= cnt +1;
			divided_clk <= divided_clk;		
		end
	end

end
			  
	


endmodule
*/

module clk_divider(
	input clk_in,
	input rst,
	input [2:0] hit,
	output reg divided_clk
    );
 
	 
	 
//parameter toggle_value = 26'b10011000100101101000000000; //40 million -> 1 secs  --< correct
//parameter toggle_value = 2'b11; //40 million -> 1 secs 
parameter toggle_value = 25'b1001100010010110100000000; 

	 
reg[24:0] cnt;


always@(posedge clk_in or posedge rst)
begin
	if (rst==1) begin
		cnt <= 0;
		divided_clk <= 0;
	end
	else begin
	   
		if ( cnt == (toggle_value - (hit * 21'b111101000010010000000))) begin //2 mil
			cnt <= 0;
			divided_clk <= ~divided_clk;
		end
		else begin
			cnt <= cnt +1;
			divided_clk <= divided_clk;		
		end
	end

end
			  
	


endmodule
