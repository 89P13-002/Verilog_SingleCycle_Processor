# Verilog_SingleCycle_Processor
Implemented six instruction programmable Single Cycle Processor in a Hardware Description language (Verilog)

# Details:-
Designed the data path and conroller of the processor.The controller part consists of an instruction memory, program counter, instruction registers and a controller.the datapath consists of data memory 2x1 mux, register file and an ALU(Arithmetic and Logic unit).

# Supported instruction  
1. MOV Ra, d : RF[a] = D[d] (move from data memory to register file) : opcode -> 0000 r3r2r1r0 d7d6d5d4d3d2d1d0
2. MOV d, Ra : D[d] = RF[a] (move from register file to data memory) : opcode -> 0001 r3r2r1r0 d7d6d5d4d3d2d1d0
3. ADD Ra, Rb, Rc : RF[a] = RF[b]+RF[c] : opcode -> 0010 ra3ra2ra1ra0 rb3rb2rb1rb0 rc3rc2rc1rc0 
4. MOV Ra, #C :  RF[a] = c : opcode -> 0011 r3r2r1r0 c7c6c5c4c3c2c1c0"
5. SUB Ra, Rb, Rc : RF[a] = RF[b]-RF[c] : opcode -> 0100 ra3ra2ra1ra0 rb3rb2rb1rb0 rc3rc2rc1rc0
6. JMPZ Ra, offset : PC = PC + offset if R[a] is 0 : opcode -> 0101 ra3ra2ra1ra0 o7o6o5o4o3o2o1o0



# Reference

