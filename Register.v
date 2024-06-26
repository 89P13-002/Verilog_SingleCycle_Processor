`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:40:36
// Design Name: 
// Module Name: Register
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

// reg file iska size decide karna hai

module Register (                 
    input [15:0] instruction,   // 16-bit instruction
    input RegWrite,             // agar koi instruction me reg me val load karna ho 
    input [15:0] WriteData,     // koi val reg me write karni ho then
    output reg [15:0] ReadData1,    // alu ka 1st input
    output reg [15:0] ReadData2     // alu ka 2nd input
);

reg [15:0] RegFile [15:0];  // register data

always @(RegWrite or instruction or WriteData) begin  
    ReadData2 = RegFile[instruction[3:0]];
    if(instruction[15:12] == 4'b0001 || instruction[15:12] == 4'b0101) begin
        ReadData1 = RegFile[instruction[11:8]];
    end
    else begin
        ReadData1 = RegFile[instruction[7:4]];        
    end
    if(RegWrite == 1'b1) begin
        RegFile[instruction[11:8]] = WriteData ; 
    end
end
endmodule

