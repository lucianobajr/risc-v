`include "./stages/MEM/data_memory.v"
`include "./util/mux1.v"
`include "./registers/mem_wb2.v"

module mem2(
    wb_ctlout,
    branch, 
    memread, 
    memwrite,
    zero,
    alu_result, 
    rdata2out,
    five_bit_muxout,
    MEM_PCSrc,
    MEM_WB_regwrite, 
    MEM_WB_memtoreg,
    read_data, 
    mem_alu_result,
    mem_write_reg
);
    input wire	[1:0]	wb_ctlout;
	input wire branch, memread, memwrite,zero;
	input wire [31:0] alu_result, rdata2out;
	input wire [4:0] five_bit_muxout;
	output wire MEM_PCSrc,MEM_WB_regwrite, MEM_WB_memtoreg;
	output wire	[31:0] read_data, mem_alu_result;
	output wire	[4:0] mem_write_reg;

    wire [31:0]	read_data_in;


    AND AND_4(
		.A(branch), 
		.B(zero),
		.Exit(MEM_PCSrc)
	);

    data_memory dm(
        .clock(1'b0),
        .reset(1'b0),
        .mem_write(memwrite),
        .mem_read(dataMemoryOut),
        .address(alu_result),
        .write_data(rdata2out),
        .result(read_data_in)
    );
    mem_wb2 mem_wb4( 
		.control_wb_in(wb_ctlout),			// inputs
		.read_data_in(read_data_in),
		.alu_result_in(alu_result),
		.write_reg_in(five_bit_muxout),
		.regwrite(MEM_WB_regwrite),			//outputs
		.memtoreg( MEM_WB_memtoreg),
		.read_data(read_data),
		.mem_alu_result(mem_alu_result),
		.mem_write_reg(mem_write_reg)
	);
endmodule