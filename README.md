# Caminho de Dados - Datapath - com pipeline RISC-V
Repositório da disciplina de CCF 353 ( Organização de Computadores II ) 

### A  estruturação do projeto segue o esquema a seguir:

    ├── src                       # Source
    │   ├── data
    │   │   ├── instrucoes.bin
    │   ├── registers      
    │   │   ├── if_id.v    
    │   │   ├── id_ex.v
    │   │   ├── ex_mem.v  
    │   │   ├── mem_wb.v
    │   ├── stages      
    │   │   ├── IF   
    │   │   ├── ID
    │   │   ├── EX
    │   │   ├── MEM      
    │   │   ├── WB             
    │   ├── tools
    │   │   ├── hazard.v    
    │   │   ├── forward.v
    │   ├── util         
    │   │   ├── Unidades Funcionais      
    │   ├── datapath_tb.v    
    │   ├── main.v      
    │   ├── makefile 
    │   



## Compilar testbench do datapath
```sh
$   make
```


## Executar testbench 
```sh   
$   make run
```

## Executar Formato de onda (.vcd) 
```sh   
$   make gtk
```


### Para a leitura das instruções é necessário a mudança do parametro 'WIDTH', além disso, é no arquivo 'instrucoes.bin' (o arquivo se encontrada no diretório data) que estão as instruções para execução em binário:

```v
module instruction_memory(endereco, instrucaoOut);
   input [31:0] endereco;  
   output [31:0] instrucaoOut;
     
   parameter WIDTH = 4; //Mudar a variável de acordo com a quantidade de instruções
     
   reg [31:0] RAM [0:WIDTH-1];
     
   initial
      begin
           $readmemb("../data/instrucoes.bin", (RAM));  
      end 
     
   assign instrucaoOut = RAM[endereco/4];

endmodule
```
