`include "./stages/IF/if.v"
`include "./stages/ID/id.v"
`include "./stages/EX/ex.v"
`include "./stages/MEM/mem.v"
`include "./stages/WB/wb.v"

module main (clock,reset);
	input wire clock,reset;
    wire EX_MEM_PCSrc;		
    wire [31:0] exMemPcIn,IF_ID_instr, IF_ID_npc; 	

    intructionfetch I_FETCH1(
		.clock(clock),
		.reset(reset),
        .exMemPc(EX_MEM_PCSrc),	
        .exMemIn(exMemPcIn), 
		.ifIdInstruction(IF_ID_instr), 	
        .ifIdIn(IF_ID_npc)	 
	);
			
	wire memread, memwrite,branch,MEM_WB_regwrite,regdst, memToReg,alusrc;	
	wire [1:0] wb_ctlout,aluop; 	
	wire [2:0] m_ctlout; 		
	wire [4:0] MEM_WB_rd,instrout1, instrout2;			
	wire [31:0]	WB_mux5_writedata,npcout, rdata1out, rdata2out, s_extendout;		
	
	instructionDecode I_DECODE2(
		.if_id_instruction_out(IF_ID_instr),		
		.if_id_npc_out(IF_ID_npc),
		.mem_wb_rd(MEM_WB_rd),		
		.branch(branch),
		.memread(memread), 
		.memwrite(memwrite),
		.memtoreg(memToReg),
		.wb_mux5_writedata(WB_mux5_writedata),
		.wb_ctlout(wb_ctlout),		
		.m_ctlout(m_ctlout),
		.regdst(regdst),
		.alusrc(alusrc),
		.aluop(aluop),
		.npcout(npcout),
		.readdata1out(rdata1out),
		.readdata2out(rdata2out),
		.sign_extendout(s_extendout),
		.instrout_2021(instrout1),
		.instrout_1511(instrout2)
	);
	
	wire zero;
	wire [1:0] wb_ctlout_pipe;
	wire [4:0] five_bit_muxout;
	wire [31:0]	alu_result, rdata2out_pipe;
		
	ex EXECUTE(
		.wb_ctl(wb_ctlout),  		
		.m_ctl(m_ctlout),
		.regdst(regdst), 
		.alusrc(alusrc),
		.aluop(aluop), 
		.npcout(npcout), 
		.rdata1(rdata1out), 
		.rdata2(rdata2out), 
		.s_extendout(s_extendout),
		.instrout_2016(instrout1), 
		.instrout_1511(instrout2),
		.wb_ctlout(wb_ctlout_pipe),	
		.EX_MEM_NPC(exMemPcIn), 	
		.zero(zero),
		.alu_result(alu_result), 
		.rdata2out(rdata2out_pipe),
		.five_bit_muxout(five_bit_muxout)
	);  

	wire [31:0]	read_data, mem_alu_result;
	
	mem MEMORY4(
		.wb_ctlout(wb_ctlout_pipe),		
		.branch(branch), 
		.memread(memread),
		.memwrite(memwrite),
		.zero(zero),
		.alu_result(alu_result), 
		.rdata2out(rdata2out),
		.five_bit_muxout(five_bit_muxout),
		.MEM_PCSrc(EX_MEM_PCSrc),		
		.MEM_WB_regwrite(MEM_WB_regwrite), 
		.MEM_WB_memtoreg(memToReg),
		.read_data(read_data), 
		.mem_alu_result(mem_alu_result),
		.mem_write_reg(MEM_WB_rd) 		
	);  
						
	wb WB5(
		.mem_Read_data(read_data),		
		.mem_ALU_result(mem_alu_result),
		.MemtoReg(memToReg),
		.wb_data(WB_mux5_writedata)		
	); 	

endmodule
