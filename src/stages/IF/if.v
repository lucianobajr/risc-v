`include "./util/inst_memory.v"
`include "./util/pc.v"
`include "./util/mux2.v"
`include "./util/alu_control.v"

module if1(
    clk,
	reset,      
	WriteReg,
	SEtoReg,
	instruction
);
    input wire clk;
	input wire reset;
	output wire WriteReg;
	output wire SEtoReg;
	output [7:0] instruction;

    wire mux_2_1_sel;
	wire [7:0] mux_2_1_d0;
	wire [7:0] mux_2_1_d1 ;
	wire [7:0] mux_2_1_y ;

	/* Wires connected to a2_pc */
	wire pc_clk;
	wire pc_reset;
	wire [7:0] pc_address_in;
	wire [7:0] pc_address_out;

	/* Wires connected to a2_instruction_memory */
	wire instruction_memory_reset;
	wire [7:0] instruction_memory_address;
	wire [7:0] instruction_memory_instruction;

	/* Wires connected to add_1 */
	wire [7:0] add_1_address_in;
	wire [7:0] add_1_address_out;

	/* Wires connected to a2_control_unit */
	wire [7:0] control_unit_opcode;
	wire control_unit_PCSrc;
	wire control_unit_WriteReg;
	wire control_unit_SEtoReg;

	/* Wires connected to a2_zero_extender */
	wire [5:0] zero_extender_unextended;
	wire [7:0] zero_extender_extended;

	/* Wires connected to a2_generate_msb */
	wire [7:0] generate_msb_msb_lsb;
	wire [7:0] generate_msb_lsb;

	/* Wires connected to a2_adder */
	wire [7:0] adder_operand1;
	wire [7:0] adder_operand2;
	wire [7:0] adder_sum;

	/*******************************************************************************************************************************************************************/

	/* Assigning the wires to some inputs */
	assign pc_clk = clk;
	assign pc_reset = reset;
	assign instruction_memory_reset = reset;
	
	/* Assigning the outputs to some wires */
	assign WriteReg = control_unit_WriteReg;
	assign SEtoReg = control_unit_SEtoReg;
	assign instruction = instruction_memory_instruction;

	/*******************************************************************************************************************************************************************/

	/* Connections between a2_mux_2_1 and a2_pc */
	assign pc_address_in = mux_2_1_y;

	/* Connections between a2_pc and a2_instruction_memory */
	assign instruction_memory_address = pc_address_out;

	/* Connections between a2_instruction_memory and a2_control_unit */
	assign control_unit_opcode = instruction_memory_instruction[7:6];
	
	/* Connections between a2_control_unit and a2_mux_2_1 */
	assign mux_2_1_sel = control_unit_PCSrc;

	/* Connections between a2_pc and a2_add_1 */
	assign add_1_address_in = pc_address_out;

	/* Connections between a2_add_1 and a2_mux_2_1 */
	assign mux_2_1_d0 = add_1_address_out;
	
	/* Connections between instruction_memory and zero_extender */
 	assign zero_extender_unextended = instruction_memory_instruction[5:0];

	/* Connections between add_1 and generate_msb */
	assign generate_msb_msb_lsb = add_1_address_out;

	/* Connections for a2_adder */
	assign adder_operand1 = generate_msb_lsb;
	assign adder_operand2 = zero_extender_extended;
	assign mux_2_1_d1 = adder_sum;

    instruction_memory InstructionMemory(.endereco(instruction_memory_address), .instrucaoOut(instruction));
    program_counter ProgramCounter(.clock(clock), .reset(reset), .data_in(pc_address_in), .data_out(pc_address_out));
    
    pcplus4 Adder(.pcIn(pc_address_in), .pcOut(pc_address_out), .clock(clk), .reset(reset));
    mux2 Mux2to1_1(.data0(mux_2_1_d0) , .data1(mux_2_1_d1) ,.select(mux_2_1_sel) , .out(mux_2_1_y));
    
    //alu_control UnitControl(.funct7(control_unit_opcode[6:0]) , .funct3(adder_operand1[2:0]) , .alu_operation(control_unit_PCSrc) , .alu_ctr(control_unit_SEtoReg) )

    
endmodule


