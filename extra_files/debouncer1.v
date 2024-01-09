`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2023 05:35:02 PM
// Design Name: 
// Module Name: debouncer
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

/*
module debouncer1(clk, butt, clean);
 
    reg out_exist;
    reg [21:0] deb_cout;
    //reg [21:0] max = 22'b1011011100011011000000;
    reg [21:0] max = 1'b1;
    input clk, butt;
    output reg clean;
    
    initial begin
        clean <= 0;
        out_exist <= 0;
        deb_cout <= 0;
    end
    
    always @(posedge clk) begin
        if(butt ==1) begin
            if(out_exist == 0) begin
                if(deb_cout == max) begin
                    clean <= 1;
                    deb_cout <= 0;
                    out_exist <= 1;
                end
                else
                    deb_cout <= deb_cout + 1;
                end
            else begin
                clean <= 0;
            end
        end
        else begin
            clean <= 0;
            out_exist <= 0;
            deb_cout <= 0;
        end
    end
    
endmodule
*/

/*
module debouncer1 (
    input clk,
    input reset,
    input button_push,
    output reg clean
);

    reg [15:0] deb_counter;
    reg output_exist;

    always @(posedge clk) begin
        if (reset) begin
            deb_counter <= 0;
            clean <= 0;
            output_exist <= 0;
        end else begin
            if (button_push) begin
                if (output_exist == 0) begin
                    if (deb_counter != 16'hFFFF) begin
                        deb_counter <= deb_counter + 1;
                    end
                end
            end else begin
                clean <= 0;
                deb_counter <= 0;
                output_exist <= 0;
            end
        end

        if (deb_counter == 16'hFFFF) begin
            clean <= 1;
            output_exist <= 1;
            deb_counter <= 0;
        end
    end

endmodule
*/
module debouncer1(
    input clk,
    input reset,
    input button_push,
    output reg clean
    );
   
    reg [19:0] deb_count;
    reg output_exist;
    parameter top_count=14'b10011100010000;
    always@ (posedge clk) begin
        if (reset) begin
            deb_count = 0;
            clean = 0;
            output_exist = 0;
        end else begin
            if (button_push == 1) begin
                if (output_exist == 0)
                begin
                    if (deb_count != top_count)
                    begin
                        deb_count = deb_count + 16'd1;
                    end
                end
                else begin
                    clean = 0;
                end
            end
            else begin
                clean = 0;
                deb_count = 0;
                output_exist = 0;
            end
            end
           
        if (deb_count == top_count) begin
                clean = 1;
                output_exist = 1;
                deb_count = 0;
        end
    end
endmodule
