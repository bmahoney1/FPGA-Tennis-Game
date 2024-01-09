`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 05:39:56 PM
// Design Name: 
// Module Name: mov_ball
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



//WORK MODULE::::

module mov_ball(

    input clk,
    input slow_clk,
    input reset,
    input button1, //P17
    input button2, //M17
    input squash_switch, 
    output reg [15:0] led,
    output reg [1:0] player1_score,
    output reg [1:0] player2_score,
    output reg [2:0] hit,
    output reg [2:0] player1_match_score,
    output reg [2:0] player2_match_score

    );
    
    reg [2:0] hit_wire;
    reg [3:0] state;
    reg direction;
    //reg [4:0] serve_counter = 0;
    reg [1:0] serving_player = 2'b10;
    reg [1:0] missed_player;
    reg [1:0] temp_player1_score;
    reg [1:0] temp_player2_score;
    reg button1_pressed = 0;
    reg button2_pressed = 0;
    reg squash_button_pressed = 0;
    reg [25:0] button_counter = 26'd0;
    reg [2:0] temp_match_score_p1;
    reg [2:0] temp_match_score_p2;
    
    reg [2:0] player1_pen_count;
    reg [2:0] player2_pen_count; 
    reg [1:0] penalty_player;
    
    
    //for squash:
    
    parameter SERVE = 4'b0001,
              PLAY = 4'b0010,
              UPDATE_SCORE = 4'b0011,
              PENALTY = 4'b0100;
             
 
 always @(posedge clk) begin
    if(reset == 1) begin
        button1_pressed = 0;
        button2_pressed = 0;
        button_counter = 0;
    end
    else begin
        if((button1 == 1) && !button1_pressed) begin // Check if button1_pressed is not already set
            button1_pressed = 1;
        end
        else if((button2 == 1) && !button2_pressed) begin // Check if button2_pressed is not already set       
            button2_pressed = 1;
        end
    
        if(button_counter >= /*27'b101111101110101010000011000*/ 26'b10111110111011001111010000) begin
            button1_pressed = 0;
            button2_pressed = 0;
            button_counter = 26'd0;
        end
        else begin
            if(button1_pressed == 1 || button2_pressed == 1) begin // Increment counter if either button is pressed
                button_counter = button_counter + 1;
            end
        end
    end
end
             
    always @(posedge slow_clk or posedge reset) begin
    
        if(reset) begin
            state <= SERVE;
            led <= 16'b0000000000000001;
            //led[15] <= 0;
            direction <= 1'b0;
            //serve_counter <= 4'b0000;
            serving_player <= 2'b10;
            temp_player1_score = 2'b00;
            temp_player2_score = 2'b00;
            player1_score = 2'b00;
            player2_score = 2'b00;
            player1_match_score = 2'b00;
            player2_match_score = 2'b00;
            temp_match_score_p1 = 3'b000;
            temp_match_score_p2 = 3'b000;
            hit_wire = 3'b000;
           player1_pen_count = 3'b000;
           player2_pen_count = 3'b000;
        end
        else begin
            if(squash_switch == 1) begin
                serving_player  = 2'b10;
                if (player2_pen_count == 2'b00) begin
                    led = 16'b0000000000000001;
                    player2_pen_count = 2'b01;
                    direction = 1;
                end
                else begin
                    if(button2_pressed == 1 && led[0] == 1) begin
                        temp_match_score_p2 = temp_match_score_p2 + 1;
                        hit_wire = hit_wire + 1;
                        direction = ~direction ;
                    end
                    if(direction == 0)begin
                        led = led << 1;
                    end
                        if(led[15] == 1) begin
                        direction = ~direction;
                        end
                        
                      if (direction == 1)begin
                          led = led >> 1;
                      end
                 end
                 
                 player2_match_score = temp_match_score_p2;
                 hit = hit_wire; 
            end     
            
            else begin
            //normal
            case(state) 
                SERVE: begin
                    
                    if(serving_player == 2'b01) begin
                        led = 16'b1000000000000000;
                    end
                    else if(serving_player == 2'b10) begin
                        led = 16'b0000000000000001;
                    end
                
                    if(button1_pressed == 1) begin
                        direction <= 0;
                        state <= PLAY;
                    end
                    else if(button2_pressed == 1) begin
                        direction <= 1;
                        state <= PLAY;
                    end
                    
                    player1_pen_count = 3'b000;
                    player2_pen_count = 3'b000;
                    
                end 
                
                PLAY: begin
                    if(direction == 1) begin //if direction is 1, then the ball propagates to the left
                        led = led << 1; 
                    end
                    else begin
                        led = led >> 1;
                    end
                    
                    if(led[15] == 1 && button1_pressed == 1) begin //when player1 hits the button at the right time
                        direction = ~direction;
                        state <= PLAY;
                        hit_wire = hit_wire +1;
                        hit = hit_wire;
                        player1_pen_count <= 3'b000;
                    end
                    //adding for penalty:
                    else if(led[15] == 0 && button1_pressed == 1) begin
                        if(player1_pen_count < 3'b011) begin
                            player1_pen_count = player1_pen_count + 3'b001;  
                            state <= PLAY;                
                        end
                        else begin
                            missed_player <= 2'b01;
                            serving_player <= 2'b01;
                            state <= UPDATE_SCORE;
                            player1_pen_count <= 3'b000;
                            player2_pen_count <= 3'b000; 
                        end
                    end                 
                    //end penalty
                    else if(led[15] == 1 && button1_pressed == 0) begin //when player1 misses the ball    
                        missed_player <= 2'b01;
                        player1_pen_count <= 3'b000;
                        player2_pen_count <= 3'b000;
                        state <= UPDATE_SCORE;
                    end
                    
                    //had else if here before
                    if(led[0] == 1 && button2_pressed == 1) begin //when player2 hits the ball
                        direction = ~direction;
                        state <= PLAY;
                        hit_wire = hit_wire +1;
                        hit = hit_wire;
                        player2_pen_count <= 3'b000;
                        player1_pen_count <= 3'b000;
                    end
                    //adding for penalty:
                    
                    else if(led[0] == 0 && button2_pressed == 1) begin
                        if(player2_pen_count < 3'b011) begin
                            player2_pen_count = player2_pen_count + 3'b001;
                            state <= PLAY;
                        end
                        else begin
                            missed_player <= 2'b10;
                            serving_player <= 2'b10;
                            state <= UPDATE_SCORE;
                            player2_pen_count <= 3'b000;
                            player1_pen_count <= 3'b000;
                        end
                    end
                    
                    //end penalty
                    else if(led[0] == 1 && button2_pressed == 0) begin //when player2 misses the ball
                    missed_player <= 2'b10;
                    player2_pen_count <= 3'b000;
                    player1_pen_count <= 3'b000;
                    state <= UPDATE_SCORE;
                    end       
                end
                  
                
                UPDATE_SCORE: begin
                     //new:
                     player1_pen_count = 3'b000;
                     player2_pen_count = 3'b000;
                     if(missed_player == 2'b01) begin //if player1 missed the ball, player2 gets a point
                        temp_player2_score = temp_player2_score + 1;
                        state <= SERVE;
                    //for match score:
                    if(temp_player2_score == 3) begin
                        temp_match_score_p2 = temp_match_score_p2 + 1;
                        temp_player2_score = 0;
                        temp_player1_score = 0;
                        player2_match_score <= temp_match_score_p2; // Add this line
                    end
                    //state <= SERVE;
                end
                else if(missed_player == 2'b10) begin
                    temp_player1_score = temp_player1_score + 1;
                    state <= SERVE;
                    //for match score:
                    if(temp_player1_score == 3) begin
                        temp_match_score_p1 = temp_match_score_p1 + 1;
                        temp_player1_score = 0;
                        temp_player2_score = 0;
                        player1_match_score <= temp_match_score_p1; // Add this line
                    end
                    //state <= SERVE;
                end
   
                //what I had before: 
                if(serving_player == 2'b01) begin
                    serving_player <= 2'b10;
                    //led[0] <= 0;
                    
                end
                    else begin
                        serving_player <= 2'b01;
                        //led[15] <= 0;
                    end
                player1_score = temp_player1_score;
                player2_score = temp_player2_score;
            
                end
                          
            endcase
        end
        
          end
    end  
    
    
endmodule
