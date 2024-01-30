`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/09/24 09:58:47
// Design Name:
// Module Name: state_transition
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


module state_transition(clk,
                        rst,
                        en_in,
                        en1,
                        en2,
                        rd,
                        opcode,
                        en_fetch_pulse,
                        en_group_pulse,
                        en_pc_pulse,
                        en_datapc_pulse,
                        en_load_pulse,
                        en_store_pulse,
                        pc_ctrl,
                        reg_en,
                        alu_func
                        );
    input clk,rst;
    input en_in;
    input en1;
    input en2;
    input [1:0] rd;
    input [3:0] opcode;
    output reg en_load_pulse;
    output reg en_store_pulse;
    output reg en_fetch_pulse;
    output reg en_group_pulse;
    output reg en_pc_pulse;
    output reg en_datapc_pulse;
    output reg [1:0] pc_ctrl;
    output reg [3:0] reg_en;
    output reg [3:0] alu_func;
    reg en_load_reg,en_load;//load信号
    reg en_store_reg,en_store;//store信号
    reg en_fetch_reg,en_fetch;//fetch信号
    reg en_group_reg,en_group;
    reg en_pc_reg,en_pc;
    reg en_datapc_reg,en_datapc;
    reg [3:0] current_state,next_state;
    reg [3:0] stateofreg_en;//用于存储load时对应的reg_en以方便下一步操作
    
    

    parameter Initial       = 4'b0000;//0
    parameter Fetch         = 4'b0001;//1
    parameter Decode        = 4'b0010;//2
    parameter Execute_Mov = 4'b0011;//3     
    parameter Execute_Add   = 4'b0100;//4
    parameter Execute_Sub   = 4'b0101;//5
    parameter Execute_Mul  = 4'b0110;//6
    parameter Execute_Div    = 4'b0111;//7
    parameter Execute_GetDataAndLoad  = 4'b1000;//8,GetDataAndLoad

    parameter Execute_Store  = 4'b1001;//9,store
    parameter Execute_GetDataAndStore  = 4'b1010;//a,GetDataAndStore
    parameter Execute_Comp = 4'b1011;//b
    parameter Execute_Load   = 4'b1100;//c,load
    parameter Execute_rs   = 4'b1101;//d
    parameter Execute_Jump =4'b1110;//e,jump
    parameter Write_back    = 4'b1111;//f
    
    always @ (posedge clk or posedge rst) begin
        if (rst)
            current_state <= Initial;
        else
            current_state <= next_state;
    end
    
    always @ (current_state or en_in or en1 or en2 or opcode) begin
        case (current_state)
            Initial: begin
                if (en_in)
                    next_state = Fetch;
                else
                    next_state = Initial;
            end
            Fetch: begin
                if (en1)
                    next_state = Decode;
                else
                    next_state = current_state;
            end
            Decode: begin
                case(opcode)
                    4'b0011: next_state = Execute_Mov;
                    4'b0100: next_state = Execute_Add;
                    4'b0101: next_state = Execute_Sub;
                    4'b0110: next_state = Execute_Mul;
                    4'b0111: next_state = Execute_Div;
                    4'b1000: next_state = Execute_GetDataAndLoad;
                    
                    4'b1001: next_state = Execute_Store;
                    4'b1010: next_state = Execute_GetDataAndStore;
                    4'b1011: next_state = Execute_Comp;
                    4'b1100: next_state = Execute_Load;
                    4'b1101: next_state = Execute_rs;
                    4'b1110: next_state=Execute_Jump;
                    4'b1111: next_state=Write_back;
                    
                    default: next_state = current_state;
                endcase
            end
            Execute_Mov: begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            Execute_Add: begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            Execute_Sub: begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            Execute_Mul: begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            Execute_Div: begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            
            Execute_Comp:begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end
            
            Execute_rs:begin
                if (en2)
                    next_state = Write_back;
                else
                    next_state = current_state;
            end

            Execute_Jump: next_state = Fetch;
            Execute_Load: next_state = Execute_GetDataAndLoad;
            Execute_GetDataAndLoad: next_state = Fetch;
            Execute_Store: next_state =Execute_GetDataAndStore;
            Execute_GetDataAndStore: next_state = Fetch;
            Write_back: next_state   = Fetch;
            default: next_state      = current_state;
        endcase
    end
    
    always @ (rst or next_state or rd) begin
        if (rst) begin
            en_fetch   = 1'b0;
            en_group   = 1'b0;
            en_pc      = 1'b0;
            pc_ctrl    = 2'b00;
            en_datapc  = 1'b0;
            reg_en     = 4'b0000;
            alu_func   = 4'b0000;
            en_load     =1'b0;
            en_store   =1'b0;
        end
        else begin
            case (next_state)
                Initial: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b0;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0000;
                    en_load     =1'b0;
                    en_store   =1'b0;
                    
                end
                Fetch: begin
                    en_fetch   = 1'b1;
                    en_group   = 1'b0;
                    en_pc      = 1'b1;
                    pc_ctrl    = 2'b01;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0000;
                    en_load     =1'b0;
                    en_store   =1'b0;

                    
                end
                Decode: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b0;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0000;
                    en_load     =1'b0;
                    en_store   =1'b0;
                    
                end
                Execute_Mov: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;//允许寄存器进行输出
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0011;
                    en_load     =1'b0;
                    en_store   =1'b0;

                end
                Execute_Add: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0100;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
                Execute_Sub: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0101;
                    en_load     =1'b0;
                    en_store   =1'b0;
                    
                end
                Execute_Mul: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0110;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
                
                Execute_Div: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0111;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
                
                Execute_Comp: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b1011;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
                               
                Execute_rs: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b1101;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
                
                Execute_Jump: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b1;
                    en_pc      = 1'b1;//无视fetch，直接启用pc
                    pc_ctrl    = 2'b10;//直接跳转
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0000;//禁用alu
                    en_load     =1'b0;
                    en_store   =1'b0;                   
                end

                Execute_Load: begin //执行load时，仅指定ram中取出数据的地址和要存的rd地址，下一步GetDataAndLoad才是重头戏
                    en_fetch   = 1'b0;
                    en_load     =1'b0;//此时不用输出en_load，下一步再输出
                    en_store   =1'b0;
                    en_group   = 1'b0;
                    en_pc      = 1'b0;//禁用指令pc
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b1; //使用datapc，跳转到ram中取数据的地址     
                    reg_en     = 4'b0000;
                    case(rd)
                            2'b00: stateofreg_en   = 4'b0001;
                            2'b01: stateofreg_en   = 4'b0010;
                            2'b10: stateofreg_en   = 4'b0100;
                            2'b11: stateofreg_en   = 4'b1000;
                        default: stateofreg_en = 4'b0000;
                        endcase//将当前reg_en存起来，方便下一步GetDataAndLoad使用                                       
                    alu_func   = 4'b0000;//禁用alu
                    
                end

                Execute_GetDataAndLoad: begin   
                    en_fetch   = 1'b0;//不允许取指令
                    en_load     =1'b1;//此时再将数据移动到寄存器中
                    en_store   =1'b0;
                    en_group   = 1'b1;//启用寄存器
                    en_pc      = 1'b0;//禁用pc
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0; //禁用datapc
                    reg_en     = stateofreg_en;//load中指定的reg_en
                    stateofreg_en=4'b0000;//此时stateofreg_en清零
                    alu_func   = 4'b0000;//禁用alu
                    
                end  

                Execute_Store: begin //执行Store时，仅指定ram中存储数据的地址和要取的rd地址，下一步GetDataAndStore才是重头戏
                    en_fetch   = 1'b0;
                    en_load     =1'b0;
                    en_store   =1'b0;//此时不用输出en_store，下一步再输出
                    en_group   = 1'b0;
                    en_pc      = 1'b0;//禁用指令pc
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b1; //使用datapc，跳转到指向ram中存数据的地址     
                    reg_en     = 4'b0000;
                    case(rd)
                            2'b00: stateofreg_en   = 4'b0001;
                            2'b01: stateofreg_en   = 4'b0010;
                            2'b10: stateofreg_en   = 4'b0100;
                            2'b11: stateofreg_en   = 4'b1000;
                        default: stateofreg_en = 4'b0000;
                        endcase//将当前reg_en存起来，方便下一步GetDataAndStore使用                                       
                    alu_func   = 4'b0000;//禁用alu
                    
                end    

                Execute_GetDataAndStore: begin   
                    en_fetch   = 1'b0;//不允许取指令
                    en_load     =1'b0;
                    en_store   =1'b1;//此时再将数据移动到ram中
                    en_group   = 1'b1;//启用寄存器
                    en_pc      = 1'b0;//禁用pc
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0; //禁用datapc
                    reg_en     = stateofreg_en;//Store中指定的reg_en
                    stateofreg_en=4'b0000;//此时stateofreg_en清零
                    alu_func   = 4'b0000;//禁用alu
                    
                end             
        
                Write_back: begin
                    case(rd)
                        2'b00: reg_en   = 4'b0001;
                        2'b01: reg_en   = 4'b0010;
                        2'b10: reg_en   = 4'b0100;
                        2'b11: reg_en   = 4'b1000;
                        default: reg_en = 4'b0000;
                    endcase
                end
                
                default: begin
                    en_fetch   = 1'b0;
                    en_group   = 1'b0;
                    en_pc      = 1'b0;
                    pc_ctrl    = 2'b00;
                    en_datapc  = 1'b0;
                    reg_en     = 4'b0000;
                    alu_func   = 4'b0000;
                    en_load     =1'b0;
                    en_store   =1'b0;
                end
            endcase
        end
    end
    
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            en_fetch_reg <= 1'b0;
            en_pc_reg    <= 1'b0;
            en_group_reg <= 1'b0;
            en_load_reg   <= 1'b0;
            en_store_reg <= 1'b0;
            en_datapc_reg <= 1'b0;
        end
        else begin
            en_fetch_reg <= en_fetch;
            en_pc_reg    <= en_pc;
            en_group_reg <= en_group;
            en_load_reg   <= en_load;
            en_store_reg <= en_store;
            en_datapc_reg <= en_datapc;
        end
    end
    
    always @ (en_fetch or en_fetch_reg)
        en_fetch_pulse = en_fetch & (~en_fetch_reg);
    
    always @ (en_pc_reg or en_pc)
        en_pc_pulse = en_pc & (~en_pc_reg);

    always @ (en_datapc_reg or en_datapc)
        en_datapc_pulse = en_datapc & (~en_datapc_reg);

    always @ (en_group_reg or en_group)
        en_group_pulse = en_group & (~en_group_reg);

    always @ (en_load or en_load_reg)
        en_load_pulse = en_load & (~en_load_reg);

    always @ (en_store or en_store_reg)
        en_store_pulse = en_store & (~en_store_reg);   
    
endmodule
