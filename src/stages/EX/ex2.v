`include "./util/pc.v"
`include "./util/bottom_mux.v"
`include "./util/alu_control.v"
`include "./util/alu.v"
`include "./util/top_mux.v"
`include "./registers/ex_mem2.v"

module ex2 (
    wb_ctl,  	
	m_ctl,
	regdst, 
    alusrc,
	aluop, 
	npcout, 
    rdata1, 
    rdata2, 
    s_extendout,
	instrout_2016, 
    instrout_1511,
	wb_ctlout,
	branch,
    memread, 
    memwrite,
	EX_MEM_NPC,
	zero,
	alu_result,
    rdata2out,
	five_bit_muxout
);
    input wire regdst, alusrc;
    input wire [1:0] wb_ctl,aluop;
	input wire [2:0]	m_ctl;
	input wire [31:0]	npcout, rdata1, rdata2, s_extendout;
	input wire [4:0]	instrout_2016, instrout_1511;
	output	wire [1:0]	wb_ctlout;
	output	wire zero,branch, memread, memwrite;
	output	wire	[31:0]	EX_MEM_NPC,alu_result, rdata2out;
	output	wire	[4:0]	five_bit_muxout;

    wire [31:0]	adder_out, b, aluout;
	wire [4:0]	muxout;
	wire [3:0]	control;
	wire aluzero;

    adder32 adder(
        .operand1(npcout),
        .operand2(s_extendout),
        .sum(adder_out)
	);

    bottom_mux bottomMux(.a(instrout_1511),.b(instrout_2016),.sel(regdst),.out(muxout));

    alu_control aluControl(
        .funct7(s_extendout[31:25]),
        .funct3(s_extendout[14:12]),
        .alu_operation(aluop),
        .alu_ctr(control)
    );

    alu ALU(.alu_control(control),.a(rdata1),.b(b),.alu_out(aluout),.zero(aluzero));
    top_mux top_mux3(.a(s_extendout), .b(rdata2),.sel(alusrc),.out(b));
    ex_mem2 ex_mem3(
        .ctlwb_out(wb_ctl),			
        .ctlm_out(m_ctl),
        .adder_out(adder_out),
        .aluzero(aluzero),
        .aluout(aluout), 
        .readdat2(rdata2),
        .muxout(muxout), 
        .wb_ctlout(wb_ctlout),		
        .branch(branch), 
        .memread(memread), 
        .memwrite(memwrite), 
        .add_result(EX_MEM_NPC),
        .zero(zero),
        .alu_result(alu_result), 
        .rdata2out(rdata2out),
        .five_bit_muxout(five_bit_muxout)
    );
endmodule