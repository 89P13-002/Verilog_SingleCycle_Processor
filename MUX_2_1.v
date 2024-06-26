`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:29:49
// Design Name: 
// Module Name: MUX_2_1
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


// mux
//module Mux_2x1 (
//    input sel,
//    input [15:0] a,
//    input [15:0] b,
//    output reg [15:0] out
//);
    
//    always @* begin
//        if(sel == 1'b0)
//            out = a;
//        else
//            out = b;
//    end
    
//endmodule
// mux
module Mux_2x1 (
    input sel,
    input [15:0] a,
    input [15:0] b,
    output [15:0] out
);
 
  wire nsel;  
  not(nsel,sel);
  //for a of mux
  wire [15:0] w1,w2;
 
  and(w1[0],a[0],nsel);
  and(w1[1],a[1],nsel);
  and(w1[2],a[2],nsel);
  and(w1[3],a[3],nsel);
  and(w1[4],a[4],nsel);
  and(w1[5],a[5],nsel);
  and(w1[6],a[6],nsel);
  and(w1[7],a[7],nsel);
  and(w1[8],a[8],nsel);
  and(w1[9],a[9],nsel);
  and(w1[10],a[10],nsel);
  and(w1[11],a[11],nsel);
  and(w1[12],a[12],nsel);
  and(w1[13],a[13],nsel);
  and(w1[14],a[14],nsel);
  and(w1[15],a[15],nsel);
 
  //for b of mux
  and(w2[0],b[0],sel);
  and(w2[1],b[1],sel);
  and(w2[2],b[2],sel);
  and(w2[3],b[3],sel);
  and(w2[4],b[4],sel);
  and(w2[5],b[5],sel);
  and(w2[6],b[6],sel);
  and(w2[7],b[7],sel);
  and(w2[8],b[8],sel);
  and(w2[9],b[9],sel);
  and(w2[10],b[10],sel);
  and(w2[11],b[11],sel);
  and(w2[12],b[12],sel);
  and(w2[13],b[13],sel);
  and(w2[14],b[14],sel);
  and(w2[15],b[15],sel);
 
  //output of vals a and b
  or(out[0],w1[0],w2[0]);
  or(out[1],w1[1],w2[1]);
  or(out[2],w1[2],w2[2]);
  or(out[3],w1[3],w2[3]);
  or(out[4],w1[4],w2[4]);
  or(out[5],w1[5],w2[5]);
  or(out[6],w1[6],w2[6]);
  or(out[7],w1[7],w2[7]);
  or(out[8],w1[8],w2[8]);
  or(out[9],w1[9],w2[9]);
  or(out[10],w1[10],w2[10]);
  or(out[11],w1[11],w2[11]);
  or(out[12],w1[12],w2[12]);
  or(out[13],w1[13],w2[13]);
  or(out[14],w1[14],w2[14]);
  or(out[15],w1[15],w2[15]);
endmodule
