# Verilog_SingleCycle_Processor
Implemented six instruction programmable Single Cycle Processor in a Hardware Description language (Verilog)

# Details:-
Designed the data path and conroller of the processor.The controller part consists of an instruction memory, program counter, instruction registers and a controller.the datapath consists of data memory 2x1 mux, register file and an ALU(Arithmetic and Logic unit).

# Supported instruction
1. MOV Ra, d : 
2. MOV d, Ra : 
3. ADD Ra, Rb, Rc :
4. MOV Ra, #C : For loading const c to register file a ( RF[a] = c) " opcode : 0011_r3r2r1r0_c7c6c5c4c3c2c1c0"
5. SUB Ra, Rb, Rc :
6. JMPZ Ra, offset : 
