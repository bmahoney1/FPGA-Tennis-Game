`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 12:52:47 PM
// Design Name: 
// Module Name: mov_ball_testbench
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


module mov_ball_testbench;

    reg clk;
    reg reset;
    reg button1;
    reg button2;
    wire [15:0] led;

    // Instantiate the mov_ball module
    mov_ball mov_ball_inst (
        .clk(clk),
        .reset(reset),
        .button1(button1),
        .button2(button2),
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
        button1 = 0;
        button2 = 0;

        // Apply reset
        reset = 1;
        #10 reset = 0;

        // Test scenario 1: Player 1 serves the ball
        #20 button1 = 1;
        #10 button1 = 0;
        #100;

        // Test scenario 2: Player 2 serves the ball
        #20 button2 = 1;
        #10 button2 = 0;
        #100;

        // Test scenario 3: Player 1 serves the ball, then Player 2 serves the ball
        #20 button1 = 1;
        #10 button1 = 0;
        #60 button2 = 1;
        #10 button2 = 0;
        #100;

        // Test scenario 4: Player 2 serves the ball, then Player 1 serves the ball
        #20 button2 = 1;
        #10 button2 = 0;
        #60 button1 = 1;
        #10 button1 = 0;
        #100;

        $finish; // End simulation
    end

endmodule


//`timescale 1ns / 1ps

//module mov_ball_testbench;

//    reg clk;
//    reg clk_40MHz;
//    reg reset;
//    reg button1;
//    reg button2;
//    wire [15:0] led;

//    // Clock frequency dividers
//    integer clock_divider;
//    reg [21:0] clk_counter;

//    // Instantiate the mov_ball module
//    mov_ball mov_ball_inst (
//        .clk(clk_40MHz),
//        .reset(reset),
//        .button1(button1),
//        .button2(button2),
//        .led(led)
//    );

//    // Clock generation
//    always begin
//        #5 clk = ~clk;
//    end

//    // 40 MHz clock generation
//    always @(posedge clk) begin
//        if (clk_counter == 22'b1011011100011011000000 - 1) begin
//            clk_counter <= 0;
//            clk_40MHz <= ~clk_40MHz;
//        end
//        else begin
//            clk_counter <= clk_counter + 1;
//        end
//    end

//    // Testbench stimulus
//    initial begin
//        // Initialize signals
//        clk = 0;
//        clk_40MHz = 0;
//        reset = 0;
//        button1 = 0;
//        button2 = 0;

//        // Apply reset
//        reset = 1;
//        #10 reset = 0;

//        // Test scenario 1: Player 1 serves the ball
//        #800000 button1 = 1;
//        #400000 button1 = 0;
//        #4000000;

//        // Test scenario 2: Player 2 serves the ball
//        #800000 button2 = 1;
//        #400000 button2 = 0;
//        #4000000;

//        // Test scenario 3: Player 1 serves the ball, then Player 2 serves the ball
//        #800000 button1 = 1;
//        #400000 button1 = 0;
//        #2400000 button2 = 1;
//        #400000 button2 = 0;
//        #4000000;

//        // Test scenario 4: Player 2 serves the ball, then Player 1 serves the ball
//        #800000 button2 = 1;
//        #400000 button2 = 0;
//        #2400000 button1 = 1;
//        #400000 button1 = 0;
//        #4000000;

//        $finish; // End simulation
//    end

//endmodule

