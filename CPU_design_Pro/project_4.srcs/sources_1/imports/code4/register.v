`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/05 20:35:49
// Design Name: 
// Module Name: areg
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


module register(
			clk,
			rst,
			en,				
			d,
      en_load,
      
      loaddata,

			q				
    );
    input clk,rst;
    input en,en_load;
    input wire[15:0]d;
    input wire[15:0]loaddata;

    output reg[15:0]q;
   always@(posedge clk or posedge rst )
     if(rst)
       q   <= 16'b0000000000000000;
     else
        begin
          if(en==1)//使能为1，两种情况
            
            if(en_load==1)//load
            q <=loaddata;

            else q <=d;


          else//使能为0,直接置0
          q <=q;  
              
        end      
                       
            
          
        
endmodule
