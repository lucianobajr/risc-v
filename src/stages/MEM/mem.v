`include "./stages/MEM/data_memory.v"

module mem (
   clk,
   reset,
   memToRegInput,
   regWriteInput,
   memWriteInput,
   memReadInput,
   aluInput,
   memWriteDataInput,
   regWriteAdressInput,
   memToRegOut,
   regWriteOut,
   dataMemoryOut,
   aluOut,
   regWriteAdressOut
);

    input wire clk,reset,memToRegInput,regWriteInput,memWriteInput,memReadInput;
    input wire [4:0] regWriteAdressInput;
    input wire [31:0] aluInput,memWriteDataInput;
    
    output memToRegOut,regWriteOut;
    output [4:0] regWriteAdressOut;
    output [31:0] dataMemoryOut,aluOut;
    
    assign aluOut = aluInput;
    assign memToRegOut = memToRegInput;
    assign regWriteOut =  regWriteInput;
    assign regWriteAdressOut = regWriteAdressInput;


    data_memory dm(.clock(clk),.reset(reset),.mem_write(memWriteInput),.mem_read(dataMemoryOut),.adress(aluInput),.write_data(memWriteInput),.result(aluOut));
endmodule