`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/23 20:28:46
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


module pc(clk,
          rst,
          en_in,
          offset_addr,
          pc_ctrl,
          pc_out);
    
    input clk,rst, en_in;
    input [6:0] offset_addr;
    input [1:0] pc_ctrl;
    output reg [15:0] pc_out;
    
    always @(posedge clk) begin
        if (!rst)
            pc_out <= 16'b0000_0000_0000_0000;
        else
            begin  if (en_in == 1'b1)
            begin
            // case (pc_ctrl)
            //     2'b00:
            //     begin
            //         pc_out <= pc_out;
            //     end
            //     2'b01:
            //     begin
            //         pc_out <= pc_out+1;
            //     end
            //     2'b10:
            //     begin
            //         pc_out <= {9'b0_0000_0000,offset};
            //     end
            //     default: pc_out <= 16'b0000_0000_0000_0000;
            // endcase
            case (pc_ctrl)
                2'b01:
                pc_out <= pc_out + 1;
                2'b10:
                pc_out <= {9'b0_0000_0000,offset_addr[6:0]};
                //offset_addr if the offset(偏移量) of address
                default:
                pc_out <= pc_out;
            endcase
    end
    end
    
    end
    
endmodule
