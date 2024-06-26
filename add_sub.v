`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:32:31
// Design Name: 
// Module Name: add_sub
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

module adder_subtractor(
    input [15:0] a,
    input [15:0] b,
    input wire sel,
    output [15:0] dout,
    output carry_borrow
);

    wire [15:0] s;
    wire [16:0] l;
    xor(l[0], b[0], sel);
    xor(l[1], b[1], sel);
    xor(l[2], b[2], sel);
    xor(l[3], b[3], sel);
    xor(l[4], b[4], sel);
    xor(l[5], b[5], sel);
    xor(l[6], b[6], sel);
    xor(l[7], b[7], sel);
    xor(l[8], b[8], sel);
    xor(l[9], b[9], sel);
    xor(l[10], b[10], sel);
    xor(l[11], b[11], sel);
    xor(l[12], b[12], sel);
    xor(l[13], b[13], sel);
    xor(l[14], b[14], sel);
    xor(l[15], b[15], sel);
    xor(l[16], 0, sel);
    // assign l = {1'b0, b} ^ {16{sel}};
    // 16-bit two's complement of b based on sel

    full_adder f0(a[0], l[0], sel, dout[0], s[0]);
    full_adder f1(a[1], l[1], s[0], dout[1], s[1]);
    full_adder f2(a[2], l[2], s[1], dout[2], s[2]);
    full_adder f3(a[3], l[3], s[2], dout[3], s[3]);
    full_adder f4(a[4], l[4], s[3], dout[4], s[4]);
    full_adder f5(a[5], l[5], s[4], dout[5], s[5]);
    full_adder f6(a[6], l[6], s[5], dout[6], s[6]);
    full_adder f7(a[7], l[7], s[6], dout[7], s[7]);
    full_adder f8(a[8], l[8], s[7], dout[8], s[8]);
    full_adder f9(a[9], l[9], s[8], dout[9], s[9]);
    full_adder f10(a[10], l[10], s[9], dout[10], s[10]);
    full_adder f11(a[11], l[11], s[10], dout[11], s[11]);
    full_adder f12(a[12], l[12], s[11], dout[12], s[12]);
    full_adder f13(a[13], l[13], s[12], dout[13], s[13]);
    full_adder f14(a[14], l[14], s[13], dout[14], s[14]);
    full_adder f15(a[15], l[15], s[14], dout[15], carry_borrow);

endmodule

module full_adder (
    input a,
    input b,
    input c,
    output dout,
    output carry
);
    wire temp1;
    wire temp2;
    wire temp3; 
    xor(dout, a, b, c);
    and(temp1, a, b);
    and(temp2, b, c);
    and(temp3, c, a);
    or(carry, temp1, temp2, temp3);
    // assign carry = (a & b) | (b & c) | (c & a);

endmodule
