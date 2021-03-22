module controller ( 
    opcode,
    branch, 
    memRead, 
    memToReg, 
    memWrite, 
    aluSrc, 
    regWrite, 
    aluOp,
    regDst
);
    input wire [6:0] opcode;
    output reg branch; 
    output reg memRead; 
    output reg memToReg; 
    output reg memWrite; 
    output reg aluSrc; 
    output reg regWrite; 
    output reg [1:0] aluOp;
    output reg regDst;


    parameter R_Format = 7'b0110011;
    parameter LD = 7'b0000011;
    parameter SD = 7'b0100011;
    parameter BEQ = 7'b1100011;
    always @(*) 
    begin
        case (opcode)
            R_Format:
                begin
                    branch = 1'b0;
                    memRead = 1'b0;
                    memToReg = 1'b0;
                    memWrite = 1'b0;
                    aluSrc = 1'b0;
                    regWrite = 1'b1;
                    aluOp = 2'b10;
                    regDst = 1'b1;
                end
            LD:
                begin
                    branch = 1'b0;
                    memRead = 1'b1;
                    memToReg = 1'b1;
                    memWrite = 1'b0;
                    aluSrc = 1'b1;
                    regWrite = 1'b1;
                    aluOp = 2'b00;
                    regDst = 1'b0;
                end
            SD:
                begin
                    branch = 1'b0;
                    memRead = 1'b0;
                    memToReg = 1'bx;
                    memWrite = 1'b1;
                    aluSrc = 1'b1;
                    regWrite = 1'b0;
                    aluOp = 2'b00;
                    regDst = 1'bx;
                end
            BEQ:
                begin
                    branch = 1'b1;
                    memRead = 1'b0;
                    memToReg = 1'bx;
                    memWrite = 1'b0;
                    aluSrc = 1'b0;
                    regWrite = 1'b0;
                    aluOp = 2'b01;
                    regDst = 1'bx;
                end 
        endcase
    end
endmodule