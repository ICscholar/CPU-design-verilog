`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/12 19:49:25
// Design Name:
// Module Name: alu
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
`define resetB 4'b0000
`define AaddB 4'b0001
`define AsubB 4'b0010
`define AmulB 4'b0011
`define AdivB 4'b0100
`define AandB 4'b0101
`define AorB 4'b0110
`define comp 4'b0111
`define left_shift 4'b1000
`define right_shift 4'b1001

module alu(clk,
           rst,
           en_in,
           alu_a,
           alu_b,
           alu_func,
           en_out,
           alu_out);
    input [15:0]alu_a,alu_b;
    input clk,rst,en_in;
    input [3:0] alu_func;
    output [15:0] alu_out;
    output en_out;
    
    reg [15:0] alu_out;
    reg en_out;
    
    always@(negedge rst or posedge clk)
    begin
        if (rst == 1'b0)
        begin
            alu_out <= 16'b0000_0000_0000_0000;
            en_out  <= 1'b0;
            
        end
        else if (en_in == 1'b1)
        begin
            en_out = 1'b1;
            case(alu_func)
                `resetB: alu_out      = alu_b;
                `AaddB: alu_out       = alu_a+alu_b;
                `AsubB:alu_out        = alu_a-alu_b;
                `AmulB:alu_out        = alu_a*alu_b;
                `AdivB:alu_out        = alu_a/alu_b;
                `AandB:alu_out        = alu_a&alu_b;
                `AorB: alu_out        = alu_a|alu_b;
                `comp: alu_out        = {14'b00_0000_0000_0000,(alu_a > alu_b) ? 2'b01 : (alu_a < alu_b) ? 2'b10 : 2'b00};
                `left_shift: alu_out  = {alu_a[14:0],1'b0};
                `right_shift: alu_out = {1'b0,alu_a[14:0]};
                default:alu_out       = 16'b0000_0000_0000_0000;
            endcase
        end
        else
            en_out <= 1'b0;
    end
endmodule
