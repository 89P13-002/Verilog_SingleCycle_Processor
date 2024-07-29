`timescale 1ns / 1ps

// mux
module Mux_2x1 (
    input sel,
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] out
);
    
    always @* begin
        if(sel == 1'b0)
            out = a;
        else
            out = b;
    end
    
endmodule



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
                if(data1 == data2) begin
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



module adder_subtractor(
    input [15:0] a,
    input [15:0] b,
    input wire sel,
    output [15:0] dout,
    output carry_borrow
);

    wire [15:0] s;
    wire [16:0] l;

    assign l = {1'b0, b} ^ {16{sel}};
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

    assign dout = a ^ b ^ c;   
    assign carry = (a & b) | (b & c) | (c & a);

endmodule


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



// controller 

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


module Controller (
    input clk,
    input ready,

    input c_zero,

    output  [15:0] in_instruction,
    output  c_RegDataSel,
    output  c_MemRead,
    output  c_MemDataSel,
    output  [1:0]c_ALUOp,
    output  c_MemWrite,
    output  c_AluSel,
    output c_RegWrite
);

wire [15:0] pc_in, pc_out;
wire c_Jump;


Program_counter u_Program_counter (
    .clk (clk),
    .in(pc_in),
    .out (pc_out)
);

Instruction_memory u_Instruction_memory (
    .addr(pc_out),
    .ready(ready),
    .instruction(in_instruction)
);

Control u_Control (
    .instruction(in_instruction),
    .RegDataSel     (c_RegDataSel),
    .Jump       (c_Jump),
    .MemRead    (c_MemRead),
    .MemDataSel   (c_MemDataSel),
    .ALUOp      (c_ALUOp),
    .MemWrite   (c_MemWrite),
    .AluSel     (c_AluSel),
    .RegWrite   (c_RegWrite)
);

Next_pc u_Next_pc (
    .old        (pc_out),
    .Jump       (c_Jump),
    .zero       (c_zero),
    .ready      (ready),
    .Offset     (in_instruction[7:0]),
    .out       (pc_in)
);

endmodule



module Datapath(
    input clk,
    input ready,

    input [1:0] c_ALUOp,
    input [15:0] in_instruction,
    input c_MemWrite,
    input c_MemRead,
    input c_RegDataSel,
    input c_AluSel,
    input c_MemDataSel,
    input c_RegWrite,

    output c_zero
);

wire [15:0] r_aluData,alu_result,r_memData,r_memMuxData,r_read1,r_read2,r_regMuxData;
  
Register u_Register (
    .instruction(in_instruction),
    .RegWrite   (c_RegWrite),
    .WriteData  (r_regMuxData),
    .ReadData1  (r_read1),
    .ReadData2  (r_read2)
);

ALU u_ALU (
    .data1      (r_read1),
    .data2      (r_aluData),
    .ALUcontrol (c_ALUOp),
    .zero       (c_zero),
    .ALUresult  (alu_result)
);

Data_memory u_Data_memory (
    .addr     (in_instruction[7:0]),  // im_instruction
    .wData    (r_read1),
    .MemWrite (c_MemWrite),
    .MemRead  (c_MemRead),
    .rData    (r_memData)
);


Mux_2x1 Reg_mux (
    .sel(c_RegDataSel),
    .a({{8{in_instruction[7]}}, in_instruction[7:0]}),
    .b(r_memMuxData),
    .out(r_regMuxData)
);

Mux_2x1 Alu_mux (
    .sel(c_AluSel),
    .a(r_read2),
    .b(16'b0000000000000000),
    .out(r_aluData)
);

Mux_2x1 Mem_mux (
    .sel(c_MemDataSel),
    .a(alu_result),
    .b(r_memData),
    .out(r_memMuxData)
);

endmodule

// finally combine all units 
module Top (
    input clk,  // clock signal for PC 
    input ready // make ready for computation
);

wire [15:0] in_instruction;

wire c_RegDataSel, c_MemRead, c_MemDataSel, c_MemWrite, c_AluSel,c_RegWrite;

wire [1:0] c_ALUOp;
wire c_zero;


// Instantiate Controller and Datapath modules
Controller u_Controller(
    .clk(clk),
    .ready(ready),
    .c_zero(c_zero),
    .in_instruction(in_instruction),
    .c_RegDataSel(c_RegDataSel),
    .c_MemRead(c_MemRead),
    .c_MemDataSel(c_MemDataSel),
    .c_ALUOp(c_ALUOp),
    .c_MemWrite(c_MemWrite),
    .c_AluSel(c_AluSel),
    .c_RegWrite(c_RegWrite)
);

Datapath u_Datapath(
    .clk(clk),
    .ready(ready),
    .c_ALUOp(c_ALUOp),
    .in_instruction(in_instruction),
    .c_MemWrite(c_MemWrite),
    .c_MemRead(c_MemRead),
    .c_RegDataSel(c_RegDataSel),
    .c_AluSel(c_AluSel),
    .c_MemDataSel(c_MemDataSel),
    .c_zero(c_zero),
    .c_RegWrite(c_RegWrite)
);


endmodule


