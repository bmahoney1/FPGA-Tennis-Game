`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 08:16:52 PM
// Design Name: 
// Module Name: top_module
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


module top_module(clk, reset, led, player1_button, player2_button, squash_switch, AN_Out, C_Out);

    input clk;
    input reset;
    input player1_button;
    input player2_button; 
    input squash_switch;
    output wire [15:0] led;
    
    wire divided_clk_output;
    wire player1_wire_output;
    wire player2_wire_output;
    wire [1:0] player1_score_wire;
    wire [1:0] player2_score_wire;
    
    //wire [2:0] speed_value_wire;  
    wire [2:0] hit_wire;
    
    //match score wire:
    wire [2:0] player1_match_score_wire;
    wire [2:0] player2_match_score_wire;
    
    
    output [7:0] AN_Out;
    output [6:0] C_Out;

    clk_divider c1(.clk_in(clk), .rst(reset), .hit(hit_wire), .divided_clk(divided_clk_output)); //output of the clock divider becomes the clock input for moving_ball
    //moving_ball m1(.clk(divided_clk_output), .reset(reset), .serve_button_player1(player1_button), .serve_button_player2(player2_button), .led(led));
    mov_ball m1(.clk(clk), .slow_clk(divided_clk_output), .reset(reset), .button1(player1_wire_output), .button2(player2_wire_output), .squash_switch(squash_switch), .led(led), .player1_score(player1_score_wire), .player2_score(player2_score_wire), .hit(hit_wire), .player1_match_score(player1_match_score_wire), .player2_match_score(player2_match_score_wire));
    
    //for buttons:
    //debouncer1 d1(.clk(clk), .butt(reset), .clean(reset_output)); //debouncer for reset button
    //debouncer1 d2(.clk(clk), .butt(player1_button), .clean(player1_wire_output));
    //debouncer1 d3(.clk(clk), .butt(player2_button), .clean(player2_wire_output));
    //debouncer1 d1(.clk(clk), .reset(reset), .button_push(reset), .clean(reset_wire_output));
    debouncer1 d2(.clk(clk), .reset(reset), .button_push(player1_button), .clean(player1_wire_output));
    debouncer1 d3(.clk(clk), .reset(reset), .button_push(player2_button), .clean(player2_wire_output));
    //debouncer1 d4(.clk(clk), .reset(reset), .button_push(squash_button), .clean(squash_wire_output));
    
    //always @(posedge clk) begin
    //    player1_sync_score <= player1_score_wire;
    //    player2_sync_score <= player2_score_wire;
   // end
    //for LED:
    SevenLEDDemo s1(.clk(clk), .rst(reset), .player1_score(player1_score_wire), .player2_score(player2_score_wire), .player1_match_score(player1_match_score_wire), .player2_match_score(player2_match_score_wire), .squash_switch(squash_switch), .AN_Out(AN_Out), .C_Out(C_Out));
    
endmodule
