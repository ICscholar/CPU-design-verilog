`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/13 21:13:45
// Design Name: 
// Module Name: tb_alu
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

`define AaddB 4'b0000
`define AsubB 4'b0001
`define AmulB 4'b0010
`define AdivB 4'b0011
`define AxorB 4'b0101
`define AandB 4'b0110
`define AorB 4'b0111
`define comp 4'b1000
`define left_shift 4'b1001 
`define right_shift 4'b1010 
`define average 4'b1011
module tb_alu(

    );


    reg clk, rst, en_in;
    reg [15:0] alu_a, alu_b;
    reg [3:0] alu_func;
    wire [15:0] alu_out;
    wire en_out;

  // Instantiate the ALU module
  alu dut(.clk(clk), .rst(rst), .en_in(en_in), .alu_a(alu_a), 
          .alu_b(alu_b), .alu_func(alu_func), .en_out(en_out), 
          .alu_out(alu_out));

  // Generate clock signal
  always #10 clk=~clk;

initial begin
    clk = 0;
    rst = 0;
    en_in = 0;
    alu_a = 16'b0000_0000_0000_0000;
    alu_b = 16'b0000_0000_0000_0000;
    alu_func = `AaddB;

    // Reset the module
    #(20);
    rst = 1;
    #(20);

    // Test Add operation
    alu_a = 16'h1234;
    alu_b = 16'h5678;
    alu_func = `AaddB;
    en_in = 1;
    #(20);
    $display("Add operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h68ac) $display("Error: Add operation failed");

    // Test Subtract operation
    alu_a = 16'h5678;
    alu_b = 16'h1234;
    alu_func = `AsubB;
    #(20);
    $display("Subtract operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h4444) $display("Error: Subtract operation failed");

    // Test Multiply operation
    alu_a = 16'h1234;
    alu_b = 16'h5678;
    alu_func = `AmulB;
    #(20);
    $display("Multiply operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h6dbe) $display("Error: Multiply operation failed");

    // Test Divide operation
    alu_a = 16'h5678;
    alu_b = 16'h1234;
    alu_func = `AdivB;
    #(20);
    $display("Divide operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h0000) $display("Error: Divide operation failed");

    // Test XOR operation
    alu_a = 16'h5a5a;
    alu_b = 16'h2b2b;
    alu_func = `AxorB;
    #(20);
    $display("XOR operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h7171) $display("Error: XOR operation failed");

    // Test AND operation
    alu_a = 16'h5a5a;
    alu_b = 16'h2b2b;
    alu_func = `AandB;
    #(20);
    $display("AND operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h0808) $display("Error: AND operation failed");

    // Test OR operation
    alu_a = 16'h5a5a;
    alu_b = 16'h2b2b;
    alu_func = `AorB;
    #(20);
    $display("OR operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h7f7b) $display("Error: OR operation failed");

    // Test comparison operation
    alu_a = 16'd1000;
    alu_b = 16'd500;
    alu_func = `comp;
    #(20);
    $display("Comparison operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h03e8) $display("Error: Comparison operation failed");

    // Test left shift operation
    alu_a = 16'h5678;
    alu_func = `left_shift;
    #(20);
    $display("Left shift operation: alu_out=%h", alu_out);
    if (alu_out !== 16'hace0) $display("Error: Left shift operation failed");

    // Test right shift operation
    alu_a = 16'h5678;
    alu_func = `right_shift;
    #(20);
    $display("Right shift operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h2bb4) $display("Error: Right shift operation failed");

    // Test average operation
    alu_a = 16'h1234;
    alu_b = 16'h5678;
    alu_func = `average;
    #(20);
    $display("Average operation: alu_out=%h", alu_out);
    if (alu_out !== 16'h3456) $display("Error: Average operation failed");

    $display("All tests passed successfully");

    // End simulation after testing
    #(20);
    $finish;
end

endmodule
