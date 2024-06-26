`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:47:13
// Design Name: 
// Module Name: datapath
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
