module id_ex(
    clock,
    reset,
    ctlwb_out,
    ctlm_out,
    ctlex_out,
    npc,
    readata1,
    readata2,
    signext_out,
    instr_2021,
    instr_1511,
    wb_ctlout,
    m_ctlout,
    regdst,
    alusrc,
    aluop,
    npcout,
    rdata1out,
    rdata2out,
    sign_extendout,
    instrout_2021,
    instrout_1511
);
    input wire clock,reset;
    input wire [1:0] ctlwb_out;
    input wire [2:0] ctlm_out;
    input wire [3:0] ctlex_out;
    input wire [31:0] npc, readata1, readata2, signext_out;
    input wire [4:0] instr_2021, instr_1511;
    
    output reg [1:0] wb_ctlout;
    output reg [2:0] m_ctlout;
    output reg regdst, alusrc;
    output reg [1:0] aluop;
    output reg [31:0] npcout, rdata1out, rdata2out, sign_extendout;
    output reg [4:0] instrout_2021, instrout_1511;
    
    initial  @(posedge reset) begin
            wb_ctlout       <= 0;
            m_ctlout        <= 0;
            regdst          <= 0;
            aluop           <= 0;
            alusrc          <= 0;
            npcout          <= 0;
            rdata1out       <= 0;
            rdata2out       <= 0;
            sign_extendout  <= 0;
            instrout_2021   <= 0;
            instrout_1511   <= 0;
    end

    always @(posedge clock ) begin
        #1
        wb_ctlout <= ctlwb_out;
        m_ctlout <= ctlm_out;
        regdst <= ctlex_out[3];
        aluop <= ctlex_out[2:1];
        alusrc <= ctlex_out[0];
        npcout <= npc;
        rdata1out <= readata1;
        rdata2out <= readata2;
        sign_extendout <= signext_out;
        instrout_2021 <= instr_2021;
        instrout_1511 <= instr_1511;
    end
endmodule