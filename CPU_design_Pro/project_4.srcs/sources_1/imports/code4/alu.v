`timescale 1ns / 1ps

`define mov 4'b0011
`define add 4'b0100
`define sub 4'b0101
`define mul 4'b0110 
`define div 4'b0111 
//`define And 4'b1001 
//`define Or 4'b1010 
`define comp 4'b1011 
`define rs 4'b1101//共9种


module alu(clk,
           rst,
           en_in,
           alu_a,
           alu_b,
           alu_func,
           en_out,
          alu_out,
          cz_flag          
         );
    input [15:0]alu_a,alu_b;
    input clk,rst,en_in;
    input [3:0] alu_func; 
    output reg[15:0] alu_out;
    output reg en_out;
    output reg[1:0] cz_flag;
   
    always@(posedge rst or posedge clk)
    begin
        if (rst == 1'b1)
        begin
            alu_out <= 16'b0000_0000_0000_0000;
            en_out  <= 1'b0;
            cz_flag<=2'b00;         
        end
        else if (en_in == 1'b1)
            begin
                en_out = 1'b1;         
                case(alu_func)
                    4'b0011 :alu_out                     = alu_b;//mov
                    4'b0100 :{cz_flag[0] ,alu_out }      = alu_a+alu_b+cz_flag[0];//add                                                          
                    4'b0101 :{cz_flag[0] ,alu_out }      = alu_a-alu_b+cz_flag[0];//sub
                    4'b0110 :{cz_flag[0] ,alu_out }      = alu_a*alu_b;//mul
                    4'b0111 : begin 
                              alu_out                    = alu_a/alu_b;
                              cz_flag[0]=alu_a%alu_b;
                              end
                    //4'b1001 :alu_out                     = alu_a&alu_b;//and
                    //4'b1010 :alu_out                     = alu_a|alu_b;//or
                    4'b1011 :cz_flag                     = (alu_a > alu_b) ? 2'b01 : (alu_a < alu_b) ? 2'b10 : 2'b00;//comp
                    4'b1101 :alu_out                     = {1'b0,alu_a[14:0]};//rs
                    default :alu_out                     = 16'b0000_0000_0000_0000;                                                           
                endcase
            end
        else
            en_out <= 1'b0;
    end

endmodule
