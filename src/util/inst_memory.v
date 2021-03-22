module instruction_memory(endereco, instrucaoOut);
   input [31:0] endereco;  
   output [31:0] instrucaoOut;
     
   parameter WIDTH = 4; //Mudar a variável de acordo com a quantidade de instruções
     
   reg [31:0] RAM [0:WIDTH-1];
     
   initial
      begin
           $readmemb("./data/instrucoes.bin", (RAM));  
      end 
     
   assign instrucaoOut = RAM[endereco/4];

endmodule