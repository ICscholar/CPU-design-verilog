`timescale 1ns / 1ps

module tb_cpu();
reg         clk,rst,en_in,en_ram_out;
reg  [15:0] ins;
wire        en_ram_in;
wire [15:0] addr;

cpu test_cpu(
    .clk (clk),
    .rst (rst),
    .en_in (en_in),
    .en_ram_in (en_ram_in), 
    .ins (ins),	
    .en_ram_out (en_ram_out),
    .addr (addr)   	
);

parameter Tclk = 10;

initial begin
	    clk = 0;
        forever #(Tclk/2) clk = ~clk;
		end
        
initial begin
		rst = 1;
		#(Tclk*4) rst = 0;
		end

initial begin                
		//define en_in and en_ram_out
		en_in = 1;
		en_ram_out = 1;
		#(Tclk*10)  ins = 16'b0100_0000_0000_0000; //ADD

end


endmodule
