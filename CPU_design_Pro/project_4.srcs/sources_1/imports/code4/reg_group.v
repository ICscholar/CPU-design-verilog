`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/05 20:43:17
// Design Name: 
// Module Name: reg_group
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


module reg_group(
            clk,       
            rst	,	
			en_in,		
			reg_en,		
			d_in,		
			rd,rs,		
			en_out,		
			rd_q,
			rs_q,
            loaddata,
            storedata,
            en_load,
            en_store,
            en_ram_store
    );
    input clk,rst,en_in;
    input [15:0] loaddata;
    input en_load,en_store;
    output reg en_ram_store;
    input wire[3:0] reg_en;
    input wire[15:0] d_in;
    input wire[1:0] rd,rs;
    output reg en_out;
    output reg[15:0] storedata;
    output reg[15:0]rd_q,rs_q;
    wire[15:0]q0,q1,q2,q3;


    register reg0(
               . clk(clk)        ,
               . rst(rst)        ,
               . en (reg_en[0])           , 
               . en_load(en_load)  ,          
               . d  (d_in)           ,                
               . q  (q0) ,
               .loaddata(loaddata)              
               );
     register reg1(
               . clk(clk)        ,
               . rst(rst)        ,
               . en (reg_en[1])           , 
               . en_load(en_load),                
               . d  (d_in)           ,                
               . q  (q1),   
               .loaddata(loaddata)  
               );
     register reg2(
               . clk(clk)        ,
               . rst(rst)        ,
               . en (reg_en[2])           ,  
               . en_load(en_load)  ,               
               . d  (d_in)           ,                
               . q  (q2),    
               .loaddata(loaddata)
               );
     register reg3(
               . clk(clk)        ,
               . rst(rst)        ,
               . en (reg_en[3])           , 
               . en_load(en_load)  ,                
               . d  (d_in)           ,                
               . q  (q3) ,     
               .loaddata(loaddata)
               );             
 
     always@(posedge clk or posedge rst)
          if(rst)
             begin
                rd_q   <= 16'b0000000000000000;
                rs_q   <= 16'b0000000000000000;    
                en_out <= 0; 
                storedata <=16'b0000000000000000;
                en_ram_store <= 0;
             end
            else if(en_in==1)//允许输出
                    if(en_store==0)//正常情况，非store情况
                    begin
                    en_out <=1;
                    en_ram_store <= 0;      
                    case({rd[1:0],rs[1:0]})
                    4'b0000:
                        begin
                        rd_q <= q0;
                        rs_q <= q0;
                        end
                     4'b0001:
                        begin
                        rd_q <= q0;
                        rs_q <= q1;
                        end   
                    4'b0010:
                        begin
                        rd_q <= q0; 
                        rs_q <= q2; 
                        end
                    4'b0011:              
                        begin      
                        rd_q <= q0;                                                           
                        rs_q <= q3;
                        end        
                     4'b0100:          
                        begin      
                        rd_q <= q1;
                        rs_q <= q0;
                        end        
                    4'b0101:          
                        begin      
                        rd_q <= q1;
                        rs_q <= q1;
                        end           
                    4'b0110:          
                        begin      
                        rd_q <= q1;
                        rs_q <= q2;
                        end   
                    4'b0111:          
                         begin      
                         rd_q <= q1;
                         rs_q <= q3;
                         end                   
                    4'b1000:           
                       begin      
                       rd_q <= q2;
                       rs_q <= q0;
                       end    
                    4'b1001:                
                        begin           
                        rd_q <= q2;     
                        rs_q <= q1;         
                        end      
                    4'b1010:           
                         begin      
                         rd_q <= q2;
                         rs_q <= q2;
                         end                
                    4'b1011:          
                        begin      
                        rd_q <= q2;
                        rs_q <= q3;
                        end 
                    4'b1100:           
                        begin      
                        rd_q <= q3;
                        rs_q <= q0;
                        end              
                    4'b1101:             
                        begin        
                        rd_q <= q3;    
                        rs_q <= q1;          
                        end      
                    4'b1110:           
                         begin      
                         rd_q <= q3;
                         rs_q <= q2;
                         end        
                    4'b1111:
                         begin      
                          rd_q <= q3;
                          rs_q <= q3;
                          end         
                   default:
                        begin
                        rd_q <= 16'b0000000000000000;
                        rs_q <= 16'b0000000000000000;
                        end
                 endcase
            end
                else begin//store情况
                    en_out=0;
                    en_ram_store=1;
                    case(reg_en)
                    4'b0001:storedata<=q0;
                    4'b0010:storedata<=q1;
                    4'b0100:storedata<=q2;
                    4'b1000:storedata<=q3;
                    default:storedata<=16'b0000000000000000;
                    endcase
                    end


                else en_out <= 0;//en_in=0的情况
                    




                    

            

              
endmodule               
                        