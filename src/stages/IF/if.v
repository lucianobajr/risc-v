`include "./util/inst_memory.v"
`include "./registers/if_id.v"

module intructionfetch (
    clock,
    reset,
    exMemPc,
    exMemIn,
    ifIdInstruction,
    ifIdIn
);
    input wire clock,reset;
    input wire exMemPc;
    input wire [31:0] exMemIn;
    output [31:0] ifIdIn,ifIdInstruction;
    
    wire [31:0] pc;
    wire [31:0] dataOut;
    wire [31:0] in,muxOut;

    mux2 MUX2(.data0(exMemIn),.data1(in),.select(exMemPc),.out(muxOut));
    program_counter PC(.clock(clock), .reset(reset), .data_in(pc), .data_out(muxOut));
    instruction_memory memory(.instrucaoOut(dataOut),.endereco(pc));		
    if_id IF_ID(.clock(clock),.reset(reset),.instrout(ifIdInstruction),.npcout(ifIdIn),.instr(dataOut),.npc(in));
    pcplus4 PCPlus(.pcIn(pc), .pcOut(in),.clock(clock),.reset(reset));
endmodule