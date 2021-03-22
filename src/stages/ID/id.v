`include "./stages/ID/registers.v"

module id (
    clock,
    reset,
    signExtendRegIn,
    writeRegIn,
    writeReg,
    rdIn,
    instruction,
    writeData,
    signExtendRegOut,
    writeRegOut,
    rs1,
    rdOut,
    data1,
    data2,
    unextended
);
    input wire clk,reset;
    input wire clock,reset,signExtendRegIn,writeRegIn,writeReg;
    input wire [2:0] rdIn;
    input wire [7:0] instruction,writeData;
    output signExtendRegOut,writeRegOut;
    output [2:0] rs1,rdOut,unextended;
    output [7:0] data1,data2;

    wire register_file_reset;
	wire register_file_WriteReg;
	wire [2:0] register_file_rs1;
	wire [2:0] register_file_rs2;
	wire [2:0] register_file_rd;
	wire [7:0] register_file_write_data;
	wire [7:0] register_file_data1;
	wire [7:0] register_file_data2;

	assign register_file_reset = reset;
	assign register_file_WriteReg = writeReg;
	assign register_file_rs1 = instruction[2:0];
	assign register_file_rs2 = instruction[5:3];
	assign register_file_rd = rdIn;
	assign register_file_write_data = writeData;

	assign signExtendRegOut = signExtendRegIn;
	assign writeRegOut = writeRegIn;
	assign rs1 = register_file_rs1;
	assign rdOut = register_file_rs2;
	assign register_file_data1 = data1;
	assign register_file_data2 = data2;
	assign unextended = instruction[2:0];

    registers regFile(
        .clock(clock),
        .reset(reset),
        .rs1(register_file_rs1),
        .rs2(register_file_rs2),
        .rd(register_file_rd),
        .writedata(register_file_write_data),
        .writereg(register_file_WriteReg),
        .readdata1(register_file_data1),
        .readdata2(register_file_data2)
    );

endmodule