`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 07:29:24 PM
// Design Name: 
// Module Name: top_module_testbench
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


`timescale 1ns/1ps

module top_module_testbench();
    reg clk;
    reg reset;
    reg player1_button;
    reg player2_button;
    wire [15:0] led;
    wire [7:0] AN_Out;
    wire [6:0] C_Out;

    // Instantiate the top_module
    top_module t1(.clk(clk), .reset(reset), .led(led), .player1_button(player1_button), .player2_button(player2_button), .AN_Out(AN_Out), .C_Out(C_Out));

    // Clock generation
    always begin
        #2 clk = ~clk;
    end

    // Test stimulus
    initial begin
        // Initial conditions
        clk = 0;
        reset = 0;
        player1_button = 0;
        player2_button = 0;

        // Reset the system
        reset = 1;
        #10 reset = 0;
        #50;

        // Test player 1 button press
        player1_button = 0;
        #10 player1_button = 0;
        #90 player1_button = 1;
        #100 player1_button = 0;
        #227 player1_button = 1;
        #50;

        // Test player 2 button press
        player2_button = 1;
        #10 player2_button = 0;
        #50;

        // Test multiple button presses for a game scenario
        repeat(4) begin
            player1_button = 1;
            #10 player1_button = 0;
            #50;
        end

        repeat(3) begin
            player2_button = 1;
            #10 player2_button = 0;
            #50;
        end

        // End the simulation
        $finish;
    end
endmodule
