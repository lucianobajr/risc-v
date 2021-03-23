module id_ex(
    clock,
    reset,
    ctlWbOut,
    ctlMOut,
    ctlExOut,
    pcIn,
    readata1,
    readata2,
    signextOut,
    instr1,
    instr2,
    WbctlOut,
    MctlOut,
    regdst,
    alusrc,
    aluop,
    pcOut,
    rdata1out,
    rdata2out,
    signExtendOut,
    instrOut1,
    instrOut2
);
    input wire clock,reset;
    input wire [1:0] ctlWbOut;
    input wire [2:0] ctlMOut;
    input wire [3:0] ctlExOut;
    input wire [31:0] pcIn, readata1, readata2, signextOut;
    input wire [4:0] instr1, instr2;
    
    output reg [1:0] WbctlOut;
    output reg [2:0] MctlOut;
    output reg regdst, alusrc;
    output reg [1:0] aluop;
    output reg [31:0] npcout, rdata1out, rdata2out, signExtendOut;
    output reg [4:0] instrOut1, instrOut2;
    
    initial  @(posedge reset) begin
            WbctlOut       <= 0;
            MctlOut        <= 0;
            regdst          <= 0;
            aluop           <= 0;
            alusrc          <= 0;
            pcOut          <= 0;
            rdata1out       <= 0;
            rdata2out       <= 0;
            signExtendOut  <= 0;
            instrOut1   <= 0;
            instrOut2   <= 0;
    end

    always @(posedge clock ) begin
        #1
        WbctlOut <= ctlWbOut;
        MctlOut <= ctlMOut;
        regdst <= ctlExOut[3];
        aluop <= ctlExOut[2:1];
        alusrc <= ctlExOut[0];
        pcOut <= pcIn;
        rdata1out <= readata1;
        rdata2out <= readata2;
        signExtendOut <= signextOut;
        instrOut1 <= instr1;
        instrOut2 <= instr2;
    end
endmodule