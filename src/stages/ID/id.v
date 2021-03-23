`include "./stages/ID/controller.v"
`include "./stages/ID/registers.v"
`include "./util/imm_gen.v"
`include "./registers/id_ex.v"

module instructionDecode (
    clock,
    reset,
    instrOutIfId,
    pcOutIfId,
    memWbRd,
    branch,
    memread, 
	memwrite,
    memtoreg,
    writeDtMux5Wb, // dt = data
    wbCtlOut,
    mCtlOut,
    regdst,
    alusrc,
    aluop, 
    pcOut,
    readData1Out,
    readData2Out,
    signExtendOut,
    instrOut1,
    instrOut2
);


    input wire clock,reset;
    input wire [31:0] instrOutIfId, pcOutIfId;
    input wire [4:0] memWbRd;
    input wire branch, memread,memwrite,memtoreg;
    input wire [31:0] writeDtMux5Wb;
    output wire [1:0] wbCtlOut;
    output wire [2:0] mCtlOut;
    output wire regdst, alusrc;
    output wire [1:0] aluop;
    output wire [31:0] pcOut, readData1Out, readData2Out, signExtendOut;
    output wire [4:0] instrOut1, instrOut2;

    wire [3:0] ctlExOut;
    wire [2:0] ctlMOut;
    wire [1:0] ctlWbOut;
    wire [31:0] readData1, readData2, extendOutSign;  

    controller control2( 
        .opcode(instrOutIfId[6:0]),
        .branch(branch), 
        .memRead(memread), 
        .memToReg(memtoreg), 
        .memWrite(memwrite), 
        .aluSrc(alusrc), 
        .regWrite(memWbRd), 
        .aluOp(aluop),
        .regDst(regdst)
    );

    registers registered(
        .writereg(memWbRd),
        .writedata(writeDtMux5Wb),
        .rs1(instrOutIfId[19:15]), 
        .rs2(instrOutIfId[24:20]),
        .rd(memWbRd),
        .readdata1(readData1),
        .readdata2(readData2),
        .clock(clock), 
        .reset(reset)
    );

    sign_extender signalextender(
        .nextend(instrOutIfId[15:0]),
        .extended(signExtendOut)
    );

    id_ex idex2(
        .clock(clock),
        .reset(reset),
        .ctlwb_out(ctlWbOut),
        .ctlm_out(ctlMOut),
        .ctlex_out(ctlExOut),
        .npc(pcOutIfId),
        .readata1(readData1),
        .readata2(readData2),
        .signext_out(extendOutSign),
        .instr_2021(instrOutIfId[20:16]),
        .instr_1511(instrOutIfId[15:11]),
        .wb_ctlout(wbCtlOut),
        .m_ctlout(mCtlOut),
        .regdst(regdst),
        .alusrc(alusrc),
        .aluop(aluop),
        .npcout(pcOut),
        .rdata1out(readData1Out),
        .rdata2out(readData2Out),
        .sign_extendout(signExtendOut),
        .instrout_2021(instrOut1),
        .instrout_1511(instrOut2)
    );
endmodule