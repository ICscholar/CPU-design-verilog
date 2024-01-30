`timescale 1ns / 1ps

module ram(clk,
           rst,
           start,
           addr,
           en_ram_in,
           en_in,
           en_ram_out,
           en_ram_store,
           en_ram_load,
           en_reg_load,
           storedata,
           loaddata,
           ins
           );
    
    input clk,rst;
    input start;
    input wire [15:0]storedata;
    input wire [6:0] addr;
    input wire en_ram_in;
    input wire en_ram_store;
    input wire en_ram_load;
    output reg en_in;
    output reg en_ram_out;
    output reg en_reg_load;
    output reg [15:0] ins;
    output reg [15:0] loaddata;
    
    
    reg [15:0] ram [64:0];
    initial
begin
    ram[0] = 16'b1100_0011_0000_0100; //load,4
    ram[1] = 16'b0100_00_00_0_0110010;
    ram[2] = 16'b0100_01_00_0_0110100;   
    ram[3] = 16'b0100_10_00_0_0110110; 
    ram[4] = 16'b0100_00_00_0_0110010;//data=4032
    ram[5] = 16'b0100_01_00_0_0110100;   
    ram[6] = 16'b1001_00_00_0_0001010;//把reg0上的数据4032存到ram[10]上
    ram[7] = 16'b0100_11_00_0_0111011;
    ram[8] = 16'b0100_0000_0000_0001;
    ram[9] = 16'b0100_0000_0000_0001;
    ram[10] = 16'b0100_0000_0000_0001;
    ram[11] = 16'b0100_0000_0000_0001;
    ram[12] = 16'b1110_0000_0000_1111; //jump,ram[15]
    ram[13] = 16'b0100_0000_0000_0001;
    ram[14] = 16'b0100_0000_0000_0001;
    ram[15] = 16'b0100_0000_0000_0001;
    ram[16] = 16'b0100_0000_0000_0001;
    ram[17] = 16'b0100_0000_0000_0001;
    ram[18] = 16'b0100_0000_0000_0001;
    ram[19] = 16'b0100_0000_0000_0001;
    ram[20] = 16'b0100_0000_0000_0001;
    ram[21] = 16'b0100_0000_0000_0001;
    //ram[1] = 16'b1100_0110_0000_0101; //load,5  c605
    //ram[2] = 16'b1100_1001_0000_0110; //load,6
    //ram[3] = 16'b1100_1100_0000_0111; //load,7  cc07
    //ram[4] = 16'b0101_0000_1000_0111;
    //ram[5] = 16'b0101_00_00_1_0000001;
    //ram[6] = 16'b0101_01_00_1_0000010;
    //ram[7] = 16'b0101_10_00_1_0000011;
    //ram[8] = 16'b0101_11_00_1_0000100;
    //ram[50]= 16'b000000000_1010100;//data 80
    //ram[52]= 16'b000000000_0100100;//data 36
    //ram[54]= 16'b000000000_0101101;//data 45
    //ram[59]= 16'b000000000_1000110;//data 70
	//Annotate sample programs
	//Try to add your own programs and check the results
	
end

    /*integer i;

    initial begin //初始化
        for (i = 0; i < 127; i = i + 1) begin
            mem[i] <= 16'b0100_0000_0000_0000;
        end
    end*/
    
    always @(posedge clk or posedge rst) begin
        if (rst)
        begin
            en_in      <= 1'b0;
            en_ram_out <= 1'b0;
            en_reg_load<= 1'b0;
            ins        <= 16'b0000_0000_0000_0000;
            loaddata   <= 16'b0000_0000_0000_0000;
        end
        else if (start==1)
        begin
        ins        <= ram[addr];
        en_in      <= 1'b1;
        en_ram_out <= 1'b1;
        end    
        
        else if(en_ram_in==1)//en_ram_in=en_fetch
            begin
            ins        <= ram[addr];
            en_in      <= 1'b1;
            en_ram_out <= 1'b1;
            end
        
        else if(en_ram_store==1)//store信号，与en_ram_in不冲突，en_ram_in=en_fetch
            begin
            ram[addr]<=storedata;
            end

        else if(en_ram_load==1)//load信号，与en_ram_in不冲突，en_ram_in=en_fetch
            begin
            loaddata<=ram[addr];
            en_reg_load=1'b1;
            end    
        


        

            
            
    end
    
endmodule
