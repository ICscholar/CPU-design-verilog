`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/15 22:13:03
// Design Name:
// Module Name: alu_mux
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


module alu_mux(clk,
               rst,
               en_in,
               offset,
               rd_q,
               rs_q,
               alu_in_sel,
               alu_a,
               alu_b,
               en_out);
    input [15:0] rd_q,rs_q ;
    input clk, rst,en_in,alu_in_sel;
    input [6:0] offset; //7 bits immediate number
    output [15:0] alu_a, alu_b ;
    output en_out;
    reg [15:0] alu_a, alu_b;
    reg en_out;
    
    always @(
    negedge rst or posedge clk
    )
    begin
    if (rst == 1'b0)
    begin
        alu_a  <= 16'b0000000000000000;
        alu_b  <= 16'b0000000000000000;
        en_out <= 1'b0;
    end
    else if (en_in == 1'b1)
    begin
        alu_a  <= rd_q;
        en_out <= 1'b1;
        if (alu_in_sel == 1'b0)
            alu_b <= {9'b0000_0000_0,offset[6:0]};
        else
            alu_b <= rs_q;
    end
    else
        en_out <= 1'b0;
    end
endmodule
