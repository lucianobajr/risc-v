`include "./stages/ID/controller.v"
`include "./stages/ID/registers.v"
`include "./util/imm_gen.v"
`include "./registers/id_ex.v"

module instructionDecode (
    clock,
    reset,
    if_id_instruction_out,
    if_id_npc_out,
    mem_wb_rd,
    mem_wb_regwrite,
    branch,
    memread, 
	memwrite,
    memtoreg,
    wb_mux5_writedata,
    wb_ctlout,
    m_ctlout,
    regdst,
    alusrc,
    aluop, 
    npcout,
    readdata1out,
    readdata2out,
    sign_extendout,
    instrout_2021,
    instrout_1511
);


    input wire clock,reset;
    input wire [31:0] if_id_instruction_out, if_id_npc_out;
    input wire [4:0] mem_wb_rd;
    input wire mem_wb_regwrite,branch, memread,memwrite,memtoreg;
    input wire [31:0] wb_mux5_writedata;
    output wire [1:0] wb_ctlout;
    output wire [2:0] m_ctlout;
    output wire regdst, alusrc;
    output wire [1:0] aluop;
    output wire [31:0] npcout, readdata1out, readdata2out, sign_extendout;
    output wire [4:0] instrout_2021, instrout_1511;

    wire [3:0] ctlex_out;
    wire [2:0] ctlm_out;
    wire [1:0] ctlwb_out;
    wire [31:0] read_data1, read_data2, signextendout;  

    controller control2( 
        .opcode(if_id_instruction_out[6:0]),
        .branch(branch), 
        .memRead(memread), 
        .memToReg(memtoreg), 
        .memWrite(memwrite), 
        .aluSrc(alusrc), 
        .regWrite(mem_wb_regwrite), 
        .aluOp(aluop),
        .regDst(regdst)
    );

    registers registered(
        .writereg(mem_wb_regwrite),
        .writedata(wb_mux5_writedata),
        .rs1(if_id_instruction_out[19:15]), 
        .rs2(if_id_instruction_out[24:20]),
        .rd(mem_wb_rd),
        .readdata1(read_data1),
        .readdata2(read_data2),
        .clock(clock), 
        .reset(reset)
    );

    sign_extender signalextender(
        .nextend(if_id_instruction_out[15:0]),
        .extended(sign_extendout)
    );

    id_ex idex2(
        .clock(clock),
        .reset(reset),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .ctlex_out(ctlex_out),
        .npc(if_id_npc_out),
        .readata1(read_data1),
        .readata2(read_data2),
        .branch(branch),
        .memread(memread), 
	    .memwrite(memwrite),
        .memtoreg(memToReg),
        .signext_out(signextendout),
        .instr_2021(if_id_instruction_out[20:16]),
        .instr_1511(if_id_instruction_out[15:11]),
        .wb_ctlout(wb_ctlout),
        .m_ctlout(m_ctlout),
        .regdst(regdst),
        .alusrc(alusrc),
        .aluop(aluop),
        .npcout(npcout),
        .rdata1out(readdata1out),
        .rdata2out(readdata2out),
        .sign_extendout(sign_extendout),
        .instrout_2021(instrout_2021),
        .instrout_1511(instrout_1511)
    );
endmodule