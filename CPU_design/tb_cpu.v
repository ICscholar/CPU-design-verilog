`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/09 20:35:47
// Design Name: 
// Module Name: tb_cpu
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
	    //define clk
	    clk = 0;
        forever #(Tclk/2) clk = ~clk;
		end
        
initial begin
		//define rst
		rst = 0;
		#(Tclk*4) rst = 1;
		end

initial begin                
		//define en_in and en_ram_out
		en_in = 0;
		en_ram_out = 0;
		#(Tclk*8) en_in = 1;//enabling state_transition
		#(Tclk*2) en_ram_out = 1;//anabling ir
end

initial begin
         //define ins ,you can assign 0000_0000_0000_0001
		    //0000_0100_0000_0010 and so on to ins.
		           ins = 16'b0000_0000_0000_0000;
	    #(Tclk*6)  ins = 16'b0000_0000_1011_0110; //MOV R0, #0x00B6 (not enabled) (#0x0000)
	    #(Tclk*6)  ins = 16'b0000_0100_0101_1000; //MOV R1, #0x0058
	    #(Tclk*6)  ins = 16'b0000_1000_0001_1110; //MOV R2, #0x001E
	    #(Tclk*10) ins = 16'b0000_1100_0010_1001; //MOV R3, #0x0029
	    #(Tclk*6)  ins = 16'b0010_1000_0100_0110; //ADD R2, #0x0046 (#0x0064)
	    #(Tclk*6)  ins = 16'b0101_1101_0100_0110; //SUB R3, R1 (#0xFFD1)
	    #(Tclk*6)  ins = 16'b0111_1100_0100_0110; //AND R3, R0 (#0x0000)
	    #(Tclk*6)  ins = 16'b1001_0010_0100_0110; //ORR R0, R2 (#0x0064)
	    #(Tclk*6)  ins = 16'b1010_0100_0010_0000; //JUMP #0x20 
	    #(Tclk*6)  en_in = 0;  en_ram_out = 0;
	    
        end
       
initial begin
    #(Tclk*400)  $stop;
end

endmodule
