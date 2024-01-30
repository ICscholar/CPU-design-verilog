`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/23 22:05:08
// Design Name: 
// Module Name: ir
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


module ir(
      clk, rst, en_in, ins, en_out, ir_out  
    );

    input clk,rst,en_in;
    input [15:0] ins;
    output reg en_out;
    output reg [15:0] ir_out;

    always @(posedge clk or negedge rst ) begin
        if(!rst)
        begin
            en_out<=1'b0;
            ir_out<=16'b0000_0000_0000_0000;
        end 
        else 
            begin
                if (en_in==1'b1) begin
                    en_out<=1'b1;
                    ir_out<=ins; 
                end else begin
                    en_out<=1'b0;
                end
            end
    end
endmodule
