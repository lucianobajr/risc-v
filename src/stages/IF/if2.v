`include "./util/inst_memory.v"
`include "./util/mux2.v"
`include "./util/pc.v"

module if2 (clk, reset, hazard, outBranchControlin, pcBranchin, jumpin, pcJumpin, instruction, pc4out);
    input wire clk, reset, hazard, outBranchControlin, jumpin;
    input wire [31:0] pcBranchin, pcJumpin;    
    output [31:0] instruction, pc4out;

    wire [31:0] pcOutMuxJump, pc4, pcOut, pcIn;
    assign pc4out = pc4;

    instruction_memory InstructionMemory(.clk(clk), .reset(reset), .pcout(pcout), .instruction(instruction));
    program_counter ProgramCounter(.clk(clk), .reset(reset),  .data_in(pcIn), .data_out(pcOut));

    pcplus4 Adder(.pcIn(pcIn), .pcOut(pcOut), .clock(clk), .reset(reset));
    mux2 Mux2to1_1(.data0(pcJumpin), .data1(pc4), .select(jumpin), .out(pcOutMuxJump));
    mux2 Mux2to1_2(.data0(pcBranchin), .data1(pcOutMuxJump), .select(outBranchControlin), .out(pcIn));

endmodule

// hazard nao esta sendo utilizado