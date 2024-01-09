`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 06:11:52 PM
// Design Name: 
// Module Name: moving_ball_testbench
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


`timescale 1ns / 1ps

module moving_ball_testbench;

    reg clk;
    reg reset;
    reg serve_button_player1;
    reg serve_button_player2;
    wire [15:0] led;

    // Instantiate the moving_ball module
    moving_ball moving_ball_inst (
        .clk(clk),
        .reset(reset),
        .serve_button_player1(serve_button_player1),
        .serve_button_player2(serve_button_player2),
        .led(led)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Testbench stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        serve_button_player1 = 0;
        serve_button_player2 = 0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Test scenario 1: Player 1 serves the ball
        #20 serve_button_player1 = 1;
        #10 serve_button_player1 = 0;
        #100;

        // Test scenario 2: Player 2 serves the ball
        #20 serve_button_player1 = 1;
        #10 serve_button_player2 = 0;
        #100;

        // Test scenario 3: Player 1 serves the ball, then Player 2 serves the ball
        #20 serve_button_player1 = 1;
        #10 serve_button_player1 = 0;
        #60 serve_button_player1 = 1;
        #10 serve_button_player2 = 0;
        #100;

        // Test scenario 4: Player 2 serves the ball, then Player 1 serves the ball
        #20 serve_button_player2 = 1;
        #10 serve_button_player2 = 0;
        #60 serve_button_player1 = 1;
        #10 serve_button_player1 = 0;
        #100;

        $finish; // End simulation
    end

endmodule

