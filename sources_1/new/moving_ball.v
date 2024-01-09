`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2023 07:28:26 PM
// Design Name: 
// Module Name: moving_ball
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


module moving_ball(clk, reset, serve_button_player1, serve_button_player2, led);

    

    input clk;
    input reset;
    input serve_button_player1;
    input serve_button_player2;
    output reg [15:0] led;
    
    reg direction;
   
    
    
    //asynchronously change the direction:
    always @(*)begin
        if(led[15] == 1 && serve_button_player1 == 1)begin
            direction = 1'b0; //going right
        end
        else if(led[0] == 1 && serve_button_player2 == 1)begin
            direction = 1'b1; //going left
        end
    end
   
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 15'd1; //start with 1 
            direction <= 1'b1;
        end
        else begin
            if(direction == 1'b0)begin //if player 1 hits the button and the LED[15] is on, then it bounces the ball to the other direction
                led = led >> 1;
            end
            if(direction == 1'b1)begin //if player 2 hits the button and the LED[0] is on, then it bounces the ball to the other direction
                led = led << 1;
            end
        end
    end
    
endmodule


/*
module moving_ball(clk, reset, serve_button_player1, serve_button_player2, led);

    input clk;
    input reset;
    input serve_button_player1;
    input serve_button_player2;
    output reg [15:0] led;
    
    reg direction;
    reg change_direction;
    
    //asynchronously change the direction:
    always @(*)begin
        if(led[15] == 1 && serve_button_player1 == 1)begin
            change_direction = 1'b1;
            direction = 1'b0; //going right
        end
        else if(led[0] == 1 && serve_button_player2 == 1)begin
            change_direction = 1'b1;
            direction = 1'b1; //going left
        end
        else begin
            change_direction = 1'b0;
        end
    end
   
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 16'h0001; //start with 1 
            direction <= 1'b1;
        end
        else begin
            if (change_direction == 1'b0) begin
                if(direction == 1'b0)begin //going right
                    led <= led >> 1;
                end
                else if(direction == 1'b1)begin //going left
                    led <= led << 1;
                end
            end
        end
    end
    
endmodule
*/

/*
module moving_ball(clk, reset, serve_button_player1, serve_button_player2, led);

    input clk;
    input reset;
    input serve_button_player1;
    input serve_button_player2;
    output reg [15:0] led;
    
    reg direction;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 16'b0000000000000001; // Start with 1
            //direction <= 1'b1;
        end
        else begin
            if(led[15] == 1 && serve_button_player1 == 1) begin
                direction <= 1'b0; // Going right
            end
            else if(led[0] == 1 && serve_button_player2 == 1) begin
                direction <= 1'b1; // Going left
            end

            if(direction == 1'b0) begin // If player 1 hits the button and the LED[15] is on, then it bounces the ball to the other direction
                led <= led >> 1;
            end
            else if(direction == 1'b1) begin // If player 2 hits the button and the LED[0] is on, then it bounces the ball to the other direction
                led <= led << 1;
            end
        end
    end
    
endmodule
*/

/*
module moving_ball(clk, reset, serve_button_player1, serve_button_player2, led);

    input clk;
    input reset;
    input serve_button_player1;
    input serve_button_player2;
    output reg [15:0] led;
    
    reg direction;
    reg [15:0] next_led;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            led <= 16'b0000000000000001; // Start with 1
            direction <= 1'b1;
        end
        else begin
            next_led = led;
            if(led[15] == 1 && serve_button_player1 == 1) begin
                direction <= 1'b0; // Going right
            end
            else if(led[0] == 1 && serve_button_player2 == 1) begin
                direction <= 1'b1; // Going left
            end

            if(direction == 1'b0) begin // If player 1 hits the button and the LED[15] is on, then it bounces the ball to the other direction
                next_led = led >> 1;
            end
            else if(direction == 1'b1) begin // If player 2 hits the button and the LED[0] is on, then it bounces the ball to the other direction
                next_led = led << 1;
            end
            led <= next_led;
        end
    end
    
endmodule
*/
