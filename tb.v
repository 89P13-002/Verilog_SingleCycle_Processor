`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 12:48:04
// Design Name: 
// Module Name: tb
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

`define CYCLE_TIME 10

module processor_tb;

reg clk = 1'b0;
reg r = 1'b0;
integer i; // integer  counter

always #(`CYCLE_TIME / 2) clk = ~clk;

Processor uut (.clk(clk),.ready(r));

initial begin
// Initialize data memory
  // loading reg
  uut.u_Controller.u_Instruction_memory.InstructionMem[0] = 16'b0011_0010_0000_0000; // load r2	(sum)
  uut.u_Controller.u_Instruction_memory.InstructionMem[1] = 16'b0011_0100_0000_0000;	// load r4	(0)
  uut.u_Controller.u_Instruction_memory.InstructionMem[2] = 16'b0011_0001_0000_0110; //  load r1  (n)
  uut.u_Controller.u_Instruction_memory.InstructionMem[3] = 16'b0011_0011_0000_0001; // load r3	(1)
  
  
  // add (sum = sum+n)
  uut.u_Controller.u_Instruction_memory.InstructionMem[4] = 16'b0010_0101_0001_0010; // add r5 = r1+r2
  uut.u_Controller.u_Instruction_memory.InstructionMem[5] = 16'b0001_0101_0000_0010; // D[2] = r5
  uut.u_Controller.u_Instruction_memory.InstructionMem[6] = 16'b0000_0010_0000_0010; // r2 = D[2]
  
  // sub (n = n-1)
  uut.u_Controller.u_Instruction_memory.InstructionMem[7] = 16'b0100_0110_0001_0011; // sub r6 = r1-r3
  uut.u_Controller.u_Instruction_memory.InstructionMem[8] = 16'b0001_0110_0000_0011; // D[3] = r6
  uut.u_Controller.u_Instruction_memory.InstructionMem[9] = 16'b0000_0001_0000_0011; // r1 = D[3]
  
  // jump 
  uut.u_Controller.u_Instruction_memory.InstructionMem[10] = 16'b0101_0001_0000_0010; // jump to exit if n == 0
  uut.u_Controller.u_Instruction_memory.InstructionMem[11] = 16'b0101_0100_1111_1001; // jump to loop otherwise

// test jump
//   uut.u_Controller.u_Instruction_memory.InstructionMem[0] = 16'b0011_0001_0000_0000; 
//   uut.u_Controller.u_Instruction_memory.InstructionMem[1] = 16'b0101_0001_0000_0100; // jump to exit if n == 0
  
  //   uut.u_Controller.u_Instruction_memory.InstructionMem[8] = 16'b0001_0010_0000_0010; //
  
#20 

  r = 1'b1;

end

always @(posedge clk) begin
  $display($time,, "PC = %d", uut.u_Controller.pc_in);
  $display($time,, "IM = %b", uut.in_instruction);
//   $display($time,, "RegData = %d", uut.u_Datapath.u_Register.RegFile[1]);
  $display($time,, "MemData = %d", uut.u_Datapath.u_Data_memory.DataMem[2]);
end 
initial begin
    #1800 $finish;
end


endmodule


