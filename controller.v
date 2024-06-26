`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:41:10
// Design Name: 
// Module Name: controller
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



module Controller (
    input clk,
    input ready,

    input c_zero,

    output  [15:0] in_instruction,
    output  c_RegDataSel,
    output  c_MemRead,
    output  c_MemDataSel,
    output  [1:0]c_ALUOp,
    output  c_MemWrite,
    output  c_AluSel,
    output c_RegWrite
);

wire [15:0] pc_in, pc_out;
wire c_Jump;


Program_counter u_Program_counter (
    .clk (clk),
    .in(pc_in),
    .out (pc_out)
);

Instruction_memory u_Instruction_memory (
    .addr(pc_out),
    .ready(ready),
    .instruction(in_instruction)
);

Control u_Control (
    .instruction(in_instruction),
    .RegDataSel     (c_RegDataSel),
    .Jump       (c_Jump),
    .MemRead    (c_MemRead),
    .MemDataSel   (c_MemDataSel),
    .ALUOp      (c_ALUOp),
    .MemWrite   (c_MemWrite),
    .AluSel     (c_AluSel),
    .RegWrite   (c_RegWrite)
);

Next_pc u_Next_pc (
    .old        (pc_out),
    .Jump       (c_Jump),
    .zero       (c_zero),
    .ready      (ready),
    .Offset     (in_instruction[7:0]),
    .out       (pc_in)
);

endmodule
