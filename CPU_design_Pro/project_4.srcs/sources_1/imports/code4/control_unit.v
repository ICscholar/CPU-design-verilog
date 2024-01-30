module control_unit (
 clk,rst,en,en_alu,en_ram_out	,ins,
	offset_addr,en_ram_in,	en_group_pulse,en_pc_pulse,reg_en,
	alu_func,pc_ctrl,alu_in_sel ,rd,rs,en_load_pulse,	en_store_pulse,en_datapc_pulse	
);
input clk,rst,en,en_alu	,en_ram_out;	
input [15:0] ins;
output en_ram_in,en_group_pulse,en_pc_pulse,en_datapc_pulse;	

output [3:0]	reg_en;
output [3:0]	alu_func;
output reg[6:0]	offset_addr;
output reg alu_in_sel;
output reg[1:0] rd;
output reg[1:0] rs;
output [1:0] pc_ctrl;
output  en_load_pulse,en_store_pulse;


wire [15:0] ir_out ;
wire en_out ;

ir ir1 (
				.clk(clk)	,
				.rst(rst)   ,
				.ins(ins)   ,
				.en_in(en_ram_out)	,
				.en_out(en_out)		,
				.ir_out(ir_out)
				);
	
	
state_transition state_transition1(
					.clk(clk) ,
					.rst(rst) ,
					.en_in(en) ,
					.en1(en_out) ,
					.en2(en_alu) ,
					.opcode(ir_out[15:12]) ,
					.rd(ir_out[11:10]),
					.en_fetch_pulse(en_ram_in),	
					.en_group_pulse(en_group_pulse),
					.en_pc_pulse(en_pc_pulse)  ,
					.en_datapc_pulse(en_datapc_pulse),
					.pc_ctrl(pc_ctrl) ,
					.reg_en(reg_en) ,
					.alu_func(alu_func),
					.en_load_pulse(en_load_pulse),
					.en_store_pulse(en_store_pulse)
				);
				
always @ (en_out,ir_out) 
begin
	rd=ir_out[11:10];
	rs=ir_out[9:8];
	alu_in_sel=ir_out[7];
	offset_addr = ir_out[6:0];
end

/*always @ (en_alu) 
begin
	
	alu_in_sel=ir_out[7];
	offset_addr = ir_out[6:0];
end*/




endmodule







