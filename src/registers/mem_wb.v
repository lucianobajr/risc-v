module mem_wb (
   clk,
   reset,
   stall,
   flush,
   memToRegInput,
   regWriteInput,
   dataMemoryInput,
   aluInput,
   regWriteAdressIn,
   memToRegOut,
   regWriteOut,
   dataMemoryOut,
   aluOut,
   regWriteAdressOut
);
    input wire clk,reset,stall,flush,memToRegInput,regWriteInput;
    input [4:0] regWriteAdressIn;
    input [31:0] dataMemoryInput,aluInput;

    output memToRegOut,regWriteOut;
    output [4:0] regWriteAdressOut;
    output [31:0] dataMemoryOut,aluOut;

    always @(posedge clk ) begin
       if (reset | flush) begin
            memToRegOut <= 0;
            regWriteOut <= 0;
            dataMemoryOut <= 0;
            aluOut <= 0;
            regWriteAdressOut <= 0;
       end 
       else  if (stall) begin
            memToRegOut <= memToRegOut;
            regWriteOut <= regWriteOut;
            dataMemoryOut <= dataMemoryOut;
            aluOut <= aluOut;
            regWriteAdressOut <= regWriteAdressOut;
       end
       else begin
            memToRegOut <= memToRegInput;
            regWriteOut <= regWriteInput;
            dataMemoryOut <= dataMemoryInput;
            aluOut <= aluInput;
            regWriteAdressOut <= regWriteAdressIn;
       end
    end
endmodule