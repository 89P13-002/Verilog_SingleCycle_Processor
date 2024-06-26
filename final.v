`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:28:14
// Design Name: 
// Module Name: bas
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



module Datapath(
    input clk,
    input ready,

    input [1:0] c_ALUOp,
    input [15:0] in_instruction,
    input c_MemWrite,
    input c_MemRead,
    input c_RegDataSel,
    input c_AluSel,
    input c_MemDataSel,
    input c_RegWrite,

    output c_zero
);

wire [15:0] r_aluData,alu_result,r_memData,r_memMuxData,r_read1,r_read2,r_regMuxData;
  
Register u_Register (
    .instruction(in_instruction),
    .RegWrite   (c_RegWrite),
    .WriteData  (r_regMuxData),
    .ReadData1  (r_read1),
    .ReadData2  (r_read2)
);

ALU u_ALU (
    .data1      (r_read1),
    .data2      (r_aluData),
    .ALUcontrol (c_ALUOp),
    .zero       (c_zero),
    .ALUresult  (alu_result)
);

Data_memory u_Data_memory (
    .addr     (in_instruction[7:0]),  // im_instruction
    .wData    (r_read1),
    .MemWrite (c_MemWrite),
    .MemRead  (c_MemRead),
    .rData    (r_memData)
);


Mux_2x1 Reg_mux (
    .sel(c_RegDataSel),
    .a({{8{in_instruction[7]}}, in_instruction[7:0]}),
    .b(r_memMuxData),
    .out(r_regMuxData)
);

Mux_2x1 Alu_mux (
    .sel(c_AluSel),
    .a(r_read2),
    .b(16'b0000000000000000),
    .out(r_aluData)
);

Mux_2x1 Mem_mux (
    .sel(c_MemDataSel),
    .a(alu_result),
    .b(r_memData),
    .out(r_memMuxData)
);

endmodule

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



