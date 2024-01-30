`timescale 1ns / 1ps

module ram_cpu(
    clk,rst,start,cz_flag,led	
    );

input  clk;
input rst;
input start;
output [1:0] cz_flag;
output [7:0] led;
wire en_ram_in;
wire en_ram_out;
wire en_ram_store;
wire [15:0]loaddata;
wire en_load;
wire [15:0]ins;
wire en_in;
wire en_pc_pulse,en_datapc_pulse,en_store,en_group_pulse,en_alu;
wire [1:0] rd;
wire [1:0] rs;
wire [3:0] alu_func;
wire [6:0] offset_addr;
wire [3:0] reg_en;
wire [1:0] pc_ctrl;
wire [6:0] addr;
wire [15:0] storedata;







data_path data_path1 (
					.clk(clk),
					.rst(rst),
					.offset(offset_addr),
					.offset_addr(offset_addr),
					.en_pc_pulse(en_pc_pulse),
					.en_datapc_pulse(en_datapc_pulse),
					.pc_ctrl(pc_ctrl),
					.en_in(en_group_pulse) ,
					.reg_en(reg_en) ,
				    .rd(rd),
					.rs(rs),
					.cz_flag(cz_flag),
					.led(led),
					.en_load(en_reg_load),
					.en_store(en_store_pulse),
					.en_ram_store(en_ram_store),
				    .alu_in_sel(alu_in_sel),
				    .alu_func(alu_func),
				    .en_out(en_alu),
				    .addr(addr),
					.storedata(storedata),
					.loaddata(loaddata)
				);	                     

control_unit control_unit1(
					.clk(clk) ,
					.rst(rst) ,
					.en(en_in)  ,
					.en_alu(en_alu) ,  
					.en_ram_out(en_ram_out) ,
					.en_load_pulse(en_load_pulse),
					.en_store_pulse(en_store_pulse),
					.ins(ins),
					.offset_addr(offset_addr),
					.en_ram_in(en_ram_in),
				    .en_group_pulse(en_group_pulse),
					.en_pc_pulse(en_pc_pulse),
					.en_datapc_pulse(en_datapc_pulse),
				    .reg_en(reg_en),
				    .alu_in_sel(alu_in_sel),
					.alu_func (alu_func),
					.pc_ctrl(pc_ctrl),	
					.rd(rd),
					.rs(rs)	
				);

ram ram_1(
    .clk(clk),
    .rst(rst),
	.start(start),
    .addr(addr),
	.storedata(storedata),
	.loaddata(loaddata),
    .en_ram_in(en_ram_in),
	.en_reg_load(en_reg_load),
	.en_ram_store(en_ram_store),
    .en_in(en_in),
    .en_ram_out(en_ram_out),
    .ins(ins),
	.en_ram_load(en_load_pulse)
	
);
endmodule
