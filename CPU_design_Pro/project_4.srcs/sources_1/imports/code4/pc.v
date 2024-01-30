`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/05 17:12:07
// Design Name: 
// Module Name: pc
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


module pc(
      clk,
      rst,       
		 en_in		,
       en_pc_out,
		 pc_ctrl  	,
		 offset_addr, 		 			 
		 pc_out,
       cz_flag  		
    );
    input clk,rst,en_in;
    input wire[1:0] cz_flag;
    input wire[1:0] pc_ctrl;
    input wire[6:0] offset_addr;
    output reg[6:0] pc_out;
    output reg en_pc_out;
    always@(posedge clk or posedge rst)
        if(rst==1'b1)
            begin
                en_pc_out<=1'b0;
                pc_out<=7'b0000000;
            end
         else
            begin
                 if(en_in==1)
                     begin
                         en_pc_out<=1'b1;
                         case (pc_ctrl)
                         2'b01:
                            pc_out <= pc_out + 1+cz_flag[0];
                         2'b10:
                            pc_out <= offset_addr[6:0];
                         default:                            
                                  pc_out <= pc_out;
                       endcase
                     end
                  else en_pc_out<=1'b0;
            end   
    
endmodule