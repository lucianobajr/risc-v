`include "./util/mux2.v"

module wb (
    mem_Read_data,
	mem_ALU_result,
	MemtoReg,
	wb_data
);
    input wire MemtoReg;
    input wire [31:0] mem_ALU_result,mem_Read_data;	
	output wire [31:0] wb_data;

    mux2 MUX2(.data0(mem_Read_data),.data1(mem_ALU_result),.select(MemtoReg),.out(wb_data));
endmodule