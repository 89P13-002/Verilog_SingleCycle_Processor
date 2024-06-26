`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:39:32
// Design Name: 
// Module Name: ProgCount
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


// program counter just assign kar rha hai address ko 
module Program_counter (
    input clk,
    input [15:0] in,  // the input address
    output reg [15:0] out  // the output address
);

always @(posedge clk) begin
    out = in;
end

endmodule
