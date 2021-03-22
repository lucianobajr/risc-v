`include "./stages/IF/if.v"
`include "./stages/ID/id.v"
`include "./stages/EX/ex.v"
`include "./stages/WB/wb.v"
`include "./registers/if_id.v"
`include "./registers/id_ex.v"


module main (
   clock,
   reset
);
   input wire clock,reset; 
   
   // Wire data hazards
   /* Wires between IF stage and IF/ID register */
	wire if_WriteReg;
	wire if_SEtoReg;
	wire [7:0] if_instruction;

	/* Wires between IF/ID register and ID stage */
	wire id_WriteReg_in;
	wire id_SEtoReg_in;
	wire [7:0] id_instruction;

	/* Wires between ID stage and ID/EX register */
	wire id_WriteReg_out;
	wire id_SEtoReg_out;
	wire [2:0] id_rs1;
	wire [2:0] id_rd;
	wire [7:0] id_data1;
	wire [7:0] id_data2;
	wire [2:0] id_unextended;

	/* Wires between ID/EX register and EX stage */
	wire ex_WriteReg_in;
	wire ex_SEtoReg_in;
	wire [2:0] ex_rs1;
	wire [2:0] ex_rd_in;
	wire [7:0] ex_data1;
	wire [7:0] ex_data2;
	wire [2:0] ex_unextended;
	
	/* Wires between EX stage and EX/WB register */
	wire ex_WriteReg_out;
	wire ex_SEtoReg_out;
	wire [2:0] ex_rd_out;
	wire [7:0] ex_sum;
	wire [7:0] ex_extended;

	/* Wires between EX/WB register and WB stage */
	wire wb_WriteReg_in;
	wire wb_SEtoReg;
	wire [2:0] wb_rd_in;
	wire [7:0] wb_sum;
	wire [7:0] wb_extended;

	
	/* Wires between WB stage and ID stage */
	wire wb_WriteReg_out;
	wire [7:0] wb_result;
	wire [2:0] wb_rd_out;

	/* Wires between EX/WB register and EX stage */
	wire [7:0] forwarded_data = wb_result;
   wire [31:0] memWriteDataIn;
   wire [31:0] memWriteDataOut;

   wire [31:0] aluIn;
   wire [31:0] aluOut;

   /*
   hazard DataHazards(
      .idExMemRead(), //1bit
      .ifIdRs(),       //5bits
      .ifIdRt(),      //5bits
      .idExDest(),    //5bits
      .hazardOut()    //1bit => output
   );
   */   

   if1 InstructionFetch( 
      .clk(clock),
      .reset(reset),
      .WriteReg(if_WriteReg),
      .SEtoReg(if_SEtoReg),
     .instruction(if_instruction)
   );

   if_id IFID(
      .clk(clock),
      .reset(reset),
      .writeReg_in(if_WriteReg), //1 bit
      .signaltoReg_in(if_SEtoReg),//1 bit
      .instruction_in(if_instruction),//8 bits
      .writeReg_out(id_WriteReg_in),//1 bit -> output
      .signaltoReg_out(id_SEtoReg_in),//1 bit -> output
      .instruction_out(id_instruction)//8 bits -> output
   );

   id InstructionDecode(
      .clock(clock),
      .reset(reset),
      .signExtendRegIn(id_SEtoReg_in), //1bit
      .writeRegIn(id_WriteReg_in), //1 bit
      .writeReg(wb_WriteReg_in), //1bit
      .rdIn(id_rd), //3bits
      .instruction(id_instruction), //8bits
      .writeData(wb_result), //8bits
      .signExtendRegOut(id_SEtoReg_out), //1bit => output
      .writeRegOut(id_WriteReg_out),   //1bit => output
      .rs1(id_rs1), //3bits => output
      .rdOut(id_rd), //3bits => output
      .data1(id_data1), //8 bits => output
      .data2(id_data2), //8 bits => output
      .unextended(id_unextended) //3bits => output
   );

   id_ex IDEX(
      .clk(clock),
      .reset(reset),
      .signExtendRegIn(id_SEtoReg_out), //1 bit
      .writeRegIn(id_WriteReg_out), //1 bit
      .rs1In(id_rs1), //3 bits
      .rdIn(id_rd), //3 bits
      .data1In(id_data1), //8 bits
      .data2In(id_data2), //8 bits
      .unextendedIn(id_unextended), //3 bits
      .signExtendRegOut(ex_SEtoReg_in), //1 bit -> output
      .writeRegOut(ex_WriteReg_in),//1 bit -> output
      .rs1Out(ex_rs1), //3 bits -> output
      .rdOut(ex_rd_in), //3 bits -> output
      .data1Out(ex_data1), //8 bits -> output
      .data2Out(ex_data2), //8 bits -> output
      .unextendedOut(ex_unextended) //3 bits -> output
   );

   ex Execute(
      .signaltoReg_in(ex_SEtoReg_in), //1bit  
      .writeReg_in(ex_WriteReg_in), //1bit
      .id_ex_rs1(ex_rs1), //3 bits
      .id_ex_rd(ex_rd_in),//3 bits
      .ex_wb_rd(wb_rd_in),// 3 bits
      .data1(ex_data1), // 8 bits
      .data2(ex_data2), // 8 bits
      .forward_data(forwarded_data), // 8 bits
      .unextended(ex_unextended), // 3 bits
      .signaltoReg_out(ex_SEtoReg_out), // 1 bit -> output
      .writeReg_out(ex_WriteReg_out), // 1 bit -> output
      .rd_out(ex_rd_out), // 3 bits -> output
      .sum(ex_sum), // 8 bits -> output
      .extensor(ex_extended) // 8 bits -> output
   );
   
   wb WriteBack(
      .signExtendReg(wb_SEtoReg), //1 bit
      .writeRegIn(wb_WriteReg_in), //1 bit
      .rdIn(wb_rd_in), //3 bits
      .sum(wb_sum), // 8 bits
      .extended(wb_extended), //8 bits
      .writeRegOut(wb_WriteReg_out), //1 bit -> output
      .rdOut(wb_rd_out), //3 bits -> output
      .result(wb_result) //8 bits -> output
   ); 

endmodule