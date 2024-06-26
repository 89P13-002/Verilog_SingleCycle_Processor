`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:38:21
// Design Name: 
// Module Name: PC
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



// next address calculation
module Next_pc (
    input [15:0] old,  // pc_in / old program counter
    input Jump,     // jarurat hai jab jump instruction ho
    input zero,     // jump if R[a] == 0 ho 
    input ready,    // kab suru karna hai
    input [7:0] Offset, // kitna jump karna hai
    output reg [15:0] out  // final next address ?? hoga
);


// next address calculation

always @(zero or Jump or old or ready) begin
    if(ready == 1'b0) begin
        out = 16'b0000000000000000;
    end
    else if(zero == 1'b1 && Jump == 1'b1) begin
        out = old + ({{8{Offset[7]}}, Offset}); // iske liye ek alu/simply ek adder banana hai
    end
    else begin
        out = old + 16'b0000000000000001;
    end
end

endmodule
