`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/23 17:43:17
// Design Name: 
// Module Name: register
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


module register(
clk, rst,en, d, q
    );
    input clk,rst, en;
    input [15:0] d;
    output reg [15:0] q;
    always @(posedge clk or negedge rst ) begin
        if(!rst)
            q<=16'b0000_0000_0000_0000;
        else
            begin
                if(en==1)
                q<=d;
            end

    end
endmodule
