`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/01 12:01:39
// Design Name:
// Module Name: tb_ram_cpu
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


module tb_ram_cpu();
    
    reg         clk,rst,start;
    wire [2:0] cz_flag;
    wire [7:0] led;
    
    ram_cpu test_ram_cpu(
    .clk (clk),
    .rst (rst),
    .cz_flag(cz_flag),
    .led(led),
    .start(start)
    );
    
    parameter Tclk = 10;
    
    initial begin
        clk                   = 0;
        forever #(Tclk/2) clk = ~clk;
    end
    
    initial begin
        rst           = 1;
        #(Tclk*4) rst = 0;
    end

    initial begin
        start          = 0;
        #(Tclk*4)
        start          = 1;
        #(Tclk*2) start = 0;
    end


endmodule
