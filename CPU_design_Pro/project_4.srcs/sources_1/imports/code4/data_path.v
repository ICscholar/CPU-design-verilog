module data_path (
	 clk, rst,
	 offset_addr ,
	 loaddata,storedata,
	 en_load,en_store,
	 en_pc_pulse ,
	 en_datapc_pulse,
	 pc_ctrl ,offset , 
	 en_in,reg_en ,
	 alu_func, en_out,	
	 rd,rs,alu_in_sel,
	 cz_flag,led,
	 en_ram_store,
	 addr	
);

input clk,rst,en_pc_pulse,en_datapc_pulse,en_in;
input en_load,en_store;
input [15:0] loaddata;
output [15:0] storedata;
output en_ram_store;
input [6:0] offset_addr,offset;
input [1:0] pc_ctrl ,rd,rs;
input [3:0]  reg_en;
input [3:0] alu_func;
input alu_in_sel;
output  en_out;


output [1:0] cz_flag;
output [7:0] led;

wire [6:0] pc_out,datapc_out;


wire [15:0] rd_q, rs_q ,alu_a ,alu_b ,alu_out;	
wire en_out_group ,en_out_alu_mux;  

wire en_pc_out,en_datapc_out;
output [6:0] addr;


pc pc1(
         .clk(clk),
         .rst(rst),       
		 .en_in(en_pc_pulse),
		 .en_pc_out(en_pc_out),
		 .pc_ctrl(pc_ctrl),
		 .offset_addr(offset_addr), 		 			 
		 .pc_out(pc_out),
		 .cz_flag(cz_flag)	
    );

datapc datapc1(
         .clk(clk),
         .rst(rst),       
		 .en_in(en_datapc_pulse),
		 .en_datapc_out(en_datapc_out),
		 .offset_addr(offset_addr), 		 			 
		 .datapc_out(datapc_out)	
    );

addrselector addrselector1(
		.clk(clk),
        .rst(rst),
		.en_pc_out(en_pc_out),
		.en_datapc_out(en_datapc_out),
		.pc_out(pc_out),
		.datapc_out(datapc_out),
		.addr(addr)
);


	 
	 
	 
reg_group reg_group1(
				.clk(clk),
				.rst(rst),
				.en_in(en_in),
				.reg_en(reg_en),
				.d_in(alu_out),
				.rd(rd),
				.rs(rs),
				.rd_q(rd_q),
				.en_out(en_out_group),
				.en_ram_store(en_ram_store),
				.rs_q(rs_q),
				.loaddata(loaddata),	
				.storedata(storedata),
				.en_load(en_load),
				.en_store(en_store)	
			);
			
alu_mux alu_mux1(                                        
					.clk(clk),
					.rst(rst),
					.en_in(en_out_group),
					.rd_q(rd_q),
					.rs_q(rs_q),
					.offset(offset),
					.alu_in_sel(alu_in_sel),
					.alu_a(alu_a),
					.en_out(en_out_alu_mux),					
					.alu_b(alu_b)  		
				);
alu alu1 (
					.clk(clk),
					.rst(rst),
					.en_in(en_out_alu_mux),					
					.alu_a(alu_a),
					.alu_b(alu_b),
					.alu_func(alu_func),
					.en_out(en_out),
					.alu_out(alu_out ), 
					.cz_flag(cz_flag)
					
				);	


water_led water_led_inst (
	.clk(clk),
	.rst(rst),
	.alu_func(alu_func),
	.led(led)
);
endmodule				
				