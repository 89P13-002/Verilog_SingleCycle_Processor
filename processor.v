`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:45:58
// Design Name: 
// Module Name: processor
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


// finally combine all units 
module Processor (
    input clk,  // clock signal for PC 
    input ready // make ready for computation
);

wire [15:0] in_instruction;

wire c_RegDataSel, c_MemRead, c_MemDataSel, c_MemWrite, c_AluSel,c_RegWrite;

wire [1:0] c_ALUOp;
wire c_zero;


// Instantiate Controller and Datapath modules
Controller u_Controller(
    .clk(clk),
    .ready(ready),
    .c_zero(c_zero),
    .in_instruction(in_instruction),
    .c_RegDataSel(c_RegDataSel),
    .c_MemRead(c_MemRead),
    .c_MemDataSel(c_MemDataSel),
    .c_ALUOp(c_ALUOp),
    .c_MemWrite(c_MemWrite),
    .c_AluSel(c_AluSel),
    .c_RegWrite(c_RegWrite)
);

Datapath u_Datapath(
    .clk(clk),
    .ready(ready),
    .c_ALUOp(c_ALUOp),
    .in_instruction(in_instruction),
    .c_MemWrite(c_MemWrite),
    .c_MemRead(c_MemRead),
    .c_RegDataSel(c_RegDataSel),
    .c_AluSel(c_AluSel),
    .c_MemDataSel(c_MemDataSel),
    .c_zero(c_zero),
    .c_RegWrite(c_RegWrite)
);


endmodule



