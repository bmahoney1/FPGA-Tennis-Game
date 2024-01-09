`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2023 10:36:33 PM
// Design Name: 
// Module Name: SevenLEDDemo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module SevenLEDDemo(clk,rst,player1_score, player2_score, player1_match_score, player2_match_score, squash_switch, AN_Out,C_Out);

input clk,rst;
input [1:0] player1_score;
input [1:0] player2_score;
input [2:0] player1_match_score;
input [2:0] player2_match_score;
input squash_switch;
output [7:0] AN_Out;
output [6:0] C_Out;

reg [7:0] AN_In; 
reg [55:0] C_In;

reg [4:0] condition;

//parameter ONE = 7'b0000110, THREE=7'b1001111,C=7'b0111001,E=7'b1111001; 

//parameter for Tennis:
parameter NUM_0 = 7'b0111111,
          NUM_1 = 7'b0000110, 
          NUM_2 = 7'b1011011,
          NUM_3 = 7'b1001111,
          NUM_4 = 7'b1100110,
          NUM_5 = 7'b1101101,
          NUM_6 = 7'b1111101,
          NUM_7 = 7'b1100111,
          NUM_8 = 7'b1111111,
          NUM_9 = 7'b1100111,
          CHAR_P = 7'b1110011;
          
reg [6:0] p1_match_variable, p2_match_variable;
reg [6:0] p1_score_variable, p2_score_variable;
reg [6:0] p1_win_p_variable, p2_win_p_variable;

reg normal_or_winning;

////to check if the match score goes up by one:
//reg [2:0] check_p1_score;
//reg [2:0] check_p2_score;


SevenSegmentLED SevenSegmentLED(.clk(clk),.rst(rst),.AN_In(AN_In),.C_In(C_In),.AN_Out(AN_Out),.C_Out(C_Out));

always @ (posedge clk or posedge rst)
begin
    if(rst)
    begin
        AN_In <= 8'h0;
        C_In <= 56'h0;
        C_In <= {NUM_0, 7'd0, NUM_0, 7'd0, 7'd0, NUM_0, 7'd0, NUM_0};
    end
    else begin
        if(squash_switch == 1) begin
            //squash here
            if(player2_match_score == 3'b000) begin
                p2_match_variable = NUM_0;
            end
            else if(player2_match_score == 3'b001) begin
                p2_match_variable = NUM_1;
            end
            else if(player2_match_score == 3'b010) begin
                p2_match_variable = NUM_2;
            end
            else if(player2_match_score == 3'b011) begin
                p2_match_variable = NUM_3;
            end
            else if(player2_match_score == 3'b100) begin
                p2_match_variable = NUM_4;
            end
            else if(player2_match_score == 3'b101) begin
                p2_match_variable = NUM_5;
            end
            else if(player2_match_score == 3'b110) begin
                p2_match_variable = NUM_6;
            end
            else if(player2_match_score == 3'b111) begin
                p2_match_variable = NUM_7;
            end
                                  
            AN_In <= 8'b11100111;
            C_In <= {7'd0, 7'd0, 7'd0, 7'd0, 7'd0, 7'd0, p2_match_variable, 7'd0};
        end
        
        else begin
            if(player1_match_score == 3'b011 || player2_match_score == 3'b011) begin
        if(player1_match_score == 3'b011) begin
            AN_In <= 8'b11100111;
            C_In <= {7'd0,CHAR_P,NUM_1,7'd0,7'd0, 7'd0,7'd0,7'd0};
        end
        else if(player2_match_score == 3'b011) begin
            AN_In <= 8'b11100111;
            C_In <= {7'd0,7'd0,7'd0,7'd0,7'd0, CHAR_P,NUM_2,7'd0};
        end
    end
    else begin 
        //new part:
        if(player1_match_score == 3'b000) begin
            p1_match_variable = 7'b0111111; //0
        end
        else if(player1_match_score == 3'b001) begin
            p1_match_variable = 7'b0000110; //1
        end
        else if(player1_match_score == 3'b010) begin
            p1_match_variable = 7'b1011011;
        end
        

        
        
        if(player2_match_score == 3'b000) begin
            p2_match_variable = 7'b0111111; //0
        end
        else if(player2_match_score == 3'b001) begin
            p2_match_variable = 7'b0000110; //1
        end
        else if(player2_match_score == 3'b010) begin
            p2_match_variable = 7'b1011011;
        end
        
        
        if(player1_score == 2'b00) begin 
            p1_score_variable = 7'b0111111; //0
        end
        else if(player1_score == 2'b01) begin
            p1_score_variable = 7'b0000110;
        end
        else if(player1_score == 2'b010) begin
            p1_score_variable = NUM_2;
        end
        
        
        if(player2_score == 2'b00) begin 
            p2_score_variable = 7'b0111111; //0
        end
        else if(player2_score == 2'b01) begin
            p2_score_variable = 7'b0000110;
        end
        else if(player2_score == 2'b010) begin
            p2_score_variable = NUM_2;
        end
        //for squash:
//        else if(player2_score == 3'b011) begin
//            p2_score_variable = NUM_3;
//        end
//        else if(player2_score == 3'b100) begin
//            p2_score_variable = NUM_4;
//        end
//        else if(player2_score == 3'b101) begin
//            p2_score_variable = NUM_5;
//        end
//        else if(player2_score == 3'b110) begin
//            p2_score_variable = NUM_6;
//        end
//        else if(player2_score == 3'b111) begin
//            p2_score_variable = NUM_7;
//        end
        
        AN_In <= 8'b11100111;
        C_In <= {p1_match_variable,7'd0,p1_score_variable,7'd0,7'd0, p2_score_variable,7'd0,p2_match_variable};
    end
            end
        end
end

endmodule