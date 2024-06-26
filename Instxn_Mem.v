`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:34:53
// Design Name: 
// Module Name: Instxn_Mem
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

// instruction mem 
module Instruction_memory (
    input [15:0] addr,            // address to read
    input ready,                 // ready for computation
    output reg [15:0] instruction       // actual instruction in binary 
);

// inalization and size 
parameter SIZE_IM = 32;  // size of this memory  
reg [15:0] InstructionMem[SIZE_IM-1:0];  // instruction memory


always @(addr or ready) begin
if (ready == 1'b0) begin  // init
    instruction = 16'b1111000000000000;
end 
else if(ready == 1'b1)begin
    instruction = InstructionMem[addr]; 
end

end

endmodule
