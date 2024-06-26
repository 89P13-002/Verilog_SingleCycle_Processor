`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:34:10
// Design Name: 
// Module Name: Data_Mem
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

// data memory
module Data_memory (                
    input [7:0] addr,          // address to read
    input [15:0] wData,         // address to write
    input MemWrite,             // write signal
    input MemRead,              // read signal
    output reg [15:0] rData     // output of mem
);

// size and initialization 
parameter SIZE_DM = 32;  // size of this memory
reg [15:0] DataMem[SIZE_DM-1:0];  // instruction memory


always @(MemRead or MemWrite or addr) begin
    if (MemRead == 1'b1) begin
        rData = DataMem[addr];
    end 
    else if (MemWrite == 1'b1) begin
        DataMem[addr] = wData;
    end
end

endmodule
