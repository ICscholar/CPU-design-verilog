`timescale 1ns / 1ps

module addrselector(
         clk,
         rst,       
		 en_pc_out,
         en_datapc_out,
         pc_out,
         datapc_out,
		 addr
		 		 			 
		   		
    );
    input clk,rst;
    input wire en_pc_out,en_datapc_out;
    input wire[6:0] pc_out,datapc_out;
    output reg [6:0] addr;

    always@(posedge clk or posedge rst)

    if(rst==1'b1)
            begin
                addr<=7'b0000000;
            end
         else
                begin
                case({en_pc_out,en_datapc_out})
                2'b10:addr<=pc_out;
                2'b01:addr<=datapc_out;
                default:addr<=addr;
                endcase
                end    


endmodule    