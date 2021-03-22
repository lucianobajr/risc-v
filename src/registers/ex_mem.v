module ex_mem (
    clk,
    reset,
    stall,
    flush,
    memRegIn,
    regWriteIn,
    memWriteIn,
    memReadIn,
    aluIn,
    memWriteDataIn,
    regWriteAddressIn,
    memRegOut,
    regWriteOut,
    memWriteOut,
    memReadOut,
    regWriteAddressOut,
    aluOut,
    memWriteDataOut
);

    input wire clk,reset,stall,flush, memRegIn, regWriteIn, memWriteIn, memReadIn;
    input wire [4:0] regWriteAddressIn;
    input wire [31:0] memWriteDataIn,aluIn;

    output memRegOut,regWriteOut,memWriteOut,memReadOut;
    output [4:0] regWriteAddressOut;
    output [31:0] aluOut,memWriteDataOut;   

    always @(posedge clk ) begin
        if(reset | flush) begin
            memRegOut <= 0;
            regWriteOut <= 0;
            memWriteOut <= 0;
            memReadOut <= 0;
            aluOut <= 0;
            memWriteDataOut <= 0;
            regWriteAddressOut <= 0;
        end
        else if(stall) begin
            memRegOut <= memRegOut;
            regWriteOut <= regWriteOut;
            memWriteOut <= memWriteOut;
            memReadOut <= memReadOut;
            aluOut <= aluOut;
            memWriteDataOut <= memWriteDataOut;
            regWriteAddressOut <= regWriteAddressOut;
        end 
        else begin
            memRegOut <= memRegIn;
            regWriteOut <= regWriteIn;
            memWriteOut <= memWriteIn;
            memReadOut <= memReadIn;
            aluOut <= aluIn;
            memWriteDataOut <= memWriteDataIn;
            regWriteAddressOut <= regWriteAddressIn;  
        end
    end
endmodule