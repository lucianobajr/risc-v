
module main2 ();
    wire [31:0] IF_ID_instr, IF_ID_npc;
    wire EX_MEM_PCSrc;		// reg from I_Fetch to Execute
    wire [31:0] EX_MEM_NPC; 	// reg from I_Fetch to Decode

    I_FETCH I_FETCH1(
        .EX_MEM_PCSrc(EX_MEM_PCSrc),	//inputs
        .EX_MEM_NPC(EX_MEM_NPC), 
		.IF_ID_instr(IF_ID_instr), 	//outputs
        .IF_ID_npc(IF_ID_npc)	 
	);
	//connects between the I_FETCH and I_DECODE modules

	wire	[4:0]	MEM_WB_rd;					//rd input to register module
	wire		MEM_WB_regwrite;	
	wire 	[31:0]	WB_mux5_writedata;				//writedata input to register module
	wire 	[1:0]	wb_ctlout; 					//output of control module (WB)
	wire 	[2:0]	m_ctlout; 					//output of control module (M)
	wire 		regdst; 					//output of control module (EX, regdst)
	wire 		alusrc; 					//output of control module (EX, alusrc)
	wire 	[1:0]	aluop; 						//output of control module (EX, aluop)
	wire 	[31:0]	npcout, rdata1out, rdata2out, s_extendout;	//outputs of the ID/EX pipeline register
	wire 	[4:0]	instrout_2016, instrout_1511; 			//outputs of the ID/EX pipeline register
	
	IDECODE I_DECODE2(
		.IF_ID_instrout(IF_ID_instr),		//inputs
		.IF_ID_npcout(IF_ID_npc),
		.MEM_WB_rd(MEM_WB_rd),			//from MEM/WB of MEMORY
		.MEM_WB_regwrite(MEM_WB_regwrite), 		
		.WB_mux5_writedata(WB_mux5_writedata),	//from WB_mux of Write-Back
		.wb_ctlout(wb_ctlout),			//outputs
		.m_ctlout(m_ctlout),
		.regdst(regdst),
		.alusrc(alusrc),
		.aluop(aluop),
		.npcout(npcout),
		.rdata1out(rdata1out),
		.rdata2out(rdata2out),
		.s_extendout(s_extendout),
		.instrout_2016(instrout_2016),
		.instrout_1511(instrout_1511)
		);
	// "Internal" wires for Execute to connect to other Stages
	wire	[1:0]	wb_ctlout_pipe;
	wire		branch, memread, memwrite;
	wire		zero;
	wire	[31:0]	alu_result, rdata2out_pipe;
	wire	[4:0]	five_bit_muxout;
		
	EXECUTE EXECUTE3(
		.wb_ctl(wb_ctlout),  		//11 inputs, based off of outputs of ID/EX latch (Lab 2-2)
		.m_ctl(m_ctlout),
		.regdst(regdst), 
		.alusrc(alusrc),
		.aluop(aluop), 
		.npcout(npcout), 
		.rdata1(rdata1out), 
		.rdata2(rdata2out), 
		.s_extendout(s_extendout),
		.instrout_2016(instrout_2016), 
		.instrout_1511(instrout_1511),
		.wb_ctlout(wb_ctlout_pipe),	//9 total outputs from EX/MEM latch (Lab 3-2)
		.branch(branch), 
		.memread(memread), 
		.memwrite(memwrite),
		.EX_MEM_NPC(EX_MEM_NPC), 	// add_result in Lab 3-5, said to go to IF_MUX
		.zero(zero),
		.alu_result(alu_result), 
		.rdata2out(rdata2out_pipe),
		.five_bit_muxout(five_bit_muxout)
		);  
	// Internal wires for MEMORY
	wire		MEM_WB_memtoreg;
	wire	[31:0]	read_data, mem_alu_result;
	
	MEMORY MEMORY4(
		.wb_ctlout(wb_ctlout_pipe),		//inputs
		.branch(branch), 
		.memread(memread), 
		.memwrite(memwrite),
		.zero(zero),
		.alu_result(alu_result), 
		.rdata2out(rdata2out),
		.five_bit_muxout(five_bit_muxout),
		.MEM_PCSrc(EX_MEM_PCSrc),		//outputs
		.MEM_WB_regwrite(MEM_WB_regwrite), 
		.MEM_WB_memtoreg(MEM_WB_memtoreg),
		.read_data(read_data), 
		.mem_alu_result(mem_alu_result),
		.mem_write_reg(MEM_WB_rd) 		//goes to DECODE register module, MEM_WB_rd
		);  
						
	WB WB5(
		.mem_Read_data(read_data),		// inputs
		.mem_ALU_result(mem_alu_result),
		.MemtoReg(MEM_WB_memtoreg),
		.wb_data(WB_mux5_writedata)		// outputs, goes to I_DECODE
	); 	

endmodule