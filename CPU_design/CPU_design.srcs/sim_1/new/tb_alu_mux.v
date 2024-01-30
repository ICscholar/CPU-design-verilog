`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/11 20:38:13
// Design Name:
// Module Name: alu_mux_tb
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


module alu_mux_tb; reg clk; reg rst; reg en_in; reg [7:0] offset; reg [15:0] rd_q; reg [15:0] rs_q; reg alu_in_sel; wire [15:0] alu_a; wire [15:0] alu_b; wire en_out; alu_mux uut (.clk(clk), .rst(rst), .en_in(en_in), .offset(offset), .rd_q(rd_q), .rs_q(rs_q), .alu_in_sel(alu_in_sel), .alu_a(alu_a), .alu_b(alu_b), .en_out(en_out));
    
    // 时钟生成
    always begin
        #5 clk = ~clk; // 生成�?个时钟周期为 10 个时间单�?
    end
    
    // 初始�?
    initial begin
        clk        = 0;
        rst        = 1;
        en_in      = 0;
        offset     = 8'b0;
        rd_q       = 16'b0;
        rs_q       = 16'b0;
        alu_in_sel = 0;
        
        // 等待�?段时间，然后取消复位
        #20 rst = 0;
        
        // 在不同条件下测试模块
        // 你可以根据需要修改测试用�?
        // 测试复位条件
        en_in      = 0;
        offset     = 8'b10101010;
        rd_q       = 16'b1100110011001100;
        rs_q       = 16'b0011001100110011;
        alu_in_sel = 1;
        #10; // 等待 10 个时间单�?
        
        // 测试使能条件
        en_in      = 1;
        offset     = 8'b00000001;
        rd_q       = 16'b1010101010101010;
        rs_q       = 16'b0101010101010101;
        alu_in_sel = 0;
        #10; // 等待 10 个时间单�?
        
        // 测试复位后的使能条件
        rst     = 1;
        #20 rst = 0; // 取消复位
        #10; // 等待 10 个时间单�?
        en_in      = 1;
        offset     = 8'b11111111;
        rd_q       = 16'b1111000011110000;
        rs_q       = 16'b0000111100001111;
        alu_in_sel = 1;
        #10; // 等待 10 个时间单�?
        
        // 测试复位后的复位条件
        rst     = 1;
        #20 rst = 0; // 取消复位
        #10; // 等待 10 个时间单�?
        en_in      = 0;
        offset     = 8'b01010101;
        rd_q       = 16'b1111111100000000;
        rs_q       = 16'b0000000011111111;
        alu_in_sel = 0;
        #10; // 等待 10 个时间单�?
        
        // 结束仿真
        $finish;
    end
    
endmodule
