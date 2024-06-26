`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:36:24
// Design Name: 
// Module Name: Ctrl
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


module Control (
    input [15:0] instruction,   // instruction mem se instruction
    output reg RegDataSel,      // input data decide karne me
    output reg Jump,            // jump at equal 
    output reg MemRead,         // mem read karna ho then
    output reg MemWrite,        // mem me write karna ho then
    output reg MemDataSel,      // mem ke aage wala mux
    output reg [1:0] ALUOp,     // operation of Alu
    output reg AluSel,          // alu ke pahle ka mux
    output reg RegWrite         // reg file me likhna hai then
);


// initalization as default
initial begin
    RegDataSel = 1'b0;
    Jump = 1'b0;
    MemRead = 1'b0;
    MemDataSel = 1'b0;
    ALUOp = 2'b11;
    MemWrite = 1'b0;
    AluSel = 1'b0;
    RegWrite = 1'b0;
end

// opcode operation decide karega

always @(instruction) begin
case (instruction[15:12])
    // MOV R[a] d (R[a] = d)
    4'b0000: begin 
        RegDataSel = 1'b1;
        Jump = 1'b0;
        MemRead = 1'b1;
        MemDataSel = 1'b1;
        ALUOp = 2'b11;
        MemWrite = 1'b0;
        AluSel = 1'b0;
        RegWrite = 1'b1;
    end
    // MOV d R[a] (d = R[a])
    4'b0001: begin
        RegDataSel = 1'b0;
        Jump = 1'b0;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b11;
        MemWrite = 1'b1;
        AluSel = 1'b0;
        RegWrite = 1'b0;
    end
    // ADD R[a] R[b] R[c] (R[a] = R[b] + R[c])
    4'b0010: begin
        RegDataSel = 1'b1;
        Jump = 1'b0;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b00;
        MemWrite = 1'b0;
        AluSel = 1'b0;
        RegWrite = 1'b1;
    end
    // MOV R[a] #c (R[a] = c)
    4'b0011: begin
        RegDataSel = 1'b0;
        Jump = 1'b0;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b11;
        MemWrite = 1'b0;
        AluSel = 1'b0;
        RegWrite = 1'b1;
    end
    // SUB R[a] R[b] R[c] (R[a] = R[b] - R[c])
    4'b0100: begin
        RegDataSel = 1'b1;
        Jump = 1'b0;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b01;
        MemWrite = 1'b0;
        AluSel = 1'b0;
        RegWrite = 1'b1;
    end
    // JMPZ R[a] offset (if R[a] == 0, PC = PC + offset)
    4'b0101: begin
        RegDataSel = 1'b0;
        Jump = 1'b1;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b10;
        MemWrite = 1'b0;
        AluSel = 1'b1;
        RegWrite = 1'b0;
    end
    default : begin   // isko default kiya hai
        RegDataSel = 1'b0;
        Jump = 1'b0;
        MemRead = 1'b0;
        MemDataSel = 1'b0;
        ALUOp = 2'b11;
        MemWrite = 1'b0;
        AluSel = 1'b0;
        RegWrite = 1'b0;
    end
endcase
end

endmodule

