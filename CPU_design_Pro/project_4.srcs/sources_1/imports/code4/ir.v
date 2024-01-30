module ir(clk,rst,ins,en_in,en_out,ir_out);
input clk,rst;
input [15:0] ins;
input en_in;
output reg en_out;
output reg [15:0] ir_out;

always @ (posedge clk or posedge rst) begin
	if(rst) begin
		en_out <= 1'b0;
		ir_out <= 16'b0000000000000000;
		
	end
	else begin
		if(en_in==1) 
		begin
			en_out <= 1'b1;
			ir_out <= ins;
		end
		else en_out <= 1'b0;
	end
end
endmodule


