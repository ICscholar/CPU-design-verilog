`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/23 20:54:16
// Design Name:
// Module Name: data_path
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


module data_path(clk,
                 rst,
                 offset_addr,
                 en_pc_pulse,
                 pc_ctrl,
                 offset,
                 en_in,
                 reg_en,
                 alu_in_sel,
                 alu_func,
                 en_out,
                 pc_out,
                 rd,
                 rs);
    input clk, rst, en_pc_pulse,en_in, alu_in_sel;
    input [6:0] offset_addr, offset;
    input pc_ctrl,rd,rs;
    input [3:0] reg_en;
    input [3:0] alu_func;
    output en_out;
    output [15:0] pc_out;
    
    wire [15:0] rd_q,rs_q,alu_a,alu_b, alu_out;
    wire en_out_group, en_out_alu_mux;
    // pc(clk,
    //           rst,
    //           en_in,
    //           offset_addr,
    //           pc_ctrl,
    //           pc_out);
    pc pc1(
    .clk(clk),
    .rst(rst),
    .en_in(en_pc_pulse),
    .offset_addr(offset_addr),
    .pc_ctrl(pc_ctrl),
    .pc_out(pc_out)
    );
    
    //  reg_group(clk,
    //              rst,
    //              en_in,
    //              reg_en,
    //              rd,
    //              rs,
    //              d_in,
    //              rd_q,
    //              rs_q,
    //              en_out);
    reg_group reg_group1(
    .clk(clk),
    .rst(rst),
    .en_in(en_in),
    .reg_en(reg_en),
    .rd(rd),
    .rs(rs),
    .d_in(alu_out),
    .rd_q(rd_q),
    .rs_q(rs_q),
    .en_out(en_out_group)
    );
    
    // alu_mux(clk,
    //            rst,
    //            en_in,
    //            offset,
    //            rd_q,
    //            rs_q,
    //            alu_in_sel,
    //            alu_a,
    //            alu_b,
    //            en_out);
    alu_mux alu_mux1(
    .clk(clk),
    .rst(rst),
    .en_in(en_out_group),
    .offset(offset),
    .rd_q(rd_q),
    .rs_q(rs_q),
    .alu_in_sel(alu_in_sel),
    .alu_a(alu_a),
    .alu_b(alu_b),
    .en_out(en_out_alu_mux)
    );
    
    
    // alu(clk,
    //        rst,
    //        en_in,
    //        alu_a,
    //        alu_b,
    //        alu_func,
    //        en_out,
    //        alu_out);
    alu alu1(
    .clk(clk),
    .rst(rst),
    .en_in(en_out_alu_mux),
    .alu_a(alu_a),
    .alu_b(alu_b),
    .alu_func(alu_func),
    .en_out(en_out),
    .alu_out(alu_out)
    );
    
endmodule
