`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:31:32
// Design Name: 
// Module Name: control
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

module ALU (
    input [15:0] data1,        // data 1
    input [15:0] data2,        // data 2 from MUX
    input [1:0] ALUcontrol,    // for operation
    output reg zero,           // check for equality
    output reg [15:0] ALUresult // final ans
);

    wire [15:0] sum;
    wire [15:0] difference;
    wire carry_borrow;

    // Gate-level instantiation of adder_subtractor module
    adder_subtractor add_sub(
        .a(data1),
        .b(data2),
        .sel(ALUcontrol[0]),
        .dout(sum),
        .carry_borrow(carry_borrow)
    );
    wire [15:0] xor_d12;
    xor(xor_d12[0], data1[0], data2[0]);
    xor(xor_d12[1], data1[1], data2[1]);
    xor(xor_d12[2], data1[2], data2[2]);
    xor(xor_d12[3], data1[3], data2[3]);
    xor(xor_d12[4], data1[4], data2[4]);
    xor(xor_d12[5], data1[5], data2[5]);
    xor(xor_d12[6], data1[6], data2[6]);
    xor(xor_d12[7], data1[7], data2[7]);
    xor(xor_d12[8], data1[8], data2[8]);
    xor(xor_d12[9], data1[9], data2[9]);
    xor(xor_d12[10], data1[10], data2[10]);
    xor(xor_d12[11], data1[11], data2[11]);
    xor(xor_d12[12], data1[12], data2[12]);
    xor(xor_d12[13], data1[13], data2[13]);
    xor(xor_d12[14], data1[14], data2[14]);
    xor(xor_d12[15], data1[15], data2[15]);
    always @* begin
        case (ALUcontrol)
            2'b00: begin // Addition
                ALUresult = sum;
                zero = 1'b0;
            end
            2'b01: begin // Subtraction
                ALUresult = sum;
                zero = 1'b0;
            end
            2'b10 : begin
                if(!xor_d12) begin
                    ALUresult = 16'b0000000000000000;
                    zero = 1'b1;
                end
                else begin
                    ALUresult = 16'b0000000000000000;
                    zero = 1'b0;
                end
            end
            default: begin
                ALUresult = 16'b0000000000000000;
                zero = 1'b0;
            end
        endcase
    end

endmodule
