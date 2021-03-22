`include "./util/inst_memory.v"
`include "./registers/if_id2.v"

module if3 (
    exMemPc,
    exMemIn,
    ifIdInstruction,
    ifIdIn
);
    input wire exMemPc;
    input wire [31:0] exMemIn;
    output [31:0] ifIdIn,ifIdInstruction;
    

    wire [31:0] pc;
    wire [31:0] dataout;
    wire [31:0] in,muxOut;

    mux2 MUX2(.data0(exMemIn),.data1(in),.select(exMemPc),.out(muxOut));
    program_counter PC(.clock(1'b0), .reset(1'b0), .data_in(pc), .data_out(muxOut));
    instruction_memory memory(.instrucaoOut(dataout),.endereco(pc));		
    if_id2 IF_ID(.instrout(ifIdInstruction),.npcout(ifIdIn),.instr(dataout),.npc(in));
    pcplus4 PCPlus(.pcIn(pc), .pcOut(in),.clock(1'b0),.reset(1'b0));
endmodule