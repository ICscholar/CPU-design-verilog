`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/24 14:46:48
// Design Name:
// Module Name: cpu
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


module cpu(clk,
           rst,
           en_in,
           en_ram_out,
           addr,
           ins,
           en_ram_in);
    
    input clk,rst,en_in, en_ram_out;
    input [15:0] ins;
    output [15:0] addr;
    output en_ram_in;
    
    wire en_pc_pulse, en_group_pulse,alu_in_sel,en_alu;
    wire [1:0]pc_ctrl;
    wire [3:0] reg_en;
    wire [3:0] alu_func;
    wire [6:0] offset_addr;
    
    data_path data_path1(
    .clk(clk),
    .rst(rst),
    
    .offset_addr(offset_addr),
    .en_pc_pulse(en_pc_pulse),
    .pc_ctrl(pc_ctrl),
    .offset(ins[6:0]),
    .en_in(en_group_pulse),
    .reg_en(reg_en),
    .alu_in_sel(alu_in_sel),
    // .alu_func(ins[15:12]),????/
    .alu_func(alu_func),
    .en_out(en_alu),
    .pc_out(addr),
    .rd(ins[10:9]),
    .rs(ins[8:7])
    
    
    );
    
    control_unit control_unit1(
    .clk(clk),
    .rst(rst),
    .en(en_in),
    .en_alu(en_alu),
    .en_ram_out(en_ram_out),
    .ins(ins),
    .offset_addr(offset_addr),
    .en_ram_in(en_ram_in),
    .en_group_pulse(en_group_pulse),
    .en_pc_pulse(en_pc_pulse),
    .reg_en(reg_en),
    .alu_in_sel(alu_in_sel),
    .alu_func (alu_func),
    .pc_ctrl(pc_ctrl)
    );
    
endmodule
