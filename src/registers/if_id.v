module if_id (clk, reset, writeReg_in, signaltoReg_in, instruction_in, writeReg_out, signaltoReg_out, instruction_out);
    input clk, reset, writeReg_in, signaltoReg_in;
    input [7:0] instruction_in;

    output reg writeReg_out;
    output reg signaltoReg_out;
    output reg [7:0] instruction_out;
    
    always @(posedge reset) 
    begin
        writeReg_out = 0;
        signaltoReg_out = 0;
        instruction_out = 0;
    end

    always @(posedge clk) 
    begin
        if (!reset) 
        begin
            writeReg_out = writeReg_in;
            signaltoReg_out = signaltoReg_in;
            instruction_out = instruction_in;    
        end    
    end

endmodule