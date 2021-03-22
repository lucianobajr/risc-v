module alu_control(funct7,funct3,alu_operation,alu_ctr);
    input [6:0]funct7; // 7bits
    input [2:0]funct3; // 3bits
    input [1:0]alu_operation; //2bits
    output reg [3:0]alu_ctr; //4bits

    always @*begin
        if(alu_operation == 2'b00 && funct7 == 7'bxxxxxxx && funct3 == 3'b011) begin      //alu_ctr => ld 
            alu_ctr <= 4'b0010;
        end
        else if(alu_operation == 2'b00 && funct7 == 7'bxxxxxxx && funct3 == 3'b111) begin //alu_ctr => sd
            alu_ctr <= 4'b0010;
        end
        else if(alu_operation == 2'b01 && funct7 == 7'bxxxxxxx && funct3 == 3'b000) begin //alu_ctr => beq
            alu_ctr <= 4'b0110;
        end
        else if(alu_operation == 2'b10 && funct7 == 7'b0000000 && funct3 == 3'b000 ) begin //alu_ctr => add
            alu_ctr <= 4'b0010;
        end
        else if(alu_operation == 2'b10 && funct7 == 7'b0100000 && funct3 == 3'b000) begin //alu_ctr => sub
            alu_ctr <= 4'b0110;
        end
        else if(alu_operation == 2'b10 && funct7 == 7'b0000000 && funct3 == 3'b111) begin //alu_ctr => and
            alu_ctr <= 4'b0000;
        end
        else if(alu_operation == 2'b10 && funct7 == 7'b0000000 && funct3 == 3'b110) begin //alu_ctr => or
            alu_ctr <= 4'b0001;
        end
    end
endmodule