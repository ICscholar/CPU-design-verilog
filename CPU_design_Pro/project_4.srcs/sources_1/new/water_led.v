`timescale 1ns / 1ps

module water_led(

	input wire 	clk		,
	input wire	rst	,
	input [3:0] alu_func,
	output [7:0] led	
);

	parameter CNT_MAX = 32'd1_0;

	reg [31:0]	cnt_1s;//1s 
	wire 		flag_1s;

	reg [7:0]	led_reg=8'b00000000;

	always@(posedge clk or posedge rst)begin
		if(rst)
			cnt_1s <= 32'd0;
		else if(cnt_1s >= CNT_MAX - 32'd1) 
			cnt_1s <= 32'd0;
		else
			cnt_1s <= cnt_1s + 32'd1;
	end
	
	assign flag_1s = (cnt_1s >= CNT_MAX - 32'd1);
	// assign flag_1s = 1'b1;


	always@(posedge clk or posedge rst)begin
		if(rst)
			led_reg <= 8'b0000_0000;
		else if(flag_1s && (alu_func==4'b0100))
			if(led_reg == 8'b0000_0000)
				led_reg <= 8'b0000_0001;
			else
				led_reg <= {led_reg[6:0],led_reg[7]};
		else
			led_reg <= led_reg;
	end

	assign led = led_reg;
	
endmodule 
