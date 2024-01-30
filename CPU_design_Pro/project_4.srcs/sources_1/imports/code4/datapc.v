`timescale 1ns / 1ps

module datapc(
         clk,
         rst,       
         en_in,
         offset_addr,
         datapc_out,
         en_datapc_out
		 
		  		 			 
		);
input wire clk,rst,en_in;  
input wire[6:0] offset_addr; 
output reg[6:0] datapc_out; 
output reg en_datapc_out;    
always@(posedge clk or posedge rst)
        if(rst==1'b1)
            begin
                en_datapc_out<=1'b0;
                datapc_out<=7'b0000000;
            end
         else
            begin
                 if(en_in==1) begin
                    en_datapc_out<=1'b1;
                    datapc_out<=offset_addr[6:0];
                 end
                 else begin
                    en_datapc_out<=1'b0;
                    datapc_out<=datapc_out;
                 end

            end     





endmodule        